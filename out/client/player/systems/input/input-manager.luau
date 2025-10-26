-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local KeyboardHandler = TS.import(script, script.Parent, "keyboard-handler").KeyboardHandler
local MouseHandler = TS.import(script, script.Parent, "mouse-handler").MouseHandler
local InputBuffer = TS.import(script, script.Parent, "input-buffer").InputBuffer
local InputAction = TS.import(script, script.Parent, "types").InputAction
local InputManager
do
	InputManager = setmetatable({}, {
		__tostring = function()
			return "InputManager"
		end,
	})
	InputManager.__index = InputManager
	function InputManager.new(...)
		local self = setmetatable({}, InputManager)
		return self:constructor(...) or self
	end
	function InputManager:constructor()
		self.enabled = false
		self.keyboardHandler = KeyboardHandler.new()
		self.mouseHandler = MouseHandler.new()
		self.inputBuffer = InputBuffer.new()
	end
	function InputManager:initialize()
		self.keyboardHandler:initialize()
		self.mouseHandler:initialize()
		-- Route all inputs through buffer
		self.keyboardHandler:on(InputAction.Attack, function(event)
			return self:handleInput(event)
		end)
		self.keyboardHandler:on(InputAction.Block, function(event)
			return self:handleInput(event)
		end)
		self.keyboardHandler:on(InputAction.Jump, function(event)
			return self:handleInput(event)
		end)
		self.keyboardHandler:on(InputAction.Dash, function(event)
			return self:handleInput(event)
		end)
		self.mouseHandler:on(InputAction.Attack, function(event)
			return self:handleInput(event)
		end)
		self.mouseHandler:on(InputAction.StartGrapple, function(event)
			return self:handleInput(event)
		end)
		self.mouseHandler:on(InputAction.ReleaseGrapple, function(event)
			return self:handleInput(event)
		end)
		print("Input manager initialized")
	end
	function InputManager:enable()
		self.enabled = true
	end
	function InputManager:disable()
		self.enabled = false
		self.inputBuffer:clear()
	end
	function InputManager:handleInput(event)
		if not self.enabled then
			return nil
		end
		self.inputBuffer:add(event)
	end
	function InputManager:onAction(action, callback)
		self.keyboardHandler:on(action, function(event)
			if not self.enabled then
				return nil
			end
			callback(event)
		end)
		self.mouseHandler:on(action, function(event)
			if not self.enabled then
				return nil
			end
			callback(event)
		end)
	end
	function InputManager:getBuffer()
		return self.inputBuffer
	end
	function InputManager:getMousePosition()
		return self.mouseHandler:getMousePosition()
	end
	function InputManager:rebindKey(keyCode, action)
		self.keyboardHandler:rebindKey(keyCode, action)
	end
end
return {
	InputManager = InputManager,
}
