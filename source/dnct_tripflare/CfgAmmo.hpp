class CfgAmmo
{
    class APERSTripMine_Wire_Ammo;

    class DNCT_Tripflare_Wire_Ammo : APERSTripMine_Wire_Ammo
    {
        hit = 1;
        indirectHit = 0;
        indirectHitRange = 0;
        minimumSafeZone = 0;
        defaultMagazine = "DNCT_Tripflare_Mine_Mag";
        explosionEffects = "";
        craterEffects = "";

        model = "\A3\Weapons_F\Explosives\Flare_tripwire.p3d";
        mineModelDisabled = "\A3\Weapons_F\Explosives\Flare_tripwire_d.p3d";

        soundHit[] = {};
        SoundSetExplosion[] = {};

        class EventHandlers
        {
            AmmoHit = "_this remoteExec ['dnct_fnc_tripflare']";
        };
    };
};