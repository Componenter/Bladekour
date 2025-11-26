import { Workspace, RunService } from "@rbxts/services";

export class GrapplePhysics {
	private physicsStates = new Map<Player, boolean>();
	private grappleConnections = new Map<Player, RBXScriptConnection>();
	private pendulumVelocities = new Map<Player, Vector3>();
	private grapplePoints = new Map<Player, Vector3>();
	private ropeLengths = new Map<Player, number>();
	private readonly GRAVITY = 196.2;
	private readonly DAMPING = 0.92;

	findFloorY(character: Model): number | undefined {
		const leftLeg = character.FindFirstChild("Left Leg") as BasePart | undefined;
		if (leftLeg) {
			const charBottomPosition = leftLeg.Position.sub(leftLeg.Size.div(2));
			const raycastParams = new RaycastParams();
			raycastParams.FilterType = Enum.RaycastFilterType.Include;
			raycastParams.FilterDescendantsInstances = Workspace.WaitForChild("Map").GetDescendants();
			const raycastResults = Workspace.Raycast(charBottomPosition, new Vector3(0, -100, 0), raycastParams);
			if (raycastResults && raycastResults.Instance) {
				return raycastResults.Position.Y;
			}
		}
		return undefined;
	}

	startGrapple(player: Player, hitPosition: Vector3) {
		print("=== STARTING GRAPPLE ===");
		print("Hit position:", hitPosition);

		const character = player.Character as Model;
		const hrp = character.WaitForChild("HumanoidRootPart", 4) as BasePart | undefined;
		const humanoid = character.WaitForChild("Humanoid", 4) as Humanoid | undefined;

		if (!hrp || !humanoid) {
			print("ERROR: Missing HRP or Humanoid");
			return;
		}

		if (this.physicsStates.get(player) === true) {
			print("Stopping previous grapple");
			this.stopGrapple(player);
		}

		const initialPos = hrp.Position;
		const ropeLength = initialPos.sub(hitPosition).Magnitude * 0.7;
		print("Rope length:", ropeLength);

		hrp.SetNetworkOwner(player);

		humanoid.SetStateEnabled(Enum.HumanoidStateType.Physics, true);
		humanoid.ChangeState(Enum.HumanoidStateType.Physics);

		let velocity = hrp.AssemblyLinearVelocity;
		if (velocity.Magnitude < 5) {
			const toGrapple = hitPosition.sub(initialPos).Unit;
			const horizontalDir = new Vector3(toGrapple.X, 0, toGrapple.Z).Unit;
			velocity = horizontalDir.mul(15).add(new Vector3(0, 8, 0));
		}
		print("Initial velocity:", velocity);

		this.physicsStates.set(player, true);
		this.pendulumVelocities.set(player, velocity);
		this.grapplePoints.set(player, hitPosition);
		this.ropeLengths.set(player, ropeLength);

		print("Creating Heartbeat connection...");

		const connection = RunService.Heartbeat.Connect((dt) => {
			if (this.physicsStates.get(player) !== true) {
				connection.Disconnect();
				return;
			}

			let currentVelocity = this.pendulumVelocities.get(player);
			const grapplePoint = this.grapplePoints.get(player);
			const ropeLen = this.ropeLengths.get(player);

			if (!currentVelocity || !grapplePoint || !ropeLen) {
				this.stopGrapple(player);
				return;
			}

			const position = hrp.Position;

			// First, constrain to rope length
			const ropeVector = position.sub(grapplePoint);
			const currentLength = ropeVector.Magnitude;

			let constrainedPosition = position;
			if (currentLength > ropeLen) {
				constrainedPosition = grapplePoint.add(ropeVector.Unit.mul(ropeLen));
				hrp.CFrame = new CFrame(constrainedPosition);
			}

			// Now calculate physics from the constrained position
			const finalRopeVector = constrainedPosition.sub(grapplePoint);
			const ropeDirection = finalRopeVector.Unit;

			// Apply gravity tangentially
			const gravityForce = new Vector3(0, -this.GRAVITY, 0);
			const radialComponent = ropeDirection.mul(gravityForce.Dot(ropeDirection));
			const tangentialComponent = gravityForce.sub(radialComponent);

			currentVelocity = currentVelocity.add(tangentialComponent.mul(dt));
			currentVelocity = currentVelocity.mul(this.DAMPING);

			// Project velocity to be tangent to rope
			const radialVelocity = currentVelocity.Dot(ropeDirection);
			currentVelocity = currentVelocity.sub(ropeDirection.mul(radialVelocity));

			// Calculate new position
			const newPosition = constrainedPosition.add(currentVelocity.mul(dt));

			// Final constraint
			const newRopeVector = newPosition.sub(grapplePoint);
			const newLength = newRopeVector.Magnitude;

			if (newLength > ropeLen) {
				const finalPos = grapplePoint.add(newRopeVector.Unit.mul(ropeLen));
				hrp.CFrame = new CFrame(finalPos);
			} else {
				hrp.CFrame = new CFrame(newPosition);
			}

			this.pendulumVelocities.set(player, currentVelocity);

			const floorY = this.findFloorY(character);
			if (floorY && hrp.Position.Y <= floorY + 4 && currentVelocity.Y < -15) {
				this.stopGrapple(player);
			}
		});

		this.grappleConnections.set(player, connection);
		print("=== GRAPPLE STARTED ===");
	}

	applySwingInput(player: Player, inputDirection: Vector3) {
		const currentVelocity = this.pendulumVelocities.get(player);
		const isGrappling = this.physicsStates.get(player);

		if (!currentVelocity && isGrappling) {
			const character = player.Character as Model;
			const hrp = character?.WaitForChild("HumanoidRootPart") as BasePart | undefined;
			if (hrp) {
				const vel = hrp.AssemblyLinearVelocity;
				this.pendulumVelocities.set(player, vel);
				const swingForce = inputDirection.mul(25);
				const newVelocity = vel.add(swingForce);
				this.pendulumVelocities.set(player, newVelocity);
				print("Applied swing! New velocity:", newVelocity);
			}
		} else if (currentVelocity && isGrappling) {
			const swingForce = inputDirection.mul(25);
			const newVelocity = currentVelocity.add(swingForce);
			this.pendulumVelocities.set(player, newVelocity);
			print("Applied swing! New velocity:", newVelocity);
		}
	}

	stopGrapple(player: Player) {
		if (this.physicsStates.get(player) !== true) {
			return;
		}

		print("Stopping grapple for", player.Name);

		this.physicsStates.set(player, false);

		const connection = this.grappleConnections.get(player);
		if (connection) {
			connection.Disconnect();
			this.grappleConnections.delete(player);
		}

		this.pendulumVelocities.delete(player);
		this.grapplePoints.delete(player);
		this.ropeLengths.delete(player);

		const character = player.Character as Model;
		if (character) {
			const humanoid = character.FindFirstChild("Humanoid") as Humanoid | undefined;
			if (humanoid) {
				humanoid.ChangeState(Enum.HumanoidStateType.Freefall);
			}
		}
	}
}
