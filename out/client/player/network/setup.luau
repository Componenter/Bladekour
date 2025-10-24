-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local setupGameListeners = TS.import(script, script.Parent, "listeners", "game-listeners").setupGameListeners
local setupCombatListeners = TS.import(script, script.Parent, "listeners", "combat-listeners").setupCombatListeners
local setupMovementListeners = TS.import(script, script.Parent, "listeners", "movement-listeners").setupMovementListeners
local function setupClientNetworking()
	-- Setup listeners
	setupGameListeners()
	setupCombatListeners()
	setupMovementListeners()
end
return {
	setupClientNetworking = setupClientNetworking,
}
