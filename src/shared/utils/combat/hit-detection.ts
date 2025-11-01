// Hit detection

import { HITBOX_CONFIG } from "shared/constants/combat/hitboxes";

export function isInAttackRange(
	attackerPosition: Vector3,
	attackerLookVector: Vector3,
	targetPosition: Vector3,
): boolean {
	const toTarget = targetPosition.sub(attackerPosition);
	const distance = toTarget.Magnitude;

	// Check distance
	if (distance > HITBOX_CONFIG.attackRange) {
		return false;
	}

	// Check angle (cone check)
	const directionToTarget = toTarget.Unit;
	const dotProduct = attackerLookVector.Dot(directionToTarget);
	const angle = math.deg(math.acos(dotProduct));

	return angle <= HITBOX_CONFIG.attackAngle / 2;
}

export function getTargetsInRange(
	attacker: Player,
	attackerPosition: Vector3,
	attackerLookVector: Vector3,
	allPlayers: Player[],
): Player[] {
	const targets: Player[] = [];

	for (const player of allPlayers) {
		if (player === attacker) continue;
		if (!player.Character) continue;

		const humanoidRootPart = player.Character.FindFirstChild("HumanoidRootPart") as BasePart;
		if (!humanoidRootPart) continue;

		const targetPosition = humanoidRootPart.Position;

		if (isInAttackRange(attackerPosition, attackerLookVector, targetPosition)) {
			targets.push(player);
		}
	}

	return targets;
}
