import { MiddlewareChain } from "shared/network/middleware/middleware-chain";
import { RateLimiterMiddleware } from "../middleware/anti-cheat/rate-limiter-middleware";
import { Combat } from "shared/network/packets";
import { PacketContext } from "shared/network/middleware/types";
import ProfileCache from "server/data/player-data-store";
import { combat_state_actions, combat_state_store } from "server/systems/state/combat-state";
import { StateMiddleware } from "../middleware/anti-cheat/state-middleware";

export function setupCombatHandlers() {
	const chain = new MiddlewareChain().use(RateLimiterMiddleware).use(StateMiddleware);

	Combat.Attack.listen((data, player?: Player) => {
		player = player as Player;

		const context: PacketContext = {
			packet: data,
			player: player,
			timestamp: os.clock(),
			metadata: new Map(),
		};

		chain.execute(context, (ctx) => {
			combat_state_store.dispatch(combat_state_actions.attack(player));
			Combat.Attack.sendTo(undefined, player);
			task.wait(0.5);
			combat_state_store.dispatch(combat_state_actions.stop_attack(player));
		});
	});
}
