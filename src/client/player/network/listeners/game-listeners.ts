import { GameState } from "shared/network/packets";
import { LoggingMiddleware } from "../middleware";
import { game_state_actions, game_state_store } from "shared/state/game-state";
import { TransitionManager } from "client/player/systems/game-state/transition-manager";
import { HitFeedback } from "client/player/systems/combat/hit-feedback";
import { CombatSounds } from "client/player/systems/effects/audio-effects/combat-sounds";
import { VisualizeGrappleRopeData } from "shared/types/movement/grapple";
import { GrappleRope } from "client/player/systems/effects/visual-effects/grapple-rope";

export function setupGameListeners(
	transitionManager: TransitionManager,
	hitFeedback: HitFeedback,
	combatSounds: CombatSounds,
	grappleRope: GrappleRope,
) {
	GameState.RequestData.listen((data: unknown, player?: Player) => {
		print("Recieved data: ", data);
	});

	GameState.TransitionState.listen((state: string) => {
		if (state === "Menu") {
			game_state_store.dispatch(game_state_actions.transition_to_menu());
			transitionManager.transition("Menu");
		}
	});

	GameState.PlayerHit.listen((data) => {
		hitFeedback.onTakeDamage(data.damage, data.knockback);

		combatSounds.playHitSound();
	});

	// When we deal damage
	GameState.DamageDealt.listen((data) => {
		combatSounds.playHitConfirmSound();
	});

	// When we die
	GameState.PlayerDied.listen((data) => {
		combatSounds.playDeathSound();

		hitFeedback.onDeath();
	});

	// Visualizing/Removing Grapple rope
}
