if(isDedicated) exitWith { false };
params["_box"];

if(zDebug) then { systemChat "zDebug (handleEquip): Reading current equipment and profile" };
_curEquips = false call ZE_fnc_currentEquip;
[getPlayerUID player] remoteExecCall ["ZE_fnc_moneyBalance", 2];
_transactionDone = false;

[_box, player, true] call ace_arsenal_fnc_openBox;

/*
while { !_transactionDone } do {
	_cost = 0;
	if(zDebug) then { systemChat "zDebug (handleEquip): Waiting for arsenal display..."; };
	waitUntil { !isNull (uiNameSpace getVariable "RSCDisplayArsenal") };
	if(zDebug) then { systemChat "zDebug (handleEquip): Waiting for arsenal exit..."; };
	waitUntil { isNull (uiNameSpace getVariable "RSCDisplayArsenal") };

	if(zDebug) then { systemChat "zDebug (handleEquip): Arsenal exited, now evaluating gear cost" };
	_newEquips = call ZE_fnc_currentEquip;
	_struct = true call ZE_fnc_currentEquip;

	for [{private _i = 0}, {_i < count _struct}, {_i = _i + 1}] do {
		_curSelect = _curEquips select _i;
		_newSelect = _newEquips select _i;
		_equipType = _struct select _i;
		
		if(typeName _equipType == "ARRAY") then {
			_filtered = [+_curSelect, +_newSelect] call ZE_fnc_inventoryFilter;
			if(count _filtered != 0) then {
				_cost = _cost + ([_filtered, _equipType, true] call ZE_fnc_calcCosts);
			}
		} else {
			if(_curSelect != _newSelect && _newSelect != "") then {
				_cost = _cost + ([_newSelect, _equipType, false] call ZE_fnc_calcCosts);
			};
		};
	};

	if(isNil "_cost") exitWith { 
		systemChat "_cost borked, reset";
		_curEquips call ZE_fnc_resetEquip;
	};

	if(zDebug) then { systemChat format ["zDebug (handleEquip): Final cost for new equipment is $%1...", _cost] };

	if(_cost == 0) then {
		if(zDebug) then { systemChat "zDebug (handleEquip): Nothing purchased, restoring equipment and terminating transaction" };
		_curEquips call ZE_fnc_resetEquip;
		_transactionDone = true;
	} else {
		if(_cost > zMoney) then {
			if(zDebug) then { systemChat format ["zDebug (handleEquip): Not enough money ($%1), returning to arsenal...", _cash] };
			["Open", false] call BIS_fnc_arsenal;
		} else {
			purchaseCancel = false;
			[zMoney, _cost] call ZE_fnc_shopDialog;
			waitUntil { !dialog };
			if (purchaseCancel) then {
				if(zDebug) then { systemChat "zDebug (handleEquip): Purchase cancelled, returning to arsenal..."};
				["Open", false] call BIS_fnc_arsenal;
			} else {
				//_cash = _cash - _cost;
				[getPlayerUID player, _cost] remoteExecCall ["ZE_fnc_moneyDeduct", 2];
				if(zDebug) then { systemChat format ["zDebug (handleEquip): $%1 deducted from profile, now $%2", _cost, zMoney] };
				_transactionDone = true;
				if(zDebug) then { systemChat "zDebug (handleEquip): Transaction Completed" };
			};
		};
	};
};*/