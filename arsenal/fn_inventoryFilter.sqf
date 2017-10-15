params["_cur","_new"];

while { count _cur > 0 && count _new > 0 } do {
	{
		_index = _cur find _x;
		if(_index != -1) exitWith {
			_cur deleteAt _index;
			_new deleteAt _forEachIndex;
		};
	} forEach _new;
};
_new;