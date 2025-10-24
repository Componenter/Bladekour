-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Rodux = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "rodux", "src")
-- State interface
-- Action Types
-- Reducer
local reducer = Rodux.createReducer({
	playing = false,
}, {
	spawn = function(state)
		local _object = table.clone(state)
		setmetatable(_object, nil)
		_object.playing = true
		return _object
	end,
	transition_to_menu = function(state)
		local _object = table.clone(state)
		setmetatable(_object, nil)
		_object.playing = false
		return _object
	end,
})
-- Create store
local game_state_store = Rodux.Store.new(reducer)
-- Export action creaters
local game_state_actions = {
	spawn = function()
		return {
			type = "spawn",
		}
	end,
	transition_to_menu = function()
		return {
			type = "transition_to_menu",
		}
	end,
}
return {
	game_state_store = game_state_store,
	game_state_actions = game_state_actions,
}
