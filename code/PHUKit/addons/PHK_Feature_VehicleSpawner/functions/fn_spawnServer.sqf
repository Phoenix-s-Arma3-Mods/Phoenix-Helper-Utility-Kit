if (!isServer) exitWith {};
params ["_terminal", "_spawnClass", "_pASL", "_uid"];

if !(["Feature_VehicleSpawner"] call PHK_fnc_isFeatureEnabled) exitWith {
	["Spawner disabled by server."] remoteExec ["hint", remoteExecutedOwner];
};

if (isNull _terminal) exitWith {};
if !(_terminal getVariable ["PHK_vehicleSpawner_isSpawner", false]) exitWith {};
if ((_terminal distance _pASL) > 5) exitWith {
	["Too far from terminal. Move Closer."] remoteExec ["hint", remoteExecutedOwner];
};

// allowed vehicle class (hard-coded helicopter for v1)
if !(_spawnClass in ["B_Heli_Transport_01_F"]) exitWith {
	["That vehicle is not allowed."] remoteExec ["hint", remoteExecutedOwner];
};

private _helipad = [_terminal] call PHK_fnc_findHelipad;
if (_helipad isEqualTo []) exitWith {
	["No spawn point (invisible helipad) found within 100m."] remoteExec ["hint", remoteExecutedOwner];
};

_helipad params ["_posATL", "_dir"];

private _near = nearestObjects [_posATL, ["Air", "LandVehicle","Ship"], 10];
if ((count _near) > 0) then {
	private _canClear = false;
	private _emptyVehicle = objNull;

	{
		if (_x isKindOf "Air" && {count crew _x == 0}) exitWith {
			_canClear = true; _emptyVehicle = _x;
		};
	} forEach _near;

	if {_canClear && {!isNull _emptyVehicle}} then {
		deleteVehicle _emptyVehicle;
	} else {
		["Cannot spawn: spawn area not clear."] remoteExec ["hint", remoteExecutedOwner];
		breakOut "PHK_VehicleSpawner_end";
	};
};

scopeName "PHK_VehicleSpawner_end";
private _newVehicle = createVehicle [_spawnClass, [0,0,0], [], 0, "CAN_COLLIDE"];
_newVehicle setDir _dir;
_newVehicle setPosATL _posATL;

["Vehicle Spawned at Nearest Spawn Location."] remoteExec ["hint", remoteExecutedOwner];