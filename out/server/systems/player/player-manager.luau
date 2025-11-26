-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Players = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").Players
local PlayerManager
do
	PlayerManager = setmetatable({}, {
		__tostring = function()
			return "PlayerManager"
		end,
	})
	PlayerManager.__index = PlayerManager
	function PlayerManager.new(...)
		local self = setmetatable({}, PlayerManager)
		return self:constructor(...) or self
	end
	function PlayerManager:constructor()
		self.playerStates = {}
	end
	function PlayerManager:initialize()
		Players.PlayerAdded:Connect(function(player)
			return self:onPlayerAdded(player)
		end)
		Players.PlayerRemoving:Connect(function(player)
			return self:onPlayerRemoved(player)
		end)
		-- Handle existing players
		local _exp = Players:GetPlayers()
		-- ▼ ReadonlyArray.forEach ▼
		local _callback = function(player)
			return self:onPlayerAdded(player)
		end
		for _k, _v in _exp do
			_callback(_v, _k - 1, _exp)
		end
		-- ▲ ReadonlyArray.forEach ▲
	end
	function PlayerManager:onPlayerAdded(player)
		local _playerStates = self.playerStates
		local _player = player
		_playerStates[_player] = {
			health = 100,
			maxHealth = 100,
			isDead = false,
			isAttacking = false,
			lastAttackTime = 0,
			isGrappling = false,
		}
		print(`Player state created: {player.Name}`)
	end
	function PlayerManager:onPlayerRemoved(player)
		local _playerStates = self.playerStates
		local _player = player
		_playerStates[_player] = nil
		print(`Player state removed: {player.Name}`)
	end
	function PlayerManager:getState(player)
		local _playerStates = self.playerStates
		local _player = player
		return _playerStates[_player]
	end
	function PlayerManager:setState(player, state)
		local _playerStates = self.playerStates
		local _player = player
		local currentState = _playerStates[_player]
		if currentState then
			local _playerStates_1 = self.playerStates
			local _exp = player
			local _object = table.clone(currentState)
			setmetatable(_object, nil)
			for _k, _v in state do
				_object[_k] = _v
			end
			_playerStates_1[_exp] = _object
		end
	end
	function PlayerManager:getAllPlayers()
		return Players:GetPlayers()
	end
end
return {
	PlayerManager = PlayerManager,
}
