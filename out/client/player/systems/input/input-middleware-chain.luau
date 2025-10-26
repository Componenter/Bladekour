-- Compiled with roblox-ts v3.0.0
local InputMiddlewareChain
do
	InputMiddlewareChain = setmetatable({}, {
		__tostring = function()
			return "InputMiddlewareChain"
		end,
	})
	InputMiddlewareChain.__index = InputMiddlewareChain
	function InputMiddlewareChain.new(...)
		local self = setmetatable({}, InputMiddlewareChain)
		return self:constructor(...) or self
	end
	function InputMiddlewareChain:constructor()
		self.middlewares = {}
	end
	function InputMiddlewareChain:use(middleware)
		local _middlewares = self.middlewares
		local _middleware = middleware
		table.insert(_middlewares, _middleware)
		return self
	end
	function InputMiddlewareChain:validate(event)
		for _, middleware in self.middlewares do
			if not middleware:validate(event) then
				print(`Action blocked by {middleware.name}`)
				return false
			end
		end
		return true
	end
end
return {
	InputMiddlewareChain = InputMiddlewareChain,
}
