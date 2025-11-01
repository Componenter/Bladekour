-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- Combat audio
local Players = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").Players
local player = Players.LocalPlayer
local CombatSounds
do
	CombatSounds = setmetatable({}, {
		__tostring = function()
			return "CombatSounds"
		end,
	})
	CombatSounds.__index = CombatSounds
	function CombatSounds.new(...)
		local self = setmetatable({}, CombatSounds)
		return self:constructor(...) or self
	end
	function CombatSounds:constructor()
	end
	function CombatSounds:initialize()
		-- Assuming sounds are in ReplicatedStorage
		self.soundFolder = game:GetService("ReplicatedStorage"):FindFirstChild("Sounds")
	end
	function CombatSounds:playSwingSound()
		self:playSound("SwordSwing")
	end
	function CombatSounds:playHitSound()
		self:playSound("Hit", {
			Volume = 0.5,
		})
	end
	function CombatSounds:playHitConfirmSound()
		self:playSound("HitMarker", {
			Volume = 0.3,
		})
	end
	function CombatSounds:playDeathSound()
		self:playSound("Death")
	end
	function CombatSounds:playBlockSound()
		self:playSound("Block")
	end
	function CombatSounds:playSound(soundName, properties)
		if not self.soundFolder then
			return nil
		end
		local sound = self.soundFolder:FindFirstChild(soundName)
		if sound then
			-- Clone so we can play multiple at once
			local soundClone = sound:Clone()
			local _result = properties
			if _result ~= nil then
				_result = _result.Volume
			end
			if _result ~= nil then
				soundClone.Volume = properties.Volume
			end
			local _result_1 = properties
			if _result_1 ~= nil then
				_result_1 = _result_1.Pitch
			end
			if _result_1 ~= nil then
				soundClone.PlaybackSpeed = properties.Pitch
			end
			soundClone.Parent = player:WaitForChild("PlayerGui")
			soundClone:Play()
			-- Cleanup after playing
			soundClone.Ended:Connect(function()
				return soundClone:Destroy()
			end)
		else
			warn(`Sound not found: {soundName}`)
		end
	end
end
return {
	CombatSounds = CombatSounds,
}
