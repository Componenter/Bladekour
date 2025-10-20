import { GameState } from "shared/network/packets";
import { LoggingMiddleware } from "../middleware";

export function setupGameListeners() {
	GameState.RequestData.listen((data: unknown, player?: Player) => {
		print("Recieved data: ", data);
	});
}
