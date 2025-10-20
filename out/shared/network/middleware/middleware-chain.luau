-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local MiddlewareChain
do
	MiddlewareChain = setmetatable({}, {
		__tostring = function()
			return "MiddlewareChain"
		end,
	})
	MiddlewareChain.__index = MiddlewareChain
	function MiddlewareChain.new(...)
		local self = setmetatable({}, MiddlewareChain)
		return self:constructor(...) or self
	end
	function MiddlewareChain:constructor()
		self.middlewares = {}
	end
	function MiddlewareChain:use(middleware)
		local _middlewares = self.middlewares
		local _middleware = middleware
		table.insert(_middlewares, _middleware)
		return self
	end
	function MiddlewareChain:execute(context, handler)
		-- Execute onReceive chain
		for _, middleware in self.middlewares do
			if middleware.onReceive ~= nil then
				local shouldContinue = middleware:onReceive(context)
				if not shouldContinue then
					print(`Packet rejected by {middleware.name}`)
					return nil
				end
			end
		end
		TS.try(function()
			-- Execute actual handler
			local response = handler(context)
			-- Execute onResponse chain (reverse order)
			for i = #self.middlewares - 1, 0, -1 do
				local middleware = self.middlewares[i + 1]
				if middleware.onResponse ~= nil then
					middleware:onResponse(context, response)
				end
			end
		end, function(error)
			-- Execute onError chain
			for _, middleware in self.middlewares do
				if middleware.onError ~= nil then
					middleware:onError(context, error)
				end
			end
			warn(`Handler error: {error}`)
		end)
	end
end
return {
	MiddlewareChain = MiddlewareChain,
}
