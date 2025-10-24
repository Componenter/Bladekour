-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local GameState = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "network", "packets").GameState
local game_state_store = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "state", "game-state").game_state_store
game_state_store.changed:connect(function(new_state, old_state)
	if new_state.playing ~= old_state.playing then
		if new_state.playing then
			GameState.TransitionState.send("Playing")
		end
	end
end)
return nil
