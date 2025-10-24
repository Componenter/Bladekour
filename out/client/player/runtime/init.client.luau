-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local setupClientNetworking = TS.import(script, script.Parent, "network", "setup").setupClientNetworking
local setup_menu_camera = TS.import(script, script.Parent, "systems", "menu", "camera-controller").setup_menu_camera
-- Setup networking
task.spawn(setupClientNetworking)
task.spawn(setup_menu_camera)
