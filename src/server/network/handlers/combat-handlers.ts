import { MiddlewareChain } from "shared/network/middleware/middleware-chain";
import { RateLimiterMiddleware } from "../middleware/anti-cheat/rate-limiter-middleware";
import { Combat } from "shared/network/packets";
import { PacketContext } from "shared/network/middleware/types";
import ProfileCache from "server/data/player-data-store";
import { StateMiddleware } from "../middleware/anti-cheat/state-middleware";
import { CombatSystem } from "server/systems/combat/combat-system";
import { PlayerManager } from "server/systems/player/player-manager";
import { HitResolver } from "server/systems/combat/hit-resolver";
import { DamageHandler } from "server/systems/combat/damage-handler";
import { AttackData } from "shared/types/combat/attack";

export function setupCombatHandlers(combatSystem: CombatSystem) {
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
			combatSystem.processAttack(player, ctx.packet as AttackData);
		});
	});
}
