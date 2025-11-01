// Hit feedback
import { Players, TweenService, Workspace } from "@rbxts/services";

const player = Players.LocalPlayer;
const camera = Workspace.CurrentCamera!;

export class HitFeedback {
	private screenShakeIntensity = 0;

	initialize() {
		// Screen shake loop
		game.GetService("RunService").RenderStepped.Connect(() => {
			if (this.screenShakeIntensity > 0) {
				this.applyScreenShake();
				this.screenShakeIntensity *= 0.9; // Decay
			}
		});
	}

	// Called when we take damage
	onTakeDamage(damage: number, knockback: Vector3) {
		// Screen shake
		this.screenShakeIntensity = math.min(damage / 10, 5); // Max shake of 5

		// Red vignette flash
		this.flashDamageVignette();

		// Camera tilt toward damage direction
		this.tiltCameraFromKnockback(knockback);
	}

	onDeath() {
		// Fade to black
		this.fadeScreen(1, 0.5);
	}

	private applyScreenShake() {
		const randomX = (math.random() - 0.5) * this.screenShakeIntensity;
		const randomY = (math.random() - 0.5) * this.screenShakeIntensity;

		camera.CFrame = camera.CFrame.mul(CFrame.Angles(math.rad(randomY), math.rad(randomX), 0));
	}

	private flashDamageVignette() {
		// Create red flash on screen
		const playerGui = player.WaitForChild("PlayerGui") as PlayerGui;
		const screenGui = playerGui.FindFirstChild("DamageFlash") as ScreenGui;

		if (screenGui) {
			const frame = screenGui.FindFirstChild("Frame") as Frame;
			if (frame) {
				frame.BackgroundTransparency = 0.5;

				TweenService.Create(frame, new TweenInfo(0.3), {
					BackgroundTransparency: 1,
				}).Play();
			}
		}
	}

	private tiltCameraFromKnockback(knockback: Vector3) {
		// Tilt camera slightly in knockback direction
		const tiltAmount = math.rad(5);
		const tiltDirection = math.sign(knockback.X);

		// Would implement camera tilt here
	}

	private fadeScreen(transparency: number, duration: number) {
		const playerGui = player.WaitForChild("PlayerGui") as PlayerGui;
		const screenGui = playerGui.FindFirstChild("FadeScreen") as ScreenGui;

		if (screenGui) {
			const frame = screenGui.FindFirstChild("Frame") as Frame;
			if (frame) {
				TweenService.Create(frame, new TweenInfo(duration), {
					BackgroundTransparency: transparency,
				}).Play();
			}
		}
	}
}
