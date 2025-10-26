import { setupGameListeners } from "./listeners/game-listeners";
import { setupCombatListeners } from "./listeners/combat-listeners";
import { setupMovementListeners } from "./listeners/movement-listeners";
import { TransitionManager } from "../systems/game-state/transition-manager";

export function setupClientNetworking(transitionManager: TransitionManager) {
	// Setup listeners
	setupGameListeners(transitionManager);
	setupCombatListeners();
	setupMovementListeners();
}
