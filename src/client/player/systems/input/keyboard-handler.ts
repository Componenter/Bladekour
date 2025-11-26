import { UserInputService } from "@rbxts/services";
import { InputAction, InputEvent } from "./types";

export class KeyboardHandler {
	private callbacks = new Map<InputAction, Set<(event: InputEvent) => void>>();

	// Key bindings
	private keyBindings = new Map<Enum.KeyCode, InputAction>([
		[Enum.KeyCode.Q, InputAction.Attack],
		[Enum.KeyCode.F, InputAction.Block],
		[Enum.KeyCode.Space, InputAction.Jump],
		[Enum.KeyCode.LeftShift, InputAction.Dash],
		[Enum.KeyCode.W, InputAction.W],
		[Enum.KeyCode.S, InputAction.S],
	]);

	initialize() {
		UserInputService.InputBegan.Connect((input, gameProcessed) => {
			if (gameProcessed) return;

			const action = this.keyBindings.get(input.KeyCode);
			if (action) {
				this.triggerAction(action);
			}
		});

		UserInputService.InputEnded.Connect((input, gameProcessed) => {
			if (gameProcessed) return;

			// Handle key release if needed
			// Example: releasing block key
			if (input.KeyCode === Enum.KeyCode.E) {
				// Could trigger "StopBlocking" action
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

	private triggerAction(action: InputAction) {
		const event: InputEvent = {
			action: action,
			timestamp: os.clock(),
		};

		const callbacks = this.callbacks.get(action);
		if (callbacks) {
			callbacks.forEach((callback) => callback(event));
		}
	}

	rebindKey(keyCode: Enum.KeyCode, action: InputAction) {
		this.keyBindings.set(keyCode, action);
	}
}
