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
        craterEffects = "";

        soundHit[] =
        {
            "\A3\Sounds_F\arsenal\explosives\mines\Explosion_tripwire_landmine",
            3.1622777,
            1,
            1500
        };
        SoundSetExplosion[] =
        {
            "TrainingMine_Exp_SoundSet",
            "TrainingMine_Report_SoundSet"
        };

        class EventHandlers
        {
            AmmoHit = "_this remoteExec ['dnct_fnc_tripflare']";
        };
    };
};