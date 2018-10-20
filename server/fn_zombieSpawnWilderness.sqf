if(!isDedicated && !isServer) exitWith { false };

_zombieTypes = [
	[
		(configfile >> "CfgGroups" >> "Indep" >> "Ryanzombiesfaction" >> "RyanzombiesgroupWalker" >> "RyanzombiesgroupWalker2"),
		(configfile >> "CfgGroups" >> "Indep" >> "Ryanzombiesfaction" >> "RyanzombiesgroupWalker" >> "RyanzombiesgroupWalker3"),
		(configfile >> "CfgGroups" >> "Indep" >> "Ryanzombiesfaction" >> "RyanzombiesgroupWalker" >> "RyanzombiesgroupWalker4"),
		(configfile >> "CfgGroups" >> "Indep" >> "Ryanzombiesfaction" >> "RyanzombiesgroupWalker" >> "RyanzombiesgroupWalker5")
	],[
		(configfile >> "CfgGroups" >> "Indep" >> "Ryanzombiesfaction" >> "RyanzombiesgroupCrawler" >> "RyanzombiesgroupCrawler2"),
		(configfile >> "CfgGroups" >> "Indep" >> "Ryanzombiesfaction" >> "RyanzombiesgroupCrawler" >> "RyanzombiesgroupCrawler3")
	],[
		(configfile >> "CfgGroups" >> "Indep" >> "Ryanzombiesfaction" >> "Ryanzombiesgroupslow" >> "Ryanzombiesgroupslow2"),
		(configfile >> "CfgGroups" >> "Indep" >> "Ryanzombiesfaction" >> "Ryanzombiesgroupslow" >> "Ryanzombiesgroupslow3"),
		(configfile >> "CfgGroups" >> "Indep" >> "Ryanzombiesfaction" >> "Ryanzombiesgroupslow" >> "Ryanzombiesgroupslow4"),
		(configfile >> "CfgGroups" >> "Indep" >> "Ryanzombiesfaction" >> "Ryanzombiesgroupslow" >> "Ryanzombiesgroupslow5")
	],[
		(configfile >> "CfgGroups" >> "Indep" >> "Ryanzombiesfaction" >> "Ryanzombiesgroupspider" >> "Ryanzombiesgroupspider2"),
		(configfile >> "CfgGroups" >> "Indep" >> "Ryanzombiesfaction" >> "Ryanzombiesgroupspider" >> "Ryanzombiesgroupspider3")
	],[
		(configfile >> "CfgGroups" >> "Indep" >> "Ryanzombiesfaction" >> "Ryanzombiesgroupmedium" >> "Ryanzombiesgroupmedium2"),
		(configfile >> "CfgGroups" >> "Indep" >> "Ryanzombiesfaction" >> "Ryanzombiesgroupmedium" >> "Ryanzombiesgroupmedium3"),
		(configfile >> "CfgGroups" >> "Indep" >> "Ryanzombiesfaction" >> "Ryanzombiesgroupmedium" >> "Ryanzombiesgroupmedium4"),
		(configfile >> "CfgGroups" >> "Indep" >> "Ryanzombiesfaction" >> "Ryanzombiesgroupmedium" >> "Ryanzombiesgroupmedium5")
	],[
		(configfile >> "CfgGroups" >> "Indep" >> "Ryanzombiesfaction" >> "Ryanzombiesgroupfast" >> "Ryanzombiesgroupfast3"),
		(configfile >> "CfgGroups" >> "Indep" >> "Ryanzombiesfaction" >> "Ryanzombiesgroupfast" >> "Ryanzombiesgroupfast5")
	],[
		(configfile >> "CfgGroups" >> "Indep" >> "Ryanzombiesfaction" >> "Ryanzombiesgroupdemon" >> "Ryanzombiesgroupdemon3")
	]
];

