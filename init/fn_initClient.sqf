if(isDedicated) exitWith { false };

// Query server profile for player's balance.
[getPlayerUID player, true] remoteExecCall ["ZE_fnc_moneyBalance", 2];

["Preload"] call BIS_fnc_arsenal;

waitUntil { alive player };
player action ["SwitchWeapon", player, player, 100];