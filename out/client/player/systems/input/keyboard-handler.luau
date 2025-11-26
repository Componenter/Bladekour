-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local UserInputService = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").UserInputService
local InputAction = TS.import(script, script.Parent, "types").InputAction
local KeyboardHandler
do
	KeyboardHandler = setmetatable({}, {
		__tostring = function()
			return "KeyboardHandler"
		end,
	})
	KeyboardHandler.__index = KeyboardHandler
	function KeyboardHandler.new(...)
		local self = setmetatable({}, KeyboardHandler)
		return self:constructor(...) or self
	end
	function KeyboardHandler:constructor()
		self.callbacks = {}
		self.keyBindings = {
			[Enum.KeyCode.Q] = InputAction.Attack,
			[Enum.KeyCode.F] = InputAction.Block,
			[Enum.KeyCode.Space] = InputAction.Jump,
			[Enum.KeyCode.LeftShift] = InputAction.Dash,
			[Enum.KeyCode.W] = InputAction.W,
			[Enum.KeyCode.S] = InputAction.S,
		}
	end
	function KeyboardHandler:initialize()
		UserInputService.InputBegan:Connect(function(input, gameProcessed)
			if gameProcessed then
				return nil
			end
			local _keyBindings = self.keyBindings
			local _keyCode = input.KeyCode
			local action = _keyBindings[_keyCode]
			if action then
				self:triggerAction(action)
			end
		end)
		UserInputService.InputEnded:Connect(function(input, gameProcessed)
			if gameProcessed then
				return nil
			end
			-- Handle key release if needed
			-- Example: releasing block key
			if input.KeyCode == Enum.KeyCode.E then
				-- Could trigger "StopBlocking" action
			end
		end)
	end
	function KeyboardHandler:on(action, callback)
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
	function KeyboardHandler:off(action, callback)
		local _callbacks = self.callbacks
		local _action = action
		local _result = _callbacks[_action]
		if _result ~= nil then
			local _callback = callback
			_result[_callback] = nil
		end
	end
	function KeyboardHandler:triggerAction(action)
		local event = {
			action = action,
			timestamp = os.clock(),
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
	function KeyboardHandler:rebindKey(keyCode, action)
		local _keyBindings = self.keyBindings
		local _keyCode = keyCode
		local _action = action
		_keyBindings[_keyCode] = _action
	end
end
return {
	KeyboardHandler = KeyboardHandler,
}
