class CfgWeapons
{
    class Default;
    class Put: Default
    {
        muzzles[] += 
        { 
            "DNCT_TripwireFlareMuzzle"
        };

        class PutMuzzle: Default {};
        class DNCT_TripwireFlareMuzzle: PutMuzzle
        {
            magazines[] =
            {
                "DNCT_TripwireFlare_Mine_Mag"
            };
        };
    };
};