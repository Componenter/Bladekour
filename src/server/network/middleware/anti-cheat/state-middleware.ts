import { ServerMiddleware, PacketContext } from "shared/network/middleware/types";

export const StateMiddleware: ServerMiddleware = {
	name: "StateMiddleware",

	onReceive(context: PacketContext): boolean {
		return true;
	},
};
