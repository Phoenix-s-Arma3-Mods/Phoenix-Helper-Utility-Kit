// fn_zeusCreateNewSpawnLocation.sqf  (REPLACE)
if (!isServer) exitWith {};
params ["_logic", "_position", "_activated", "_isCuratorPlaced"];

// Resolve an ATL position robustly
private _atl =
  if (_position isEqualType [] && {(count _position) >= 2}) then {
    // If curator passed an ASL-like vector including Z, convert to ATL; otherwise assume ATL XY and ground Z
    if ((count _position) >= 3) then { ASLToATL _position } else { [_position select 0, _position select 1, 0] }
  } else {
    getPosATL _logic
  };

// Create at origin, then place with ATL to be explicit and deterministic
private _pad = createVehicle ["Land_HelipadEmpty_F", [0,0,0], [], 0, "CAN_COLLIDE"];
_pad setPosATL _atl;
// Optional (recommended): align to ground normal to avoid tiny hover on slopes
_pad setVectorUp (surfaceNormal _atl);

_pad setVariable ["PHK_vehicleSpawner_isSpawnPoint", true, true];
