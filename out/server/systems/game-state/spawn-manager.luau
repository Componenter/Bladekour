-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- Spawn manager
local game_state_store = TS.import(script, game:GetService("ServerScriptService"), "TS", "systems", "state", "game-state").game_state_store
local function setup_spawn_manager()
	game_state_store.changed:connect(function(newState, oldState)
		local changed_player = nil
		local changed_player_state = nil
		for index, state in pairs(newState) do
			if oldState[index] ~= newState[index] then
				changed_player = state.player
				changed_player_state = state
			end
		end
		if changed_player and changed_player_state then
			if (oldState[changed_player.UserId] or {
				playing = nil,
			}).playing ~= changed_player_state.playing then
				local character = changed_player.Character
				if not character then
					return nil
				end
				local root = character:WaitForChild("HumanoidRootPart")
				if changed_player_state.playing then
					root.Anchored = false
					root.CFrame = CFrame.new(-918.668, 45.088, 1093.752)
				else
					if not changed_player_state.playing then
						root.Anchored = true
					end
				end
			end
		end
	end)
end
return {
	setup_spawn_manager = setup_spawn_manager,
}
