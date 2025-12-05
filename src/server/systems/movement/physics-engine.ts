import { Workspace, RunService, TextChatService } from "@rbxts/services";

export class GrapplePhysics {
	private connections = new Map<Player, RBXScriptConnection>();
	private playerInputVelocities = new Map<Player, number>();
	private playerInputKey = new Map<Player, "W" | "S" | "None">();
	private playerAngularVelocity = new Map<Player, number>();

	private readonly GRAVITY = 196.2;
	private readonly MAXANGLE = math.rad(89);
	private readonly MAXINPUTFORCE = 10;
	private readonly MAXANGULARVELOCITY = 10;

	findFloorY(character: Model): number | undefined {
		const leftLeg = character.FindFirstChild("Left Leg") as BasePart | undefined;
		if (leftLeg) {
			const charBottomPosition = leftLeg.Position.add(new Vector3(20, 20, 20));

			// Create fresh raycast params each time
			const raycastParams = new RaycastParams();
			raycastParams.FilterType = Enum.RaycastFilterType.Exclude;
			raycastParams.FilterDescendantsInstances = [character];

			const raycastResults = Workspace.Raycast(charBottomPosition, new Vector3(0, -100, 0), raycastParams);

			print("Starting position: ", charBottomPosition);
			print("Raycast params: ", raycastParams);
			print("Results: ", raycastResults);

			if (raycastResults && raycastResults.Instance) {
				return raycastResults.Position.Y;
			}
		}
		return undefined;
	}

	startGrapple(player: Player, hitPosition: Vector3) {
		const character = player.Character as Model;
		const root = character.FindFirstChild("HumanoidRootPart") as BasePart;
		const groundLevel = this.findFloorY(character);
		if (!groundLevel) return;

		if (this.connections.get(player)) return;

		const ropeLength = (55 / 100) * (hitPosition.Y - groundLevel);

		const downVector = new Vector3(0, -1, 0);

		let angularVelocity = 0;

		root.Anchored = true;

		if (!this.playerInputVelocities.get(player)) {
			this.playerInputVelocities.set(player, 1);
		}

		let swingDirection = root.CFrame.LookVector;

		const ropeVector = root.Position.sub(hitPosition);

		let theta = math.acos(ropeVector.Unit.Dot(downVector));

		this.connections.set(
			player,
			RunService.Heartbeat.Connect((deltaTime: number) => {
				const angularAcceleration = -(this.GRAVITY / ropeLength) * math.sin(theta);

				angularVelocity = angularVelocity + angularAcceleration * deltaTime;

				const inputVelocity = this.playerInputVelocities.get(player) as number;

				if (this.playerInputKey.get(player) === "W") {
					this.playerInputVelocities.set(player, inputVelocity + 0.1);
				} else {
					if (this.playerInputKey.get(player) === "S") {
						this.playerInputVelocities.set(player, inputVelocity - 0.2);
					}
				}

				this.playerInputVelocities.set(
					player,
					math.clamp(
						this.playerInputVelocities.get(player) as number,
						-this.MAXINPUTFORCE,
						this.MAXINPUTFORCE,
					),
				);

				if (this.playerInputVelocities.get(player)) {
					if (inputVelocity && inputVelocity !== 1) {
						if (inputVelocity < 0) {
							angularVelocity = angularVelocity - inputVelocity * deltaTime;
						} else {
							angularVelocity = angularVelocity + inputVelocity * deltaTime;
						}
					}
				}

				swingDirection = root.CFrame.LookVector;

				theta = theta + angularVelocity * deltaTime;

				if (theta > this.MAXANGLE) {
					theta = this.MAXANGLE;
					angularVelocity = -angularVelocity * 1.01; // bounce back with damping
				}
				if (theta < -this.MAXANGLE) {
					// Changed from -MAXANGLE to 0
					theta = -this.MAXANGLE;
					angularVelocity = -angularVelocity * 1.01;
				}

				angularVelocity = math.clamp(angularVelocity, -this.MAXANGULARVELOCITY, this.MAXANGULARVELOCITY);

				this.playerAngularVelocity.set(player, angularVelocity);

				const horizontalOffset = swingDirection.mul(ropeLength * math.sin(theta));
				const verticalOffset = new Vector3(0, -ropeLength * math.cos(theta), 0);

				const newPosition = hitPosition.add(horizontalOffset).add(verticalOffset);

				root.Position = newPosition;
			}),
		);
	}

	applySwingInput(player: Player, inputDirection: number) {
		if (!this.connections.get(player)) return;
		if (inputDirection !== undefined) {
			if (inputDirection === -1) {
				this.playerInputKey.set(player, "S");
			}
			if (inputDirection === 1) {
				this.playerInputKey.set(player, "W");
			}
			if (inputDirection === 0) {
				this.playerInputKey.set(player, "None");
			}
		}
	}

	stopGrapple(player: Player) {
		this.connections.get(player)?.Disconnect();
		this.connections.delete(player);
		const root = player.Character?.FindFirstChild("HumanoidRootPart") as BasePart;
		root.Anchored = false;

		const angularVelocity = this.playerAngularVelocity.get(player);
		if (angularVelocity) {
			const bodyVelocity = new Instance("BodyVelocity", root);
			bodyVelocity.Velocity = new Vector3(angularVelocity ** 2, angularVelocity ** 2, 0);
			task.delay(0.9, () => {
				bodyVelocity.Destroy();
				this.playerAngularVelocity.set(player, 0);
				this.playerInputVelocities.set(player, 1);
				this.playerInputKey.set(player, "None");
			});
		}
	}
}
