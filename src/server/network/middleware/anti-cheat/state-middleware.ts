import { combat_state_store } from "server/systems/state/combat-state";
import { ServerMiddleware, PacketContext } from "shared/network/middleware/types";

export const StateMiddleware: ServerMiddleware = {
	name: "RateLimiter",

	onReceive(context: PacketContext): boolean {
		const state = combat_state_store.getState()[context.player.UserId];

		if (state.attacking) {
			return false;
		}

		return true;
	},
};
