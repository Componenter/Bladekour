-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- Weapon animations
local Players = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").Players
local ANIMATION_VALUES = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "constants", "combat", "animations").ANIMATION_VALUES
local player = Players.LocalPlayer
local WeaponAnimator
do
	WeaponAnimator = setmetatable({}, {
		__tostring = function()
			return "WeaponAnimator"
		end,
	})
	WeaponAnimator.__index = WeaponAnimator
	function WeaponAnimator.new(...)
		local self = setmetatable({}, WeaponAnimator)
		return self:constructor(...) or self
	end
	function WeaponAnimator:constructor()
		self.attackAnimations = {}
	end
	function WeaponAnimator:initialize()
		-- Load animations
		self:loadAnimations()
	end
	function WeaponAnimator:loadAnimations()
		local character = player.Character or (player.CharacterAdded:Wait())
		local humanoid = character:WaitForChild("Humanoid")
		local animator = humanoid:WaitForChild("Animator")
		local lightAttackAnim = Instance.new("Animation")
		lightAttackAnim.AnimationId = "rbxassetid://0"
		local heavyAttackAnim = Instance.new("Animation")
		heavyAttackAnim.AnimationId = ANIMATION_VALUES.Heavy[0]
		self.attackAnimations.light = lightAttackAnim
		self.attackAnimations.heavy = heavyAttackAnim
	end
	function WeaponAnimator:playAttackAnimation(attackType, combo)
		local character = player.Character
		if not character then
			return nil
		end
		local humanoid = character:FindFirstChild("Humanoid")
		if not humanoid then
			return nil
		end
		local animator = humanoid:FindFirstChild("Animator")
		if not animator then
			return nil
		end
		local AttackAnim = Instance.new("Animation")
		AttackAnim.AnimationId = ANIMATION_VALUES[attackType][combo]
		if not AttackAnim then
			return nil
		end
		local _attackAnimations = self.attackAnimations
		local _attackType = attackType
		_attackAnimations[_attackType] = AttackAnim
		local _attackAnimations_1 = self.attackAnimations
		local _attackType_1 = attackType
		local animation = _attackAnimations_1[_attackType_1]
		if not animation then
			return nil
		end
		-- Stop current animation
		if self.currentTrack then
			self.currentTrack:Stop(0.1)
		end
		-- Play new animation
		self.currentTrack = animator:LoadAnimation(animation)
		self.currentTrack.Priority = Enum.AnimationPriority.Action
		self.currentTrack:Play()
		return self.currentTrack
	end
	function WeaponAnimator:isAnimationPlaying()
		local _result = self.currentTrack
		if _result ~= nil then
			_result = _result.IsPlaying
		end
		local _condition = _result
		if _condition == nil then
			_condition = false
		end
		return _condition
	end
end
return {
	WeaponAnimator = WeaponAnimator,
}
