import { HitFeedback } from "client/player/systems/combat/hit-feedback";
import { WeaponAnimator } from "client/player/systems/combat/weapon-animator";
import { CombatSounds } from "client/player/systems/effects/audio-effects/combat-sounds";
import { COOLDOWN_VALUES } from "shared/constants/combat/cooldown";
import { Combat, GameState } from "shared/network/packets";
import { combat_state_actions, combat_state_store } from "shared/state/combat-state";
import { AttackData, AttackDataClient } from "shared/types/combat/attack";

export function setupCombatListeners(weaponAnimator: WeaponAnimator) {
	Combat.Attack.listen((packet: AttackDataClient | unknown) => {
		const data = packet as AttackDataClient;

		weaponAnimator.playAttackAnimation(data.attackType, data.combo);

		combat_state_store.dispatch(combat_state_actions.attack());
		task.wait(COOLDOWN_VALUES[data.attackType]);
		combat_state_store.dispatch(combat_state_actions.stop_attack());
	});
}
