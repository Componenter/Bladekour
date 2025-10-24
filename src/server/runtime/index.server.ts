// Server entry

import ProfileCache from "server/data/player-data-store";
import { setupNetworking } from "server/network/setup";
import { setup_server_game_state_managers } from "server/systems/game-state/setup";
import { setup_server_states } from "server/systems/state/setup";

task.spawn(() => {
	ProfileCache.isEmpty();
});

task.spawn(setupNetworking);
task.spawn(setup_server_states);
task.spawn(() => {
	setup_server_game_state_managers();
});
