import { PacketContext, ServerMiddleware } from "./types";

export class MiddlewareChain<T> {
	private middlewares: ServerMiddleware<T>[] = [];

	use(middleware: ServerMiddleware<T>): this {
		this.middlewares.push(middleware);
		return this;
	}

	execute(context: PacketContext<T>, handler: (ctx: PacketContext<T>) => unknown): void {
		// Execute onReceive chain
		for (const middleware of this.middlewares) {
			if (middleware.onReceive !== undefined) {
				const shouldContinue = middleware.onReceive(context);
				if (!shouldContinue) {
					print(`Packet rejected by ${middleware.name}`);
					return; // Stop execution
				}
			}
		}

		try {
			// Execute actual handler
			const response = handler(context);

			// Execute onResponse chain (reverse order)
			for (let i = this.middlewares.size() - 1; i >= 0; i--) {
				const middleware = this.middlewares[i];
				if (middleware.onResponse !== undefined) {
					middleware.onResponse(context, response);
				}
			}
		} catch (error) {
			// Execute onError chain
			for (const middleware of this.middlewares) {
				if (middleware.onError !== undefined) {
					middleware.onError(context, error);
				}
			}
			warn(`Handler error: ${error}`);
		}
	}
}
