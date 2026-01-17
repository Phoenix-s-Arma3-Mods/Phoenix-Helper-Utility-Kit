params ["_target", "_caller", "_actionId", "_args"];

if !(["feature_vehicleSpawner"] call PHK_fnc_isFeatureEnabled) exitWith { hint "Vehicle Spawner disabled by server."; };

private _terminal = _target;
if (isNull _terminal) exitWith {};
if !(_terminal getVariable ["PHK_vehicleSpawner_isSpawner", false]) exitWith {};

// private _pASL = getPosASL player;
private _pATL = getPosATL player;
private _uid = getPlayerUID player;
private _spawnClass = "B_Heli_Transport_01_F";

[_terminal, _spawnClass, _pATL, _uid] remoteExecCall ["PHK_fnc_spawnServer", 2];