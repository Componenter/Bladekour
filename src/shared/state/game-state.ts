import Rodux from "@rbxts/rodux";

// State interface
interface State {
	playing: boolean;
}

// Action Types

interface spawn {
	type: "spawn";
}

interface transition_to_menu {
	type: "transition_to_menu";
}

type Action = spawn | transition_to_menu;

// Reducer
const reducer = Rodux.createReducer<State, Action>(
	{ playing: false },
	{
		spawn: (state) => ({
			...state,
			playing: true,
		}),

		transition_to_menu: (state) => ({
			...state,
			playing: false,
		}),
	},
);

// Create store
export const game_state_store = new Rodux.Store(reducer);

// Export action creaters
export const game_state_actions = {
	spawn: (): spawn => ({
		type: "spawn",
	}),
	transition_to_menu: (): transition_to_menu => ({
		type: "transition_to_menu",
	}),
};
