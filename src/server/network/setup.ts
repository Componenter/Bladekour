import { CombatSystem } from "server/systems/combat/combat-system";
import { setupCombatHandlers } from "./handlers/combat-handlers";
import { setupGameHandlers } from "./handlers/game-handlers";
import { setupMovementHandlers } from "./handlers/movement-handlers";
import { GrappleSystem } from "server/systems/movement/grapple-system";

export function setupNetworking(combatSystem: CombatSystem, grappleSystem: GrappleSystem) {
	setupGameHandlers();
	setupCombatHandlers(combatSystem);
	setupMovementHandlers(grappleSystem);

	print("Server networking initialized");
}
