if(!isDedicated && !isServer) exitWith { false };

params["_callerSteam", ["_silent", false]];
if(zDebug) then { systemChat format ["zDebug (moneyBalance): Client:%1 | SteamID:%2 requested their balance", remoteExecutedOwner, _callerSteam] };

_bank = profileNamespace getVariable "zBank";
_account = _bank findIf { _x#0 == _callerSteam };

if(_account == -1) exitWith {
	_bonus = "MoneyBonus" call BIS_fnc_getParamValue;
	_account = [_callerSteam, _bonus];
	_bank pushBack _account;
	profileNamespace setVariable ["zBank", _bank];
	zMoney = _account#1;
	remoteExecutedOwner publicVariableClient "zMoney";
	if(_bonus != 0) then {
		if(zDebug) then { systemChat format ["zDebug (moneyBalance): Client:%1 | SteamID:%2 recieved new player bonus", remoteExecutedOwner, _callerSteam] };
		[format ["Account Balance\n\nYou have received a new player bonus.\nYou have $%1 under your name.", zMoney]] remoteExec ["hint", remoteExecutedOwner];
	} else {
		if(zDebug) then { systemChat format ["zDebug (moneyBalance): Created new account for Client:%1 | SteamID:%2", remoteExecutedOwner, _callerSteam] };
	}
};

if(zDebug) then { systemChat format ["zDebug (moneyBalance): Client:%1 | SteamID:%2 account found, sent data", remoteExecutedOwner, _callerSteam] };
zMoney = _bank#_account#1;
remoteExecutedOwner publicVariableClient "zMoney";
if(!_silent) then {
	[format ["Account Balance\n\nYou have $%1 under your name.", zMoney]] remoteExec ["hint", remoteExecutedOwner];
};