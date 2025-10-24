import ProfileCache from "server/data/player-data-store";
import { MiddlewareChain } from "shared/network/middleware/middleware-chain";
import { PacketContext } from "shared/network/middleware/types";
import { GameState } from "shared/network/packets";
import { RateLimiterMiddleware } from "../middleware/anti-cheat/rate-limiter-middleware";
import { game_state_actions, game_state_store } from "server/systems/state/game-state";

export function setupGameHandlers() {
	const chain = new MiddlewareChain().use(RateLimiterMiddleware);

	GameState.RequestData.listen((data, player?: Player) => {
		player = player as Player;

		const context: PacketContext = {
			packet: data,
			player: player,
			timestamp: os.clock(),
			metadata: new Map(),
		};

		chain.execute(context, (ctx) => {
			GameState.RequestData.sendTo(ProfileCache.get(player)?.Data, player);
		});
	});

	GameState.TransitionState.listen((pckt, player?: Player) => {
		player = player as Player;

		const context: PacketContext = {
			packet: pckt,
			player: player,
			timestamp: os.clock(),
			metadata: new Map(),
		};

		chain.execute(context, (ctx) => {
			const new_state = ctx.packet;
			if (new_state === "Playing") {
				game_state_store.dispatch(game_state_actions.transition_to_playing(ctx.player));
			}
		});
	});
}
