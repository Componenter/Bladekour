import { ClientMiddleware } from "shared/network/middleware/types";

export const LoggingMiddleware: ClientMiddleware = {
	name: "Logging",

	onSend(packet) {
		print(`[SEND] -> Packet sent`);
		return true;
	},

	onReceive(packet) {
		print(`[RECV] <- Packet received`);
	},
};
