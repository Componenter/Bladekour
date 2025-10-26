import { setupClientNetworking } from "client/player/network/setup";
import { setup_menu_camera } from "../systems/menu/camera-controller";
import { InputManager } from "../systems/input/input-manager";
import { TransitionManager } from "../systems/game-state/transition-manager";
import { PlayingState } from "../systems/game-state/playing-state";

// Setup networking
task.spawn(setup_menu_camera);

const inputManager = new InputManager();

task.spawn(() => {
	inputManager.initialize();
});

const playingState = new PlayingState(inputManager);

const transitionManager = new TransitionManager(playingState);

task.spawn(setupClientNetworking, transitionManager);
