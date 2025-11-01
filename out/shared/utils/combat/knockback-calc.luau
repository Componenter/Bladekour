-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- Knockback calculation
local KNOCKBACK_VALUES = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "constants", "combat", "knockback").KNOCKBACK_VALUES
local function calculateKnockback(attackType, attackerPosition, targetPosition)
	local _targetPosition = targetPosition
	local _attackerPosition = attackerPosition
	local direction = (_targetPosition - _attackerPosition).Unit
	local _condition = KNOCKBACK_VALUES[attackType]
	if not (_condition ~= 0 and _condition == _condition and _condition) then
		_condition = KNOCKBACK_VALUES.light
	end
	local force = _condition
	-- Add upward component
	return Vector3.new(direction.X * force, force * 0.5, direction.Z * force)
end
return {
	calculateKnockback = calculateKnockback,
}
