import Rodux from "@rbxts/rodux";

// State interface
interface State {
	[userId: number]: {
		attacking: boolean;
	};
}

// Action Types

interface attack {
	type: "attack";
	player: Player;
}

interface stop_attack {
	type: "stop_attack";
	player: Player;
}

interface add_player {
	type: "add_player";
	player: Player;
}

type Action = attack | stop_attack | add_player;

// Reducer
const reducer = Rodux.createReducer<State, Action>(
	{},
	{
		attack: (state, action) => ({
			...state,
			[action.player.UserId]: { ...state[action.player.UserId], attacking: true },
		}),

		stop_attack: (state, action) => ({
			...state,
			[action.player.UserId]: { ...state[action.player.UserId], attacking: false },
		}),

		add_player: (state, action) => ({
			...state,
			[action.player.UserId]: { attacking: false },
		}),
	},
);

// Create store
export const combat_state_store = new Rodux.Store(reducer);

// Export action creaters
export const combat_state_actions = {
	attack: (player: Player): attack => ({
		type: "attack",
		player: player,
	}),

	stop_attack: (player: Player): stop_attack => ({
		type: "stop_attack",
		player: player,
	}),

	add_player: (player: Player): add_player => ({
		type: "add_player",
		player: player,
	}),
};
