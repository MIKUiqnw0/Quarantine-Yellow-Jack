class CfgRemoteExec
{
        class Commands
        {
                mode = 1;
	        class systemChat {};
                class hint {};                         //jip is not allowed for this command
                //class setFuel {allowedTargets = 2;};           //execute only on server
        };
        class Functions
        {
                //mode = 0;
                //jip = 0;                                       //no functions can use jip

                //class BIS_fnc_setRank {allowedTargets = 1;};   //execute only on clients, server execution denied
        };
};