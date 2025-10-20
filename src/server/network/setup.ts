import { setupCombatHandlers } from "./handlers/combat-handlers";
import { setupGameHandlers } from "./handlers/game-handlers";
import { setupMovementHandlers } from "./handlers/movement-handlers";

export function setupNetworking() {
	setupGameHandlers();
	setupCombatHandlers();
	setupMovementHandlers();

	print("Server networking initialized");
}
