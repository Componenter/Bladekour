import Roact from "@rbxts/roact";
import { store } from "../../store";
import { play_button } from "./play-button";
import { settings_button } from "./settings-button";

export class homepage extends Roact.Component<{}, { Visible: boolean }> {
	protected state: Readonly<{ Visible: boolean }>;

	constructor(props: {}) {
		super(props);

		this.state = { Visible: true };
	}

	protected didMount(): void {
		this.setState({ Visible: true });

		store.changed.connect((newState, oldState) => {
			if (newState.home_page_visible !== oldState.home_page_visible) {
				this.setState({ ...this.state, Visible: newState.home_page_visible });
			}
		});
	}

	protected willUnmount(): void {}
	public render(): Roact.Element {
		return Roact.createElement(
			"Frame",
			{
				Size: new UDim2(1, 0, 1, 0),
				Position: new UDim2(0, 0, 0, 0),

				Transparency: 1,

				Visible: this.state.Visible,
			},
			{
				// Children
				play_button: play_button(),
				settings_button: settings_button(),
			},
		);
	}
}
