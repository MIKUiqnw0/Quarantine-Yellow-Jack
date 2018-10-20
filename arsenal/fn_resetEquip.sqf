_struct = true call ZE_fnc_currentEquip;
params["_equip"];

if(count _equip == count _struct) then { 
	removeHeadgear player;
	removeGoggles player;
	removeAllAssignedItems player;
	removeUniform player;
	removeVest player;
	removeBackpack player;
	removeAllWeapons player;
	
	player addHeadgear (_equip select 0); 
	player addGoggles (_equip select 1); 
	{ player assignItem _x } forEach (_equip select 2);
	player addUniform (_equip select 3);
	{ player addItemToUniform _x } forEach (_equip select 4);
	player addVest (_equip select 5);
	{ player addItemToVest _x } forEach (_equip select 6);
	player addBackpack (_equip select 7);
	{ player addItemToBackpack _x } forEach (_equip select 8);
	{ player addWeapon _x } forEach (_equip select 9);
	{ player addPrimaryWeaponItem _x } forEach (_equip select 10);
	{ player addSecondaryWeaponItem _x } forEach (_equip select 11);
	{ player addHandgunItem _x } forEach (_equip select 12);
	if(zDebug) then { systemChat "zDebug (resetEquip): Equipment restored" };
};