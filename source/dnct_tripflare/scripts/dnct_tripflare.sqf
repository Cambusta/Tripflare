params["", "_victim", "", "_tripflarePosASL", "", "", "_ammo", "", ""];

private _tripwirePosATL = ASLToATL _tripflarePosASL;

["DNCT_TripflareTriggered", _tripwirePosATL] call CBA_fnc_localEvent;

if (isServer) then
{
    _flarePos = _tripwirePosATL getPos [10, random 360];

    // Adjust flare height
    _flarePos set [2, 125 + random (25)];
    _flare = createVehicle ["F_20mm_Red", _flarePos, [], 0, "NONE"];
    _flare setVelocity [0,0,-0.01];
};
