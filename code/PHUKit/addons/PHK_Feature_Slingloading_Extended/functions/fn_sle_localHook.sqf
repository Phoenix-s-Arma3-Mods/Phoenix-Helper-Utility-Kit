/*
  PHK_fnc_sle_localHook
  Must run where _heli is local.
*/
params ["_heli", "_cargo", "_maxKg", "_clamp", "_ropeLen", "_ropeCnt"];
if (isNull _heli || isNull _cargo) exitWith {};
if (!local _heli) exitWith {};
if (!(missionNamespace getVariable ["PHK_SLE_enabled", true])) exitWith {};

if (!alive _heli || {!alive _cargo}) exitWith {};
if (!isNull (_heli getVariable ["PHK_SLE_cargo", objNull])) exitWith {};
if (_cargo isKindOf "Man") exitWith {};
if (!simulationEnabled _cargo) exitWith {};

// If already rope-attached somehow, refuse (prevents weirdness)
if ((ropes _cargo) isNotEqualTo []) exitWith {
  systemChat "[PHK SLE] Cargo already has ropes attached.";
};

if (isNil { _cargo getVariable "PHK_SLE_origMass" }) then {
  _cargo setVariable ["PHK_SLE_origMass", getMass _cargo, true];
};

private _origMass = _cargo getVariable ["PHK_SLE_origMass", getMass _cargo];
private _didClamp = false;

if (_clamp) then {
  private _newMass = _origMass min _maxKg;
  if (_newMass < _origMass) then {
    _cargo setMass _newMass;
    _didClamp = true;
  };
};
_cargo setVariable ["PHK_SLE_didClamp", _didClamp, true];

// Spread points slightly so multiple ropes stabilize better
private _heliPoints = [
  [ 0.20,  0.20, -2.2],
  [-0.20,  0.20, -2.2],
  [ 0.20, -0.20, -2.2],
  [-0.20, -0.20, -2.2]
];
private _cargoPoints = [
  [ 0.25,  0.25, 0.6],
  [-0.25,  0.25, 0.6],
  [ 0.25, -0.25, 0.6],
  [-0.25, -0.25, 0.6]
];

private _ropes = [];
_ropeCnt = (_ropeCnt max 1) min 4;

for "_i" from 0 to (_ropeCnt - 1) do {
  private _r = ropeCreate [
    _heli, (_heliPoints select _i),
    _cargo, (_cargoPoints select _i),
    _ropeLen
  ];
  _ropes pushBack _r;
};

_heli setVariable ["PHK_SLE_cargo", _cargo, true];
_heli setVariable ["PHK_SLE_ropes", _ropes, true];

// Local auto-cleanup: if heli dies or cargo dies, drop
// (these EHs are local to this machine, which is OK because this machine owns heli now)
if !(_heli getVariable ["PHK_SLE_ehAdded", false]) then {
  _heli setVariable ["PHK_SLE_ehAdded", true];

  _heli addEventHandler ["Killed", {
    params ["_veh"];
    [_veh] call PHK_fnc_sle_localDrop;
  }];

  _heli addEventHandler ["Deleted", {
    params ["_veh"];
    [_veh] call PHK_fnc_sle_localDrop;
  }];

  // When heli locality changes (pilot swaps), the new owner can re-drop safely;
  // the old owner should clean up its local ropes.
  _heli addEventHandler ["Local", {
    params ["_veh", "_isLocal"];
    if (!_isLocal) then {
      [_veh] call PHK_fnc_sle_localDrop;
    };
  }];
};

systemChat format ["[PHK SLE] Hooked (orig %1kg, clamp %2kg).", round _origMass, round (getMass _cargo)];