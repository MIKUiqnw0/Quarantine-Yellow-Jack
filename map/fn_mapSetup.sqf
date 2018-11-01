params[["_debugRecreate", false]];

_locations = call ZE_fnc_getAllLocations;

if(_debugRecreate && !isNil "zMapReferences") then {
	{ deleteMarker _x#1 } forEach zMapReferences;
	{ deleteVehicle _x#2 } forEach zMapReferences;
};
zMapReferences = [];

if(zDebug) then { systemChat "zDebug (mapSetup): Setting up map markers" };
_locations spawn {
	{
		_store = [];
		_store pushBack _x;

		_radius = 100;
		switch(type _x) do {
			case "NameVillage": { _radius = 350 };
			case "NameCity": { _radius = 500 };
			case "NameCityCapital": {_radius = 700 };
		};

		_markerRef = createMarker [text _x, position _x];
		_markerRef setMarkerShape "ELLIPSE";
		_markerRef setMarkerSize [_radius, _radius];
		_markerRef setMarkerBrush "SOLID";
		_markerRef setMarkerColor "ColorRed";
		_markerRef setMarkerAlpha 0.35;
		_store pushBack _markerRef;
		if(zDebug) then { systemChat format ["zDebug (mapSetup): Marker created @ %1 for %2 (%3)", position _x, text _x, str _x] };
		_triggerRef = createTrigger ["EmptyDetector", position _x, false];
		_triggerRef setVariable ["location", _forEachIndex];
		_triggerRef setTriggerArea [_radius, _radius, 0, false];
		_triggerRef setTriggerActivation ["ANYPLAYER", "PRESENT", true];
		//WIP
		_triggerRef setTriggerStatements ["this", "[_thisTrigger getVariable 'location'] remoteExec ['ZE_fnc_zombieSpawnLocations', 2, false]", "hint 'Left area zombie spawning radius'"];
		_store pushBack _triggerRef;
		zMapReferences pushBack _store;
		uiSleep 0.1;
	} forEach _this;
};