if(isDedicated) exitWith { false };

zeMoney = 5000;

["Preload"] call BIS_fnc_arsenal;

waitUntil { alive player };
player action ["SwitchWeapon",player, player, 100];