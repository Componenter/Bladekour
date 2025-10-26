-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local combat_state_store = TS.import(script, game:GetService("ServerScriptService"), "TS", "systems", "state", "combat-state").combat_state_store
local StateMiddleware = {
	name = "RateLimiter",
	onReceive = function(self, context)
		local state = combat_state_store:getState()[context.player.UserId]
		if state.attacking then
			return false
		end
		return true
	end,
}
return {
	StateMiddleware = StateMiddleware,
}
