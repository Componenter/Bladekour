import Rodux from "@rbxts/rodux";

// State interface
interface State {
	attacking: boolean;
}

// Action Types

interface attack {
	type: "attack";
}

interface stop_attack {
	type: "stop_attack";
}

type Action = attack | stop_attack;

// Reducer
const reducer = Rodux.createReducer<State, Action>(
	{ attacking: false },
	{
		attack: (state) => ({
			...state,
			attacking: true,
		}),

		stop_attack: (state) => ({
			...state,
			attacking: false,
		}),
	},
);

// Create store
export const combat_state_store = new Rodux.Store(reducer);

// Export action creaters
export const combat_state_actions = {
	attack: (): attack => ({
		type: "attack",
	}),
	stop_attack: (): stop_attack => ({
		type: "stop_attack",
	}),
};
