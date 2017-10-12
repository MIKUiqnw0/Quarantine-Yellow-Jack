/*
	List of indentifiers
	-------------------------------
	Weapons
	-------------------------------
	arifle_		Assault Rifle
	srifle_		Sniper Rifle
	LMG_		Light Machine Gun
	MMG_		Medium Machine Gun
	SMG_		Submachine Gun
	hgun_		Handgun
	launch_		Rocket Launcher
	-------------------------------
	Magazine
	-------------------------------
	*By Rounds
	100,10,11,130,150,16,1,200,20,30,3,5,6,7,9 - (n)Rnd_
	100,10,200,20,30,5,7 - ACE_(n)Rnd_
	-------------------------------
	Backpacks
	-------------------------------
	B_
	-------------------------------
	Items
	-------------------------------
	H_ 			headgear
	-------------------------------
*/

params["_purchase", "_type", "_isArray"];

if(!_isArray) then {
	switch(_type) do {
		case "headgear": {
			_result = _purchase find "H_Helmet";
			
		};
	};
} else {
	
};