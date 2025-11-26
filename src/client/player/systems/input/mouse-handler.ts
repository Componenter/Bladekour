import { Players, UserInputService } from "@rbxts/services";
import { InputAction, InputEvent } from "./types";

const player = Players.LocalPlayer;
const mouse = player.GetMouse();

export class MouseHandler {
	private callbacks = new Map<InputAction, Set<(event: InputEvent) => void>>();

	initialize() {
		// Left/Right click

		let GrappleToggle = false;

		UserInputService.InputBegan.Connect((input, gameProcessed) => {
			if (gameProcessed) return;

			if (input.UserInputType === Enum.UserInputType.MouseButton1) {
				this.triggerAction(InputAction.Attack, {
					position: mouse.Hit.Position,
				});
			}

			if (input.UserInputType === Enum.UserInputType.MouseButton2) {
				if (GrappleToggle) {
					GrappleToggle = false;

					this.triggerAction(InputAction.ReleaseGrapple);
				} else {
					GrappleToggle = true;
					this.triggerAction(InputAction.StartGrapple, {
						position: mouse.Hit.Position,
						mouseHit: mouse.Target,
					});
				}
			}
		});
	}

	on(action: InputAction, callback: (event: InputEvent) => void) {
		if (!this.callbacks.has(action)) {
			this.callbacks.set(action, new Set());
		}
		this.callbacks.get(action)!.add(callback);
	}

	off(action: InputAction, callback: (event: InputEvent) => void) {
		this.callbacks.get(action)?.delete(callback);
	}

	private triggerAction(action: InputAction, data?: unknown) {
		const event: InputEvent = {
			action: action,
			timestamp: os.clock(),
			data: data,
		};

		const callbacks = this.callbacks.get(action);
		if (callbacks) {
			callbacks.forEach((callback) => callback(event));
		}
	}

	getMousePosition(): Vector3 {
		return mouse.Hit.Position;
	}

	getMouseTarget(): BasePart | undefined {
		return mouse.Target;
	}
}