_zombieTypesOpfor = [
		[
		(configfile >> "CfgGroups" >> "East" >> "Ryanzombiesfactionopfor" >> "RyanzombiesgroupWalkeropfor" >> "RyanzombiesgroupWalker2opfor"),
		(configfile >> "CfgGroups" >> "East" >> "Ryanzombiesfactionopfor" >> "RyanzombiesgroupWalkeropfor" >> "RyanzombiesgroupWalker3opfor"),
		(configfile >> "CfgGroups" >> "East" >> "Ryanzombiesfactionopfor" >> "RyanzombiesgroupWalkeropfor" >> "RyanzombiesgroupWalker4opfor"),
		(configfile >> "CfgGroups" >> "East" >> "Ryanzombiesfactionopfor" >> "RyanzombiesgroupWalkeropfor" >> "RyanzombiesgroupWalker5opfor")
	],[
		(configfile >> "CfgGroups" >> "East" >> "Ryanzombiesfactionopfor" >> "RyanzombiesgroupCrawleropfor" >> "RyanzombiesgroupCrawler2opfor"),
		(configfile >> "CfgGroups" >> "East" >> "Ryanzombiesfactionopfor" >> "RyanzombiesgroupCrawleropfor" >> "RyanzombiesgroupCrawler3opfor")
	],[
		(configfile >> "CfgGroups" >> "East" >> "Ryanzombiesfactionopfor" >> "Ryanzombiesgroupslowopfor" >> "Ryanzombiesgroupslow2opfor"),
		(configfile >> "CfgGroups" >> "East" >> "Ryanzombiesfactionopfor" >> "Ryanzombiesgroupslowopfor" >> "Ryanzombiesgroupslow3opfor"),
		(configfile >> "CfgGroups" >> "East" >> "Ryanzombiesfactionopfor" >> "Ryanzombiesgroupslowopfor" >> "Ryanzombiesgroupslow4opfor"),
		(configfile >> "CfgGroups" >> "East" >> "Ryanzombiesfactionopfor" >> "Ryanzombiesgroupslowopfor" >> "Ryanzombiesgroupslow5opfor")
	],[
		(configfile >> "CfgGroups" >> "East" >> "Ryanzombiesfactionopfor" >> "Ryanzombiesgroupspideropfor" >> "Ryanzombiesgroupspider2opfor"),
		(configfile >> "CfgGroups" >> "East" >> "Ryanzombiesfactionopfor" >> "Ryanzombiesgroupspideropfor" >> "Ryanzombiesgroupspider3opfor")
	],[
		(configfile >> "CfgGroups" >> "East" >> "Ryanzombiesfactionopfor" >> "Ryanzombiesgroupmediumopfor" >> "Ryanzombiesgroupmedium2opfor"),
		(configfile >> "CfgGroups" >> "East" >> "Ryanzombiesfactionopfor" >> "Ryanzombiesgroupmediumopfor" >> "Ryanzombiesgroupmedium3opfor"),
		(configfile >> "CfgGroups" >> "East" >> "Ryanzombiesfactionopfor" >> "Ryanzombiesgroupmediumopfor" >> "Ryanzombiesgroupmedium4opfor"),
		(configfile >> "CfgGroups" >> "East" >> "Ryanzombiesfactionopfor" >> "Ryanzombiesgroupmediumopfor" >> "Ryanzombiesgroupmedium5opfor")
	],[
		(configfile >> "CfgGroups" >> "East" >> "Ryanzombiesfactionopfor" >> "Ryanzombiesgroupfastopfor" >> "Ryanzombiesgroupfast3opfor"),
		(configfile >> "CfgGroups" >> "East" >> "Ryanzombiesfactionopfor" >> "Ryanzombiesgroupfastopfor" >> "Ryanzombiesgroupfast5opfor")
	],[
		(configfile >> "CfgGroups" >> "East" >> "Ryanzombiesfactionopfor" >> "Ryanzombiesgroupdemonopfor" >> "Ryanzombiesgroupdemon3opfor")
	]
];

zGroupArr = [];
zMaxGroups = 6;
zLoop = true;
zTimer = 60;
zKill = false;

/*
_numTotal = 0;
_numArr = [];
for "_i" from 1 to 20 do {
  _num = floor(random 3) + 1;
  _numTotal = _numTotal + _num;
  _numArr pushback _num;
};
*/

_fnRandomType = compileFinal "selectRandom _this";
_fnRandomGroup = compileFinal "selectRandom _this";  // select (2 + round(random((count _randomType) - 3)))";
_fnRandomPosition = compileFinal "(selectRandom playableUnits) getPos [1000 * sqrt random 1, random 360]";
_fnZombieSpawn = compileFinal "[_this select 0, resistance, _this select 1] call BIS_fnc_spawnGroup";

if(zDebug) then { systemChat "zDebug (zombieSpawnWilderness): Wild zombie spawner loop started" };

while { !zKill } do {
	sleep zTimer;
	if ( west countSide allPlayers > 0 ) then { 
		zTimer = 10;
		zLoop = true;
	};
	
	while { zLoop } do {
		sleep zTimer;
		if( west countSide allPlayers == 0 || zKill ) then { 
			zLoop = false;
			zTimer = 60;
		} else {				
			if(count zGroupArr < zMaxGroups) then {
				_randomPosition = call _fnRandomPosition;
				_randomType = _zombieTypes call _fnRandomType;
				_randomGroup = _randomType call _fnRandomGroup;
				_spawnedGroup = [_randomPosition, _randomGroup] call _fnZombieSpawn;
				_spawnedGroup deleteGroupWhenEmpty true;
				(allCurators select 0) addCuratorEditableObjects [units _spawnedGroup, false];
				zGroupArr pushBack _spawnedGroup;
				
				if(zDebug) then { systemChat format ["zDebug (zombieSpawnWilderness): Spawned Group @ %1, %2", _randomPosition, _randomGroup] };
			} else {		
				// NULL Check the group array and purge any null entries.
				_hasNull = true;
				while { _hasNull } do {
					_hasNull = false;
					{		
						if(isNull _x) exitWith {
							_hasNull = true;
							zGroupArr deleteAt _forEachIndex;
							if(zDebug) then { systemChat "zDebug (zombieSpawnWilderness): Deleted a null group from group array" };
						};
					} forEach zGroupArr;
				};
				
				// Unit count check the group array and purge empty groups.
				// Keep an eye out for sync issues.
				_hasEmpty = true;
				while { _hasEmpty } do {
					_hasEmpty = false;
					{
						if(count units _x == 0) exitWith {
							_hasEmpty = true;
							zGroupArr deleteAt _forEachIndex;
							if(zDebug) then { systemChat "zDebug (zombieSpawnWilderness): Deleted a empty group from group array" };
						};
					} forEach zGroupArr;
				};
			};
		};
	};
};

// Cleanup
zGroupArr = nil; 
zMaxGroups = nil;
zLoop = nil;
zTimer = nil;
zKill = nil;

if(zDebug) then { systemChat "zDebug (zombieSpawnWilderness): Script Terminated" };