if(!isDedicated && !isServer) exitWith { false };

if(zDebug) then { systemChat "zDebug (initServer): Initializing server side" };
independent setFriend [civilian, 0];
zSideJIP = 0;
publicVariable "zSideJIP";
if(isNil {profileNamespace getVariable "zBank"}) then { profileNamespace setVariable ["zBank", []] };

RZ_fnc_zombie_onDeath_exec = {
	
};

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

if(zDebug) then { systemChat "zDebug (initServer): Forming array of zombie classnames" };
_cfgVehs = configFile >> "CfgVehicles";
_zList = ("(configName _x isKindOf 'CAManBase') && (getText (_x >> 'faction') == 'Ryanzombiesfaction')" configClasses _cfgVehs) apply { _x };
_zListOpfor = ("(configName _x isKindOf 'CAManBase') && (getText (_x >> 'faction') == 'Ryanzombiesfactionopfor')" configClasses _cfgVehs) apply { _x };
zDemons = _zList apply { if(getText (_x >> "vehicleClass") == "ryanzombiesboss") then { configName _x } };
zRunners = _zList apply { if(getText (_x >> "vehicleClass") == "ryanzombiesfast") then { configName _x } };
zWalkers = _zList apply { if(getText (_x >> "vehicleClass") == "ryanzombieswalker") then { configName _x } };
zMedium = _zList apply { if(getText (_x >> "vehicleClass") == "ryanzombiesmedium") then { configName _x } };
zSlow = _zList apply { if(getText (_x >> "vehicleClass") == "ryanzombiesslow") then { configName _x } };

if(zDebug) then { systemChat "zDebug (initServer): Waiting for preload end" };
_handle = addMissionEventHandler ["PreloadFinished", { [] spawn ZE_fnc_zombieSpawnWilderness }];