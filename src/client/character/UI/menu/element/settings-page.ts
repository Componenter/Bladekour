import Roact from "@rbxts/roact";
import { Actions, store } from "../../store";
import { play_button } from "./play-button";
import { backbutton } from "../component/back_button";
import { settings_sf_container } from "./settings-sf-container";

export class settingspage extends Roact.Component<{}, { Visible: boolean }> {
	protected state: Readonly<{ Visible: boolean }>;

	constructor(props: {}) {
		super(props);

		this.state = { Visible: false };
	}

	protected didMount(): void {
		this.setState({ Visible: false });

		store.changed.connect((newState, oldState) => {
			if (newState.settings_page_visible !== oldState.settings_page_visible) {
				this.setState({ ...this.state, Visible: newState.settings_page_visible });
			}
		});
	}

	protected willUnmount(): void {}
	public render(): Roact.Element {
		return Roact.createElement(
			"Frame",
			{
				Size: new UDim2(0.75, 0, 0.75, 0),
				Position: new UDim2(0.125, 0, 0.125, 0),

				Transparency: 0.5,
				BackgroundColor3: Color3.fromRGB(140, 140, 140),

				BorderSizePixel: 0,

				Visible: this.state.Visible,
			},
			{
				// Children
				UICorner: Roact.createElement("UICorner", {
					CornerRadius: new UDim(0.004, 0),
				}),

				back_button: Roact.createElement(backbutton, {
					Position: new UDim2(-0.1, 0, 0.95, 0),
					onClick: () => {
						store.dispatch(Actions.go_home_page());
					},
				}),

				settings_sf_container: settings_sf_container(),
			},
		);
	}
}
