-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local setupGameListeners = TS.import(script, script.Parent, "listeners", "game-listeners").setupGameListeners
local setupCombatListeners = TS.import(script, script.Parent, "listeners", "combat-listeners").setupCombatListeners
local setupMovementListeners = TS.import(script, script.Parent, "listeners", "movement-listeners").setupMovementListeners
local HitFeedback = TS.import(script, script.Parent.Parent, "systems", "combat", "hit-feedback").HitFeedback
local SwordTrails = TS.import(script, script.Parent.Parent, "systems", "effects", "visual-effects", "sword-trails").SwordTrails
local WeaponAnimator = TS.import(script, script.Parent.Parent, "systems", "combat", "weapon-animator").WeaponAnimator
local CombatSounds = TS.import(script, script.Parent.Parent, "systems", "effects", "audio-effects", "combat-sounds").CombatSounds
local function setupClientNetworking(transitionManager)
	local hitFeedback = HitFeedback.new()
	hitFeedback:initialize()
	local combatSounds = CombatSounds.new()
	combatSounds:initialize()
	local weaponAnimator = WeaponAnimator.new()
	weaponAnimator:initialize()
	local swordTrails = SwordTrails.new()
	swordTrails:initialize()
	-- Setup listeners
	setupGameListeners(transitionManager, hitFeedback, combatSounds)
	setupCombatListeners(weaponAnimator)
	setupMovementListeners()
end
return {
	setupClientNetworking = setupClientNetworking,
}
