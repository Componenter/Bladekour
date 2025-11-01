// Damage calculation

import { DAMAGE_VALUES } from "shared/constants/combat/damage";

export function calculateDamage(attackType: string): number {
	return DAMAGE_VALUES[attackType as keyof typeof DAMAGE_VALUES] || DAMAGE_VALUES.light;
}
