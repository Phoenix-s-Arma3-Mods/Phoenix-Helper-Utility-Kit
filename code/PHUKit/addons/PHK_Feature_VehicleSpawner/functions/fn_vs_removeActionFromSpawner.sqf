if (!hasInterface) exitWith {};
params ["_spawner"];

if (isNull _spawner) exitWith {};

// ["Removing vehicle spawner action from object: " + (name _spawner)] call PHK_fnc_log; // DEBUG - delete me before PROD

private _existing = _spawner getVariable ["PHK_vehicleSpawner_actionId", -1];
if (_existing >= 0) then {
	_spawner removeAction _existing;
	_spawner setVariable ["PHK_vehicleSpawner_actionId", -1, true];
};
