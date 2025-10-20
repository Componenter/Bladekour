-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
--[[
	 Author: Amponent
	   Date: 10/20/2025
	
]]
local ProfileStore = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "profile-store", "src")
local Players = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").Players
local ProfileTemplate = {
	Kills = 0,
	Deaths = 0,
	Level = 1,
	Experience = 0,
	EquippedWeapon = "Default",
	WeaponStorage = {},
	EquippedGrapplingHook = "Default",
	GrapplingHookStorage = {},
}
local PlayerStore = ProfileStore.New("PlayerStore", ProfileTemplate)
local ProfileCache = {}
local PlayerAdded = function(player)
	-- Start the profile session for the player
	local Profile = PlayerStore:StartSessionAsync(tostring(player.UserId), {
		Cancel = function()
			return player.Parent ~= Players
		end,
	})
	if Profile ~= nil then
		Profile:AddUserId(player.UserId)
		Profile:Reconcile()
		Profile.OnSessionEnd:Connect(function()
			local _player = player
			ProfileCache[_player] = nil
			player:Kick("Profile session end - Please rejoin")
		end)
		if player.Parent == Players then
			local _player = player
			ProfileCache[_player] = Profile
		else
			Profile:EndSession()
		end
	else
		player:Kick("Profile load fail - Please rejoin")
	end
end
local _exp = Players:GetPlayers()
-- ▼ ReadonlyArray.forEach ▼
local _callback = function(player)
	task.spawn(PlayerAdded, player)
end
for _k, _v in _exp do
	_callback(_v, _k - 1, _exp)
end
-- ▲ ReadonlyArray.forEach ▲
Players.PlayerAdded:Connect(PlayerAdded)
Players.PlayerRemoving:Connect(function(player)
	local _player = player
	local Profile = ProfileCache[_player]
	if Profile then
		Profile:EndSession()
	end
end)
game:BindToClose(function()
	-- ▼ ReadonlyMap.forEach ▼
	local _callback_1 = function(profile)
		profile:EndSession()
	end
	for _k, _v in ProfileCache do
		_callback_1(_v, _k, ProfileCache)
	end
	-- ▲ ReadonlyMap.forEach ▲
end)
return ProfileCache
