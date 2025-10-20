-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local exports = {}
for _k, _v in TS.import(script, script, "core", "logging-middleware") or {} do
	exports[_k] = _v
end
for _k, _v in TS.import(script, script, "core", "timing-middleware") or {} do
	exports[_k] = _v
end
for _k, _v in TS.import(script, game:GetService("ReplicatedStorage"), "TS", "network", "middleware", "types") or {} do
	exports[_k] = _v
end
return exports
