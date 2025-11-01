// Server entry

import ProfileCache from "server/data/player-data-store";
import { setupCombatHandlers } from "server/network/handlers/combat-handlers";
import { setupNetworking } from "server/network/setup";
import { CombatSystem } from "server/systems/combat/combat-system";
import { ComboTracker } from "server/systems/combat/combo-tracker";
import { DamageHandler } from "server/systems/combat/damage-handler";
import { HitResolver } from "server/systems/combat/hit-resolver";
import { setup_server_game_state_managers } from "server/systems/game-state/setup";
import { PlayerManager } from "server/systems/player/player-manager";
import { setup_server_states } from "server/systems/state/setup";

task.spawn(() => {
	ProfileCache.isEmpty();
});

task.spawn(setup_server_states);
task.spawn(() => {
	setup_server_game_state_managers();
});

const playerManager = new PlayerManager();
task.spawn(() => {
	playerManager.initialize();
});

const hitResolver = new HitResolver(playerManager);
const damageHandler = new DamageHandler(playerManager);
const comboTracker = new ComboTracker();
const combatSystem = new CombatSystem(playerManager, hitResolver, damageHandler, comboTracker);

task.spawn(setupNetworking, combatSystem);
