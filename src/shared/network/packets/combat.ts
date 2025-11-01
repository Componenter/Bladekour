import ByteNet from "@rbxts/bytenet";

export const Combat = ByteNet.defineNamespace("Combat", () => {
	return {
		Attack: ByteNet.definePacket({ value: ByteNet.unknown, reliabilityType: "reliable" }),
	};
});
