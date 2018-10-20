if(isDedicated) exitWith { false };

// Query server profile for player's balance.
[getPlayerUID player, true] remoteExecCall ["ZE_fnc_moneyBalance", 2];

["Preload"] call BIS_fnc_arsenal;

waitUntil { alive player };
player action ["SwitchWeapon", player, player, 100];

_taskAfterPreload = addMissionEventHandler ["PreloadFinished", {
	[BLUFOR, "beginTask", ["Or perhaps they can, that's up to you.<br/><br/>Either way, you and your questionably living crew are going to have to secure some kind of assistance and arsenal. Just last night, Jarate and a few other useless souls got the chop over there in that tent of yours - you can't keep this up anymore. Guns, ammo and food don't grow on trees either.<br/><br/>... Well, food might, but you lot are just desk sitters. What do you know?", "The living cannot survive alone", "This shouldn't show up"], getMarkerPos "respawn_west", true, 0, false, "whiteboard", false] call BIS_fnc_taskCreate;
	[BLUFOR, ["indepTask", "beginTask"], ["So you've decided to go at it alone. Kind of.<br/><br/>A ragtag group of PMC and some locals just north of your doomed encampment have setup shop near Pulkovo. They've been around the place during your scavenging runs and you've had some close calls with these folks. Can't blame 'em really, everyone else looks like the stuff of nightmares.<br/><br/>You might be able to get some trade going on with this lot with abit of luck, assuming their sentries don't put a bullet through your skull first.", "1. Independently Screwed", "1. Independently Screwed"], position pmcvip, "Created", 1, false, "meet", false] call BIS_fnc_taskCreate;
	
	[missionNameSpace, "zSideJIP", 0] spawn BIS_fnc_getServerVariable;
	if(zSideJIP != 0) then { ["beginTask", "SUCCEEDED"] call BIS_fnc_taskSetState };
	switch(zSideJIP) do {
		case 1: { ["indepTask", "SUCCEEDED"] call BIS_fnc_taskSetState; };
		case 2: {};
		case 3: {};
	};
}];
