import { PlayerManager } from "../player/player-manager";
import { HitResolver } from "./hit-resolver";
import { DamageHandler } from "./damage-handler";
import { AttackData, AttackDataClient, HitResult } from "shared/types/combat/attack";
import { COOLDOWN_VALUES } from "shared/constants/combat/cooldown";
import { Combat } from "shared/network/packets";
import { ComboTracker } from "./combo-tracker";

const ATTACK_COOLDOWN = 0.5; // seconds

export class CombatSystem {
	constructor(
		private playerManager: PlayerManager,
		private hitResolver: HitResolver,
		private damageHandler: DamageHandler,
		private comboTracker: ComboTracker,
	) {}

	processAttack(attacker: Player, data: AttackData): HitResult | undefined {
		// Get attacker state
		const attackerState = this.playerManager.getState(attacker);
		if (!attackerState) {
			return;
		}

		// Check if dead
		if (attackerState.isDead) {
			return;
		}

		// Check cooldown
		const now = os.clock();
		if (now - attackerState.lastAttackTime < ATTACK_COOLDOWN) {
			return;
		}

		// Get attacker character
		const character = attacker.Character;
		if (!character) {
			return;
		}

		const humanoidRootPart = character.FindFirstChild("HumanoidRootPart") as BasePart;
		if (!humanoidRootPart) {
			return;
		}

		this.comboTracker.incrementCombo(attacker);

		const newCombo = this.comboTracker.getCombo(attacker);

		const ClientAttackData: AttackDataClient = { attackType: data.attackType, combo: newCombo };
		Combat.Attack.sendTo(ClientAttackData, attacker);

		// Update attack state
		this.playerManager.setState(attacker, {
			isAttacking: true,
			lastAttackTime: now,
		});

		// Resolve hit
		const hitResult = this.hitResolver.resolveHit(
			attacker,
			humanoidRootPart.Position,
			humanoidRootPart.CFrame.LookVector,
			data.attackType,
			newCombo,
		);

		// Apply damage if hit
		if (hitResult.hit && hitResult.target) {
			this.damageHandler.applyDamage(hitResult.target, hitResult.damage, attacker);
			this.damageHandler.applyKnockback(hitResult.target, hitResult.knockback);
		}

		// Reset attack state after short delay
		task.delay(COOLDOWN_VALUES[data.attackType], () => {
			this.playerManager.setState(attacker, { isAttacking: false });
		});

		return hitResult;
	}
}
