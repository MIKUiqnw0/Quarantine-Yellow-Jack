if(isDedicated) exitWith { false };
params["_target"];

_id = _target getVariable ["VIP_actionID", -1];

if(_id >= 0) then {
	_target removeAction _id;
};