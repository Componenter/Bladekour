// Weapon animations

import { Players } from "@rbxts/services";
import { ANIMATION_VALUES } from "shared/constants/combat/animations";

const player = Players.LocalPlayer;

export class WeaponAnimator {
	private attackAnimations = new Map<string, Animation>();
	private currentTrack?: AnimationTrack;

	initialize() {
		// Load animations
		this.loadAnimations();
	}

	private loadAnimations() {
		const character = player.Character || player.CharacterAdded.Wait()[0];
		const humanoid = character.WaitForChild("Humanoid") as Humanoid;
		const animator = humanoid.WaitForChild("Animator") as Animator;

		const lightAttackAnim = new Instance("Animation");
		lightAttackAnim.AnimationId = "rbxassetid://0";

		const heavyAttackAnim = new Instance("Animation");
		heavyAttackAnim.AnimationId = ANIMATION_VALUES["Heavy"][0];

		this.attackAnimations.set("light", lightAttackAnim);
		this.attackAnimations.set("heavy", heavyAttackAnim);
	}

	playAttackAnimation(attackType: string, combo: number) {
		const character = player.Character;
		if (!character) return;

		const humanoid = character.FindFirstChild("Humanoid") as Humanoid;
		if (!humanoid) return;

		const animator = humanoid.FindFirstChild("Animator") as Animator;
		if (!animator) return;

		const AttackAnim = new Instance("Animation");
		AttackAnim.AnimationId = ANIMATION_VALUES[attackType][combo];

		if (!AttackAnim) return;
		this.attackAnimations.set(attackType, AttackAnim);

		const animation = this.attackAnimations.get(attackType);
		if (!animation) {
			return;
		}

		// Stop current animation
		if (this.currentTrack) {
			this.currentTrack.Stop(0.1);
		}

		// Play new animation
		this.currentTrack = animator.LoadAnimation(animation);
		this.currentTrack.Priority = Enum.AnimationPriority.Action;
		this.currentTrack.Play();

		return this.currentTrack;
	}

	isAnimationPlaying(): boolean {
		return this.currentTrack?.IsPlaying ?? false;
	}
}
