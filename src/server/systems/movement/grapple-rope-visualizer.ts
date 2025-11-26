import { Workspace } from "@rbxts/services";
import { VisualizeGrappleRopeData } from "shared/types/movement/grapple";

export class GrappleRopeVisualizer {
	GrappleRopes = new Map<Player, { rope: RopeConstraint; att0: Attachment; grapplePart: Part }>();

	showGrappleRope(grappleData: VisualizeGrappleRopeData) {
		const character = grappleData.Player.Character as Model;
		const left_arm = character.FindFirstChild("Left Arm") as BasePart;
		const root = character.FindFirstChild("HumanoidRootPart") as BasePart;
	}

	removeGrappleRope(player: Player) {
		const value = this.GrappleRopes.get(player);
		if (value) {
			try {
				value.rope.Destroy();
				value.grapplePart.Destroy();
				value.att0.Destroy();
			} catch {}
		}
	}
}
