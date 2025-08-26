if (!hasInterface) exitWith {};
if !(["feature_vehicleSpawner"] call PHK_fnc_isFeatureEnabled) exitWith {};

["Vehicle Spawner XEH_postInit executed"] call PHK_fnc_log;

[] call PHK_fnc_addAction;

player addEventHandler ["Respawn", {
	[] call PHK_fnc_addAction;
}];