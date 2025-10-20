import ProfileCache from "server/data/player-data-store";
import { MiddlewareChain } from "shared/network/middleware/middleware-chain";
import { PacketContext } from "shared/network/middleware/types";
import { GameState } from "shared/network/packets";
import { RateLimiterMiddleware } from "../middleware/anti-cheat/rate-limiter-middleware";

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
}
