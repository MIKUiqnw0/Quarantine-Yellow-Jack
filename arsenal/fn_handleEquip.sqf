if(isDedicated) exitWith { false };
params["_box"];

if(zDebug) then { systemChat "zDebug (handleEquip): Reading current equipment and profile" };
_curEquips = false call ZE_fnc_currentEquip;
[getPlayerUID player] remoteExecCall ["ZE_fnc_moneyBalance", 2];

_fncClose = {
	params["_handle", "_arsenal", "_oldEquips"];
	if(zDebug) then { systemChat "zDebug (handleEquip): ACE Arsenal exited, evaluating gear costs" };
	_cost = 0;
	_newEquips = false call ZE_fnc_currentEquip;
	_struct = true call ZE_fnc_currentEquip;
	for [{private _i = 0}, {_i < count _struct}, {_i = _i + 1}] do {
		_curSelect = _oldEquips select _i;
		_newSelect = _newEquips select _i;
		_equipType = _struct select _i;

		if(typeName _equipType == "ARRAY") then {
			_filtered = [+_curSelect, +_newSelect] call ZE_fnc_inventoryFilter;
			if(count _filtered != 0) then {
				_cost = _cost + ([_filtered, _equipType, true] call ZE_fnc_calcCosts);
				systemChat format ["%1 returned on %2", _cost, _filtered];
			};
		} else {
			if(_curSelect != _newSelect && _newSelect != "") then {
				_cost = _cost + ([_newSelect, _equipType, false] call ZE_fnc_calcCosts);
				systemChat format ["%1 returned on else %2", _cost, _newSelect];
			};
		};
	};

	if(isNil "_cost") exitWith {
		systemChat "_cost borked, reset";
		_oldEquips call ZE_fnc_resetEquip;
		["ace_arsenal_displayClosed", _handle] call CBA_fnc_removeEventHandler;
	};

	if(zDebug) then { systemChat format ["zDebug (handleEquip): Final cost for new equipment is $%1...", _cost] };

	if(_cost == 0) then {
		if(zDebug) then { systemChat "zDebug (handleEquip): Nothing purchased, restoring equipment and terminating transaction" };
		_oldEquips call ZE_fnc_resetEquip;
		["ace_arsenal_displayClosed", _handle] call CBA_fnc_removeEventHandler;
	} else {
		if(_cost > zMoney) then {
			if(zDebug) then { systemChat format ["zDebug (handleEquip): Not enough money ($%1), returning to arsenal...", zMoney] };
			disableUserInput true;
			sleep 0.2;
			[_arsenal, player, false] call ace_arsenal_fnc_openBox;
			disableUserInput false;
		} else {
			purchaseCancel = false;
			[zMoney, _cost] call ZE_fnc_shopDialog;
			waitUntil { !dialog };
			if (purchaseCancel) then {
				if(zDebug) then { systemChat "zDebug (handleEquip): Purchase cancelled, returning to arsenal..."};
				disableUserInput true;
				sleep 0.2;
				[_arsenal, player, false] call ace_arsenal_fnc_openBox;
				disableUserInput false;
			} else {
				[getPlayerUID player, _cost] remoteExecCall ["ZE_fnc_moneyDeduct", 2];
				if(zDebug) then { systemChat format ["zDebug (handleEquip): $%1 deducted from profile, now $%2", _cost, zMoney - _cost] }; // Check for consistency
				if(zDebug) then { systemChat "zDebug (handleEquip): Transaction Completed" };
				["ace_arsenal_displayClosed", _handle] call CBA_fnc_removeEventHandler;
			};
		};
	};
};

_closeHandle = ["ace_arsenal_displayClosed", { [_thisId, _thisArgs#1, _thisArgs#2] spawn _thisArgs#0 }, [_fncClose, _box, _curEquips]] call CBA_fnc_addEventHandlerArgs;

[_box, player, false] call ace_arsenal_fnc_openBox;