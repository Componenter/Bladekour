import { ServerMiddleware, PacketContext } from "shared/network/middleware/types";

const RATE_LIMIT = 10; // Max packets per second
const playerBuckets = new Map<Player, number[]>();

export const RateLimiterMiddleware: ServerMiddleware = {
	name: "RateLimiter",

	onReceive(context: PacketContext): boolean {
		const now = os.clock();
		const bucket = playerBuckets.get(context.player) || [];

		// Remove old timestamps (older than 1 second)
		const recent = bucket.filter((t) => now - t < 1);

		// Check rate limit
		if (recent.size() >= RATE_LIMIT) {
			warn(`Rate limit exceeded: ${context.player.Name}`);
			return false; // Reject packet
		}

		// Add new timestamp
		recent.push(now);
		playerBuckets.set(context.player, recent);

		return true;
	},
};
