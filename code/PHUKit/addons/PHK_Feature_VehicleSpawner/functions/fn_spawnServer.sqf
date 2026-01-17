if (!isServer) exitWith {};
params ["_terminal", "_spawnClass", "_pATL", "_uid"];

if !(["feature_vehicleSpawner"] call PHK_fnc_isFeatureEnabled) exitWith {
	["Spawner disabled by server."] remoteExec ["hint", remoteExecutedOwner];
};

if (isNull _terminal) exitWith {};
if !(_terminal getVariable ["PHK_vehicleSpawner_isSpawner", false]) exitWith {};
// my preference is distance <= 5 to action, but position issues necessitates higher server distance check... menu distance in fn_canSpawn is lower to compensate.
if ((_terminal distance2D _pATL) > 10) exitWith { 
	["Too far from terminal. Move Closer."] remoteExec ["hint", remoteExecutedOwner];
};

// allowed vehicle class (hard-coded helicopter for v1)
if !(_spawnClass in ["B_Heli_Transport_01_F"]) exitWith {
	["That vehicle is not allowed."] remoteExec ["hint", remoteExecutedOwner];
};

private _helipadInfo = [_terminal] call PHK_fnc_findHelipad;
if (_helipadInfo isEqualTo []) exitWith {
	["No spawn point (invisible helipad) found within 100m."] remoteExec ["hint", remoteExecutedOwner];
};

_helipadInfo params ["_helipad","_posATL", "_dir"];

// pad Mutex
if (_helipad getVariable ["PHK_vehicleSpawner_lock", false]) exitWith {
	["Spawner busy, Try again in a second."] remoteExec ["hint", remoteExecutedOwner];
};
_helipad setVariable ["PHK_vehicleSpawner_lock", true, true];

private _unlock = {
	_helipad setVariable ["PHK_vehicleSpawner_lock", false, true];
};

private _near = nearestObjects [_posATL, ["AllVehicles","Wreck_Base_F","Ruins_F","Thing","ThingX"], 10];
_near = _near select { _x != _helipad && _x != _terminal };

{
	if (_x isKindOf "AllVehicles") then {
		// never touch humans
		if (_x isKindOf "Man") then {
			// skip
		} else {
			if (alive _x) then {
				// only clear alive vehicles if they're AIR and empty
				if (_x isKindOf "Air" && { (count crew _x) isEqualTo 0 }) then {
					deleteVehicle _x;
					waitUntil { sleep 0.05; isNull _x };
				};
			} else {
				// destroyed vehicle of ANY kind counts as wreck -> clear it
				deleteVehicle _x;
				waitUntil { sleep 0.05; isNull _x };
			};
		};
	} else {
		// non-vehicle junk: clear ALL wrecks/debris props
		if (
			_x isKindOf "Wreck_Base_F"
			|| _x isKindOf "Ruins_F"
			|| _x isKindOf "Thing"
			|| _x isKindOf "ThingX"
		) then {
			deleteVehicle _x;
		};
	};
} forEach _near;

sleep 0.05;

private _radius = 10;
private _remaining = nearestObjects [_posATL, ["Air", "LandVehicle","Ship"], _radius];
if ((count _remaining) > 0) exitWith {
	["Cannot spawn: spawn area not clear."] remoteExec ["hint", remoteExecutedOwner];
	call _unlock;
};

private _newVehicle = createVehicle [_spawnClass, [0,0,0], [], 0, "CAN_COLLIDE"];
_newVehicle allowDamage false;
_newVehicle enableSimulationGlobal false;

_newVehicle setDir _dir;
_newVehicle setPosATL _posATL;
_newVehicle setVectorUp [0,0,1];
_newVehicle setVelocity [0,0,0];

enableCamShake false;
uiSleep 0.1;

_newVehicle enableSimulationGlobal true;
uiSleep 0.1;
_newVehicle allowDamage true;

["Vehicle Spawned at Nearest Spawn Location."] remoteExec ["hint", remoteExecutedOwner];

call _unlock;