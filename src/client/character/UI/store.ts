import Rodux from "@rbxts/rodux";

// State interface
interface State {
	menu_visible: boolean;
	home_page_visible: boolean;
	settings_page_visible: boolean;
	playing: boolean;
}

// Action Types

interface toggle_menu {
	type: "toggle_menu";
}

interface go_settings {
	type: "go_settings";
}

interface go_home_page {
	type: "go_home_page";
}

type Action = toggle_menu | go_settings | go_home_page;

// Reducer
const reducer = Rodux.createReducer<State, Action>(
	{ menu_visible: true, home_page_visible: true, settings_page_visible: false, playing: false },
	{
		toggle_menu: (state) => ({
			...state,
			menu_visible: !state.menu_visible,
		}),
		go_settings: (state) => ({
			...state,
			settings_page_visible: true,
			home_page_visible: false,
		}),
		go_home_page: (state) => ({
			...state,
			home_page_visible: true,
			settings_page_visible: false,
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
	go_settings: (): go_settings => ({
		type: "go_settings",
	}),
	go_home_page: (): go_home_page => ({
		type: "go_home_page",
	}),
};
