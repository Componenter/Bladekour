-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Roact = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "roact", "src", "ts")
local _store = TS.import(script, script.Parent.Parent.Parent, "store")
local Actions = _store.Actions
local store = _store.store
local button = TS.import(script, script.Parent.Parent, "component", "button").button
local function settings_button()
	return Roact.createElement(button, {
		Position = UDim2.new(0.07, 0, 0.35, 0),
		Text = "SETTINGS",
		onClick = function()
			store:dispatch(Actions.go_settings())
		end,
	})
end
return {
	settings_button = settings_button,
}
