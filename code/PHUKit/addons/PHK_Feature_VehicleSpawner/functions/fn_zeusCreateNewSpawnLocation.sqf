if (!isServer) exitWith {};
params ["_logic", "_position", "_activated", "_isCuratorPlaced"];

if ((typeName _position) != "ARRAY" || {count _position < 2}) then {
	_position = getPosASL _logic;
};

if ((count _position) < 3) then {
	_position pushBack 0;
};

private _newSpawnLocation = createVehicle ["Land_HelipadEmpty_F", _position, [], 0, "CAN_COLLIDE"];
_newSpawnLocation setVariable ["PHK_vehicleSpawner_isSpawnPoint", true, true];