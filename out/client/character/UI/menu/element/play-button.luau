-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _roact = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "roact", "src", "ts")
local Roact = _roact
local Event = _roact.Event
local _store = TS.import(script, script.Parent.Parent.Parent, "store")
local Actions = _store.Actions
local store = _store.store
local _game_state = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "state", "game-state")
local game_state_actions = _game_state.game_state_actions
local game_state_store = _game_state.game_state_store
local GameState = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "network", "packets").GameState
local play_button
do
	local super = Roact.Component
	play_button = setmetatable({}, {
		__tostring = function()
			return "play_button"
		end,
		__index = super,
	})
	play_button.__index = play_button
	function play_button.new(...)
		local self = setmetatable({}, play_button)
		return self:constructor(...) or self
	end
	function play_button:constructor(props)
		super.constructor(self, props)
		self.state = {
			Hovering = false,
		}
	end
	function play_button:didMount()
		self:setState({
			Hovering = false,
		})
	end
	function play_button:willUnmount()
	end
	function play_button:render()
		return Roact.createElement("TextButton", {
			TextScaled = true,
			Text = "  PLAY  ",
			FontFace = Font.new("Arial", Enum.FontWeight.Bold),
			Visible = true,
			Size = UDim2.new(0.2, 0, 0.08, 0),
			Position = UDim2.new(0.07, 0, 0.25, 0),
			TextColor3 = Color3.fromRGB(207, 207, 207),
			BackgroundColor3 = Color3.new(0, 0, 0),
			BackgroundTransparency = 0.8,
			BorderSizePixel = 0,
			[Event.MouseButton1Click] = function()
				store:dispatch(Actions.toggle_menu())
				game_state_store:dispatch(game_state_actions.spawn())
				GameState.TransitionState.send("Playing")
			end,
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
	play_button = play_button,
}
