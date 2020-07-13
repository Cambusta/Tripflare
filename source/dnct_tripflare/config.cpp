class CfgPatches
{
    class DNCT_TripwireFlare
    {
        name = "Tripwire Flare";
        author = "Dunecat (aka Cambusta)";
        url = "";
        version = "1.0";
        requiredVersion = 0.1;
        requiredAddons[] = {
            "A3_Weapons_F",
            "A3_Weapons_F_Explosives"
        };
        units[] = {
            "DNCT_TripwireFlare_Mine"
        };
    };
};

#include "CfgFunctions.hpp"
#include "CfgAmmo.hpp"
#include "CfgMagazines.hpp"
#include "CfgWeapons.hpp"
