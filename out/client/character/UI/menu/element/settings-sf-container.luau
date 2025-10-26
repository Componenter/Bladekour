-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Roact = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "roact", "src", "ts")
local function settings_sf_container()
	return Roact.createElement("Frame", {
		Size = UDim2.new(0.97, 0, 0.88, 0),
		Position = UDim2.new(0.015, 0, 0.14, 0),
		BackgroundColor3 = Color3.fromRGB(100, 100, 100),
		BackgroundTransparency = 0.7,
	}, {
		UICorner = Roact.createElement("UICorner", {
			CornerRadius = UDim.new(0.004, 0),
		}),
	})
end
return {
	settings_sf_container = settings_sf_container,
}
