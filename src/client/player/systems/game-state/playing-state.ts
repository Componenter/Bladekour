import { GameState } from "shared/network/packets";
import { game_state_store } from "shared/state/game-state";

game_state_store.changed.connect((new_state, old_state) => {
	if (new_state.playing !== old_state.playing) {
		if (new_state.playing) {
			GameState.TransitionState.send("Playing");
		}
	}
});
