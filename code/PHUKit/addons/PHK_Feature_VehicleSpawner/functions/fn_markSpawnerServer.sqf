if (!isServer) exitWith {};
params ["_obj"];
if (isNull _obj) exitWith {};

["Marking object as spawner: " + (typeOf _obj)] call PHK_fnc_log; // temp DEBUG: DELETE ME before PROD
_obj setVariable ["PHK_vehicleSpawner_isSpawner", true, true];

["Calling remoteExecCall to add action to: " + (typeOf _obj)] call PHK_fnc_log; // temp DEBUG; DELETE ME before PROD
[_obj] remoteExecCall ["PHK_fnc_addActionToSpawner", 0, true];