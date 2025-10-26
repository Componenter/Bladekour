-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Rodux = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "rodux", "src")
-- State interface
-- Action Types
-- Reducer
local reducer = Rodux.createReducer({
	menu_visible = true,
	home_page_visible = true,
	settings_page_visible = false,
	playing = false,
}, {
	toggle_menu = function(state)
		local _object = table.clone(state)
		setmetatable(_object, nil)
		_object.menu_visible = not state.menu_visible
		return _object
	end,
	go_settings = function(state)
		local _object = table.clone(state)
		setmetatable(_object, nil)
		_object.settings_page_visible = true
		_object.home_page_visible = false
		return _object
	end,
	go_home_page = function(state)
		local _object = table.clone(state)
		setmetatable(_object, nil)
		_object.home_page_visible = true
		_object.settings_page_visible = false
		return _object
	end,
})
-- Create store
local store = Rodux.Store.new(reducer)
-- Export action creaters
local Actions = {
	toggle_menu = function()
		return {
			type = "toggle_menu",
		}
	end,
	go_settings = function()
		return {
			type = "go_settings",
		}
	end,
	go_home_page = function()
		return {
			type = "go_home_page",
		}
	end,
}
return {
	store = store,
	Actions = Actions,
}
