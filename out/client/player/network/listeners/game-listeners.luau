-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local GameState = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "network", "packets").GameState
local _game_state = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "state", "game-state")
local game_state_actions = _game_state.game_state_actions
local game_state_store = _game_state.game_state_store
local function setupGameListeners(transitionManager, hitFeedback, combatSounds)
	GameState.RequestData.listen(function(data, player)
		print("Recieved data: ", data)
	end)
	GameState.TransitionState.listen(function(state)
		if state == "Menu" then
			game_state_store:dispatch(game_state_actions.transition_to_menu())
			transitionManager:transition("Menu")
		end
	end)
	GameState.PlayerHit.listen(function(data)
		print(`Got hit for {data.damage} damage!`)
		-- Update health in store
		-- Play hit feedback
		hitFeedback:onTakeDamage(data.damage, data.knockback)
		-- Play hit sound
		combatSounds:playHitSound()
	end)
	-- When we deal damage
	GameState.DamageDealt.listen(function(data)
		print(`Dealt {data.damage} damage!`)
		-- Show hit marker
		-- Play hit confirm sound
		combatSounds:playHitConfirmSound()
	end)
	-- When we die
	GameState.PlayerDied.listen(function(data)
		print("You died!")
		-- Play death sound
		combatSounds:playDeathSound()
		-- Show death effect
		hitFeedback:onDeath()
	end)
end
return {
	setupGameListeners = setupGameListeners,
}
