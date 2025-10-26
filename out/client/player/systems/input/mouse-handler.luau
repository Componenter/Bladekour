-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _services = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services")
local Players = _services.Players
local UserInputService = _services.UserInputService
local InputAction = TS.import(script, script.Parent, "types").InputAction
local player = Players.LocalPlayer
local mouse = player:GetMouse()
local MouseHandler
do
	MouseHandler = setmetatable({}, {
		__tostring = function()
			return "MouseHandler"
		end,
	})
	MouseHandler.__index = MouseHandler
	function MouseHandler.new(...)
		local self = setmetatable({}, MouseHandler)
		return self:constructor(...) or self
	end
	function MouseHandler:constructor()
		self.callbacks = {}
	end
	function MouseHandler:initialize()
		-- Left click
		UserInputService.InputBegan:Connect(function(input, gameProcessed)
			if gameProcessed then
				return nil
			end
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				self:triggerAction(InputAction.Attack, {
					position = mouse.Hit.Position,
				})
			end
			if input.UserInputType == Enum.UserInputType.MouseButton2 then
				self:triggerAction(InputAction.StartGrapple, {
					position = mouse.Hit.Position,
				})
			end
		end)
		-- Right click release
		UserInputService.InputEnded:Connect(function(input, gameProcessed)
			if gameProcessed then
				return nil
			end
			if input.UserInputType == Enum.UserInputType.MouseButton2 then
				self:triggerAction(InputAction.ReleaseGrapple)
			end
		end)
	end
	function MouseHandler:on(action, callback)
		local _callbacks = self.callbacks
		local _action = action
		if not (_callbacks[_action] ~= nil) then
			local _callbacks_1 = self.callbacks
			local _action_1 = action
			_callbacks_1[_action_1] = {}
		end
		local _callbacks_1 = self.callbacks
		local _action_1 = action
		local _exp = _callbacks_1[_action_1]
		local _callback = callback
		_exp[_callback] = true
	end
	function MouseHandler:off(action, callback)
		local _callbacks = self.callbacks
		local _action = action
		local _result = _callbacks[_action]
		if _result ~= nil then
			local _callback = callback
			_result[_callback] = nil
		end
	end
	function MouseHandler:triggerAction(action, data)
		local event = {
			action = action,
			timestamp = os.clock(),
			data = data,
		}
		local _callbacks = self.callbacks
		local _action = action
		local callbacks = _callbacks[_action]
		if callbacks then
			-- ▼ ReadonlySet.forEach ▼
			local _callback = function(callback)
				return callback(event)
			end
			for _v in callbacks do
				_callback(_v, _v, callbacks)
			end
			-- ▲ ReadonlySet.forEach ▲
		end
	end
	function MouseHandler:getMousePosition()
		return mouse.Hit.Position
	end
	function MouseHandler:getMouseTarget()
		return mouse.Target
	end
end
return {
	MouseHandler = MouseHandler,
}
