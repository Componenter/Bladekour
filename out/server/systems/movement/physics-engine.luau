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
		self.connections = {}
		self.playerInputVelocities = {}
		self.playerInputKey = {}
		self.playerAngularVelocity = {}
		self.GRAVITY = 196.2
		self.MAXANGLE = math.rad(89)
		self.MAXINPUTFORCE = 10
		self.MAXANGULARVELOCITY = 10
	end
	function GrapplePhysics:findFloorY(character)
		local leftLeg = character:FindFirstChild("Left Leg")
		if leftLeg then
			local _position = leftLeg.Position
			local _vector3 = Vector3.new(20, 20, 20)
			local charBottomPosition = _position + _vector3
			-- Create fresh raycast params each time
			local raycastParams = RaycastParams.new()
			raycastParams.FilterType = Enum.RaycastFilterType.Exclude
			raycastParams.FilterDescendantsInstances = { character }
			local raycastResults = Workspace:Raycast(charBottomPosition, Vector3.new(0, -100, 0), raycastParams)
			print("Starting position: ", charBottomPosition)
			print("Raycast params: ", raycastParams)
			print("Results: ", raycastResults)
			if raycastResults and raycastResults.Instance then
				return raycastResults.Position.Y
			end
		end
		return nil
	end
	function GrapplePhysics:startGrapple(player, hitPosition)
		local character = player.Character
		local root = character:FindFirstChild("HumanoidRootPart")
		local groundLevel = self:findFloorY(character)
		if not (groundLevel ~= 0 and groundLevel == groundLevel and groundLevel) then
			return nil
		end
		local _connections = self.connections
		local _player = player
		if _connections[_player] then
			return nil
		end
		local ropeLength = (55 / 100) * (hitPosition.Y - groundLevel)
		local downVector = Vector3.new(0, -1, 0)
		local angularVelocity = 0
		root.Anchored = true
		local _playerInputVelocities = self.playerInputVelocities
		local _player_1 = player
		local _value = _playerInputVelocities[_player_1]
		if not (_value ~= 0 and _value == _value and _value) then
			local _playerInputVelocities_1 = self.playerInputVelocities
			local _player_2 = player
			_playerInputVelocities_1[_player_2] = 1
		end
		local swingDirection = root.CFrame.LookVector
		local _position = root.Position
		local _hitPosition = hitPosition
		local ropeVector = _position - _hitPosition
		local theta = math.acos(ropeVector.Unit:Dot(downVector))
		local _connections_1 = self.connections
		local _player_2 = player
		local _arg1 = RunService.Heartbeat:Connect(function(deltaTime)
			local angularAcceleration = -(self.GRAVITY / ropeLength) * math.sin(theta)
			angularVelocity = angularVelocity + angularAcceleration * deltaTime
			local _playerInputVelocities_1 = self.playerInputVelocities
			local _player_3 = player
			local inputVelocity = _playerInputVelocities_1[_player_3]
			local _playerInputKey = self.playerInputKey
			local _player_4 = player
			if _playerInputKey[_player_4] == "W" then
				local _playerInputVelocities_2 = self.playerInputVelocities
				local _player_5 = player
				local _arg1_1 = inputVelocity + 0.1
				_playerInputVelocities_2[_player_5] = _arg1_1
			else
				local _playerInputKey_1 = self.playerInputKey
				local _player_5 = player
				if _playerInputKey_1[_player_5] == "S" then
					local _playerInputVelocities_2 = self.playerInputVelocities
					local _player_6 = player
					local _arg1_1 = inputVelocity - 0.2
					_playerInputVelocities_2[_player_6] = _arg1_1
				end
			end
			local _playerInputVelocities_2 = self.playerInputVelocities
			local _exp = player
			local _playerInputVelocities_3 = self.playerInputVelocities
			local _player_5 = player
			local _arg1_1 = math.clamp(_playerInputVelocities_3[_player_5], -self.MAXINPUTFORCE, self.MAXINPUTFORCE)
			_playerInputVelocities_2[_exp] = _arg1_1
			local _playerInputVelocities_4 = self.playerInputVelocities
			local _player_6 = player
			local _value_1 = _playerInputVelocities_4[_player_6]
			if _value_1 ~= 0 and _value_1 == _value_1 and _value_1 then
				local _condition = inputVelocity
				if _condition ~= 0 and _condition == _condition and _condition then
					_condition = inputVelocity ~= 1
				end
				if _condition ~= 0 and _condition == _condition and _condition then
					if inputVelocity < 0 then
						angularVelocity = angularVelocity - inputVelocity * deltaTime
					else
						angularVelocity = angularVelocity + inputVelocity * deltaTime
					end
				end
			end
			swingDirection = root.CFrame.LookVector
			theta = theta + angularVelocity * deltaTime
			if theta > self.MAXANGLE then
				theta = self.MAXANGLE
				angularVelocity = -angularVelocity * 1.01
			end
			if theta < -self.MAXANGLE then
				-- Changed from -MAXANGLE to 0
				theta = -self.MAXANGLE
				angularVelocity = -angularVelocity * 1.01
			end
			angularVelocity = math.clamp(angularVelocity, -self.MAXANGULARVELOCITY, self.MAXANGULARVELOCITY)
			local _playerAngularVelocity = self.playerAngularVelocity
			local _player_7 = player
			local _angularVelocity = angularVelocity
			_playerAngularVelocity[_player_7] = _angularVelocity
			local _swingDirection = swingDirection
			local _arg0 = ropeLength * math.sin(theta)
			local horizontalOffset = _swingDirection * _arg0
			local verticalOffset = Vector3.new(0, -ropeLength * math.cos(theta), 0)
			local newPosition = hitPosition + horizontalOffset + verticalOffset
			root.Position = newPosition
		end)
		_connections_1[_player_2] = _arg1
	end
	function GrapplePhysics:applySwingInput(player, inputDirection)
		local _connections = self.connections
		local _player = player
		if not _connections[_player] then
			return nil
		end
		if inputDirection ~= nil then
			if inputDirection == -1 then
				local _playerInputKey = self.playerInputKey
				local _player_1 = player
				_playerInputKey[_player_1] = "S"
			end
			if inputDirection == 1 then
				local _playerInputKey = self.playerInputKey
				local _player_1 = player
				_playerInputKey[_player_1] = "W"
			end
			if inputDirection == 0 then
				local _playerInputKey = self.playerInputKey
				local _player_1 = player
				_playerInputKey[_player_1] = "None"
			end
		end
	end
	function GrapplePhysics:stopGrapple(player)
		local _connections = self.connections
		local _player = player
		local _result = _connections[_player]
		if _result ~= nil then
			_result:Disconnect()
		end
		local _connections_1 = self.connections
		local _player_1 = player
		_connections_1[_player_1] = nil
		local _result_1 = player.Character
		if _result_1 ~= nil then
			_result_1 = _result_1:FindFirstChild("HumanoidRootPart")
		end
		local root = _result_1
		root.Anchored = false
		local _playerAngularVelocity = self.playerAngularVelocity
		local _player_2 = player
		local angularVelocity = _playerAngularVelocity[_player_2]
		if angularVelocity ~= 0 and angularVelocity == angularVelocity and angularVelocity then
			local bodyVelocity = Instance.new("BodyVelocity", root)
			bodyVelocity.Velocity = Vector3.new(angularVelocity ^ 2, angularVelocity ^ 2, 0)
			task.delay(0.9, function()
				bodyVelocity:Destroy()
				local _playerAngularVelocity_1 = self.playerAngularVelocity
				local _player_3 = player
				_playerAngularVelocity_1[_player_3] = 0
				local _playerInputVelocities = self.playerInputVelocities
				local _player_4 = player
				_playerInputVelocities[_player_4] = 1
				local _playerInputKey = self.playerInputKey
				local _player_5 = player
				_playerInputKey[_player_5] = "None"
			end)
		end
	end
end
return {
	GrapplePhysics = GrapplePhysics,
}
