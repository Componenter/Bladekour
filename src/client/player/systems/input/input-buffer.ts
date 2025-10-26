import { InputAction, InputEvent } from "./types";

const BUFFER_WINDOW = 0.2; // 200ms buffer window
const MAX_BUFFER_SIZE = 10;

export class InputBuffer {
	private buffer: InputEvent[] = [];

	add(event: InputEvent) {
		this.buffer.push(event);

		// Limit buffer size
		if (this.buffer.size() > MAX_BUFFER_SIZE) {
			this.buffer.shift();
		}

		// Clean old inputs
		this.cleanOldInputs();
	}

	// Get recent inputs within buffer window
	getRecent(withinSeconds: number = BUFFER_WINDOW): InputEvent[] {
		const now = os.clock();
		return this.buffer.filter((event) => now - event.timestamp <= withinSeconds);
	}

	// Check if action was pressed recently
	wasPressed(action: InputAction, withinSeconds: number = BUFFER_WINDOW): boolean {
		return this.getRecent(withinSeconds).some((event) => event.action === action);
	}

	// Get sequence of actions (for combos)
	getSequence(actions: InputAction[], maxTimeBetween: number = 0.3): boolean {
		const recent = this.getRecent(actions.size() * maxTimeBetween);

		if (recent.size() < actions.size()) return false;

		let actionIndex = 0;
		for (const event of recent) {
			if (event.action === actions[actionIndex]) {
				actionIndex++;
				if (actionIndex === actions.size()) return true;
			}
		}

		return false;
	}

	clear() {
		this.buffer.clear();
	}

	private cleanOldInputs() {
		const now = os.clock();
		this.buffer = this.buffer.filter((event) => now - event.timestamp <= 1); // Keep last 1 second
	}
}
