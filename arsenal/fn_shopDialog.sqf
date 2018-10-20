disableSerialization;

params["_cash", "_cost"];

createDialog "zShopDialog";

waitUntil { !isNull (uiNamespace getVariable "zShopDialog") };
_display = uiNamespace getVariable "zShopDialog";
(_display displayCtrl 1004) ctrlSetText format ["Total: $%1", str _cost];