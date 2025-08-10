/*
 * [_unit] call PHK_fnc_canPush → bool
 * Rules: on foot, near a LandVehicle, vehicle slow, alive, within 3m, not swimming.
 */
params [["_unit", objNull, [objNull]]];

if (isNull _unit) exitWith {false};
if (vehicle _unit != _unit) exitWith {false};          // must be infantry
if !(alive _unit) exitWith {false};
if (surfaceIsWater (getPosATL _unit)) exitWith {false};

private _veh = cursorTarget;
if (isNull _veh) exitWith {false};
if !(_veh isKindOf "LandVehicle") exitWith {false};
if !alive _veh exitWith {false};

if ((_unit distance _veh) > 3) exitWith {false};
if ((speed _veh) > 2) exitWith {false};                 // don’t push moving vehicles

true
