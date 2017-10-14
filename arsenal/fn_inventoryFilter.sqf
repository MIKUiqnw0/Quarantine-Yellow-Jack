params["_current","_new"];
systemChat format ["InventoryFilterStart cur:%1 - new:%2", _current, _new];
_finished = false;
while { !_finished } do {
	_finished = true;
	if(count _new != 0) then {
		{
			_index = _current find _x;
			if(_index != -1) exitWith {
				_finished = false;
				_current deleteAt _index;
				_new deleteAt _forEachIndex;
			};
			
			if(_x == "") then { // Handle case where something in the _new equipment has been removed
				_finished = false;
				_new deleteAt _forEachIndex;
			};
		} forEach _new;
	};
};
systemChat format ["InventoryFilterResult cur:%1 - new:%2", _current, _new];
_new;