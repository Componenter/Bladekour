import Rodux from "@rbxts/rodux";

// State interface
interface State {
	[userId: number]: {
		playing: boolean;
		active: boolean;
		player: Player;
	};
}

// Action Types

interface transition_to_playing {
	type: "transition_to_playing";
	player: Player;
}

interface transition_to_menu {
	type: "transition_to_menu";
	player: Player;
}

interface add_player {
	type: "add_player";
	player: Player;
}

interface remove_player {
	type: "remove_player";
	player: Player;
}

type Action = transition_to_playing | add_player | remove_player | transition_to_menu;

// Reducer
const reducer = Rodux.createReducer<State, Action>(
	{},
	{
		transition_to_playing: (state, action) => ({
			...state,
			[action.player.UserId]: { ...state[action.player.UserId], playing: true },
		}),
		transition_to_menu: (state, action) => ({
			...state,
			[action.player.UserId]: { ...state[action.player.UserId], playing: false },
		}),

		add_player: (state, action) => ({
			...state,
			[action.player.UserId]: { playing: false, active: true, player: action.player },
		}),

		remove_player: (state, action) => ({
			...state,
			[action.player.UserId]: { playing: false, active: false, player: action.player },
		}),
	},
);

// Create store
export const game_state_store = new Rodux.Store(reducer);

// Export action creaters
export const game_state_actions = {
	transition_to_playing: (player: Player): transition_to_playing => ({
		type: "transition_to_playing",
		player: player,
	}),

	transition_to_menu: (player: Player): transition_to_menu => ({
		type: "transition_to_menu",
		player: player,
	}),

	add_player: (player: Player): add_player => ({
		type: "add_player",
		player: player,
	}),

	remove_player: (player: Player): remove_player => ({
		type: "remove_player",
		player: player,
	}),
};
