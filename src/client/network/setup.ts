import { setupGameListeners } from "./listeners/game-listeners";
import { setupCombatListeners } from "./listeners/combat-listeners";
import { setupMovementListeners } from "./listeners/movement-listeners";

export function setupClientNetworking() {
	// Setup listeners
	setupGameListeners();
	setupCombatListeners();
	setupMovementListeners();
}
