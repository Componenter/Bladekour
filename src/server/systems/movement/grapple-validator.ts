// Grapple validations

// Position sync

import { MAX_GRAPPLE_Y_SIZE, MIN_GRAPPLE_Y_SIZE } from "shared/constants/movement/grapple";

export class grappleValidator {
	public canGrapple(hitPosition: Vector3, player: Player): boolean {
		const character = player.Character as Model;
		if (!character) return false;

		const humanoid = character.FindFirstChildOfClass("Humanoid");

		if (!humanoid) return false;
		if (humanoid.GetState() === Enum.HumanoidStateType.Dead) return false;

		const left_arm = character.FindFirstChild("Left Arm") as BasePart;
		const hand_position = left_arm.Position.sub(new Vector3(0, left_arm.Size.Y / 2.1, 0));

		const dist = hitPosition.sub(hand_position).Magnitude;

		if (dist > MAX_GRAPPLE_Y_SIZE) return false;
		if (dist < MIN_GRAPPLE_Y_SIZE) return false;

		return true;
	}
}
