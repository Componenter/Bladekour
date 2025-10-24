import { Players } from "@rbxts/services";
import { game_state_actions, game_state_store } from "./game-state";
import { GameState } from "shared/network/packets";

export function setup_server_states() {
	function PlayerAdded(player: Player) {
		player.CharacterAdded.Wait();
		game_state_store.dispatch(game_state_actions.add_player(player));

		player.CharacterAdded.Connect(() => {
			game_state_store.dispatch(game_state_actions.transition_to_menu(player));
			GameState.TransitionState.sendTo("Menu", player);
		});
	}

	function PlayerRemoving(player: Player) {
		game_state_store.dispatch(game_state_actions.remove_player(player));
	}

	for (const player of Players.GetPlayers()) {
		task.spawn(PlayerAdded, player);
	}

	Players.PlayerAdded.Connect(PlayerAdded);
	Players.PlayerRemoving.Connect(PlayerRemoving);
}
