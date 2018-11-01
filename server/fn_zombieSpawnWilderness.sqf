if(!isDedicated && !isServer) exitWith { false };

zActiveZombies = [];
zMaxZombies = 60;
_activeSpawn = false;
zRefreshTimer = 1;
zIdleTimer = 60;
zAccTimer = zRefreshTimer;
zKillSpawn = false;
zSpawnWeights = [0.03, 0.1, 0.4, 0.2, 0.5, 0.8, 0.9]; // Demons, Fast, Walker, Medium, Slow, Spiders, Crawlers
_threatLevel = 0;

_fncSafezoneCheck = {
	if(zSurvivorsInSafezones != 0) then {
		_threatLevel = 1 - (zSurvivorsInSafezones / count (playableUnits - [lucifer]));
	} else {
		_threatLevel = 1;
	};
};

if(zDebug) then { systemChat "zDebug (zombieSpawnWilderness): Wild zombie spawner loop started" };

while { !zKillSpawn } do {
	sleep zAccTimer;
	call _fncSafezoneCheck;
	if(count (playableUnits - [lucifer]) > 0 && _threatLevel > 0) then {
		zAccTimer = zRefreshTimer;
		_activeSpawn = true;
	};

	while { _activeSpawn } do {
		sleep zAccTimer;
		call _fncSafezoneCheck;

		if(count (playableUnits - [lucifer]) == 0 || zKillSpawn || _threatLevel == 0) then {
			_activeSpawn = false;
			zAccTimer = zIdleTimer;
		} else {
			if(count zActiveZombies < zMaxZombies) then {
    			_rndPosition = [selectRandom (playableUnits - [lucifer]), 25, 600, 0, 0, 0, 0, [], []] call BIS_fnc_findSafePos;
				_zombieList = objNull;
				_group = objNull;
				if(!isNil "zSideJIP") then {
					_zombieList = (if(zSideJIP == independent) then { zListOpfor } else { zList });
					_group = createGroup (if(zSideJIP == independent) then { east } else { independent });
				} else {
					_zombieList = zList;
					_group = createGroup independent;
				};

				_zombieType = _zombieList selectRandomWeighted zSpawnWeights;
				_zombieClass = selectRandom (_zombieType#1);
				_unit = _group createUnit [_zombieClass, _rndPosition, [], 20, "NONE"];
				[_unit, typeOf _unit == "ryanszombiesboss1", 650, 10] spawn ZE_fnc_zombieDeletion;
				_unit addEventHandler ["Killed", { [_this#0, _this#1] call ZE_fnc_moneyDrop }];
				zActiveZombies pushBack _unit;
				_group deleteGroupWhenEmpty true;
				{ _x addCuratorEditableObjects [units _group, false] } forEach allCurators;

				if(zDebug) then { systemChat format ["zDebug (zombieSpawnWilderness): Spawned %1 @ %2, %3", getText(configFile >> "CfgVehicles" >> _zombieClass >> "displayName"), _rndPosition, _group] };

			} else {
				_hasNull = true;
				while { _hasNull } do {
					_hasNull = false;
					{
						if(isNull _x) exitWith {
							_hasNull = true;
							zActiveZombies deleteAt _forEachIndex;
							if(zDebug) then { systemChat "zDebug (zombieSpawnWilderness): Deleted a null unit from active zombie array" };
						};
					} forEach zActiveZombies;
				};
			};
		};
	};
};

// Cleanup if killed
zMaxZombies = nil;
zKillSpawn = nil;
zSpawnSide = nil;
zRefreshTimer = nil;
zIdleTimer = nil;
zAccTimer = nil;
zSpawnWeights = nil;

if(zDebug) then { systemChat "zDebug (zombieSpawnWilderness): Spawning script terminated" };