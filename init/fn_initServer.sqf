if(!isDedicated && !isServer) exitWith { false };

if(zeDebug) then { systemChat "zeDebug (initServer): Initializing serverside" };
independent setFriend [civilian, 0];

if(zeDebug) then { systemChat "zeDebug (initServer): Adding arsenal config to mission namespace" };
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

if(zeDebug) then { systemChat "zeDebug (initServer): Waiting for preload end" };
_handle = addMissionEventHandler ["PreloadFinished", { [] spawn ZE_fnc_zSpawnRadial }];