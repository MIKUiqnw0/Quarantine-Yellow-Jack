class ZShopDialog {
    idd = 30000;                   // set to -1, if don't require a unique ID
    movingEnable = 0;           // the dialog can be moved with the mouse
    enableSimulation = 0;       // freeze the game
    controlsBackground[] = { }; // not necessary
    objects[] = { };            // not necessary
	onLoad = "uiNamespace setVariable ['zShopDialog', _this select 0]";
	onUnload = "uiNamespace setVariable ['zShopDialog', nil]";
	onKeyDown = "if(_this select 1 == 1) then { purchaseCancel = true; false }";
    class controls { 
		class zFrameConfirm: RscFrame {
			idc = 1800;
			x = 0.324687 * safezoneW + safezoneX;
			y = 0.291 * safezoneH + safezoneY;
			w = 0.134062 * safezoneW;
			h = 0.154 * safezoneH;
			colorBackground[] = {30,30,30,0.5};
		};
		class zLblConfirm: RscText {
			idc = 1000;
			text = "Confirm Purchase?";
			x = 0.355625 * safezoneW + safezoneX;
			y = 0.302 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class zBtnBuyConfirm: RscButton {
			idc = 1600;
			text = "Confirm";
			x = 0.371094 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.033 * safezoneH;
			action = "closeDialog 30000";
		};
		class zBtnBuyReject: RscButton	{
			idc = 1601;
			text = "Reject";
			x = 0.371094 * safezoneW + safezoneX;
			y = 0.39 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.033 * safezoneH;
			action = "purchaseCancel = true; closeDialog 30000"
		};
		class zFrameBuylist: RscFrame {
			idc = 1801;
			x = 0.463907 * safezoneW + safezoneX;
			y = 0.291 * safezoneH + safezoneY;
			w = 0.232031 * safezoneW;
			h = 0.44 * safezoneH;
			colorBackground[] = {30,30,30,0.5};
		};
		class zLblPurchaseList: RscText	{
			idc = 1001;
			text = "List of Purchases";
			x = 0.494844 * safezoneW + safezoneX;
			y = 0.302 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class zListPurchases: RscListbox {
			idc = 1500;
			x = 0.474219 * safezoneW + safezoneX;
			y = 0.357 * safezoneH + safezoneY;
			w = 0.108281 * safezoneW;
			h = 0.352 * safezoneH;
		};
		class zLblItem: RscText {
			idc = 1002;
			text = "zeLblItem";
			x = 0.592812 * safezoneW + safezoneX;
			y = 0.324 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class zLblPrice: RscText {
			idc = 1003;
			text = "zeLblPrice";
			x = 0.592812 * safezoneW + safezoneX;
			y = 0.368 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class zLblTotal: RscText {
			idc = 1004;
			text = "";
			x = 0.592812 * safezoneW + safezoneX;
			y = 0.665 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.044 * safezoneH;
		};
	};
};