if (!hasInterface) exitWith {};
params ["_spawner"];

if (isNull _spawner) exitWith {};

["Adding vehicle spawner action to object: " + (typeOf _spawner)] call PHK_fnc_log; // temp DEBUG - DELETE ME before PROD

private _existing = _spawner getVariable ["PHK_vehicleSpawner_actionId", -1];
if (_existing >= 0) then {
	_spawner removeAction _existing;
};

// Add a test action that always shows up
_spawner addAction [
	"<t color='#FF0000'>TEST ACTION</t>",
	{ hint "Test action clicked! OBJECT: " + (typeOf (_this select 0)); },
	nil, 1, true, true, "",
	"true"
];

private _id = _spawner addAction [
	"<t color='#4CAF50'>Spawn Helicopter</t>",
	{ [_this select 0, _this select 1, _this select 2, _this select 3] call PHK_fnc_spawn; },
	nil, 6, true, true, "",
	"(['feature_vehicleSpawner'] call PHK_fnc_isFeatureEnabled)"
];

_spawner setVariable ["PHK_vehicleSpawner_actionId", _id, true];
_id
