// Server entry

import ProfileCache from "server/data/player-data-store";
import { setupNetworking } from "server/network/setup";

ProfileCache.isEmpty();
setupNetworking();
