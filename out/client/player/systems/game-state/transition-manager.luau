-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local GameState = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "network", "packets").GameState
local game_state_store = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "state", "game-state").game_state_store
local TransitionManager
do
	TransitionManager = setmetatable({}, {
		__tostring = function()
			return "TransitionManager"
		end,
	})
	TransitionManager.__index = TransitionManager
	function TransitionManager.new(...)
		local self = setmetatable({}, TransitionManager)
		return self:constructor(...) or self
	end
	function TransitionManager:constructor(playingState)
		self.playingState = playingState
		game_state_store.changed:connect(function(new_state, old_state)
			if new_state.playing ~= old_state.playing then
				if new_state.playing then
					GameState.TransitionState.send("Playing")
					playingState:enter()
				else
					playingState:exit()
				end
			end
		end)
	end
	function TransitionManager:transition(state)
		if state == "Playing" then
			self.playingState:enter()
		end
		if state == "Menu" then
			self.playingState:exit()
		end
	end
end
return {
	TransitionManager = TransitionManager,
}
