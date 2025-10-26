-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Roact = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "roact", "src", "ts")
local _store = TS.import(script, script.Parent.Parent.Parent, "store")
local Actions = _store.Actions
local store = _store.store
local _game_state = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "state", "game-state")
local game_state_actions = _game_state.game_state_actions
local game_state_store = _game_state.game_state_store
local GameState = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "network", "packets").GameState
local button = TS.import(script, script.Parent.Parent, "component", "button").button
local function play_button()
	return Roact.createElement(button, {
		Position = UDim2.new(0.07, 0, 0.25, 0),
		Text = "PLAY",
		onClick = function()
			store:dispatch(Actions.toggle_menu())
			game_state_store:dispatch(game_state_actions.spawn())
			GameState.TransitionState.send("Playing")
		end,
	})
end
return {
	play_button = play_button,
}
