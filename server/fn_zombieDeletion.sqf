// Adapted from Ryan's Zombies & Demons to use players as the basis for detection instead of sides.
if (!isDedicated && !isServer) exitwith {};
params ["_zombie","_isDemon", "_deletionRadius", "_deletionCheckTime"];

_livingZombie = true;
while {_livingZombie && alive _zombie} do
{
	sleep _deletionCheckTime;
	_trg = createTrigger ["EmptyDetector", getposATL _zombie];
	_trg setTriggerArea [_deletionRadius, _deletionRadius, 0, false];
	_trg setTriggerStatements ["this", "", ""];
	_trg setTriggerActivation ["ANYPLAYER", "NOT PRESENT", false];

	sleep 1;
	if (triggeractivated _trg) then
	{
		deletevehicle _trg;
		_trg = createTrigger ["EmptyDetector", getposATL _zombie];
		_trg setTriggerArea [_deletionRadius, _deletionRadius, 0, false];
		_trg setTriggerStatements ["this", "", ""];
		_trg setTriggerActivation ["ANYPLAYER", "NOT PRESENT", false];

		sleep 1;
		if (triggeractivated _trg) exitwith
		{
			if(zDebug) then { systemChat format ["zDebug (zombieDeletion): %1 was deleted, %2", getText(configFile >> "CfgVehicles" >> typeOf _zombie >> "displayName"), str _zombie] };
			deletevehicle _zombie;
			_livingZombie = false;
		};
	};
	deletevehicle _trg;
};