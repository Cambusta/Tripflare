class CfgMineTriggers
{
    class WireTrigger;

    class DNCT_Tripflare_Trigger : WireTrigger
    {
        mineTriggerType = "wire";
        mineTriggerRange = 3;
        mineWireStart[] = { -1.4, 0.1, 0};
        mineWireEnd[] = { 2.6, 0.1, 0};
        restrictZoneCenter[] = {0.1,0,0};
    };
};