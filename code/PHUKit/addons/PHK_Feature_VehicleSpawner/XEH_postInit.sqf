if (!hasInterface) exitWith {};
["[PHK VehicleSpawner] postInit start"] call PHK_fnc_log;

private _id = [] call PHK_fnc_addAction;
["[PHK SpawnVehicle] addAction id %1", _id] call PHK_fnc_log;