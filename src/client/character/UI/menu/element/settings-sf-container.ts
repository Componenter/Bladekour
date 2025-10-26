import Roact from "@rbxts/roact";

export function settings_sf_container() {
	return Roact.createElement(
		"Frame",
		{
			Size: new UDim2(0.97, 0, 0.88, 0),
			Position: new UDim2(0.015, 0, 0.14, 0),

			BackgroundColor3: Color3.fromRGB(100, 100, 100),
			BackgroundTransparency: 0.7,
		},
		{
			UICorner: Roact.createElement("UICorner", {
				CornerRadius: new UDim(0.004, 0),
			}),
		},
	);
}
