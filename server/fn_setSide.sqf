if(!isDedicated && !isServer) exitWith { false };

params["_target", "_side"];
_layers = [
	[independent, (getMissionLayerEntities "IndepBase")],
	[east, (getMissionLayerEntities "RuskieBase")],
	[west, (getMissionLayerEntities "MericaBase")]
];
_fncDelete = {
	params["_layer"];
	if(zDebug) then { systemChat format ["zDebug (setSide): Deleting base objects on side %1", _layer#0] };
	{
		deleteVehicle _x;
	} forEach _layer#1#0;
	{
		deleteMarker _x;
	} forEach _layer#1#1;
};

// Removes the action from base leader on selected side.
{
	if(_x isEqualTo _target) then {
		[_x] remoteExec ["ZE_fnc_removeVIPAction", [0, -2] select isDedicated];
	};
	remoteExec["", format ["%1_action", vehicleVarName _x]];
} forEach [VIPIndep, VIPRuskie, VIPMerica];

// Destroy opposing bases and set the units side.
switch (_side) do {
	case independent: {
		[_layers#1] call _fncDelete;
		[_layers#2] call _fncDelete;
		playableUnits - [lucifer] joinSilent (createGroup independent);
		indepBaseUnits apply { units _x joinSilent (createGroup independent) };
		indepBaseUnits = nil;
		zSideJIP = independent;
	};
	case east: {
		[_layers#0] call _fncDelete;
		[_layers#2] call _fncDelete;
		playableUnits - [lucifer] joinSilent (createGroup east);
		ruskieBaseUnits apply { units _x joinSilent (createGroup east) };
		ruskieBaseUnits = nil;
		zSideJIP = east;
	};
	case west: {
		[_layers#0] call _fncDelete;
		[_layers#1] call _fncDelete;
		zSideJIP = west;
		"respawn_west" setMarkerPos markerPos "locMerica";
	};
};

publicVariable "zSideJIP";
switch(zSideJIP) do {
	case independent: {
		["indepTask", "SUCCEEDED", true] call BIS_fnc_taskSetState;
		["ruskieTask", "CANCELED", false] call BIS_fnc_taskSetState;
		["mericaTask", "CANCELED", false] call BIS_fnc_taskSetState;
	};
	case east: {
		["indepTask", "CANCELED", false] call BIS_fnc_taskSetState;
		["ruskieTask", "SUCCEEDED", true] call BIS_fnc_taskSetState;
		["mericaTask", "CANCELED", false] call BIS_fnc_taskSetState;
	};
	case west: {
		["indepTask", "CANCELED", false] call BIS_fnc_taskSetState;
		["ruskieTask", "CANCELED", false] call BIS_fnc_taskSetState;
		["mericaTask", "SUCCEEDED", true] call BIS_fnc_taskSetState;
	};
};
["beginTask", "SUCCEEDED", true] call BIS_fnc_taskSetState;