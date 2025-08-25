if (!hasInterface) exitWith {-1};

private _existing = player getVariable ["PHK_vehicleSpawner_actionId", -1];
if (_existing >= 0) exitWith { _existing };

private _id = player addAction [
	"<t color='#4CAF50'>Spawn Helicopter</t>",
	{ [_this select 0, _this select 1, _this select 2, _this select 3] call PHK_fnc_spawn; },
	nil, 6, true, true, "",
	"(['Feature_VehicleSpawner'] call PHK_fnc_isFeatureEnabled) && {call PHK_fnc_canSpawn}"
];

player setVariable ["PHK_vehicleSpawner_actionId", _id, true];
_id