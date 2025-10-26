import { GameState } from "shared/network/packets";
import { LoggingMiddleware } from "../middleware";
import { game_state_actions, game_state_store } from "shared/state/game-state";
import { TransitionManager } from "client/player/systems/game-state/transition-manager";

export function setupGameListeners(transitionManager: TransitionManager) {
	GameState.RequestData.listen((data: unknown, player?: Player) => {
		print("Recieved data: ", data);
	});

	GameState.TransitionState.listen((state: string) => {
		if (state === "Menu") {
			game_state_store.dispatch(game_state_actions.transition_to_menu());
			transitionManager.transition("Menu");
		}
	});
}
