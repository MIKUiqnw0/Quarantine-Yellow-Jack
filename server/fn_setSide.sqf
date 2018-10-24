if(!isServer && !isDedicated) exitWith { false };

params["_side", "_target", "_actionId"];

_target removeAction _actionId;
_layers = [getMissionLayerEntities "IndepBase", getMissionLayerEntities "RuskieBase", getMissionLayerEntities "MericaBase"];
_fncDelete = {
	params["_layer"];
	{
		deleteVehicle _x;
	} forEach _layer;
};

// Destroy opposing bases and set the units side.
switch (_side) do {
	case independent: {
		_layers#1 call _fncDelete;
		_layers#2 call _fncDelete;
		playableUnits - [lucifer] joinSilent (createGroup independent);
		indepBaseUnits apply { [_x] joinSilent (createGroup independent) };
		indepBaseUnits = nil;
		zSideJIP = independent;
		ryanzombiesdeletion = 0.3; // 0.9 = None 0.7 = Blufor 0.5 = Redfor 0.3 = Indep 0.1 = Civ
		ryanzombiesdeletiondemons = 0.3;
	};
	case east: { 
		_layers#0 call _fncDelete;
		_layers#2 call _fncDelete;
		playableUnits - [lucifer] joinSilent (createGroup east);
		ruskieBaseUnits apply { [_x] joinSilent (createGroup east) };
		ruskieBaseUnits = nil;
		zSideJIP = east;
		ryanzombiesdeletion = 0.5;
		ryanzombiesdeletiondemons = 0.5;
	};
	case west: { 
		_layers#0 call _fncDelete;
		_layers#1 call _fncDelete;
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