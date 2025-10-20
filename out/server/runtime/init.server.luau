-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- Server entry
local ProfileCache = TS.import(script, game:GetService("ServerScriptService"), "TS", "data", "player-data-store")
local setupNetworking = TS.import(script, game:GetService("ServerScriptService"), "TS", "network", "setup").setupNetworking
local _ = next(ProfileCache) == nil
setupNetworking()
