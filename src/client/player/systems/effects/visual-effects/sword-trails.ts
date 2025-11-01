// Sword trails
import { Players, TweenService } from "@rbxts/services";

const player = Players.LocalPlayer;

export class SwordTrails {
	private trail?: Trail;

	initialize() {
		// Get or create trail
		const character = player.Character || player.CharacterAdded.Wait()[0];
		const sword = character.FindFirstChild("Sword") as Tool;

		if (sword) {
			const handle = sword.FindFirstChild("Handle") as BasePart;
			if (handle) {
				this.createTrail(handle);
			}
		}
	}

	private createTrail(handle: BasePart) {
		// Create attachments for trail
		const attachment0 = new Instance("Attachment");
		attachment0.Name = "TrailAttachment0";
		attachment0.Position = new Vector3(0, -2, 0);
		attachment0.Parent = handle;

		const attachment1 = new Instance("Attachment");
		attachment1.Name = "TrailAttachment1";
		attachment1.Position = new Vector3(0, 2, 0);
		attachment1.Parent = handle;

		// Create trail
		this.trail = new Instance("Trail");
		this.trail.Attachment0 = attachment0;
		this.trail.Attachment1 = attachment1;
		this.trail.Color = new ColorSequence(new Color3(1, 1, 1));
		this.trail.Transparency = new NumberSequence([
			new NumberSequenceKeypoint(0, 0.5),
			new NumberSequenceKeypoint(1, 1),
		]);
		this.trail.Lifetime = 0.3;
		this.trail.MinLength = 0.1;
		this.trail.Enabled = false;
		this.trail.Parent = handle;
	}

	enable() {
		if (this.trail) {
			this.trail.Enabled = true;
		}
	}

	disable() {
		if (this.trail) {
			this.trail.Enabled = false;
		}
	}

	playAttackTrail(duration: number = 0.3) {
		this.enable();
		task.delay(duration, () => this.disable());
	}
}
