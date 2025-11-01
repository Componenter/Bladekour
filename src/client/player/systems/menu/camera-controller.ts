import { Players, Workspace } from "@rbxts/services";
import { game_state_store } from "shared/state/game-state";

export function setup_menu_camera() {
	const camera = Workspace.CurrentCamera as Camera;

	let is_menu = true;

	const rad = math.rad;

	game_state_store.changed.connect((newState, oldState) => {
		if (newState.playing !== oldState.playing) {
			if (newState.playing) {
				is_menu = false;
			} else {
				if (!newState.playing) {
					is_menu = true;
				}
			}
		}
	});

	while (task.wait(1)) {
		if (is_menu) {
			camera.CameraType = Enum.CameraType.Scriptable;
			camera.CFrame = new CFrame(-899.765, 85.113, 1130.13).mul(
				CFrame.fromOrientation(rad(-23.792), rad(54.208), rad(0)),
			);
		} else {
			camera.CameraType = Enum.CameraType.Custom;
			camera.CameraSubject = (Players.LocalPlayer.Character as Model).FindFirstChildOfClass("Humanoid");
		}
	}
}
