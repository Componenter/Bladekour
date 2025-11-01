// Hitbox sizes

const hitboxConfigurations = {
	Light: {
		[0]: {
			HitboxSize: new Vector3(7, 4, 7),
			HitboxOffset: new Vector3(0, 0, 2), // Hitbox from character
		},
		[1]: {
			HitboxSize: new Vector3(7, 4, 7),
			HitboxOffset: new Vector3(0, 0, 2), // Hitbox from character
		},
	},
} as { [key: string]: { [index: number]: { HitboxSize: Vector3; HitboxOffset: Vector3 } } };

export const HITBOX_CONFIG = {
	attackRange: 10, // studs
	attackRadius: 5, // studs (cone radius)
	attackAngle: 90, // degrees (cone angle)

	hitboxConfigurations: hitboxConfigurations,
};
