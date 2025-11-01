-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local COOLDOWN_VALUES = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "constants", "combat", "cooldown").COOLDOWN_VALUES
local Combat = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "network", "packets").Combat
local ATTACK_COOLDOWN = 0.5
local CombatSystem
do
	CombatSystem = setmetatable({}, {
		__tostring = function()
			return "CombatSystem"
		end,
	})
	CombatSystem.__index = CombatSystem
	function CombatSystem.new(...)
		local self = setmetatable({}, CombatSystem)
		return self:constructor(...) or self
	end
	function CombatSystem:constructor(playerManager, hitResolver, damageHandler, comboTracker)
		self.playerManager = playerManager
		self.hitResolver = hitResolver
		self.damageHandler = damageHandler
		self.comboTracker = comboTracker
	end
	function CombatSystem:processAttack(attacker, data)
		-- Get attacker state
		local attackerState = self.playerManager:getState(attacker)
		if not attackerState then
			return nil
		end
		-- Check if dead
		if attackerState.isDead then
			return nil
		end
		-- Check cooldown
		local now = os.clock()
		if now - attackerState.lastAttackTime < ATTACK_COOLDOWN then
			return nil
		end
		-- Get attacker character
		local character = attacker.Character
		if not character then
			return nil
		end
		local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
		if not humanoidRootPart then
			return nil
		end
		self.comboTracker:incrementCombo(attacker)
		local newCombo = self.comboTracker:getCombo(attacker)
		local ClientAttackData = {
			attackType = data.attackType,
			combo = newCombo,
		}
		Combat.Attack.sendTo(ClientAttackData, attacker)
		-- Update attack state
		self.playerManager:setState(attacker, {
			isAttacking = true,
			lastAttackTime = now,
		})
		-- Resolve hit
		local hitResult = self.hitResolver:resolveHit(attacker, humanoidRootPart.Position, humanoidRootPart.CFrame.LookVector, data.attackType, newCombo)
		-- Apply damage if hit
		if hitResult.hit and hitResult.target then
			self.damageHandler:applyDamage(hitResult.target, hitResult.damage, attacker)
			self.damageHandler:applyKnockback(hitResult.target, hitResult.knockback)
		end
		-- Reset attack state after short delay
		task.delay(COOLDOWN_VALUES[data.attackType], function()
			self.playerManager:setState(attacker, {
				isAttacking = false,
			})
		end)
		return hitResult
	end
end
return {
	CombatSystem = CombatSystem,
}
