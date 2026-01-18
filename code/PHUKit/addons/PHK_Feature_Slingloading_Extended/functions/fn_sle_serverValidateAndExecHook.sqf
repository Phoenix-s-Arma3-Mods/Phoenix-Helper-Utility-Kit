/*
  PHK_fnc_sle_serverValidateAndExecHook
  Runs on server.
*/
params ["_heli", "_cargo"];

if (isNull _heli || isNull _cargo) exitWith {};
if (!alive _heli || {!alive _cargo}) exitWith {};
if (!(missionNamespace getVariable ["PHK_SLE_enabled", true])) exitWith {};

// Prevent double-hook / races: reserve slot
if (_heli getVariable ["PHK_SLE_hookInProgress", false]) exitWith {};
_heli setVariable ["PHK_SLE_hookInProgress", true, true];

private _clearReserve = {
  params ["_h"];
  if (!isNull _h) then {
    _h setVariable ["PHK_SLE_hookInProgress", false, true];
  };
};

// Already carrying something?
if (!isNull (_heli getVariable ["PHK_SLE_cargo", objNull])) exitWith {
  [_heli] call _clearReserve;
};

if (_cargo isKindOf "Man") exitWith {
  [_heli] call _clearReserve;
};
if (!simulationEnabled _cargo) exitWith {
  [_heli] call _clearReserve;
};

private _maxKg   = missionNamespace getVariable ["PHK_SLE_maxLiftMassKg", 12000];
private _clamp   = missionNamespace getVariable ["PHK_SLE_clampMassEnabled", true];
private _ropeLen = missionNamespace getVariable ["PHK_SLE_ropeLength", 12];
private _ropeCnt = missionNamespace getVariable ["PHK_SLE_ropeCount", 4];

private _mass = getMass _cargo;

if (_mass > _maxKg) exitWith {
  [owner _heli, format ["[PHK SLE] Too heavy: %1kg (max %2kg).", round _mass, _maxKg]]
    remoteExecCall ["systemChat", owner _heli];
  [_heli] call _clearReserve;
};

// Execute rope ops where heli is local
private _owner = owner _heli;
[_heli, _cargo, _maxKg, _clamp, _ropeLen, _ropeCnt] remoteExecCall ["PHK_fnc_sle_localHook", _owner];

// Clear reservation after we dispatch the remote call
[_heli] call _clearReserve;
