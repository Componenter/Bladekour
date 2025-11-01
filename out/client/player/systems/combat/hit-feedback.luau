-- Compiled with roblox-ts v3.0.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- Hit feedback
local _services = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services")
local Players = _services.Players
local TweenService = _services.TweenService
local Workspace = _services.Workspace
local player = Players.LocalPlayer
local camera = Workspace.CurrentCamera
local HitFeedback
do
	HitFeedback = setmetatable({}, {
		__tostring = function()
			return "HitFeedback"
		end,
	})
	HitFeedback.__index = HitFeedback
	function HitFeedback.new(...)
		local self = setmetatable({}, HitFeedback)
		return self:constructor(...) or self
	end
	function HitFeedback:constructor()
		self.screenShakeIntensity = 0
	end
	function HitFeedback:initialize()
		-- Screen shake loop
		game:GetService("RunService").RenderStepped:Connect(function()
			if self.screenShakeIntensity > 0 then
				self:applyScreenShake()
				self.screenShakeIntensity *= 0.9
			end
		end)
	end
	function HitFeedback:onTakeDamage(damage, knockback)
		-- Screen shake
		self.screenShakeIntensity = math.min(damage / 10, 5)
		-- Red vignette flash
		self:flashDamageVignette()
		-- Camera tilt toward damage direction
		self:tiltCameraFromKnockback(knockback)
	end
	function HitFeedback:onDeath()
		-- Fade to black
		self:fadeScreen(1, 0.5)
	end
	function HitFeedback:applyScreenShake()
		local randomX = (math.random() - 0.5) * self.screenShakeIntensity
		local randomY = (math.random() - 0.5) * self.screenShakeIntensity
		local _cFrame = camera.CFrame
		local _arg0 = CFrame.Angles(math.rad(randomY), math.rad(randomX), 0)
		camera.CFrame = _cFrame * _arg0
	end
	function HitFeedback:flashDamageVignette()
		-- Create red flash on screen
		local playerGui = player:WaitForChild("PlayerGui")
		local screenGui = playerGui:FindFirstChild("DamageFlash")
		if screenGui then
			local frame = screenGui:FindFirstChild("Frame")
			if frame then
				frame.BackgroundTransparency = 0.5
				TweenService:Create(frame, TweenInfo.new(0.3), {
					BackgroundTransparency = 1,
				}):Play()
			end
		end
	end
	function HitFeedback:tiltCameraFromKnockback(knockback)
		-- Tilt camera slightly in knockback direction
		local tiltAmount = math.rad(5)
		local tiltDirection = math.sign(knockback.X)
		-- Would implement camera tilt here
	end
	function HitFeedback:fadeScreen(transparency, duration)
		local playerGui = player:WaitForChild("PlayerGui")
		local screenGui = playerGui:FindFirstChild("FadeScreen")
		if screenGui then
			local frame = screenGui:FindFirstChild("Frame")
			if frame then
				TweenService:Create(frame, TweenInfo.new(duration), {
					BackgroundTransparency = transparency,
				}):Play()
			end
		end
	end
end
return {
	HitFeedback = HitFeedback,
}
