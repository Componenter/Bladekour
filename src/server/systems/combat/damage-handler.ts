import { PlayerManager } from "../player/player-manager";
import { GameState } from "shared/network/packets";

export class DamageHandler {
	constructor(private playerManager: PlayerManager) {}

	applyDamage(target: Player, damage: number, attacker?: Player) {
		const targetState = this.playerManager.getState(target);
		if (!targetState) return;

		// Apply damage
		const newHealth = math.max(0, targetState.health - damage);
		this.playerManager.setState(target, { health: newHealth });

		print(`${target.Name} took ${damage} damage. Health: ${newHealth}/${targetState.maxHealth}`);

		// Send damage packet to victim
		GameState.PlayerHit.sendTo(
			{
				damage: damage,
				attackerUserId: attacker?.UserId || 0,
				knockback: new Vector3(0, 0, 0),
				attackType: "light",
			},
			target,
		);

		// Send confirmation to attacker
		if (attacker) {
			GameState.DamageDealt.sendTo(
				{
					targetUserId: target.UserId,
					damage: damage,
					knockback: new Vector3(0, 0, 0),
				},
				attacker,
			);
		}

		// Check if dead
		if (newHealth <= 0) {
			this.handleDeath(target, attacker);
		}
	}

	applyKnockback(target: Player, knockback: Vector3) {
		const character = target.Character;
		if (!character) return;

		const humanoidRootPart = character.FindFirstChild("HumanoidRootPart") as BasePart;
		if (!humanoidRootPart) return;

		// Apply velocity
		humanoidRootPart.AssemblyLinearVelocity = knockback;
	}

	private handleDeath(victim: Player, killer?: Player) {
		print(`${victim.Name} died!`);

		// Update state
		this.playerManager.setState(victim, {
			isDead: true,
			health: 0,
		});

		// Send death packet
		GameState.PlayerDied.sendTo(
			{
				killerUserId: killer?.UserId,
				killerId: killer?.UserId,
			},
			victim,
		);

		// Respawn after delay
		task.delay(3, () => {
			this.respawnPlayer(victim);
		});
	}

	private respawnPlayer(player: Player) {
		const state = this.playerManager.getState(player);
		if (state) {
			this.playerManager.setState(player, {
				health: state.maxHealth,
				isDead: false,
			});

			player.LoadCharacter();
			print(`${player.Name} respawned`);
		}
	}
}
