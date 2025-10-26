-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Rodux = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "rodux", "src")
-- State interface
-- Action Types
-- Reducer
local reducer = Rodux.createReducer({}, {
	attack = function(state, action)
		local _object = table.clone(state)
		setmetatable(_object, nil)
		local _left = action.player.UserId
		local _object_1 = table.clone(state[action.player.UserId])
		setmetatable(_object_1, nil)
		_object_1.attacking = true
		_object[_left] = _object_1
		return _object
	end,
	stop_attack = function(state, action)
		local _object = table.clone(state)
		setmetatable(_object, nil)
		local _left = action.player.UserId
		local _object_1 = table.clone(state[action.player.UserId])
		setmetatable(_object_1, nil)
		_object_1.attacking = false
		_object[_left] = _object_1
		return _object
	end,
	add_player = function(state, action)
		local _object = table.clone(state)
		setmetatable(_object, nil)
		_object[action.player.UserId] = {
			attacking = false,
		}
		return _object
	end,
})
-- Create store
local combat_state_store = Rodux.Store.new(reducer)
-- Export action creaters
local combat_state_actions = {
	attack = function(player)
		return {
			type = "attack",
			player = player,
		}
	end,
	stop_attack = function(player)
		return {
			type = "stop_attack",
			player = player,
		}
	end,
	add_player = function(player)
		return {
			type = "add_player",
			player = player,
		}
	end,
}
return {
	combat_state_store = combat_state_store,
	combat_state_actions = combat_state_actions,
}
