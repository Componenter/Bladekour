-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local setupClientNetworking = TS.import(script, script.Parent, "network", "setup").setupClientNetworking
local setup_menu_camera = TS.import(script, script.Parent, "systems", "menu", "camera-controller").setup_menu_camera
local InputManager = TS.import(script, script.Parent, "systems", "input", "input-manager").InputManager
local TransitionManager = TS.import(script, script.Parent, "systems", "game-state", "transition-manager").TransitionManager
local PlayingState = TS.import(script, script.Parent, "systems", "game-state", "playing-state").PlayingState
-- Setup networking
task.spawn(setup_menu_camera)
local inputManager = InputManager.new()
task.spawn(function()
	inputManager:initialize()
end)
local playingState = PlayingState.new(inputManager)
local transitionManager = TransitionManager.new(playingState)
task.spawn(setupClientNetworking, transitionManager)
