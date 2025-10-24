-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Rodux = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "rodux", "src")
-- State interface
-- Action Types
-- Reducer
local reducer = Rodux.createReducer({}, {
	transition_to_playing = function(state, action)
		local _object = table.clone(state)
		setmetatable(_object, nil)
		local _left = action.player.UserId
		local _object_1 = table.clone(state[action.player.UserId])
		setmetatable(_object_1, nil)
		_object_1.playing = true
		_object[_left] = _object_1
		return _object
	end,
	transition_to_menu = function(state, action)
		local _object = table.clone(state)
		setmetatable(_object, nil)
		local _left = action.player.UserId
		local _object_1 = table.clone(state[action.player.UserId])
		setmetatable(_object_1, nil)
		_object_1.playing = false
		_object[_left] = _object_1
		return _object
	end,
	add_player = function(state, action)
		local _object = table.clone(state)
		setmetatable(_object, nil)
		_object[action.player.UserId] = {
			playing = false,
			active = true,
			player = action.player,
		}
		return _object
	end,
	remove_player = function(state, action)
		local _object = table.clone(state)
		setmetatable(_object, nil)
		_object[action.player.UserId] = {
			playing = false,
			active = false,
			player = action.player,
		}
		return _object
	end,
})
-- Create store
local game_state_store = Rodux.Store.new(reducer)
-- Export action creaters
local game_state_actions = {
	transition_to_playing = function(player)
		return {
			type = "transition_to_playing",
			player = player,
		}
	end,
	transition_to_menu = function(player)
		return {
			type = "transition_to_menu",
			player = player,
		}
	end,
	add_player = function(player)
		return {
			type = "add_player",
			player = player,
		}
	end,
	remove_player = function(player)
		return {
			type = "remove_player",
			player = player,
		}
	end,
}
return {
	game_state_store = game_state_store,
	game_state_actions = game_state_actions,
}
