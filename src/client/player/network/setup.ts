import { setupGameListeners } from "./listeners/game-listeners";
import { setupCombatListeners } from "./listeners/combat-listeners";
import { setupMovementListeners } from "./listeners/movement-listeners";
import { TransitionManager } from "../systems/game-state/transition-manager";
import { HitFeedback } from "../systems/combat/hit-feedback";
import { SwordTrails } from "../systems/effects/visual-effects/sword-trails";
import { WeaponAnimator } from "../systems/combat/weapon-animator";
import { CombatSounds } from "../systems/effects/audio-effects/combat-sounds";

export function setupClientNetworking(transitionManager: TransitionManager) {
	const hitFeedback = new HitFeedback();
	hitFeedback.initialize();

	const combatSounds = new CombatSounds();
	combatSounds.initialize();

	const weaponAnimator = new WeaponAnimator();
	weaponAnimator.initialize();

	const swordTrails = new SwordTrails();
	swordTrails.initialize();

	// Setup listeners
	setupGameListeners(transitionManager, hitFeedback, combatSounds);
	setupCombatListeners(weaponAnimator);
	setupMovementListeners();
}
