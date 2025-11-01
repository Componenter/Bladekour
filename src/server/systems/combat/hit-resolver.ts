import { PlayerManager } from "../player/player-manager";
import { HitResult } from "shared/types/combat/attack";
import { getTargetsInRange } from "shared/utils/combat/hit-detection";
import { calculateDamage } from "shared/utils/combat/damage-calc";
import { calculateKnockback } from "shared/utils/combat/knockback-calc";
import { Players, Workspace } from "@rbxts/services";
import { HITBOX_CONFIG } from "shared/constants/combat/hitboxes";

export class HitResolver {
	constructor(private playerManager: PlayerManager) {}

	resolveHit(
		attacker: Player,
		attackerPosition: Vector3,
		attackerLookVector: Vector3,
		attackType: string,
		combo: number,
	): HitResult {
		// Get all potential targets
		const allPlayers = this.playerManager.getAllPlayers();
		const targets = getTargetsInRange(attacker, attackerPosition, attackerLookVector, allPlayers);

		// Hit first target (closest)
		if (targets.size() > 0) {
			let target: Model | undefined = undefined;

			const filter = [] as Instance[];

			targets.forEach((player) => {
				const char = player.Character as Model;
				filter.push(char);
			});

			const overlapParams = new OverlapParams();
			overlapParams.FilterType = Enum.RaycastFilterType.Include;
			overlapParams.FilterDescendantsInstances = filter;

			const hitboxConfig = HITBOX_CONFIG.hitboxConfigurations[attackType][combo];

			const detectedTargets = Workspace.GetPartBoundsInBox(
				new CFrame(attackerPosition.add(hitboxConfig.HitboxOffset)),
				hitboxConfig.HitboxSize,
				overlapParams,
			);
			if (detectedTargets && detectedTargets.size() > 0) {
				const targetPart = detectedTargets[0];

				if (targetPart.Parent?.FindFirstChildOfClass("Humanoid")) {
					target = targetPart.Parent as Model;
				}
			}

			if (!target) {
				return {
					hit: false,
					damage: 0,
					knockback: new Vector3(0, 0, 0),
				};
			}

			const damage = calculateDamage(attackType);

			const targetCharacter = target;
			const targetRoot = targetCharacter?.FindFirstChild("HumanoidRootPart") as BasePart;
			const targetPosition = targetRoot?.Position || attackerPosition;

			const knockback = calculateKnockback(attackType, attackerPosition, targetPosition);

			print(`${attacker.Name} hit ${target.Name} for ${damage} damage`);

			return {
				hit: true,
				target: Players.GetPlayerFromCharacter(target),
				damage: damage,
				knockback: knockback,
				hitPosition: targetPosition,
			};
		}

		// Missed
		return {
			hit: false,
			damage: 0,
			knockback: new Vector3(0, 0, 0),
		};
	}
}
