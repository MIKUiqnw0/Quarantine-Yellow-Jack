zeDebug = true;

[] spawn ZE_fnc_initServer;
[] spawn ZE_fnc_initClient;
[] spawn ZE_fnc_initLocations;

zearse addAction ["Purchase Weapons", {[] call ZE_fnc_handleEquip} , nil, 1.5, true, true, "", "player distance zearse < 5", 5, false, ""];