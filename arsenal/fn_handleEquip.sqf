if(isDedicated) exitWith { false };

if(zeDebug) then { systemChat "zeDebug (handleEquip): Reading current equipment" };
_curEquips = call ZE_fnc_currentEquip;

["Open", false] call BIS_fnc_arsenal;

if(zeDebug) then { systemChat "zeDebug (handleEquip): Waiting for arsenal display..."; };
waitUntil { !isNull (uiNameSpace getVariable "RSCDisplayArsenal") };
if(zeDebug) then { systemChat "zeDebug (handleEquip): Waiting for arsenal exit..."; };
waitUntil { isNull (uiNameSpace getVariable "RSCDisplayArsenal") };

if(zeDebug) then { systemChat "zeDebug (handleEquip): Arsenal exited, now evaluating gear cost" };
_newEquips = call ZE_fnc_currentEquip;
_struct = true call ZE_fnc_currentEquip;

_cost = 0;
for [{private _i = 0}, {_i < count _struct}, {_i = _i + 1}] do {
	private _curSelect = _curEquips select _i;
	private _newSelect = _newEquips select _i;
	private _equipType = _struct select _i;
	
	if(typeName _equipType == "ARRAY") then {
		_filtered = [_curSelect, _newSelect] call ZE_fnc_inventoryFilter;
		systemChat format ["Filter of %1:%2", _equipType select 0, str _filtered];
		if(count _filtered != 0) then {
			_cost = _cost + ([_filtered, _equipType, true] call ZE_fnc_calcCosts);
		}
	} else {
		if(_curSelect != _newSelect && _newSelect != "") then {
			_cost = _cost + ([_newSelect, _equipType, false] call ZE_fnc_calcCosts);
		};
	};
};

if(zeDebug) then { systemChat format ["zeDebug (handleEquip): Final cost for new equipment is $%1", _cost] };
if(zeDebug) then { systemChat "zeDebug (handleEquip): Restoring old equipment. TODO: Failed / cancelled purchase"};
//[_curEquips] call ZE_fnc_resetEquip;