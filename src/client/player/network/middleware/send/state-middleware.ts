import { InputMiddleware } from "client/player/systems/input/input-middleware-chain";
import { InputEvent } from "client/player/systems/input/types";
import { combat_state_store } from "shared/state/combat-state";

export class StateMiddleware implements InputMiddleware {
	name = "State";

	validate(event: InputEvent): boolean {
		if (event.action === "Attack") {
			const state = combat_state_store.getState();

			if (state.attacking) {
				return false;
			}
		}

		return true;
	}
}
