_locations = call ZE_fnc_getAllLocations;

if(zDebug) then { systemChat "zDebug (mapSetup): Setting up map markers" };
_locations spawn {
	{
		_radius = 100;
		switch(type _x) do {
			case "NameVillage": { _radius = 500 };
			case "NameCity": { _radius = 1000 };
			case "NameCityCapital": {_radius = 1500 };
		};
		
		_markerRef = createMarker [text _x, position _x];
		_markerRef setMarkerShape "ELLIPSE";
		_markerRef setMarkerSize [_radius, _radius];
		_markerRef setMarkerBrush "SOLID";
		_markerRef setMarkerColor "ColorRed";
		_markerRef setMarkerAlpha 0.35;
		if(zDebug) then { systemChat format ["zDebug (mapSetup): Marker created @ %1 for %2 (%3)", position _x, text _x, str _x] };
		_triggerRef = createTrigger ["EmptyDetector", position _x, false];
		_triggerRef setTriggerArea [_radius, _radius, 0, false];
		_triggerRef setTriggerActivation ["ANYPLAYER", "PRESENT", true];
		//WIP
		_triggerRef setTriggerStatements ["this", "hint 'Entered area zombie spawning radius'", "hint 'Left area zombie spawning radius'"];
		uiSleep 0.1;
	} forEach _this;
};