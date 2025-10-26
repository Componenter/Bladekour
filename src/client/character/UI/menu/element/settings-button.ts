import Roact from "@rbxts/roact";
import { Actions, store } from "../../store";
import { game_state_actions, game_state_store } from "shared/state/game-state";
import { GameState } from "shared/network/packets";
import { button } from "../component/button";

export function settings_button() {
	return Roact.createElement(button, {
		Position: new UDim2(0.07, 0, 0.35, 0),
		Text: "SETTINGS",
		onClick: () => {
			store.dispatch(Actions.go_settings());
		},
	});
}
