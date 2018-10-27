if(isDedicated) exitWith { false };
params["_target", "_indexSide"];

_actionTitle = ["Join Chernarus National Guard / PMC", "Join Russia", "Join NATO"] select _indexSide;
_side = [independent, east, west] select _indexSide;
_id = _target addAction [_actionTitle, { [_this#0, _this#3#0] remoteExec ["ZE_fnc_setSide", 2] }, [_side], 1, true, true, "", "_this distanceSqr _target <= (5^2)", 5];

_target setVariable["VIP_actionID", _id];