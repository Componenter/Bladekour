/* Author: Amponent
   Date: 10/20/2025
*/

import ProfileStore, { Profile } from "@rbxts/profile-store";
import { Players } from "@rbxts/services";

const ProfileTemplate = {
	Kills: 0,
	Deaths: 0,

	Level: 1,
	Experience: 0,

	EquippedWeapon: "Default",
	WeaponStorage: new Array<string>(),

	EquippedGrapplingHook: "Default",
	GrapplingHookStorage: new Array<string>(),
};

const PlayerStore = ProfileStore.New("PlayerStore", ProfileTemplate);
const ProfileCache = new Map<Player, Profile<typeof ProfileTemplate>>();

const PlayerAdded = (player: Player) => {
	// Start the profile session for the player

	const Profile = PlayerStore.StartSessionAsync(tostring(player.UserId), {
		Cancel: () => {
			return player.Parent !== Players;
		},
	});

	if (Profile !== undefined) {
		Profile.AddUserId(player.UserId);
		Profile.Reconcile(); // Fill in missing variables

		Profile.OnSessionEnd.Connect(() => {
			ProfileCache.delete(player);
			player.Kick("Profile session end - Please rejoin");
		});

		if (player.Parent === Players) {
			ProfileCache.set(player, Profile);
		} else {
			Profile.EndSession();
		}
	} else {
		player.Kick("Profile load fail - Please rejoin");
	}
};

Players.GetPlayers().forEach((player) => {
	task.spawn(PlayerAdded, player);
});

Players.PlayerAdded.Connect(PlayerAdded);

Players.PlayerRemoving.Connect((player: Player) => {
	const Profile = ProfileCache.get(player);
	if (Profile) {
		Profile.EndSession();
	}
});

game.BindToClose(() => {
	ProfileCache.forEach((profile) => {
		profile.EndSession();
	});
});

export = ProfileCache;
