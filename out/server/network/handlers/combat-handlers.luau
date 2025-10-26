-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local MiddlewareChain = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "network", "middleware", "middleware-chain").MiddlewareChain
local RateLimiterMiddleware = TS.import(script, game:GetService("ServerScriptService"), "TS", "network", "middleware", "anti-cheat", "rate-limiter-middleware").RateLimiterMiddleware
local Combat = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "network", "packets").Combat
local _combat_state = TS.import(script, game:GetService("ServerScriptService"), "TS", "systems", "state", "combat-state")
local combat_state_actions = _combat_state.combat_state_actions
local combat_state_store = _combat_state.combat_state_store
local StateMiddleware = TS.import(script, game:GetService("ServerScriptService"), "TS", "network", "middleware", "anti-cheat", "state-middleware").StateMiddleware
local function setupCombatHandlers()
	local chain = MiddlewareChain.new():use(RateLimiterMiddleware):use(StateMiddleware)
	Combat.Attack.listen(function(data, player)
		player = player
		local context = {
			packet = data,
			player = player,
			timestamp = os.clock(),
			metadata = {},
		}
		chain:execute(context, function(ctx)
			combat_state_store:dispatch(combat_state_actions.attack(player))
			Combat.Attack.sendTo(nil, player)
			task.wait(0.5)
			combat_state_store:dispatch(combat_state_actions.stop_attack(player))
		end)
	end)
end
return {
	setupCombatHandlers = setupCombatHandlers,
}
