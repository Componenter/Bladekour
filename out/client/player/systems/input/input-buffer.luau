-- Compiled with roblox-ts v3.0.0
local BUFFER_WINDOW = 0.2
local MAX_BUFFER_SIZE = 10
local InputBuffer
do
	InputBuffer = setmetatable({}, {
		__tostring = function()
			return "InputBuffer"
		end,
	})
	InputBuffer.__index = InputBuffer
	function InputBuffer.new(...)
		local self = setmetatable({}, InputBuffer)
		return self:constructor(...) or self
	end
	function InputBuffer:constructor()
		self.buffer = {}
	end
	function InputBuffer:add(event)
		local _buffer = self.buffer
		local _event = event
		table.insert(_buffer, _event)
		-- Limit buffer size
		if #self.buffer > MAX_BUFFER_SIZE then
			table.remove(self.buffer, 1)
		end
		-- Clean old inputs
		self:cleanOldInputs()
	end
	function InputBuffer:getRecent(withinSeconds)
		if withinSeconds == nil then
			withinSeconds = BUFFER_WINDOW
		end
		local now = os.clock()
		local _exp = self.buffer
		-- ▼ ReadonlyArray.filter ▼
		local _newValue = {}
		local _callback = function(event)
			return now - event.timestamp <= withinSeconds
		end
		local _length = 0
		for _k, _v in _exp do
			if _callback(_v, _k - 1, _exp) == true then
				_length += 1
				_newValue[_length] = _v
			end
		end
		-- ▲ ReadonlyArray.filter ▲
		return _newValue
	end
	function InputBuffer:wasPressed(action, withinSeconds)
		if withinSeconds == nil then
			withinSeconds = BUFFER_WINDOW
		end
		local _exp = self:getRecent(withinSeconds)
		-- ▼ ReadonlyArray.some ▼
		local _result = false
		local _callback = function(event)
			return event.action == action
		end
		for _k, _v in _exp do
			if _callback(_v, _k - 1, _exp) then
				_result = true
				break
			end
		end
		-- ▲ ReadonlyArray.some ▲
		return _result
	end
	function InputBuffer:getSequence(actions, maxTimeBetween)
		if maxTimeBetween == nil then
			maxTimeBetween = 0.3
		end
		local recent = self:getRecent(#actions * maxTimeBetween)
		if #recent < #actions then
			return false
		end
		local actionIndex = 0
		for _, event in recent do
			if event.action == actions[actionIndex + 1] then
				actionIndex += 1
				if actionIndex == #actions then
					return true
				end
			end
		end
		return false
	end
	function InputBuffer:clear()
		table.clear(self.buffer)
	end
	function InputBuffer:cleanOldInputs()
		local now = os.clock()
		local _exp = self.buffer
		-- ▼ ReadonlyArray.filter ▼
		local _newValue = {}
		local _callback = function(event)
			return now - event.timestamp <= 1
		end
		local _length = 0
		for _k, _v in _exp do
			if _callback(_v, _k - 1, _exp) == true then
				_length += 1
				_newValue[_length] = _v
			end
		end
		-- ▲ ReadonlyArray.filter ▲
		self.buffer = _newValue
	end
end
return {
	InputBuffer = InputBuffer,
}
