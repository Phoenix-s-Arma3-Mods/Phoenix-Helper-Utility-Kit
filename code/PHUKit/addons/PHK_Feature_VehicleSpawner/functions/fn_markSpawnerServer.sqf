if (!isServer) exitWith {};
params ["_obj"];
if (isNull _obj) exitWith {};
_obj setVariable ["PHK_vehicleSpawner_isSpawner", true, true];