-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- Combo tracking
local MAX_COMBO = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "constants", "combat", "combos").MAX_COMBO
local ComboTracker
do
	ComboTracker = setmetatable({}, {
		__tostring = function()
			return "ComboTracker"
		end,
	})
	ComboTracker.__index = ComboTracker
	function ComboTracker.new(...)
		local self = setmetatable({}, ComboTracker)
		return self:constructor(...) or self
	end
	function ComboTracker:constructor()
		self.ComboCache = {}
	end
	function ComboTracker:incrementCombo(player)
		local _comboCache = self.ComboCache
		local _player = player
		local playerCombo = _comboCache[_player]
		if playerCombo == nil then
			local _comboCache_1 = self.ComboCache
			local _player_1 = player
			_comboCache_1[_player_1] = 0
		else
			playerCombo = playerCombo
			local newCombo = playerCombo + 1
			if newCombo > MAX_COMBO then
				newCombo = 0
			end
			local _comboCache_1 = self.ComboCache
			local _player_1 = player
			local _newCombo = newCombo
			_comboCache_1[_player_1] = _newCombo
		end
	end
	function ComboTracker:getCombo(player)
		local _comboCache = self.ComboCache
		local _player = player
		local playerCombo = _comboCache[_player]
		if playerCombo == nil then
			local _comboCache_1 = self.ComboCache
			local _player_1 = player
			_comboCache_1[_player_1] = 0
		end
		local _comboCache_1 = self.ComboCache
		local _player_1 = player
		playerCombo = _comboCache_1[_player_1]
		return playerCombo
	end
end
return {
	ComboTracker = ComboTracker,
}
