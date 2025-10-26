import { InputEvent } from "./types";

export interface InputMiddleware {
	name: string;
	// Return false to block the action
	validate(event: InputEvent): boolean;
}

export class InputMiddlewareChain {
	private middlewares: InputMiddleware[] = [];

	use(middleware: InputMiddleware): this {
		this.middlewares.push(middleware);
		return this;
	}

	validate(event: InputEvent): boolean {
		for (const middleware of this.middlewares) {
			if (!middleware.validate(event)) {
				print(`Action blocked by ${middleware.name}`);
				return false;
			}
		}
		return true;
	}
}
