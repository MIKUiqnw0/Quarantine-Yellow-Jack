/*
	List of indentifiers
	-------------------------------
	Weapons
	-------------------------------
	arifle_		Assault Rifle
	srifle_		Sniper Rifle
	LMG_		Light Machine Gun
	MMG_		Medium Machine Gun
	SMG_		Submachine Gun
	hgun_		Handgun
	launch_		Rocket Launcher
	-------------------------------
	Magazine
	-------------------------------
	*By Rounds
	100,10,11,130,150,16,1,200,20,30,3,5,6,7,9 - (n)Rnd_
	100,10,200,20,30,5,7 - ACE_(n)Rnd_
	-------------------------------
	Backpacks
	-------------------------------
	B_
	-------------------------------
	Items
	-------------------------------
	H_ 			headgear
	-------------------------------

	["headgear", "goggles", ["assignedItems"],
	"uniform", ["uniformItems"], "vest",
	["vestItems"], "backpack", ["backpackItems"],
	"primaryWeapon", "secondaryWeapon", "handgunWeapon",
	"binocular", ["primaryWeaponItems"], ["secondaryWeaponItems"],
	["handgunItems"]
*/

params["_purchase", "_type", "_isArray"];
_endCost = 0;
if(!_isArray) then {
	switch(_type) do {
		case "headgear";
		case "goggles";
		case "uniform";
		case "vest": {
			_index = listOfClassNames select 3 find _purchase;
			_endCost = getArray(missionConfigFile >> "CfgArsenal" >> "Items" >> "list") select _index select 1;
		};
		case "backpack": {
			_index = listOfClassNames select 2 find _purchase;
			_endCost = getArray(missionConfigFile >> "CfgArsenal" >> "Backpacks" >> "list") select _index select 1;
		};
		case "primaryWeapon";
		case "secondaryWeapon";
		case "handgunWeapon";
		case "binocular": {
			_index = listOfClassNames select 0 find _purchase;
			if(_index == -1 && zDebug) then {
				systemChat format ["zDebug (calcCosts): _index is -1. Item %1 could not be found in CfgArsenal >> 'Weapons'", _purchase];
			} else {
				_endCost = _endCost + (getArray(missionConfigFile >> "CfgArsenal" >> "Weapons" >> "list") select _index select 1);
			};
		};
	};
};

if(_isArray) then {
	switch(_type select 0) do {
		case "assignedItems";
		case "primaryWeaponItems";
		case "secondaryWeaponItems";
		case "handgunItems": {
			{
				_index = listOfClassNames select 3 find _x;
				_endCost = _endCost + (getArray(missionConfigFile >> "CfgArsenal" >> "Items" >> "list") select _index select 1);
			} forEach _purchase;
		};
		case "uniformItems";
		case "vestItems";
		case "backpackItems": {
			_searchIn = [3,1,0]; // Search through items, then magazines and finally weapons categories in config
			_ref = ["Items", "Magazines", "Weapons"];
			{
				_xPurchase = _x;
				_index = {
					private _i = listOfClassNames select _x find _xPurchase;
					if(_i != -1) exitWith { [_forEachIndex , _i, _x] }; // [0] - matching index for _ref, [1] - item index in Cfg, [2] - debug index ref for category
				} forEach _searchIn;
				if(isNil "_index" && zDebug) then {
					systemChat format ["zDebug (calcCosts): _index is nil. Item %1 could not be found in CfgArsenal", _x];
				} else {
					_configRef = getArray(missionConfigFile >> "CfgArsenal" >> (_ref select (_index select 0)) >> "list");
					_endCost = _endCost + (_configRef select (_index select 1) select 1);
				};
			} forEach _purchase;
		};
	};
};
_endCost;