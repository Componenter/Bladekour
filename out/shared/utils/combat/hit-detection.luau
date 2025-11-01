-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- Hit detection
local HITBOX_CONFIG = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "constants", "combat", "hitboxes").HITBOX_CONFIG
local function isInAttackRange(attackerPosition, attackerLookVector, targetPosition)
	local _targetPosition = targetPosition
	local _attackerPosition = attackerPosition
	local toTarget = _targetPosition - _attackerPosition
	local distance = toTarget.Magnitude
	-- Check distance
	if distance > HITBOX_CONFIG.attackRange then
		return false
	end
	-- Check angle (cone check)
	local directionToTarget = toTarget.Unit
	local dotProduct = attackerLookVector:Dot(directionToTarget)
	local angle = math.deg(math.acos(dotProduct))
	return angle <= HITBOX_CONFIG.attackAngle / 2
end
local function getTargetsInRange(attacker, attackerPosition, attackerLookVector, allPlayers)
	local targets = {}
	for _, player in allPlayers do
		if player == attacker then
			continue
		end
		if not player.Character then
			continue
		end
		local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
		if not humanoidRootPart then
			continue
		end
		local targetPosition = humanoidRootPart.Position
		if isInAttackRange(attackerPosition, attackerLookVector, targetPosition) then
			table.insert(targets, player)
		end
	end
	return targets
end
return {
	isInAttackRange = isInAttackRange,
	getTargetsInRange = getTargetsInRange,
}
