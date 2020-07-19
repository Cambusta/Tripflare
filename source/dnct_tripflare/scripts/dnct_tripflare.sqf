params["", "_victim", "", "_tripwirePosASL", "", "", "_ammo", "", ""];

private _tripwirePosATL = ASLToATL _tripwirePosASL;

["DNCT_TripflareTriggered", _tripwirePosATL] call CBA_fnc_localEvent;

if (isServer) then
{
    private["_triggerSound", "_flarePos", "_flare"];

    _triggerSound = selectRandom [
        "A3\Sounds_F_Kart\Weapons\starting_pistol_1.wss",
        "A3\Sounds_F_Kart\Weapons\starting_pistol_2.wss",
        "A3\Sounds_F_Kart\Weapons\starting_pistol_3.wss"
    ];

    playSound3D [
        _triggerSound,
        objNull,
        false,
        _tripwirePosASL,
        3,
        1,
        300
    ];

    _flarePos = _tripwirePosATL getPos [10, random 360];
    _flarePos set [2, 125 + random (25)];   // Adjust flare height

    sleep 1;
    _flare = createVehicle ["F_20mm_Red", _flarePos, [], 0, "NONE"];
    _flare setVelocity [0,0,-0.01];
};
