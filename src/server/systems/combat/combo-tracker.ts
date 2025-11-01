// Combo tracking

import { MAX_COMBO } from "shared/constants/combat/combos";

export class ComboTracker {
	ComboCache: Map<Player, number>;
	constructor() {
		this.ComboCache = new Map<Player, number>();
	}

	incrementCombo(player: Player) {
		let playerCombo = this.ComboCache.get(player);
		if (playerCombo === undefined) {
			this.ComboCache.set(player, 0);
		} else {
			playerCombo = playerCombo as number;
			let newCombo = playerCombo + 1;
			if (newCombo > MAX_COMBO) {
				newCombo = 0;
			}

			this.ComboCache.set(player, newCombo);
		}
	}

	getCombo(player: Player): number {
		let playerCombo = this.ComboCache.get(player);
		if (playerCombo === undefined) {
			this.ComboCache.set(player, 0);
		}

		playerCombo = this.ComboCache.get(player) as number;

		return playerCombo;
	}
}
