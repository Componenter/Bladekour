-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local setup_spawn_manager = TS.import(script, game:GetService("ServerScriptService"), "TS", "systems", "game-state", "spawn-manager").setup_spawn_manager
local function setup_server_game_state_managers()
	setup_spawn_manager()
end
return {
	setup_server_game_state_managers = setup_server_game_state_managers,
}
