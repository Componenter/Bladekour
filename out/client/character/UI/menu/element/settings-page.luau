-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Roact = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "roact", "src", "ts")
local _store = TS.import(script, script.Parent.Parent.Parent, "store")
local Actions = _store.Actions
local store = _store.store
local backbutton = TS.import(script, script.Parent.Parent, "component", "back_button").backbutton
local settings_sf_container = TS.import(script, script.Parent, "settings-sf-container").settings_sf_container
local settingspage
do
	local super = Roact.Component
	settingspage = setmetatable({}, {
		__tostring = function()
			return "settingspage"
		end,
		__index = super,
	})
	settingspage.__index = settingspage
	function settingspage.new(...)
		local self = setmetatable({}, settingspage)
		return self:constructor(...) or self
	end
	function settingspage:constructor(props)
		super.constructor(self, props)
		self.state = {
			Visible = false,
		}
	end
	function settingspage:didMount()
		self:setState({
			Visible = false,
		})
		store.changed:connect(function(newState, oldState)
			if newState.settings_page_visible ~= oldState.settings_page_visible then
				local _self = self
				local _object = table.clone(self.state)
				setmetatable(_object, nil)
				_object.Visible = newState.settings_page_visible
				_self:setState(_object)
			end
		end)
	end
	function settingspage:willUnmount()
	end
	function settingspage:render()
		return Roact.createElement("Frame", {
			Size = UDim2.new(0.75, 0, 0.75, 0),
			Position = UDim2.new(0.125, 0, 0.125, 0),
			Transparency = 0.5,
			BackgroundColor3 = Color3.fromRGB(140, 140, 140),
			BorderSizePixel = 0,
			Visible = self.state.Visible,
		}, {
			UICorner = Roact.createElement("UICorner", {
				CornerRadius = UDim.new(0.004, 0),
			}),
			back_button = Roact.createElement(backbutton, {
				Position = UDim2.new(-0.1, 0, 0.95, 0),
				onClick = function()
					store:dispatch(Actions.go_home_page())
				end,
			}),
			settings_sf_container = settings_sf_container(),
		})
	end
end
return {
	settingspage = settingspage,
}
