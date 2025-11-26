-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- Server entry
local ProfileCache = TS.import(script, game:GetService("ServerScriptService"), "TS", "data", "player-data-store")
local setupNetworking = TS.import(script, game:GetService("ServerScriptService"), "TS", "network", "setup").setupNetworking
local CombatSystem = TS.import(script, game:GetService("ServerScriptService"), "TS", "systems", "combat", "combat-system").CombatSystem
local ComboTracker = TS.import(script, game:GetService("ServerScriptService"), "TS", "systems", "combat", "combo-tracker").ComboTracker
local DamageHandler = TS.import(script, game:GetService("ServerScriptService"), "TS", "systems", "combat", "damage-handler").DamageHandler
local HitResolver = TS.import(script, game:GetService("ServerScriptService"), "TS", "systems", "combat", "hit-resolver").HitResolver
local setup_server_game_state_managers = TS.import(script, game:GetService("ServerScriptService"), "TS", "systems", "game-state", "setup").setup_server_game_state_managers
local GrappleSystem = TS.import(script, game:GetService("ServerScriptService"), "TS", "systems", "movement", "grapple-system").GrappleSystem
local PlayerManager = TS.import(script, game:GetService("ServerScriptService"), "TS", "systems", "player", "player-manager").PlayerManager
local setup_server_states = TS.import(script, game:GetService("ServerScriptService"), "TS", "systems", "state", "setup").setup_server_states
task.spawn(function()
	local _ = next(ProfileCache) == nil
end)
task.spawn(setup_server_states)
task.spawn(function()
	setup_server_game_state_managers()
end)
local playerManager = PlayerManager.new()
task.spawn(function()
	playerManager:initialize()
end)
local hitResolver = HitResolver.new(playerManager)
local damageHandler = DamageHandler.new(playerManager)
local comboTracker = ComboTracker.new()
local combatSystem = CombatSystem.new(playerManager, hitResolver, damageHandler, comboTracker)
local grappleSystem = GrappleSystem.new(playerManager)
task.spawn(setupNetworking, combatSystem, grappleSystem)
