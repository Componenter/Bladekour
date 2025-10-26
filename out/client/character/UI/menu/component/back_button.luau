-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _roact = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "roact", "src", "ts")
local Roact = _roact
local Event = _roact.Event
local backbutton
do
	local super = Roact.Component
	backbutton = setmetatable({}, {
		__tostring = function()
			return "backbutton"
		end,
		__index = super,
	})
	backbutton.__index = backbutton
	function backbutton.new(...)
		local self = setmetatable({}, backbutton)
		return self:constructor(...) or self
	end
	function backbutton:constructor(props)
		super.constructor(self, props)
		self.state = {
			Hovering = false,
		}
	end
	function backbutton:didMount()
		self:setState({
			Hovering = false,
		})
	end
	function backbutton:willUnmount()
	end
	function backbutton:render()
		return Roact.createElement("TextButton", {
			TextScaled = true,
			Text = "  BACK  ",
			FontFace = Font.new("Arial", Enum.FontWeight.Bold),
			Visible = true,
			Size = UDim2.new(0.21, 0, 0.1, 0),
			Position = self.props.Position,
			TextColor3 = Color3.fromRGB(207, 207, 207),
			BackgroundColor3 = Color3.new(1, 0.07, 0.07),
			BackgroundTransparency = 0.6,
			BorderSizePixel = 0,
			[Event.MouseButton1Click] = self.props.onClick,
			[Event.MouseEnter] = function()
				local _self = self
				local _object = table.clone(self.state)
				setmetatable(_object, nil)
				_object.Hovering = true
				_self:setState(_object)
			end,
			[Event.MouseLeave] = function()
				local _self = self
				local _object = table.clone(self.state)
				setmetatable(_object, nil)
				_object.Hovering = false
				_self:setState(_object)
			end,
		}, {
			UICorner = Roact.createElement("UICorner", {
				CornerRadius = UDim.new(0.084, 0),
			}),
			HoverStroke = Roact.createElement("UIStroke", {
				Thickness = 1,
				Color = Color3.new(1, 1, 1),
				Transparency = 0.3,
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Enabled = self.state.Hovering,
			}),
		})
	end
end
return {
	backbutton = backbutton,
}
