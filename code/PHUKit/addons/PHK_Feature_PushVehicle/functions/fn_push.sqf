/*
 * Client request → server action.
 * Called from addAction. Validates again client-side.
 */
params [["_unit", objNull, [objNull]]];
if (isNull _unit) exitWith {};
if !(["Feature_PushVehicle"] call PHK_fnc_isFeatureEnabled) exitWith { hint "Push disabled by server."; };

if !([_unit] call PHK_fnc_canPush) exitWith {};

private _veh = cursorTarget;
private _vec = [_unit, _veh] call PHK_fnc_getPushVector;

// Ask server to move it
[_veh, _vec, getPosASL _unit, getPlayerUID _unit] remoteExecCall ["PHK_fnc_pushServer", 2];
