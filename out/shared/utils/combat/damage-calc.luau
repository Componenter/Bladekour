-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- Damage calculation
local DAMAGE_VALUES = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "constants", "combat", "damage").DAMAGE_VALUES
local function calculateDamage(attackType)
	local _condition = DAMAGE_VALUES[attackType]
	if not (_condition ~= 0 and _condition == _condition and _condition) then
		_condition = DAMAGE_VALUES.light
	end
	return _condition
end
return {
	calculateDamage = calculateDamage,
}
