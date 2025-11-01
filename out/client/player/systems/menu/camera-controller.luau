-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _services = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services")
local Players = _services.Players
local Workspace = _services.Workspace
local game_state_store = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "state", "game-state").game_state_store
local function setup_menu_camera()
	local camera = Workspace.CurrentCamera
	local is_menu = true
	local rad = math.rad
	game_state_store.changed:connect(function(newState, oldState)
		if newState.playing ~= oldState.playing then
			if newState.playing then
				is_menu = false
			else
				if not newState.playing then
					is_menu = true
				end
			end
		end
	end)
	while true do
		local _value = task.wait(1)
		if not (_value ~= 0 and _value == _value and _value) then
			break
		end
		if is_menu then
			camera.CameraType = Enum.CameraType.Scriptable
			local _cFrame = CFrame.new(-899.765, 85.113, 1130.13)
			local _arg0 = CFrame.fromOrientation(rad(-23.792), rad(54.208), rad(0))
			camera.CFrame = _cFrame * _arg0
		else
			camera.CameraType = Enum.CameraType.Custom
			camera.CameraSubject = (Players.LocalPlayer.Character):FindFirstChildOfClass("Humanoid")
		end
	end
end
return {
	setup_menu_camera = setup_menu_camera,
}
