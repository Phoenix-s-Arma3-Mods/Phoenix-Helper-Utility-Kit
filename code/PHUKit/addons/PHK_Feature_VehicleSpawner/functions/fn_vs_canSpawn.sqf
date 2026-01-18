

private _terminal = _thisArgs param [0, objNull];
if (isNull _terminal) exitWith {false};
if !(_terminal getVariable ["PHK_vehicleSpawner_isSpawner", false]) exitWith {false};

if ((player distance2D _terminal) > 10) exitWith {false};
true