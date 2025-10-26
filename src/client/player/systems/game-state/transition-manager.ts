import { GameState } from "shared/network/packets";
import { game_state_actions, game_state_store } from "shared/state/game-state";
import { PlayingState } from "./playing-state";

export class TransitionManager {
	playingState: PlayingState;

	constructor(playingState: PlayingState) {
		this.playingState = playingState;

		game_state_store.changed.connect((new_state, old_state) => {
			if (new_state.playing !== old_state.playing) {
				if (new_state.playing) {
					GameState.TransitionState.send("Playing");
					playingState.enter();
				} else {
					playingState.exit();
				}
			}
		});
	}

	transition(state: "Menu" | "Playing") {
		if (state === "Playing") {
			this.playingState.enter();
		}

		if (state === "Menu") {
			this.playingState.exit();
		}
	}
}
