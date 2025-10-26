-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Rodux = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "rodux", "src")
-- State interface
-- Action Types
-- Reducer
local reducer = Rodux.createReducer({
	attacking = false,
}, {
	attack = function(state)
		local _object = table.clone(state)
		setmetatable(_object, nil)
		_object.attacking = true
		return _object
	end,
	stop_attack = function(state)
		local _object = table.clone(state)
		setmetatable(_object, nil)
		_object.attacking = false
		return _object
	end,
})
-- Create store
local combat_state_store = Rodux.Store.new(reducer)
-- Export action creaters
local combat_state_actions = {
	attack = function()
		return {
			type = "attack",
		}
	end,
	stop_attack = function()
		return {
			type = "stop_attack",
		}
	end,
}
return {
	combat_state_store = combat_state_store,
	combat_state_actions = combat_state_actions,
}
