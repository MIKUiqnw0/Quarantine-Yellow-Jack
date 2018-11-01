if(isDedicated) exitWith { false };
["Preload"] call BIS_fnc_arsenal;

waitUntil { alive player };
zMoney = 0;
[getPlayerUID player, true] remoteExecCall ["ZE_fnc_moneyBalance", 2];
player action ["SwitchWeapon", player, player, 100];