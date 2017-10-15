if(isDedicated) exitWith { false };

if(isNil { profileNamespace getVariable "zeMoney" }) then { profileNamespace setVariable ["zeMoney", 1000] };

["Preload"] call BIS_fnc_arsenal;

waitUntil { alive player };
player action ["SwitchWeapon",player, player, 100];