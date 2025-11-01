-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local GameState = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "network", "packets").GameState
local DamageHandler
do
	DamageHandler = setmetatable({}, {
		__tostring = function()
			return "DamageHandler"
		end,
	})
	DamageHandler.__index = DamageHandler
	function DamageHandler.new(...)
		local self = setmetatable({}, DamageHandler)
		return self:constructor(...) or self
	end
	function DamageHandler:constructor(playerManager)
		self.playerManager = playerManager
	end
	function DamageHandler:applyDamage(target, damage, attacker)
		local targetState = self.playerManager:getState(target)
		if not targetState then
			return nil
		end
		-- Apply damage
		local newHealth = math.max(0, targetState.health - damage)
		self.playerManager:setState(target, {
			health = newHealth,
		})
		print(`{target.Name} took {damage} damage. Health: {newHealth}/{targetState.maxHealth}`)
		-- Send damage packet to victim
		local _playerHit = GameState.PlayerHit
		local _object = {
			damage = damage,
		}
		local _left = "attackerUserId"
		local _result = attacker
		if _result ~= nil then
			_result = _result.UserId
		end
		local _condition = _result
		if not (_condition ~= 0 and _condition == _condition and _condition) then
			_condition = 0
		end
		_object[_left] = _condition
		_object.knockback = Vector3.new(0, 0, 0)
		_object.attackType = "light"
		_playerHit.sendTo(_object, target)
		-- Send confirmation to attacker
		if attacker then
			GameState.DamageDealt.sendTo({
				targetUserId = target.UserId,
				damage = damage,
				knockback = Vector3.new(0, 0, 0),
			}, attacker)
		end
		-- Check if dead
		if newHealth <= 0 then
			self:handleDeath(target, attacker)
		end
	end
	function DamageHandler:applyKnockback(target, knockback)
		local character = target.Character
		if not character then
			return nil
		end
		local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
		if not humanoidRootPart then
			return nil
		end
		-- Apply velocity
		humanoidRootPart.AssemblyLinearVelocity = knockback
	end
	function DamageHandler:handleDeath(victim, killer)
		print(`{victim.Name} died!`)
		-- Update state
		self.playerManager:setState(victim, {
			isDead = true,
			health = 0,
		})
		-- Send death packet
		local _playerDied = GameState.PlayerDied
		local _object = {}
		local _left = "killerUserId"
		local _result = killer
		if _result ~= nil then
			_result = _result.UserId
		end
		_object[_left] = _result
		local _left_1 = "killerId"
		local _result_1 = killer
		if _result_1 ~= nil then
			_result_1 = _result_1.UserId
		end
		_object[_left_1] = _result_1
		_playerDied.sendTo(_object, victim)
		-- Respawn after delay
		task.delay(3, function()
			self:respawnPlayer(victim)
		end)
	end
	function DamageHandler:respawnPlayer(player)
		local state = self.playerManager:getState(player)
		if state then
			self.playerManager:setState(player, {
				health = state.maxHealth,
				isDead = false,
			})
			player:LoadCharacter()
			print(`{player.Name} respawned`)
		end
	end
end
return {
	DamageHandler = DamageHandler,
}
