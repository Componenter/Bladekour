-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- Grapple validations
-- Position sync
local _grapple = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "constants", "movement", "grapple")
local MAX_GRAPPLE_Y_SIZE = _grapple.MAX_GRAPPLE_Y_SIZE
local MIN_GRAPPLE_Y_SIZE = _grapple.MIN_GRAPPLE_Y_SIZE
local grappleValidator
do
	grappleValidator = setmetatable({}, {
		__tostring = function()
			return "grappleValidator"
		end,
	})
	grappleValidator.__index = grappleValidator
	function grappleValidator.new(...)
		local self = setmetatable({}, grappleValidator)
		return self:constructor(...) or self
	end
	function grappleValidator:constructor()
	end
	function grappleValidator:canGrapple(hitPosition, player)
		local character = player.Character
		if not character then
			return false
		end
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if not humanoid then
			return false
		end
		if humanoid:GetState() == Enum.HumanoidStateType.Dead then
			return false
		end
		local left_arm = character:FindFirstChild("Left Arm")
		local _position = left_arm.Position
		local _vector3 = Vector3.new(0, left_arm.Size.Y / 2.1, 0)
		local hand_position = _position - _vector3
		local dist = (hitPosition - hand_position).Magnitude
		if dist > MAX_GRAPPLE_Y_SIZE then
			return false
		end
		if dist < MIN_GRAPPLE_Y_SIZE then
			return false
		end
		return true
	end
end
return {
	grappleValidator = grappleValidator,
}
