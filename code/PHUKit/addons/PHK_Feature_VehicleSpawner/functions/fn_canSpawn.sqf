if (vehicle player != player) exitWith {false};

private _terminal = cursorTarget;
if (isNull _terminal) exitWith {false};
if !(_terminal getVariable ["PHK_vehicleSpawner_isSpawner", false]) exitWith {false};

(player distance _terminal) < 3