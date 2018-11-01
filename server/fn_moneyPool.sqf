if(!isDedicated && !isServer) exitWith { false };

moneyPool = profileNamespace getVariable ["zMoneyPool"];
if(isNil "moneyPool") then {
	profileNamespace setVariable ["zMoneyPool", 0];
	moneyPool = 0;
};