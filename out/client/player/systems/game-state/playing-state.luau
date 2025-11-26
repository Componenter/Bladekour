-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _packets = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "network", "packets")
local Combat = _packets.Combat
local Movement = _packets.Movement
local InputAction = TS.import(script, script.Parent.Parent, "input", "types").InputAction
local InputMiddlewareChain = TS.import(script, script.Parent.Parent, "input", "input-middleware-chain").InputMiddlewareChain
local StateMiddleware = TS.import(script, script.Parent.Parent.Parent, "network", "middleware", "send", "state-middleware").StateMiddleware
local Players = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").Players
local PlayingState
do
	PlayingState = setmetatable({}, {
		__tostring = function()
			return "PlayingState"
		end,
	})
	PlayingState.__index = PlayingState
	function PlayingState.new(...)
		local self = setmetatable({}, PlayingState)
		return self:constructor(...) or self
	end
	function PlayingState:constructor(inputManager)
		self.inputManager = inputManager
		self.middleware = InputMiddlewareChain.new():use(StateMiddleware.new())
	end
	function PlayingState:enter()
		local mouse = Players.LocalPlayer:GetMouse()
		self.inputManager:enable()
		-- Subscribe to actions
		self.inputManager:onAction(InputAction.Attack, function(event)
			if not self.middleware:validate(event) then
				return nil
			end
			local AttackData = {
				attackType = "Light",
				mousePosition = Vector3.new(mouse.X, mouse.Y, 0),
				timestamp = tick(),
			}
			Combat.Attack.send(AttackData)
		end)
		self.inputManager:onAction(InputAction.W, function(event)
			if not self.middleware:validate(event) then
				return nil
			end
			Movement.GrappleMovement.send("W")
		end)
		self.inputManager:onAction(InputAction.S, function(event)
			if not self.middleware:validate(event) then
				return nil
			end
			Movement.GrappleMovement.send("S")
		end)
		self.inputManager:onAction(InputAction.StartGrapple, function(event)
			if not self.middleware:validate(event) then
				return nil
			end
			local eventData = event.data
			local GrappleData = {
				GrappleEventType = "StartGrapple",
				MouseHitPart = eventData.mouseHit,
				MousePosition3DSpace = eventData.position,
			}
			Movement.Grapple.send(GrappleData)
		end)
		self.inputManager:onAction(InputAction.ReleaseGrapple, function(event)
			if not self.middleware:validate(event) then
				return nil
			end
			local GrappleData = {
				GrappleEventType = "ReleaseGrapple",
			}
			Movement.Grapple.send(GrappleData)
		end)
	end
	function PlayingState:exit()
		self.inputManager:disable()
	end
end
return {
	PlayingState = PlayingState,
}
