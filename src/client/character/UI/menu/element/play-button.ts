import Roact, { Event } from "@rbxts/roact";
import { Actions, store } from "../../store";
import { game_state_actions, game_state_store } from "shared/state/game-state";
import { GameState } from "shared/network/packets";

export class play_button extends Roact.Component<{}, { Hovering: boolean }> {
	protected state: Readonly<{ Hovering: boolean }>;

	constructor(props: {}) {
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
				Text: "  PLAY  ",
				FontFace: new Font("Arial", Enum.FontWeight.Bold),

				Visible: true,
				Size: new UDim2(0.2, 0, 0.08, 0),
				Position: new UDim2(0.07, 0, 0.25, 0),

				TextColor3: Color3.fromRGB(207, 207, 207),
				BackgroundColor3: new Color3(0, 0, 0),
				BackgroundTransparency: 0.8,
				BorderSizePixel: 0,

				[Event.MouseButton1Click]: () => {
					store.dispatch(Actions.toggle_menu());
					game_state_store.dispatch(game_state_actions.spawn());
					GameState.TransitionState.send("Playing");
				},

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
