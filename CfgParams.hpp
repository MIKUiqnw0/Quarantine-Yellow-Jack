class Params {
    class MoneyBonus {
        title = "Bonus amount of cash awarded on creation";
        values[] = {0, 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1500, 2000};
        default = 500;
    };

    class ResetProgress {
        title = "Reset Map Progression";
        values[] = {0, 1};
        texts[] = {"No", "Yes"};
        default = 1;
    }
    class ResetMoney {
        title = "Reset Money";
        values[] = {0, 1};
        texts[] = {"No", "Yes"};
        default = 1;
    };
    class ResetConfirm {
        title = "Reset Safety Switch - Set to 'Confirm' for it to take effect";
        values[] = {0, 1};
        texts[] = {"Unconfirmed", "Confirm"};
        default = 0;
        function = "ZE_fnc_progressReset";
    };
};