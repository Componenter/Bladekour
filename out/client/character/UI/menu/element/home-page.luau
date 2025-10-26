-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Roact = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "roact", "src", "ts")
local store = TS.import(script, script.Parent.Parent.Parent, "store").store
local play_button = TS.import(script, script.Parent, "play-button").play_button
local settings_button = TS.import(script, script.Parent, "settings-button").settings_button
local homepage
do
	local super = Roact.Component
	homepage = setmetatable({}, {
		__tostring = function()
			return "homepage"
		end,
		__index = super,
	})
	homepage.__index = homepage
	function homepage.new(...)
		local self = setmetatable({}, homepage)
		return self:constructor(...) or self
	end
	function homepage:constructor(props)
		super.constructor(self, props)
		self.state = {
			Visible = true,
		}
	end
	function homepage:didMount()
		self:setState({
			Visible = true,
		})
		store.changed:connect(function(newState, oldState)
			if newState.home_page_visible ~= oldState.home_page_visible then
				local _self = self
				local _object = table.clone(self.state)
				setmetatable(_object, nil)
				_object.Visible = newState.home_page_visible
				_self:setState(_object)
			end
		end)
	end
	function homepage:willUnmount()
	end
	function homepage:render()
		return Roact.createElement("Frame", {
			Size = UDim2.new(1, 0, 1, 0),
			Position = UDim2.new(0, 0, 0, 0),
			Transparency = 1,
			Visible = self.state.Visible,
		}, {
			play_button = play_button(),
			settings_button = settings_button(),
		})
	end
end
return {
	homepage = homepage,
}
