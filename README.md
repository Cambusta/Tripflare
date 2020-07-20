# Tripflare
Adds Tripwire Flare Mine that deals no damage but creates a flare when mine is triggered.

## Required mods
* CBA_A3

## Item name
* Flare Tripwire Mine

## Classnames
* Mine inventory item - `DNCT_Tripflare_Mine_Mag`
* Mine object - `DNCT_TripflareMine`

## Triggered Event (CBA)
> ℹ See [Custom Events System](https://github.com/CBATeam/CBA_A3/wiki/Custom-Events-System) for more details on CBA events.

`DNCT_TripflareTriggered` event is raised globally when mine is triggered and location of the mine (positionATL) is passed as event parameter.

You can subscribe to this event in your mission using `["DNCT_TripflareTriggered", { _minePos = _this; /* Your code */ }] call CBA_fnc_addEventHandler;`.

## Acknowledgements
* [AveryTheKitty](https://steamcommunity.com/id/averythekitty) - big thanks for pointing out that there is a vanilla tripflare model.
* RHS - for the idea on how to circumvent locality of explosion effects on dedicated server.
* BIS - for Arma and the tripwire flare model.