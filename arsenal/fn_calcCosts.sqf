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
	["weapons"], ["primaryWeaponItems"], 
	["secondaryWeaponItems"], ["handgunItems"]
*/

params["_purchase", "_type", "_isArray"];

_cost = 0;
if(!_isArray) then {
	switch(_type) do {
		case "headgear";
		case "goggles";
		case "uniform";
		case "vest": {
			_index = listOfClassNames select 3 find _purchase;
			_cost = getArray(missionConfigFile >> "CfgArsenal" >> "Items" >> "list") select _index select 1;
		};
		case "backpack": {
			_index = listOfClassNames select 2 find _purchase;
			_cost = getArray(missionConfigFile >> "CfgArsenal" >> "Backpacks" >> "list") select _index select 1;
		};
	};
};

if(_isArray) then {
	systemChat format ["Type: %1", _type select 0];
	switch(_type select 0) do {
		case "assignedItems";
		case "primaryWeaponItems";
		case "secondaryWeaponItems";
		case "handgunItems": {
			{
				_index = listOfClassNames select 3 find _x;
				_cfgCost = getArray(missionConfigFile >> "CfgArsenal" >> "Items" >> "list") select _index select 1;
				systemChat format ["_cfgCost = %1", _cfgCost];
				_cost = _cost + _cfgCost;
			} forEach _purchase;
		};
		case "uniformItems";
		case "vestItems";
		case "backpackItems": {
			_searchIn = [3,1,0]; // Search through items, then magazines and finally weapons categories in config
			_ref = ["Items", "Magazines", "Weapons"];
			{
				_xPurchase = _x;
				_index = { // Element 0 - Category in CfgArsenal, Element 1 - Index of item in that category
					_i = listOfClassNames select _x find _xPurchase;
					if(_i != -1) exitWith { [_forEachIndex , _i, _x] };
				} forEach _searchIn;
				if(isNil "_index" && zeDebug) then {
					systemChat format ["zeDebug (calcCosts): _index is nil. Item %1 could not be found in CfgArsenal", _x];
				} else {
					_configRef = getArray(missionConfigFile >> "CfgArsenal" >> (_ref select (_index select 0)) >> "list");
					_cost = _cost + (_configRef select (_index select 1) select 1);
				};
			} forEach _purchase;
		};
		case "weapons": {
			{
				_index = listOfClassNames select 0 find _x;
				if(isNil "_index" && zeDebug) then {
					systemChat format ["zeDebug (calcCosts): _index is nil. Item %1 could not be found in CfgArsenal >> 'Weapons'", _x];
				} else {
					_cost = _cost + (getArray(missionConfigFile >> "CfgArsenal" >> "Weapons" >> "list") select _index select 1);
				}
			} forEach _purchase;
		};
	};
};
_cost;