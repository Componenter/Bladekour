import ByteNet from "@rbxts/bytenet";

export const GameState = ByteNet.defineNamespace("GameState", () => {
	return {
		RequestData: ByteNet.definePacket({
			value: ByteNet.unknown,
			reliabilityType: "reliable",
		}),

		TransitionState: ByteNet.definePacket({
			value: ByteNet.string,
			reliabilityType: "reliable",
		}),
		PlayerHit: ByteNet.definePacket({
			value: ByteNet.struct({
				damage: ByteNet.uint8,
				attackerUserId: ByteNet.uint32,
				knockback: ByteNet.vec3,
				attackType: ByteNet.string,
			}),
			reliabilityType: "reliable",
		}),

		DamageDealt: ByteNet.definePacket({
			value: ByteNet.struct({
				targetUserId: ByteNet.uint32,
				damage: ByteNet.uint8,
				knockback: ByteNet.vec3,
			}),
			reliabilityType: "reliable",
		}),

		PlayerDied: ByteNet.definePacket({
			value: ByteNet.struct({
				killerUserId: ByteNet.optional(ByteNet.uint32),
				killerId: ByteNet.optional(ByteNet.uint32),
			}),
			reliabilityType: "reliable",
		}),
	};
});
