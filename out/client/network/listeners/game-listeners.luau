-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local GameState = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "network", "packets").GameState
local function setupGameListeners()
	GameState.RequestData.listen(function(data, player)
		print("Recieved data: ", data)
	end)
end
return {
	setupGameListeners = setupGameListeners,
}
