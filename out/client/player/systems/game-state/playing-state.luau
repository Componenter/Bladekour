-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Combat = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "network", "packets").Combat
local InputAction = TS.import(script, script.Parent.Parent, "input", "types").InputAction
local InputMiddlewareChain = TS.import(script, script.Parent.Parent, "input", "input-middleware-chain").InputMiddlewareChain
local StateMiddleware = TS.import(script, script.Parent.Parent.Parent, "network", "middleware", "send", "state-middleware").StateMiddleware
local PlayingState
do
	PlayingState = setmetatable({}, {
		__tostring = function()
			return "PlayingState"
		end,
	})
	PlayingState.__index = PlayingState
	function PlayingState.new(...)
		local self = setmetatable({}, PlayingState)
		return self:constructor(...) or self
	end
	function PlayingState:constructor(inputManager)
		self.inputManager = inputManager
		self.middleware = InputMiddlewareChain.new():use(StateMiddleware.new())
	end
	function PlayingState:enter()
		self.inputManager:enable()
		-- Subscribe to actions
		self.inputManager:onAction(InputAction.Attack, function(event)
			if not self.middleware:validate(event) then
				return nil
			end
			Combat.Attack.send()
		end)
	end
	function PlayingState:exit()
		self.inputManager:disable()
	end
end
return {
	PlayingState = PlayingState,
}
