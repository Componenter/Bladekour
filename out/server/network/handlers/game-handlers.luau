-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local ProfileCache = TS.import(script, game:GetService("ServerScriptService"), "TS", "data", "player-data-store")
local MiddlewareChain = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "network", "middleware", "middleware-chain").MiddlewareChain
local GameState = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "network", "packets").GameState
local RateLimiterMiddleware = TS.import(script, game:GetService("ServerScriptService"), "TS", "network", "middleware", "anti-cheat", "rate-limiter-middleware").RateLimiterMiddleware
local function setupGameHandlers()
	local chain = MiddlewareChain.new():use(RateLimiterMiddleware)
	GameState.RequestData.listen(function(data, player)
		player = player
		local context = {
			packet = data,
			player = player,
			timestamp = os.clock(),
			metadata = {},
		}
		chain:execute(context, function(ctx)
			local _requestData = GameState.RequestData
			local _player = player
			local _result = ProfileCache[_player]
			if _result ~= nil then
				_result = _result.Data
			end
			_requestData.sendTo(_result, player)
		end)
	end)
end
return {
	setupGameHandlers = setupGameHandlers,
}
