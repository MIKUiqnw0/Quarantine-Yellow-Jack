if(!isDedicated && !isServer) exitWith { false };

if(zDebug) then { systemChat "zDebug (initServer): Initializing server side" };
zSideJIP = nil;
publicVariable "zSideJIP";
if(isNil {profileNamespace getVariable "zBank"}) then { profileNamespace setVariable ["zBank", []] };

if(zDebug) then { systemChat "zDebug (initServer): Adding arsenal config to mission namespace" };
listOfClassNames = [];
_fnGetClass = {
	_finalArr = [];
	{ _finalArr pushBack (_x select 0) } forEach _this;
	listOfClassNames pushBack _finalArr;
	_finalArr;
};

_arr = getArray (missionConfigFile >> "CfgArsenal" >> "Weapons" >> "list");
[missionNamespace, _arr call _fnGetClass, false, false] call BIS_fnc_addVirtualWeaponCargo;
_arr = getArray (missionConfigFile >> "CfgArsenal" >> "Magazines" >> "list");
[missionNamespace, _arr call _fnGetClass, false, false] call BIS_fnc_addVirtualMagazineCargo;
_arr = getArray (missionConfigFile >> "CfgArsenal" >> "Backpacks" >> "list");
[missionNamespace, _arr call _fnGetClass, false, false] call BIS_fnc_addVirtualBackpackCargo;
_arr = getArray (missionConfigFile >> "CfgArsenal" >> "Items" >> "list");
[missionNamespace, _arr call _fnGetClass, false, false] call BIS_fnc_addVirtualItemCargo;

_aceListofClassNames = [];
{ _aceListofClassNames = _aceListofClassNames + _x } forEach listOfClassNames;
{ [_x, _aceListOfClassNames, true] call ACE_arsenal_fnc_addVirtualItems } forEach [arse];

if(zDebug) then { systemChat "zDebug (initServer): Forming array of zombie classnames" };
_cfgVehs = configFile >> "CfgVehicles";
_zList = ("(configName _x isKindOf 'CAManBase') && (getText (_x >> 'faction') == 'Ryanzombiesfaction')" configClasses _cfgVehs) apply { _x };
_zListOpfor = ("(configName _x isKindOf 'CAManBase') && (getText (_x >> 'faction') == 'Ryanzombiesfactionopfor')" configClasses _cfgVehs) apply { _x };
zList = [];
zListOpfor = [];

_fnFetchZombieClassNames = {
	params["_list","_vehClass"];
	_zombieConfigNames = [];
	{
		if(getText (_x >> "vehicleClass") == _vehClass) then {
			_zombieConfigNames pushBack configName _x;
		};
	} forEach _list;
	_zombieConfigNames;
};

zList pushBack ["Demons", [_zList, "ryanzombiesboss"] call _fnFetchZombieClassNames];
zList pushBack ["Spiders", [_zList, "ryanzombiesSpider"] call _fnFetchZombieClassNames];
zList pushBack ["Crawlers", [_zList, "ryanzombiesCrawler"] call _fnFetchZombieClassNames];
zList pushBack ["Fast", [_zList, "ryanzombiesfast"] call _fnFetchZombieClassNames];
zList pushBack ["Medium", [_zList, "ryanzombiesmedium"] call _fnFetchZombieClassNames];
zList pushBack ["Walkers", [_zList, "ryanzombieswalker"] call _fnFetchZombieClassNames];
zList pushBack ["Slow", [_zList, "ryanzombiesslow"] call _fnFetchZombieClassNames];

zListOpfor pushBack ["Demons", [_zListOpfor, "ryanzombiesboss"] call _fnFetchZombieClassNames];
zListOpfor pushBack ["Spiders", [_zListOpfor, "ryanzombiesSpider"] call _fnFetchZombieClassNames];
zListOpfor pushBack ["Crawlers", [_zListOpfor, "ryanzombiesCrawler"] call _fnFetchZombieClassNames];
zListOpfor pushBack ["Fast", [_zListOpfor, "ryanzombiesfast"] call _fnFetchZombieClassNames];
zListOpfor pushBack ["Medium", [_zListOpfor, "ryanzombiesmedium"] call _fnFetchZombieClassNames];
zListOpfor pushBack ["Walkers", [_zListOpfor, "ryanzombieswalker"] call _fnFetchZombieClassNames];
zListOpfor pushBack ["Slow", [_zListOpfor, "ryanzombiesslow"] call _fnFetchZombieClassNames];

if(zDebug) then { systemChat "zDebug (initServer): Waiting for preload end" };
addMissionEventHandler ["PreloadFinished", {
	if(isNil "lucifer") then { lucifer = objNull };
	[] spawn ZE_fnc_zombieSpawnWilderness;
	[] spawn ZE_fnc_lootMagazine;

	if(zDebug) then { systemChat "zDebug (initServer): Generating tasks" };
	[[p1, p2, p3, p4, p5], "beginTask", ["Or perhaps they can, that's up to you.<br/><br/>Either way, you and your questionably living crew are going to have to secure some kind of assistance and arsenal. Just last night, Jarate and a few other useless souls got the chop over there in that tent of yours - you can't keep this up anymore. Guns, ammo and food don't grow on trees either.<br/><br/>... Well, food might, but you lot are just desk sitters. What do you know?", "The living cannot survive alone", "This shouldn't show up"], getMarkerPos "respawn_west", "ASSIGNED", 0, true, "whiteboard", true] call BIS_fnc_taskCreate;
	[[p1, p2, p3, p4, p5], ["indepTask", "beginTask"], ["So you've decided to go at it alone. Kind of.<br/><br/>A ragtag group of Chernarus National Guard and PMCs just north of your doomed encampment have setup shop near Zelenogorsk at the Green Mountain radio tower. They've been around the place during your scavenging runs and you've had some close calls with these folks. Can't blame 'em really, everyone else looks like the stuff of nightmares.<br/><br/>You might be able to get some trade going on with this lot with abit of luck, assuming their sentries don't put a bullet through your skull first.", "1. Independently Screwed", "1. Independently Screwed"], position VIPIndep, "CREATED", 1, true, "meet", true] call BIS_fnc_taskCreate;
	[[p1, p2, p3, p4, p5], ["ruskieTask", "beginTask"], ["Todo", "2. Russian Recollection", "2. Russian Recollection"], position VIPRuskie, "CREATED", 1, true, "meet", true] call BIS_fnc_taskCreate;
	[[p1, p2, p3, p4, p5], ["mericaTask", "beginTask"], ["Todo", "3. American Freedom", "3. American Freedom"], position VIPMerica, "CREATED", 1, true, "meet", true] call BIS_fnc_taskCreate;

	if(zDebug) then { systemChat "zDebug (initServer): Adding action to VIP units" };
	{ [_x, _forEachIndex] remoteExec ["ZE_fnc_addVIPAction", [0, -2] select isDedicated, format ["%1_action", vehicleVarName _x]] } forEach [VIPIndep, VIPRuskie, VIPMerica];
}];