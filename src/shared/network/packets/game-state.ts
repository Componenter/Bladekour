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
	};
});
