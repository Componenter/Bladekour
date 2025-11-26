import { KeyboardHandler } from "./keyboard-handler";
import { MouseHandler } from "./mouse-handler";
import { InputBuffer } from "./input-buffer";
import { InputAction, InputEvent } from "./types";

export class InputManager {
	private keyboardHandler: KeyboardHandler;
	private mouseHandler: MouseHandler;
	private inputBuffer: InputBuffer;
	private enabled = false;

	constructor() {
		this.keyboardHandler = new KeyboardHandler();
		this.mouseHandler = new MouseHandler();
		this.inputBuffer = new InputBuffer();
	}

	initialize() {
		this.keyboardHandler.initialize();
		this.mouseHandler.initialize();

		// Route all inputs through buffer
		this.keyboardHandler.on(InputAction.Attack, (event) => this.handleInput(event));
		this.keyboardHandler.on(InputAction.Block, (event) => this.handleInput(event));
		this.keyboardHandler.on(InputAction.Jump, (event) => this.handleInput(event));
		this.keyboardHandler.on(InputAction.Dash, (event) => this.handleInput(event));

		this.keyboardHandler.on(InputAction.W, (event) => this.handleInput(event));
		this.keyboardHandler.on(InputAction.S, (event) => this.handleInput(event));

		this.mouseHandler.on(InputAction.Attack, (event) => this.handleInput(event));
		this.mouseHandler.on(InputAction.StartGrapple, (event) => this.handleInput(event));
		this.mouseHandler.on(InputAction.ReleaseGrapple, (event) => this.handleInput(event));

		print("Input manager initialized");
	}

	enable() {
		this.enabled = true;
	}

	disable() {
		this.enabled = false;
		this.inputBuffer.clear();
	}

	private handleInput(event: InputEvent) {
		if (!this.enabled) return;

		this.inputBuffer.add(event);
	}

	// Subscribe to specific action
	onAction(action: InputAction, callback: (event: InputEvent) => void) {
		this.keyboardHandler.on(action, (event) => {
			if (!this.enabled) return;
			callback(event);
		});
		this.mouseHandler.on(action, (event) => {
			if (!this.enabled) return;
			callback(event);
		});
	}

	// Get the buffer for combo checking
	getBuffer(): InputBuffer {
		return this.inputBuffer;
	}

	// Utility methods
	getMousePosition(): Vector3 {
		return this.mouseHandler.getMousePosition();
	}

	rebindKey(keyCode: Enum.KeyCode, action: InputAction) {
		this.keyboardHandler.rebindKey(keyCode, action);
	}
}
