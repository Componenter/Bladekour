import ByteNet from "@rbxts/bytenet";

export const Movement = ByteNet.defineNamespace("Movement", () => {
	return {
		Grapple: ByteNet.definePacket({
			value: ByteNet.unknown,
			reliabilityType: "reliable",
		}),

		GrappleMovement: ByteNet.definePacket({
			value: ByteNet.string,
			reliabilityType: "reliable",
		}),
	};
});
