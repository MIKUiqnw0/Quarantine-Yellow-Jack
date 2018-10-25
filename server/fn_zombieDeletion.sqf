// Adapted from Ryan's Zombies & Demons to use players as the basis for detection instead of sides.
params ["_zombie","_isDemon", "_deletionRadius", "_deletionCheckTime"];

if ((!isServer) and hasInterface) exitwith {};

while {alive _zombie} do
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
			deletevehicle _zombie;
		};
	};
	deletevehicle _trg;
};