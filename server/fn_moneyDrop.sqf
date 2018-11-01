if(!isDedicated && !isServer) exitWith { false };
params ["_unit", "_killer"];
if(!(_killer in playableUnits)) exitWith { false };

_randMoney = round(random 100);
_callerSteam = getPlayerUID _killer;
_clientId = owner _killer;

_bank = profileNamespace getVariable "zBank";
_account = _bank findIf { _x#0 == _callerSteam };

if(_account == -1) exitWith {
	diag_log format ["zDebug (moneyDrop): Failed to find client:%1 | SteamID:%2 _account in _bank", _clientId, _callerSteam];
	if(zDebug) then { systemChat format ["zDebug (moneyDrop): Failed to find client:%1 | SteamID:%2 _account in _bank", _clientId, _callerSteam] };
};

_bank#_account set [1, _bank#_account#1 + _randMoney];
zMoney = _bank#_account#1;

_clientId publicVariableClient "zMoney";
format ["Gained $%1 from killing %2.", _randMoney, getText(configFile >> "CfgVehicles" >> typeOf _unit >> "displayName")] remoteExec ["systemChat", _clientId, false];