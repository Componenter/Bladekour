-- Compiled with roblox-ts v3.0.0
local RATE_LIMIT = 10
local playerBuckets = {}
local RateLimiterMiddleware = {
	name = "RateLimiter",
	onReceive = function(self, context)
		local now = os.clock()
		local _player = context.player
		local _condition = playerBuckets[_player]
		if not _condition then
			_condition = {}
		end
		local bucket = _condition
		-- Remove old timestamps (older than 1 second)
		-- ▼ ReadonlyArray.filter ▼
		local _newValue = {}
		local _callback = function(t)
			return now - t < 1
		end
		local _length = 0
		for _k, _v in bucket do
			if _callback(_v, _k - 1, bucket) == true then
				_length += 1
				_newValue[_length] = _v
			end
		end
		-- ▲ ReadonlyArray.filter ▲
		local recent = _newValue
		-- Check rate limit
		if #recent >= RATE_LIMIT then
			warn(`Rate limit exceeded: {context.player.Name}`)
			return false
		end
		-- Add new timestamp
		table.insert(recent, now)
		local _player_1 = context.player
		playerBuckets[_player_1] = recent
		return true
	end,
}
return {
	RateLimiterMiddleware = RateLimiterMiddleware,
}
