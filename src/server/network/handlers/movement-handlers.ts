import { MiddlewareChain } from "shared/network/middleware/middleware-chain";
import { Movement } from "shared/network/packets";
import { RateLimiterMiddleware } from "../middleware/anti-cheat/rate-limiter-middleware";
import { GrappleData } from "shared/types/movement/grapple";
import { PacketContext } from "shared/network/middleware/types";
import { GrappleSystem } from "server/systems/movement/grapple-system";

export function setupMovementHandlers(grappleSystem: GrappleSystem) {
	const chain = new MiddlewareChain().use(RateLimiterMiddleware);

	Movement.Grapple.listen((data: unknown, player?: Player) => {
		const pck = data as GrappleData;

		const context: PacketContext<GrappleData> = {
			packet: pck,
			player: player as Player,
			timestamp: os.clock(),
			metadata: new Map(),
		};

		chain.execute(context, (_ctx: PacketContext) => {
			const ctx = _ctx as PacketContext<GrappleData>;

			const packet = ctx.packet;

			grappleSystem.process(packet, ctx.player);
		});
	});

	Movement.GrappleMovement.listen((data: string, player?: Player) => {
		grappleSystem.processInput(data, player as Player);
	});
}
