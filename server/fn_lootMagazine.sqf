if(!isDedicated && !isServer) exitWith { false };

zKillLoot = false;
_weaponArr = [];
_arsenalMags = [];
{ _arsenalMags pushBack _x#0 } forEach (getArray (missionConfigFile >> "CfgArsenal" >> "Magazines" >> "list"));

while { !zKillLoot } do {
	_supportedMags = [];
	ryanzombiesmagazines = [];
 	{
  		_weaponsArr = weapons _x;
  		{
			{ _supportedMags pushBackUnique _x } forEach (getArray (configFile >> "CfgWeapons" >> _x >> "magazines"));
  		} forEach _weaponsArr;
  		ryanzombiesmagazines = _supportedMags arrayIntersect _arsenalMags;
		ryanzombiesmagazinesSoldier = ryanzombiesmagazines;
	} forEach playableUnits - [lucifer];
	sleep 300;
};