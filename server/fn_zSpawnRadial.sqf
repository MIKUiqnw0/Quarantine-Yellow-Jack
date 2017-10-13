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
maximumGroups = 6;
_zLoop = true;

_fnRandomType = compileFinal "selectRandom _this";
_fnRandomGroup = compileFinal "selectRandom _this";  // select (2 + round(random((count _randomType) - 3)))";
_fnRandomPosition = compileFinal "(selectRandom playableUnits) getPos [1000 * sqrt random 1, random 360]";
_fnZombieSpawn = compileFinal "[_this select 0, resistance, _this select 1] call BIS_fnc_spawnGroup";

if(zeDebug) then { systemChat "zeDebug (zSpawnRadial): Wilderness zombie spawner loop started" };

while { _zLoop } do {
	sleep zeRespawnTimer;
	if( west countSide allPlayers > 0 ) then {
		if(count zeGroupArr < maximumGroups) then {
			_randomPosition = call _fnRandomPosition;
			_randomType = _zombieTypes call _fnRandomType;
			_randomGroup = _randomType call _fnRandomGroup;
			_spawnedGroup = [_randomPosition, _randomGroup] call _fnZombieSpawn;
			_spawnedGroup deleteGroupWhenEmpty true;
			(allCurators select 0) addCuratorEditableObjects [units _spawnedGroup, false];
			zeGroupArr pushBack _spawnedGroup;
			
			if(zeDebug) then { systemChat format ["zeDebug (zSpawnRadial): Spawned Group @ %1, %2, %3", _randomPosition, _randomType, _randomGroup] };
		} else {		
			// NULL Check the group array and purge any null entries.
			_hasNull = true;
			while { _hasNull } do {
				_hasNull = false;
				{		
					if(isNull _x) exitWith {
						_hasNull = true;
						zeGroupArr deleteAt _forEachIndex;
						if(zeDebug) then { systemChat "zeDebug (zSpawnRadial): Deleted a null group from group array" };
					};
				} forEach zeGroupArr;
			};
			
			// Unit count check the group array and purge empty groups.
			// Keep an eye out for sync issues.
			_hasEmpty = true;
			while { _hasEmpty } do {
				_hasEmpty = false;
				{
					if(count units _x == 0) exitWith {
						_hasEmpty = true;
						zeGroupArr deleteAt _forEachIndex;
						if(zeDebug) then { systemChat "zeDebug (zSpawnRadial): Deleted a empty group from group array" };
						
					};
				} forEach zeGroupArr;
			};
		};
	};
};