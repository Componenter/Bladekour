// Combat audio
import { Players } from "@rbxts/services";

const player = Players.LocalPlayer;

export class CombatSounds {
	private soundFolder?: Folder;

	initialize() {
		// Assuming sounds are in ReplicatedStorage
		this.soundFolder = game.GetService("ReplicatedStorage").FindFirstChild("Sounds") as Folder;
	}

	playSwingSound() {
		this.playSound("SwordSwing");
	}

	playHitSound() {
		this.playSound("Hit", { Volume: 0.5 });
	}

	playHitConfirmSound() {
		this.playSound("HitMarker", { Volume: 0.3 });
	}

	playDeathSound() {
		this.playSound("Death");
	}

	playBlockSound() {
		this.playSound("Block");
	}

	private playSound(soundName: string, properties?: { Volume?: number; Pitch?: number }) {
		if (!this.soundFolder) return;

		const sound = this.soundFolder.FindFirstChild(soundName) as Sound;
		if (sound) {
			// Clone so we can play multiple at once
			const soundClone = sound.Clone();

			if (properties?.Volume !== undefined) {
				soundClone.Volume = properties.Volume;
			}
			if (properties?.Pitch !== undefined) {
				soundClone.PlaybackSpeed = properties.Pitch;
			}

			soundClone.Parent = player.WaitForChild("PlayerGui");
			soundClone.Play();

			// Cleanup after playing
			soundClone.Ended.Connect(() => soundClone.Destroy());
		} else {
			warn(`Sound not found: ${soundName}`);
		}
	}
}
