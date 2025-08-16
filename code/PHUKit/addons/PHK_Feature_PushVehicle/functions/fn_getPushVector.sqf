/*
 * [_unit, _veh] call PHK_fnc_getPushVector → displacement vector (ASL)
 * Pushes away from the unit in the unit's facing direction.
 */
params ["_unit", "_veh"];

private _fwd = vectorDirVisual _unit;
_fwd set [2, 0];
private _dist = missionNamespace getVariable ["PHK_pushVehicle_distance", 1.2];
private _pushVector = (vectorNormalized _fwd) vectorMultiply _dist;

_pushVector