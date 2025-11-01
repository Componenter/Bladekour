-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local getTargetsInRange = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "utils", "combat", "hit-detection").getTargetsInRange
local calculateDamage = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "utils", "combat", "damage-calc").calculateDamage
local calculateKnockback = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "utils", "combat", "knockback-calc").calculateKnockback
local _services = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services")
local Players = _services.Players
local Workspace = _services.Workspace
local HITBOX_CONFIG = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "constants", "combat", "hitboxes").HITBOX_CONFIG
local HitResolver
do
	HitResolver = setmetatable({}, {
		__tostring = function()
			return "HitResolver"
		end,
	})
	HitResolver.__index = HitResolver
	function HitResolver.new(...)
		local self = setmetatable({}, HitResolver)
		return self:constructor(...) or self
	end
	function HitResolver:constructor(playerManager)
		self.playerManager = playerManager
	end
	function HitResolver:resolveHit(attacker, attackerPosition, attackerLookVector, attackType, combo)
		-- Get all potential targets
		local allPlayers = self.playerManager:getAllPlayers()
		local targets = getTargetsInRange(attacker, attackerPosition, attackerLookVector, allPlayers)
		-- Hit first target (closest)
		if #targets > 0 then
			local target = nil
			local filter = {}
			-- ▼ ReadonlyArray.forEach ▼
			local _callback = function(player)
				local char = player.Character
				table.insert(filter, char)
			end
			for _k, _v in targets do
				_callback(_v, _k - 1, targets)
			end
			-- ▲ ReadonlyArray.forEach ▲
			local overlapParams = OverlapParams.new()
			overlapParams.FilterType = Enum.RaycastFilterType.Include
			overlapParams.FilterDescendantsInstances = filter
			local hitboxConfig = HITBOX_CONFIG.hitboxConfigurations[attackType][combo]
			local _attackerPosition = attackerPosition
			local _hitboxOffset = hitboxConfig.HitboxOffset
			local detectedTargets = Workspace:GetPartBoundsInBox(CFrame.new(_attackerPosition + _hitboxOffset), hitboxConfig.HitboxSize, overlapParams)
			if detectedTargets and #detectedTargets > 0 then
				local targetPart = detectedTargets[1]
				local _result = targetPart.Parent
				if _result ~= nil then
					_result = _result:FindFirstChildOfClass("Humanoid")
				end
				if _result then
					target = targetPart.Parent
				end
			end
			if not target then
				return {
					hit = false,
					damage = 0,
					knockback = Vector3.new(0, 0, 0),
				}
			end
			local damage = calculateDamage(attackType)
			local targetCharacter = target
			local _result = targetCharacter
			if _result ~= nil then
				_result = _result:FindFirstChild("HumanoidRootPart")
			end
			local targetRoot = _result
			local _result_1 = targetRoot
			if _result_1 ~= nil then
				_result_1 = _result_1.Position
			end
			local _condition = _result_1
			if not _condition then
				_condition = attackerPosition
			end
			local targetPosition = _condition
			local knockback = calculateKnockback(attackType, attackerPosition, targetPosition)
			print(`{attacker.Name} hit {target.Name} for {damage} damage`)
			return {
				hit = true,
				target = Players:GetPlayerFromCharacter(target),
				damage = damage,
				knockback = knockback,
				hitPosition = targetPosition,
			}
		end
		-- Missed
		return {
			hit = false,
			damage = 0,
			knockback = Vector3.new(0, 0, 0),
		}
	end
end
return {
	HitResolver = HitResolver,
}
