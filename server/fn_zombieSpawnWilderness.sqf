if(!isDedicated && !isServer) exitWith { false };

_activeZombies = [];
zMaxZombies = 60;
_activeSpawn = false;
_timer = 3;
zKill = false;
_threatLevel = 0;

_fnSafezoneCheck = {			
	if(zSurvivorsInSafezones != 0) then {
		_threatLevel = 1 - (zSurvivorsInSafezones / count (playableUnits - [lucifer]));
	} else {
		_threatLevel = 1;
	};
};

if(zDebug) then { systemChat "zDebug (zombieSpawnWilderness): Wild zombie spawner loop started" };

while { !zKill } do {
	sleep _timer;
	call _fnSafezoneCheck;
	if(count (playableUnits - [lucifer]) > 0 && _threatLevel > 0) then {
		_timer = 3;
		_activeSpawn = true;
	};

	while { _activeSpawn } do {
		sleep _timer;
		call _fnSafezoneCheck;

		if(count (playableUnits - [lucifer]) == 0 || zKill || _threatLevel == 0) then { 
			_activeSpawn = false;
			_timer = 60;
		} else {
			if(count _activeZombies < zMaxZombies) then {
    			_rndPosition = [selectRandom (playableUnits - [lucifer]), 50, 600, 0, 0, 0, 0, [], []] call BIS_fnc_findSafePos;
				_zombieList = (if(zSideJIP == independent) then { zListOpfor } else { zList });
				_group = createGroup (if(zSideJIP == independent) then { east } else { independent });
				_groupAmount = 1; // floor(random 3) + 1;
				for "_i" from 1 to _groupAmount do {
					_zombieType = _zombieList selectRandomWeighted [0.03, 0.1, 0.4, 0.2, 0.5, 0.8, 0.9]; // Demons, Fast, Walker, Medium, Slow, Spiders, Crawlers
					_zombieClass = selectRandom (_zombieType#1);
					_unit = _group createUnit [_zombieClass, _rndPosition, [], 20, "NONE"];
					[_unit, typeOf _unit == "ryanszombiesboss1", 650, 10] spawn ZE_fnc_zombieDeletion;
					_unit addEventHandler ["Killed", { [_this#0, _this#1] call ZE_fnc_moneyDrop }];
					_activeZombies pushBack _unit;
				};
				_group deleteGroupWhenEmpty true;
				{ _x addCuratorEditableObjects [units _group, false] } forEach allCurators;
				if(zDebug) then { systemChat format ["zDebug (zombieSpawnWilderness): Spawned group with %1 unit @ %2, %3", _groupAmount, _rndPosition, _group] };
			} else {
				_hasNull = true;
				while { _hasNull } do {
					_hasNull = false;
					{		
						if(isNull _x) exitWith {
							_hasNull = true;
							_activeZombies deleteAt _forEachIndex;
							if(zDebug) then { systemChat "zDebug (zombieSpawnWilderness): Deleted a null unit from active zombie array" };
						};
					} forEach _activeZombies;
				};
			};
		};
	};
};

// Cleanup if killed
zMaxZombies = nil;
zKill = nil;
zSpawnSide = nil;

if(zDebug) then { systemChat "zDebug (zombieSpawnWilderness): Spawning script terminated" };