-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Players = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").Players
local _game_state = TS.import(script, game:GetService("ServerScriptService"), "TS", "systems", "state", "game-state")
local game_state_actions = _game_state.game_state_actions
local game_state_store = _game_state.game_state_store
local GameState = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "network", "packets").GameState
local function setup_server_states()
	local function PlayerAdded(player)
		player.CharacterAdded:Wait()
		game_state_store:dispatch(game_state_actions.add_player(player))
		player.CharacterAdded:Connect(function()
			game_state_store:dispatch(game_state_actions.transition_to_menu(player))
			GameState.TransitionState.sendTo("Menu", player)
		end)
	end
	local function PlayerRemoving(player)
		game_state_store:dispatch(game_state_actions.remove_player(player))
	end
	for _, player in Players:GetPlayers() do
		task.spawn(PlayerAdded, player)
	end
	Players.PlayerAdded:Connect(PlayerAdded)
	Players.PlayerRemoving:Connect(PlayerRemoving)
end
return {
	setup_server_states = setup_server_states,
}
