import { CombatSystem } from "server/systems/combat/combat-system";
import { setupCombatHandlers } from "./handlers/combat-handlers";
import { setupGameHandlers } from "./handlers/game-handlers";
import { setupMovementHandlers } from "./handlers/movement-handlers";

export function setupNetworking(combatSystem: CombatSystem) {
	setupGameHandlers();
	setupCombatHandlers(combatSystem);
	setupMovementHandlers();

	print("Server networking initialized");
}
