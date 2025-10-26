import { Combat } from "shared/network/packets";
import { combat_state_actions, combat_state_store } from "shared/state/combat-state";

export function setupCombatListeners() {
	Combat.Attack.listen(() => {
		print("Attack");

		combat_state_store.dispatch(combat_state_actions.attack());
		task.wait(0.5);
		combat_state_store.dispatch(combat_state_actions.stop_attack());
	});
}
