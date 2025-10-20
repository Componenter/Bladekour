-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local exports = {}
for _k, _v in TS.import(script, game:GetService("ReplicatedStorage"), "TS", "network", "packets", "combat") or {} do
	exports[_k] = _v
end
for _k, _v in TS.import(script, game:GetService("ReplicatedStorage"), "TS", "network", "packets", "movement") or {} do
	exports[_k] = _v
end
for _k, _v in TS.import(script, game:GetService("ReplicatedStorage"), "TS", "network", "packets", "game-state") or {} do
	exports[_k] = _v
end
return exports
