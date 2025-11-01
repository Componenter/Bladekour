-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local MiddlewareChain = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "network", "middleware", "middleware-chain").MiddlewareChain
local RateLimiterMiddleware = TS.import(script, game:GetService("ServerScriptService"), "TS", "network", "middleware", "anti-cheat", "rate-limiter-middleware").RateLimiterMiddleware
local Combat = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "network", "packets").Combat
local StateMiddleware = TS.import(script, game:GetService("ServerScriptService"), "TS", "network", "middleware", "anti-cheat", "state-middleware").StateMiddleware
local function setupCombatHandlers(combatSystem)
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
			combatSystem:processAttack(player, ctx.packet)
		end)
	end)
end
return {
	setupCombatHandlers = setupCombatHandlers,
}
