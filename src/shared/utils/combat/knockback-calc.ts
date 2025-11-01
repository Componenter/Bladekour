// Knockback calculation

import { KNOCKBACK_VALUES } from "shared/constants/combat/knockback";

export function calculateKnockback(attackType: string, attackerPosition: Vector3, targetPosition: Vector3): Vector3 {
	const direction = targetPosition.sub(attackerPosition).Unit;
	const force = KNOCKBACK_VALUES[attackType as keyof typeof KNOCKBACK_VALUES] || KNOCKBACK_VALUES.light;

	// Add upward component
	return new Vector3(
		direction.X * force,
		force * 0.5, // Half force upward
		direction.Z * force,
	);
}
