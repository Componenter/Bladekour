import { Combat, GameState, Movement } from "shared/network/packets";
import { game_state_store } from "shared/state/game-state";
import { InputManager } from "../input/input-manager";
import { InputAction } from "../input/types";
import { InputMiddlewareChain } from "../input/input-middleware-chain";
import { StateMiddleware } from "client/player/network/middleware/send/state-middleware";
import { AttackData } from "shared/types/combat/attack";
import { Players } from "@rbxts/services";
import { GrappleData } from "shared/types/movement/grapple";

export class PlayingState {
	private inputManager: InputManager;
	private middleware: InputMiddlewareChain;

	constructor(inputManager: InputManager) {
		this.inputManager = inputManager;

		this.middleware = new InputMiddlewareChain().use(new StateMiddleware());
	}

	enter() {
		const mouse = Players.LocalPlayer.GetMouse();

		this.inputManager.enable();

		// Subscribe to actions
		this.inputManager.onAction(InputAction.Attack, (event) => {
			if (!this.middleware.validate(event)) return;
			const AttackData = {
				attackType: "Light",
				mousePosition: new Vector3(mouse.X, mouse.Y, 0),
				timestamp: tick(),
			} as AttackData;

			Combat.Attack.send(AttackData);
		});

		this.inputManager.onAction(InputAction.W, (event) => {
			if (!this.middleware.validate(event)) return;
			Movement.GrappleMovement.send("W");
		});

		this.inputManager.onAction(InputAction.S, (event) => {
			if (!this.middleware.validate(event)) return;
			Movement.GrappleMovement.send("S");
		});

		this.inputManager.onAction(InputAction.StartGrapple, (event) => {
			if (!this.middleware.validate(event)) return;

			const eventData: { position: Vector3; mouseHit: BasePart | undefined } = event.data as unknown as {
				position: Vector3;
				mouseHit: BasePart | undefined;
			};

			const GrappleData: GrappleData = {
				GrappleEventType: "StartGrapple",
				MouseHitPart: eventData.mouseHit,
				MousePosition3DSpace: eventData.position,
			};

			Movement.Grapple.send(GrappleData);
		});

		this.inputManager.onAction(InputAction.ReleaseGrapple, (event) => {
			if (!this.middleware.validate(event)) return;

			const GrappleData: GrappleData = {
				GrappleEventType: "ReleaseGrapple",
			};

			Movement.Grapple.send(GrappleData);
		});
	}

	exit() {
		this.inputManager.disable();
	}
}
