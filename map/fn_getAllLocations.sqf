_centerPoint = getArray(configFile >> "CfgWorlds" >> worldName >> "centerPosition");
_locations = nearestLocations [_centerPoint, ['NameVillage','NameCity','NameCityCapital'], 25000];
_locations;