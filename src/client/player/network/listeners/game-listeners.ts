import { GameState } from "shared/network/packets";
import { LoggingMiddleware } from "../middleware";
import { game_state_actions, game_state_store } from "shared/state/game-state";
import { TransitionManager } from "client/player/systems/game-state/transition-manager";
import { HitFeedback } from "client/player/systems/combat/hit-feedback";
import { CombatSounds } from "client/player/systems/effects/audio-effects/combat-sounds";

export function setupGameListeners(
	transitionManager: TransitionManager,
	hitFeedback: HitFeedback,
	combatSounds: CombatSounds,
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
		print(`Got hit for ${data.damage} damage!`);

		// Update health in store

		// Play hit feedback
		hitFeedback.onTakeDamage(data.damage, data.knockback);

		// Play hit sound
		combatSounds.playHitSound();
	});

	// When we deal damage
	GameState.DamageDealt.listen((data) => {
		print(`Dealt ${data.damage} damage!`);

		// Show hit marker

		// Play hit confirm sound
		combatSounds.playHitConfirmSound();
	});

	// When we die
	GameState.PlayerDied.listen((data) => {
		print("You died!");

		// Play death sound
		combatSounds.playDeathSound();

		// Show death effect
		hitFeedback.onDeath();
	});
}
