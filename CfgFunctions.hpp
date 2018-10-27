class CfgFunctions {
	class ZE {
		class arsenal {
			file = "arsenal";
			class calcCosts {};
			class currentEquip {};
			class handleEquip {};
			class handleEquip2 {};
			class inventoryFilter {};
			class resetEquip {};
			class shopDialog {};
		};
		class initialization {
			file = "init";
			class initClient {};
			class initLocations {};
			class initServer {};
		};
		class map {
			file = "map";
			class getAllLocations { description = "Fetches position information for locations on the map" };
			class mapSetup { description = "Sets up zombie spawning zones for each map location"; };
		};
		class tasking {
			file = "tasking";
			class addVIPAction { description = "Adds the side switching functions to the lead units in the mission"; };
			class removeVIPAction { description = "Removes the side switching functions on lead units in the mission"; };
		};
		class server {
			file = "server";
			class moneyDrop { description = "Handles monetary gains from zombie kills"; };
			class moneyBalance { description = "Returns the players monetary balance, silent usage used to update the client's zMoney variable in certain situations"; };
			class moneyDeduct { description = "Decreases the players monetary balance, used in purchases"; };
			class setSide { description = "Once off function, manages the side selection process at the beginning of the mission"; };
			class zombieSpawnWilderness { description = "Manages the wild zombie spawn loop"; };
			class zombieDeletion { description = "Zombie deletion loop applied to each zombie spawned via the zombieSpawnWilderness function"; };
		};
	};
};