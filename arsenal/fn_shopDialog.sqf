disableSerialization;

params["_cash", "_cost"];

createDialog "zeShopDialog";

waitUntil { !isNull (uiNamespace getVariable "zeShopDialog") };
_display = uiNamespace getVariable "zeShopDialog";
(_display displayCtrl 1004) ctrlSetText format ["Total: $%1", str _cost];