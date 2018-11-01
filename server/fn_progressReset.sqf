if(!isDedicated && !isServer || ("ResetConfirm" call BIS_fnc_getParamValue) == 0) exitWith { false };

if(("ResetProgress" call BIS_fnc_getParamValue) == 1) then {
	// Not implemented
};
if(("ResetMoney" call BIS_fnc_getParamValue) == 1) then {
	profileNamespace setVariable ["zBank", []];
	profileNamespace setVariable ["zMoneyPool", nil];
};