// Attack types

export interface AttackData {
	attackType: string;
	mousePosition?: Vector3;
	timestamp: number;
}

export interface AttackDataClient {
	attackType: string;
	combo: number;
}

export interface HitResult {
	hit: boolean;
	target?: Player;
	damage: number;
	knockback: Vector3;
	hitPosition?: Vector3;
}
