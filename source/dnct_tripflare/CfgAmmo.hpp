class CfgAmmo
{
    class APERSTripMine_Wire_Ammo;

    class DNCT_TripwireFlare_Mine_Ammo : APERSTripMine_Wire_Ammo
    {
        hit = 1;
        indirectHit = 0;
        indirectHitRange = 0;
        minimumSafeZone = 0;
        defaultMagazine = "DNCT_TripwireFlare_Mine_Mag";

        class EventHandlers
        {
            AmmoHit = "_this remoteExec ['dnct_fnc_tripflare']";
        };
    };
};