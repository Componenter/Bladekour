-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local ByteNet = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "bytenet", "src")
local GameState = ByteNet.defineNamespace("GameState", function()
	return {
		RequestData = ByteNet.definePacket({
			value = ByteNet.unknown,
			reliabilityType = "reliable",
		}),
		TransitionState = ByteNet.definePacket({
			value = ByteNet.string,
			reliabilityType = "reliable",
		}),
		PlayerHit = ByteNet.definePacket({
			value = ByteNet.struct({
				damage = ByteNet.uint8,
				attackerUserId = ByteNet.uint32,
				knockback = ByteNet.vec3,
				attackType = ByteNet.string,
			}),
			reliabilityType = "reliable",
		}),
		DamageDealt = ByteNet.definePacket({
			value = ByteNet.struct({
				targetUserId = ByteNet.uint32,
				damage = ByteNet.uint8,
				knockback = ByteNet.vec3,
			}),
			reliabilityType = "reliable",
		}),
		PlayerDied = ByteNet.definePacket({
			value = ByteNet.struct({
				killerUserId = ByteNet.optional(ByteNet.uint32),
				killerId = ByteNet.optional(ByteNet.uint32),
			}),
			reliabilityType = "reliable",
		}),
	}
end)
return {
	GameState = GameState,
}
