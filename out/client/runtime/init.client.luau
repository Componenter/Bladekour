-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local setupClientNetworking = TS.import(script, script.Parent, "network", "setup").setupClientNetworking
-- Setup networking
setupClientNetworking()
