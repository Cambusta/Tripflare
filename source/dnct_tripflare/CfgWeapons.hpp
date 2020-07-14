class CfgWeapons
{
    class Default;
    class Put: Default
    {
        muzzles[] +=
        {
            "DNCT_Tripflare_Muzzle"
        };

        class PutMuzzle: Default {};
        class DNCT_Tripflare_Muzzle: PutMuzzle
        {
            magazines[] =
            {
                "DNCT_Tripflare_Mine_Mag"
            };
        };
    };
};