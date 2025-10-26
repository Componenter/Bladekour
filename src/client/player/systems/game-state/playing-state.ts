import { Combat, GameState } from "shared/network/packets";
import { game_state_store } from "shared/state/game-state";
import { InputManager } from "../input/input-manager";
import { InputAction } from "../input/types";
import { InputMiddlewareChain } from "../input/input-middleware-chain";
import { StateMiddleware } from "client/player/network/middleware/send/state-middleware";

export class PlayingState {
	private inputManager: InputManager;
	private middleware: InputMiddlewareChain;

	constructor(inputManager: InputManager) {
		this.inputManager = inputManager;

		this.middleware = new InputMiddlewareChain().use(new StateMiddleware());
	}

	enter() {
		this.inputManager.enable();

		// Subscribe to actions
		this.inputManager.onAction(InputAction.Attack, (event) => {
			if (!this.middleware.validate(event)) return;
			Combat.Attack.send();
		});
	}

	exit() {
		this.inputManager.disable();
	}
}
