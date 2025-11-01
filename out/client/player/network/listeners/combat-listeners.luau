-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local COOLDOWN_VALUES = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "constants", "combat", "cooldown").COOLDOWN_VALUES
local Combat = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "network", "packets").Combat
local _combat_state = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "state", "combat-state")
local combat_state_actions = _combat_state.combat_state_actions
local combat_state_store = _combat_state.combat_state_store
local function setupCombatListeners(weaponAnimator)
	Combat.Attack.listen(function(packet)
		local data = packet
		weaponAnimator:playAttackAnimation(data.attackType, data.combo)
		combat_state_store:dispatch(combat_state_actions.attack())
		task.wait(COOLDOWN_VALUES[data.attackType])
		combat_state_store:dispatch(combat_state_actions.stop_attack())
	end)
end
return {
	setupCombatListeners = setupCombatListeners,
}
