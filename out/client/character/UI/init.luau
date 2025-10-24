-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Roact = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "roact", "src", "ts")
local menuframe = TS.import(script, script, "menu", "element", "menu-frame").menuframe
local App = Roact.createElement("ScreenGui", {
	IgnoreGuiInset = true,
	Enabled = true,
}, {
	menu_frame = Roact.createElement(menuframe),
})
return {
	App = App,
}
