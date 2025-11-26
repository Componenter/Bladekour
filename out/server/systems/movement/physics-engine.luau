-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _services = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services")
local Workspace = _services.Workspace
local RunService = _services.RunService
local GrapplePhysics
do
	GrapplePhysics = setmetatable({}, {
		__tostring = function()
			return "GrapplePhysics"
		end,
	})
	GrapplePhysics.__index = GrapplePhysics
	function GrapplePhysics.new(...)
		local self = setmetatable({}, GrapplePhysics)
		return self:constructor(...) or self
	end
	function GrapplePhysics:constructor()
		self.physicsStates = {}
		self.grappleConnections = {}
		self.pendulumVelocities = {}
		self.grapplePoints = {}
		self.ropeLengths = {}
		self.GRAVITY = 196.2
		self.DAMPING = 0.92
	end
	function GrapplePhysics:findFloorY(character)
		local leftLeg = character:FindFirstChild("Left Leg")
		if leftLeg then
			local _position = leftLeg.Position
			local _arg0 = leftLeg.Size / 2
			local charBottomPosition = _position - _arg0
			local raycastParams = RaycastParams.new()
			raycastParams.FilterType = Enum.RaycastFilterType.Include
			raycastParams.FilterDescendantsInstances = Workspace:WaitForChild("Map"):GetDescendants()
			local raycastResults = Workspace:Raycast(charBottomPosition, Vector3.new(0, -100, 0), raycastParams)
			if raycastResults and raycastResults.Instance then
				return raycastResults.Position.Y
			end
		end
		return nil
	end
	function GrapplePhysics:startGrapple(player, hitPosition)
		print("=== STARTING GRAPPLE ===")
		print("Hit position:", hitPosition)
		local character = player.Character
		local hrp = character:WaitForChild("HumanoidRootPart", 4)
		local humanoid = character:WaitForChild("Humanoid", 4)
		if not hrp or not humanoid then
			print("ERROR: Missing HRP or Humanoid")
			return nil
		end
		local _physicsStates = self.physicsStates
		local _player = player
		if _physicsStates[_player] == true then
			print("Stopping previous grapple")
			self:stopGrapple(player)
		end
		local initialPos = hrp.Position
		local _hitPosition = hitPosition
		local ropeLength = (initialPos - _hitPosition).Magnitude * 0.7
		print("Rope length:", ropeLength)
		hrp:SetNetworkOwner(player)
		humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, true)
		humanoid:ChangeState(Enum.HumanoidStateType.Physics)
		local velocity = hrp.AssemblyLinearVelocity
		if velocity.Magnitude < 5 then
			local toGrapple = (hitPosition - initialPos).Unit
			local horizontalDir = Vector3.new(toGrapple.X, 0, toGrapple.Z).Unit
			local _exp = horizontalDir * 15
			local _vector3 = Vector3.new(0, 8, 0)
			velocity = _exp + _vector3
		end
		print("Initial velocity:", velocity)
		local _physicsStates_1 = self.physicsStates
		local _player_1 = player
		_physicsStates_1[_player_1] = true
		local _pendulumVelocities = self.pendulumVelocities
		local _player_2 = player
		local _velocity = velocity
		_pendulumVelocities[_player_2] = _velocity
		local _grapplePoints = self.grapplePoints
		local _player_3 = player
		local _hitPosition_1 = hitPosition
		_grapplePoints[_player_3] = _hitPosition_1
		local _ropeLengths = self.ropeLengths
		local _player_4 = player
		_ropeLengths[_player_4] = ropeLength
		print("Creating Heartbeat connection...")
		local connection
		connection = RunService.Heartbeat:Connect(function(dt)
			local _physicsStates_2 = self.physicsStates
			local _player_5 = player
			if _physicsStates_2[_player_5] ~= true then
				connection:Disconnect()
				return nil
			end
			local _pendulumVelocities_1 = self.pendulumVelocities
			local _player_6 = player
			local currentVelocity = _pendulumVelocities_1[_player_6]
			local _grapplePoints_1 = self.grapplePoints
			local _player_7 = player
			local grapplePoint = _grapplePoints_1[_player_7]
			local _ropeLengths_1 = self.ropeLengths
			local _player_8 = player
			local ropeLen = _ropeLengths_1[_player_8]
			if not currentVelocity or not grapplePoint or not (ropeLen ~= 0 and ropeLen == ropeLen and ropeLen) then
				self:stopGrapple(player)
				return nil
			end
			local position = hrp.Position
			-- First, constrain to rope length
			local ropeVector = position - grapplePoint
			local currentLength = ropeVector.Magnitude
			local constrainedPosition = position
			if currentLength > ropeLen then
				local _arg0 = ropeVector.Unit * ropeLen
				constrainedPosition = grapplePoint + _arg0
				hrp.CFrame = CFrame.new(constrainedPosition)
			end
			-- Now calculate physics from the constrained position
			local finalRopeVector = constrainedPosition - grapplePoint
			local ropeDirection = finalRopeVector.Unit
			-- Apply gravity tangentially
			local gravityForce = Vector3.new(0, -self.GRAVITY, 0)
			local _arg0 = gravityForce:Dot(ropeDirection)
			local radialComponent = ropeDirection * _arg0
			local tangentialComponent = gravityForce - radialComponent
			local _currentVelocity = currentVelocity
			local _dt = dt
			local _arg0_1 = tangentialComponent * _dt
			currentVelocity = _currentVelocity + _arg0_1
			local _currentVelocity_1 = currentVelocity
			local _dAMPING = self.DAMPING
			currentVelocity = _currentVelocity_1 * _dAMPING
			-- Project velocity to be tangent to rope
			local radialVelocity = currentVelocity:Dot(ropeDirection)
			local _currentVelocity_2 = currentVelocity
			local _arg0_2 = ropeDirection * radialVelocity
			currentVelocity = _currentVelocity_2 - _arg0_2
			-- Calculate new position
			local _constrainedPosition = constrainedPosition
			local _currentVelocity_3 = currentVelocity
			local _dt_1 = dt
			local newPosition = _constrainedPosition + (_currentVelocity_3 * _dt_1)
			-- Final constraint
			local newRopeVector = newPosition - grapplePoint
			local newLength = newRopeVector.Magnitude
			if newLength > ropeLen then
				local _arg0_3 = newRopeVector.Unit * ropeLen
				local finalPos = grapplePoint + _arg0_3
				hrp.CFrame = CFrame.new(finalPos)
			else
				hrp.CFrame = CFrame.new(newPosition)
			end
			local _pendulumVelocities_2 = self.pendulumVelocities
			local _player_9 = player
			local _currentVelocity_4 = currentVelocity
			_pendulumVelocities_2[_player_9] = _currentVelocity_4
			local floorY = self:findFloorY(character)
			local _condition = floorY
			if _condition ~= 0 and _condition == _condition and _condition then
				_condition = hrp.Position.Y <= floorY + 4 and currentVelocity.Y < -15
			end
			if _condition ~= 0 and _condition == _condition and _condition then
				self:stopGrapple(player)
			end
		end)
		local _grappleConnections = self.grappleConnections
		local _player_5 = player
		_grappleConnections[_player_5] = connection
		print("=== GRAPPLE STARTED ===")
	end
	function GrapplePhysics:applySwingInput(player, inputDirection)
		local _pendulumVelocities = self.pendulumVelocities
		local _player = player
		local currentVelocity = _pendulumVelocities[_player]
		local _physicsStates = self.physicsStates
		local _player_1 = player
		local isGrappling = _physicsStates[_player_1]
		if not currentVelocity and isGrappling then
			local character = player.Character
			local _result = character
			if _result ~= nil then
				_result = _result:WaitForChild("HumanoidRootPart")
			end
			local hrp = _result
			if hrp then
				local vel = hrp.AssemblyLinearVelocity
				local _pendulumVelocities_1 = self.pendulumVelocities
				local _player_2 = player
				_pendulumVelocities_1[_player_2] = vel
				local swingForce = inputDirection * 25
				local newVelocity = vel + swingForce
				local _pendulumVelocities_2 = self.pendulumVelocities
				local _player_3 = player
				_pendulumVelocities_2[_player_3] = newVelocity
				print("Applied swing! New velocity:", newVelocity)
			end
		elseif currentVelocity and isGrappling then
			local swingForce = inputDirection * 25
			local newVelocity = currentVelocity + swingForce
			local _pendulumVelocities_1 = self.pendulumVelocities
			local _player_2 = player
			_pendulumVelocities_1[_player_2] = newVelocity
			print("Applied swing! New velocity:", newVelocity)
		end
	end
	function GrapplePhysics:stopGrapple(player)
		local _physicsStates = self.physicsStates
		local _player = player
		if _physicsStates[_player] ~= true then
			return nil
		end
		print("Stopping grapple for", player.Name)
		local _physicsStates_1 = self.physicsStates
		local _player_1 = player
		_physicsStates_1[_player_1] = false
		local _grappleConnections = self.grappleConnections
		local _player_2 = player
		local connection = _grappleConnections[_player_2]
		if connection then
			connection:Disconnect()
			local _grappleConnections_1 = self.grappleConnections
			local _player_3 = player
			_grappleConnections_1[_player_3] = nil
		end
		local _pendulumVelocities = self.pendulumVelocities
		local _player_3 = player
		_pendulumVelocities[_player_3] = nil
		local _grapplePoints = self.grapplePoints
		local _player_4 = player
		_grapplePoints[_player_4] = nil
		local _ropeLengths = self.ropeLengths
		local _player_5 = player
		_ropeLengths[_player_5] = nil
		local character = player.Character
		if character then
			local humanoid = character:FindFirstChild("Humanoid")
			if humanoid then
				humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
			end
		end
	end
end
return {
	GrapplePhysics = GrapplePhysics,
}
