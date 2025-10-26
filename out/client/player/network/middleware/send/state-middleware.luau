-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local combat_state_store = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "state", "combat-state").combat_state_store
local StateMiddleware
do
	StateMiddleware = setmetatable({}, {
		__tostring = function()
			return "StateMiddleware"
		end,
	})
	StateMiddleware.__index = StateMiddleware
	function StateMiddleware.new(...)
		local self = setmetatable({}, StateMiddleware)
		return self:constructor(...) or self
	end
	function StateMiddleware:constructor()
		self.name = "State"
	end
	function StateMiddleware:validate(event)
		if event.action == "Attack" then
			local state = combat_state_store:getState()
			if state.attacking then
				return false
			end
		end
		return true
	end
end
return {
	StateMiddleware = StateMiddleware,
}
