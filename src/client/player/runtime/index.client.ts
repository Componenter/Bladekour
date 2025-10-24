import { setupClientNetworking } from "client/player/network/setup";
import { setup_menu_camera } from "../systems/menu/camera-controller";

// Setup networking
task.spawn(setupClientNetworking);
task.spawn(setup_menu_camera);
