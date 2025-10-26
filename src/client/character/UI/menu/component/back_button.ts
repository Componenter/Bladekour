import Roact, { Event } from "@rbxts/roact";
import { Actions, store } from "../../store";
import { game_state_actions, game_state_store } from "shared/state/game-state";
import { GameState } from "shared/network/packets";

export class backbutton extends Roact.Component<{ Position: UDim2; onClick: () => void }, { Hovering: boolean }> {
	protected state: Readonly<{ Hovering: boolean }>;

	constructor(props: { Position: UDim2; onClick: () => void }) {
		super(props);

		this.state = { Hovering: false };
	}

	protected didMount(): void {
		this.setState({ Hovering: false });
	}

	protected willUnmount(): void {}

	public render(): Roact.Element {
		return Roact.createElement(
			"TextButton",
			{
				TextScaled: true,
				Text: "  BACK  ",
				FontFace: new Font("Arial", Enum.FontWeight.Bold),

				Visible: true,
				Size: new UDim2(0.21, 0, 0.1, 0),
				Position: this.props.Position,

				TextColor3: Color3.fromRGB(207, 207, 207),
				BackgroundColor3: new Color3(1, 0.07, 0.07),
				BackgroundTransparency: 0.6,
				BorderSizePixel: 0,

				[Event.MouseButton1Click]: this.props.onClick,

				[Event.MouseEnter]: () => {
					this.setState({ ...this.state, Hovering: true });
				},

				[Event.MouseLeave]: () => {
					this.setState({ ...this.state, Hovering: false });
				},
			},
			{
				UICorner: Roact.createElement("UICorner", {
					CornerRadius: new UDim(0.084, 0),
				}),

				HoverStroke: Roact.createElement("UIStroke", {
					Thickness: 1,

					Color: new Color3(1, 1, 1),
					Transparency: 0.3,

					ApplyStrokeMode: Enum.ApplyStrokeMode.Border,
					Enabled: this.state.Hovering,
				}),
			},
		);
	}
}
