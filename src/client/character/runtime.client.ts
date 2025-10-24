// Basically runs UI

import Roact from "@rbxts/roact";
import { App } from "./UI";
import { Players } from "@rbxts/services";

Roact.mount(App, Players.LocalPlayer.FindFirstChildOfClass("PlayerGui"));
