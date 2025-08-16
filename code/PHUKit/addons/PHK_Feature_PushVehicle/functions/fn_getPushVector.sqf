/*
 * [_unit, _veh] call PHK_fnc_getPushVector → displacement vector (ASL)
 * Pushes away from the unit in the unit's facing direction.
 */
params ["_unit", "_veh"];

private _dirRad = (getDir _unit) * (pi / 180);
private _fwd = [sin _dirRad, cos _dirRad, 0];

private _dist = missionNamespace getVariable ["PHK_pushVehicle_distance", 1.2];
_fwd vectorMultiply _dist
