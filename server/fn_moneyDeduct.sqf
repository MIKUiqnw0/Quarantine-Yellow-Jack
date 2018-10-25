if(!isServer && !isDedicated) exitWith { false };

params["_callerSteam", "_amount"];
if(zDebug) then { systemChat format ["zDebug (moneyDeduct): Client:%1 | SteamID:%2 is deducting %3 from their balance", remoteExecutedOwner, _callerSteam, _amount] };

_bank = profileNamespace getVariable "zBank";
_account = _bank findIf { _x#0 == _callerSteam };

if(_account == -1) exitWith { 
	diag_log format ["zDebug (moneyDeduct): Failed to find client:%1 | SteamID:%2 account in bank", remoteExecutedOwner, _callerSteam];
	if(zDebug) then { systemChat format ["zDebug (moneyDeduct): Failed to find client:%1 | SteamID:%2 account in bank", remoteExecutedOwner, _callerSteam] };
};

_bank#_account set [1, _bank#_account#1 - _amount];
zMoney = _bank#_account#1;
remoteExecutedOwner publicVariableClient "zMoney";
[format ["Account Balance\n\nDeducted %1 from your account.\nYou now have $%2 under your name.", _amount, zMoney]] remoteExec ["hint", remoteExecutedOwner];