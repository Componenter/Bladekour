-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- Sword trails
local Players = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").Players
local player = Players.LocalPlayer
local SwordTrails
do
	SwordTrails = setmetatable({}, {
		__tostring = function()
			return "SwordTrails"
		end,
	})
	SwordTrails.__index = SwordTrails
	function SwordTrails.new(...)
		local self = setmetatable({}, SwordTrails)
		return self:constructor(...) or self
	end
	function SwordTrails:constructor()
	end
	function SwordTrails:initialize()
		-- Get or create trail
		local character = player.Character or (player.CharacterAdded:Wait())
		local sword = character:FindFirstChild("Sword")
		if sword then
			local handle = sword:FindFirstChild("Handle")
			if handle then
				self:createTrail(handle)
			end
		end
	end
	function SwordTrails:createTrail(handle)
		-- Create attachments for trail
		local attachment0 = Instance.new("Attachment")
		attachment0.Name = "TrailAttachment0"
		attachment0.Position = Vector3.new(0, -2, 0)
		attachment0.Parent = handle
		local attachment1 = Instance.new("Attachment")
		attachment1.Name = "TrailAttachment1"
		attachment1.Position = Vector3.new(0, 2, 0)
		attachment1.Parent = handle
		-- Create trail
		self.trail = Instance.new("Trail")
		self.trail.Attachment0 = attachment0
		self.trail.Attachment1 = attachment1
		self.trail.Color = ColorSequence.new(Color3.new(1, 1, 1))
		self.trail.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.5), NumberSequenceKeypoint.new(1, 1) })
		self.trail.Lifetime = 0.3
		self.trail.MinLength = 0.1
		self.trail.Enabled = false
		self.trail.Parent = handle
	end
	function SwordTrails:enable()
		if self.trail then
			self.trail.Enabled = true
		end
	end
	function SwordTrails:disable()
		if self.trail then
			self.trail.Enabled = false
		end
	end
	function SwordTrails:playAttackTrail(duration)
		if duration == nil then
			duration = 0.3
		end
		self:enable()
		task.delay(duration, function()
			return self:disable()
		end)
	end
end
return {
	SwordTrails = SwordTrails,
}
