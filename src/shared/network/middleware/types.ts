export interface PacketContext<T = unknown> {
	packet: T;
	player: Player;
	timestamp: number;
	metadata: Map<string, unknown>;
}

export interface ServerMiddleware<T = unknown> {
	name: string;

	// Called before handler - return false to reject packet
	onReceive?(context: PacketContext<T>): boolean;

	// Called after handler
	onResponse?(context: PacketContext<T>, response: unknown): void;

	// Called on error
	onError?(context: PacketContext<T>, error: unknown): void;
}

export interface ClientMiddleware<T = unknown> {
	name: string;

	// Called before sending - return false to cancel
	onSend?(packet: T): boolean;

	// Called when response received
	onReceive?(packet: T): void;

	// Called on error
	onError?(packet: T, error: unknown): void;
}
