-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local GrappleRopeVisualizer
do
	GrappleRopeVisualizer = setmetatable({}, {
		__tostring = function()
			return "GrappleRopeVisualizer"
		end,
	})
	GrappleRopeVisualizer.__index = GrappleRopeVisualizer
	function GrappleRopeVisualizer.new(...)
		local self = setmetatable({}, GrappleRopeVisualizer)
		return self:constructor(...) or self
	end
	function GrappleRopeVisualizer:constructor()
		self.GrappleRopes = {}
	end
	function GrappleRopeVisualizer:showGrappleRope(grappleData)
		local character = grappleData.Player.Character
		local left_arm = character:FindFirstChild("Left Arm")
		local root = character:FindFirstChild("HumanoidRootPart")
	end
	function GrappleRopeVisualizer:removeGrappleRope(player)
		local _grappleRopes = self.GrappleRopes
		local _player = player
		local value = _grappleRopes[_player]
		if value then
			TS.try(function()
				value.rope:Destroy()
				value.grapplePart:Destroy()
				value.att0:Destroy()
			end, function() end)
		end
	end
end
return {
	GrappleRopeVisualizer = GrappleRopeVisualizer,
}
