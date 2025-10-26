export enum InputAction {
	Attack = "Attack",
	Block = "Block",
	StartGrapple = "StartGrapple",
	ReleaseGrapple = "ReleaseGrapple",
	Jump = "Jump",
	Dash = "Dash",
}

export interface InputEvent {
	action: InputAction;
	timestamp: number;
	data?: unknown;
}
