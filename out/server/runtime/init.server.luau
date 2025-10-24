-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- Server entry
local ProfileCache = TS.import(script, game:GetService("ServerScriptService"), "TS", "data", "player-data-store")
local setupNetworking = TS.import(script, game:GetService("ServerScriptService"), "TS", "network", "setup").setupNetworking
local setup_server_game_state_managers = TS.import(script, game:GetService("ServerScriptService"), "TS", "systems", "game-state", "setup").setup_server_game_state_managers
local setup_server_states = TS.import(script, game:GetService("ServerScriptService"), "TS", "systems", "state", "setup").setup_server_states
task.spawn(function()
	local _ = next(ProfileCache) == nil
end)
task.spawn(setupNetworking)
task.spawn(setup_server_states)
task.spawn(function()
	setup_server_game_state_managers()
end)
