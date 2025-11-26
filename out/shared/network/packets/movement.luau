-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local ByteNet = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "bytenet", "src")
local Movement = ByteNet.defineNamespace("Movement", function()
	return {
		Grapple = ByteNet.definePacket({
			value = ByteNet.unknown,
			reliabilityType = "reliable",
		}),
		GrappleMovement = ByteNet.definePacket({
			value = ByteNet.string,
			reliabilityType = "reliable",
		}),
	}
end)
return {
	Movement = Movement,
}
