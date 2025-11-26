-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local MiddlewareChain = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "network", "middleware", "middleware-chain").MiddlewareChain
local Movement = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "network", "packets").Movement
local RateLimiterMiddleware = TS.import(script, game:GetService("ServerScriptService"), "TS", "network", "middleware", "anti-cheat", "rate-limiter-middleware").RateLimiterMiddleware
local function setupMovementHandlers(grappleSystem)
	local chain = MiddlewareChain.new():use(RateLimiterMiddleware)
	Movement.Grapple.listen(function(data, player)
		local pck = data
		local context = {
			packet = pck,
			player = player,
			timestamp = os.clock(),
			metadata = {},
		}
		chain:execute(context, function(_ctx)
			local ctx = _ctx
			local packet = ctx.packet
			grappleSystem:process(packet, ctx.player)
		end)
	end)
	Movement.GrappleMovement.listen(function(data, player)
		grappleSystem:processInput(data, player)
	end)
end
return {
	setupMovementHandlers = setupMovementHandlers,
}
