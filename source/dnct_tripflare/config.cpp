class CfgPatches
{
    class DNCT_TripwireFlare
    {
        name = "Tripwire Flare";
        author = "Dunecat (aka Cambusta)";
        url = "https://github.com/Cambusta/Tripflare";
        version = "%VERSION%";
        requiredVersion = 0.1;
        requiredAddons[] = {
            "A3_Weapons_F",
            "A3_Weapons_F_Explosives",
            "CBA_MAIN"
        };
        units[] = {
            "DNCT_TripflareMine"
        };
    };
};

#include "CfgFunctions.hpp"
#include "CfgAmmo.hpp"
#include "CfgMagazines.hpp"
#include "CfgWeapons.hpp"
#include "CfgVehicles.hpp"
