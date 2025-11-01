-- Compiled with roblox-ts v3.0.0
-- Hitbox sizes
local hitboxConfigurations = {
	Light = {
		[0] = {
			HitboxSize = Vector3.new(7, 4, 7),
			HitboxOffset = Vector3.new(0, 0, 2),
		},
		[1] = {
			HitboxSize = Vector3.new(7, 4, 7),
			HitboxOffset = Vector3.new(0, 0, 2),
		},
	},
}
local HITBOX_CONFIG = {
	attackRange = 10,
	attackRadius = 5,
	attackAngle = 90,
	hitboxConfigurations = hitboxConfigurations,
}
return {
	HITBOX_CONFIG = HITBOX_CONFIG,
}
