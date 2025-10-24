import Rodux from "@rbxts/rodux";

// State interface
interface State {
	menu_visible: boolean;
	playing: boolean;
}

// Action Types

interface toggle_menu {
	type: "toggle_menu";
}

type Action = toggle_menu;

// Reducer
const reducer = Rodux.createReducer<State, Action>(
	{ menu_visible: true, playing: false },
	{
		toggle_menu: (state) => ({
			...state,
			menu_visible: !state.menu_visible,
		}),
	},
);

// Create store
export const store = new Rodux.Store(reducer);

// Export action creaters
export const Actions = {
	toggle_menu: (): toggle_menu => ({
		type: "toggle_menu",
	}),
};
