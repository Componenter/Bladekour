-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Roact = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "roact", "src", "ts")
local store = TS.import(script, script.Parent.Parent.Parent, "store").store
local play_button = TS.import(script, script.Parent, "play-button").play_button
local menuframe
do
	local super = Roact.Component
	menuframe = setmetatable({}, {
		__tostring = function()
			return "menuframe"
		end,
		__index = super,
	})
	menuframe.__index = menuframe
	function menuframe.new(...)
		local self = setmetatable({}, menuframe)
		return self:constructor(...) or self
	end
	function menuframe:constructor(props)
		super.constructor(self, props)
		self.state = {
			Visible = true,
		}
	end
	function menuframe:didMount()
		self:setState({
			Visible = true,
		})
		store.changed:connect(function(newState, oldState)
			if newState.menu_visible ~= oldState.menu_visible then
				local _self = self
				local _object = table.clone(self.state)
				setmetatable(_object, nil)
				_object.Visible = newState.menu_visible
				_self:setState(_object)
			end
		end)
	end
	function menuframe:willUnmount()
	end
	function menuframe:render()
		return Roact.createElement("Frame", {
			Size = UDim2.new(1, 0, 1, 0),
			Position = UDim2.new(0, 0, 0, 0),
			Transparency = 0.9,
			Visible = self.state.Visible,
		}, {
			play_button = Roact.createElement(play_button),
		})
	end
end
return {
	menuframe = menuframe,
}
