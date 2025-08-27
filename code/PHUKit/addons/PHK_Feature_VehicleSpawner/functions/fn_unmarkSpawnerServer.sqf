if (!isServer) exitWith {};
params ["_obj"];
if (isNull _obj) exitWith {};

// ["Unmarking object as spawner: " + (name _obj)] call PHK_fnc_log; // DEBUG - delete me before prod
_obj setVariable ["PHK_vehicleSpawner_isSpawner", false, true];

[_obj] remoteExecCall ["PHK_fnc_removeActionFromSpawner", 0, true];