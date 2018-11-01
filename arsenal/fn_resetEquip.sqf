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

	player addHeadgear _equip#0;
	player addGoggles _equip#1;
	{ player assignItem _x } forEach _equip#2;
	player addUniform _equip#3;
	{ player addItemToUniform _x } forEach _equip#4;
	player addVest _equip#5;
	{ player addItemToVest _x } forEach _equip#6;
	player addBackpack _equip#7;
	{ player addItemToBackpack _x } forEach _equip#8;
	{ player addWeapon _x } forEach [_equip#9, _equip#10, _equip#11, _equip#12];
	{ player addPrimaryWeaponItem _x } forEach _equip#13;
	{ player addSecondaryWeaponItem _x } forEach _equip#14;
	{ player addHandgunItem _x } forEach _equip#15;
	if(zDebug) then { systemChat "zDebug (resetEquip): Equipment restored" };
};