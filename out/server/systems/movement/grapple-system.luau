-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- Grapple system
local PositionSync = TS.import(script, game:GetService("ServerScriptService"), "TS", "systems", "movement", "position-sync").PositionSync
local grappleValidator = TS.import(script, game:GetService("ServerScriptService"), "TS", "systems", "movement", "grapple-validator").grappleValidator
local GrappleRopeVisualizer = TS.import(script, game:GetService("ServerScriptService"), "TS", "systems", "movement", "grapple-rope-visualizer").GrappleRopeVisualizer
local GrapplePhysics = TS.import(script, game:GetService("ServerScriptService"), "TS", "systems", "movement", "physics-engine").GrapplePhysics
local GrappleSystem
do
	GrappleSystem = setmetatable({}, {
		__tostring = function()
			return "GrappleSystem"
		end,
	})
	GrappleSystem.__index = GrappleSystem
	function GrappleSystem.new(...)
		local self = setmetatable({}, GrappleSystem)
		return self:constructor(...) or self
	end
	function GrappleSystem:constructor(PlayerManager)
		self.PlayerManager = PlayerManager
		self.positionSync = PositionSync.new()
		self.grappleValidator = grappleValidator.new()
		self.grappleRopeVisualizer = GrappleRopeVisualizer.new()
		self.physicsEngine = GrapplePhysics.new()
	end
	function GrappleSystem:process(packet, player)
		if packet.GrappleEventType == "StartGrapple" then
			local grapplePart = packet.MouseHitPart
			if grapplePart and grapplePart.Transparency < 0.3 then
				if not self.grappleValidator:canGrapple(packet.MousePosition3DSpace, player) then
					return nil
				end
				self.PlayerManager:setState(player, {
					isGrappling = true,
				})
				local visualizeGrappleData = {
					Player = player,
					hitPosition = packet.MousePosition3DSpace,
				}
				self.grappleRopeVisualizer:showGrappleRope(visualizeGrappleData)
				self.physicsEngine:startGrapple(player, packet.MousePosition3DSpace)
			end
		else
			if packet.GrappleEventType == "ReleaseGrapple" then
				self.PlayerManager:setState(player, {
					isGrappling = false,
				})
				self.grappleRopeVisualizer:removeGrappleRope(player)
				self.physicsEngine:stopGrapple(player)
			end
		end
	end
	function GrappleSystem:processInput(input, player)
		local character = player.Character
		local _result = character
		if _result ~= nil then
			_result = _result:WaitForChild("HumanoidRootPart", 3)
		end
		local root = _result
		if not root then
			return nil
		end
		local direction = nil
		if input == "W" then
			direction = 1
		end
		if input == "S" then
			direction = -1
		end
		if input == "None" then
			direction = 0
		end
		if direction ~= nil then
			self.physicsEngine:applySwingInput(player, direction)
		end
	end
end
return {
	GrappleSystem = GrappleSystem,
}
