// Spawn manager

import { game_state_store } from "../state/game-state";

export function setup_spawn_manager() {
	game_state_store.changed.connect((newState, oldState) => {
		let changed_player: Player | undefined = undefined;
		let changed_player_state: { playing: boolean; player: Player; active: boolean } | undefined = undefined;

		for (const [index, state] of pairs(newState)) {
			if (oldState[index] !== newState[index]) {
				changed_player = state.player;
				changed_player_state = state;
			}
		}

		if (changed_player && changed_player_state) {
			if ((oldState[changed_player.UserId] || { playing: undefined }).playing !== changed_player_state.playing) {
				let character = changed_player.Character;

				if (!character) return;

				const root = character.WaitForChild("HumanoidRootPart") as BasePart;

				if (changed_player_state.playing) {
					root.Anchored = false;
					root.CFrame = new CFrame(-918.668, 45.088, 1093.752);
				} else {
					if (!changed_player_state.playing) {
						root.Anchored = true;
					}
				}
			}
		}
	});
}
