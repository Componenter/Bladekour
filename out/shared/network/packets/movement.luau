-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local ByteNet = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "bytenet", "src")
local Movement = ByteNet.defineNamespace("Movement", function()
	return {}
end)
return {
	Movement = Movement,
}
