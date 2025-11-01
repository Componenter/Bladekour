import { Players } from "@rbxts/services";

export interface PlayerState {
	health: number;
	maxHealth: number;
	isDead: boolean;
	isAttacking: boolean;
	lastAttackTime: number;
}

export class PlayerManager {
	private playerStates = new Map<Player, PlayerState>();

	initialize() {
		Players.PlayerAdded.Connect((player) => this.onPlayerAdded(player));
		Players.PlayerRemoving.Connect((player) => this.onPlayerRemoved(player));

		// Handle existing players
		Players.GetPlayers().forEach((player) => this.onPlayerAdded(player));
	}

	private onPlayerAdded(player: Player) {
		this.playerStates.set(player, {
			health: 100,
			maxHealth: 100,
			isDead: false,
			isAttacking: false,
			lastAttackTime: 0,
		});

		print(`Player state created: ${player.Name}`);
	}

	private onPlayerRemoved(player: Player) {
		this.playerStates.delete(player);
		print(`Player state removed: ${player.Name}`);
	}

	getState(player: Player): PlayerState | undefined {
		return this.playerStates.get(player);
	}

	setState(player: Player, state: Partial<PlayerState>) {
		const currentState = this.playerStates.get(player);
		if (currentState) {
			this.playerStates.set(player, { ...currentState, ...state });
		}
	}

	getAllPlayers(): Player[] {
		return Players.GetPlayers();
	}
}
