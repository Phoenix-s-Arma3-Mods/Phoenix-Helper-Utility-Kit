/*
 * Server-authoritative nudge. Preserves orientation.
 * Extra sanity checks to prevent abuse.
 */
if (!isServer) exitWith {};
params ["_veh","_vec","_pASL","_uid"];

if (isNull _veh || {!alive _veh}) exitWith {};
if !(_veh isKindOf "LandVehicle") exitWith {};
if ((speed _veh) > 2) exitWith {};

private _posVehASL = getPosASL _veh;

// Require a nearby player origin to prevent long-range trolling
if ((_posVehASL distance _pASL) > 5) exitWith {};

private _newPos = _posVehASL vectorAdd _vec;
private _dir = getDir _veh;

_veh setPosASL _newPos;
_veh setDir _dir;
