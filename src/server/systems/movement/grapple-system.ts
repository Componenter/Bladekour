// Grapple system

import { GrappleData, VisualizeGrappleRopeData } from "shared/types/movement/grapple";
import { PlayerManager } from "../player/player-manager";
import { GameState } from "shared/network/packets";
import { PositionSync } from "./position-sync";
import { grappleValidator } from "./grapple-validator";
import { GrappleRopeVisualizer } from "./grapple-rope-visualizer";
import { GrapplePhysics } from "./physics-engine";

export class GrappleSystem {
	positionSync: PositionSync;
	grappleValidator: grappleValidator;
	grappleRopeVisualizer: GrappleRopeVisualizer;
	physicsEngine: GrapplePhysics;

	constructor(private PlayerManager: PlayerManager) {
		this.positionSync = new PositionSync();
		this.grappleValidator = new grappleValidator();
		this.grappleRopeVisualizer = new GrappleRopeVisualizer();
		this.physicsEngine = new GrapplePhysics();
	}

	public process(packet: GrappleData, player: Player) {
		if (packet.GrappleEventType === "StartGrapple") {
			const grapplePart = packet.MouseHitPart;
			if (grapplePart && grapplePart.Transparency < 0.3) {
				if (!this.grappleValidator.canGrapple(packet.MousePosition3DSpace as Vector3, player)) return;

				this.PlayerManager.setState(player, { isGrappling: true });

				const visualizeGrappleData: VisualizeGrappleRopeData = {
					Player: player,
					hitPosition: packet.MousePosition3DSpace as Vector3,
				};

				this.grappleRopeVisualizer.showGrappleRope(visualizeGrappleData);

				this.physicsEngine.startGrapple(player, packet.MousePosition3DSpace as Vector3);
			}
		} else {
			if (packet.GrappleEventType === "ReleaseGrapple") {
				this.PlayerManager.setState(player, { isGrappling: false });

				this.grappleRopeVisualizer.removeGrappleRope(player);
				this.physicsEngine.stopGrapple(player);
			}
		}
	}

	public processInput(input: string, player: Player) {
		const character = player.Character;
		const root = character?.WaitForChild("HumanoidRootPart", 3) as BasePart;
		if (!root) return;

		let direction: number | undefined = undefined;
		if (input === "W") {
			direction = 1;
		}
		if (input === "S") {
			direction = -1;
		}

		if (input === "None") {
			direction = 0;
		}

		if (direction !== undefined) {
			this.physicsEngine.applySwingInput(player, direction);
		}
	}
}
