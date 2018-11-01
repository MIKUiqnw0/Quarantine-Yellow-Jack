_wep = "getNumber(_x >> 'scope') isEqualTo 2 && configName _x isKindOf ['Rifle', configFile >> 'CfgWeapons']" configClasses (configFile >> "CfgWeapons");
_patch = [];
magazinesCompat = [];
{
  _arr = [];
  _arr pushBack configName _x;
  _arr pushBack getText(_x >> "displayName");
  _arr pushBack getArray(_x >> "magazines");
  {
    magazinesCompat pushBackUnique _x;
  } forEach getArray(_x >> "magazines");
  _patch pushBack _arr;
} forEach _wep;
copyToClipboard str _patch;