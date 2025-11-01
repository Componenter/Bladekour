-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local setupCombatHandlers = TS.import(script, game:GetService("ServerScriptService"), "TS", "network", "handlers", "combat-handlers").setupCombatHandlers
local setupGameHandlers = TS.import(script, game:GetService("ServerScriptService"), "TS", "network", "handlers", "game-handlers").setupGameHandlers
local setupMovementHandlers = TS.import(script, game:GetService("ServerScriptService"), "TS", "network", "handlers", "movement-handlers").setupMovementHandlers
local function setupNetworking(combatSystem)
	setupGameHandlers()
	setupCombatHandlers(combatSystem)
	setupMovementHandlers()
	print("Server networking initialized")
end
return {
	setupNetworking = setupNetworking,
}
