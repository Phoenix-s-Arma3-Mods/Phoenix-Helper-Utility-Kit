if (!isServer) exitWith {};
params ["_logic", "_position", "_activated", "_isCuratorPlaced"];

private _newSpawnLocation = createVehicle ["Land_HelipadEmpty_F", _position, [], 0, "CAN_COLLIDE"];
_newSpawnLocation setVariable ["PHK_vehicleSpawner_isSpawnPoint", true, true];