import Roact from "@rbxts/roact";
import { menuframe } from "./menu/element/menu-frame";

export const App = Roact.createElement(
	"ScreenGui",
	{
		IgnoreGuiInset: true,
		Enabled: true,
	},
	{
		menu_frame: Roact.createElement(menuframe),
	},
);
