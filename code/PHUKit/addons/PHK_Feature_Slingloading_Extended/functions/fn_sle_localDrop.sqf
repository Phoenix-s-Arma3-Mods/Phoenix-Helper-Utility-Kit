/*
  PHK_fnc_sle_localDrop
  Must run where _heli is local.
*/
params ["_heli"];
if (isNull _heli) exitWith {};
if (!local _heli) exitWith {};

private _cargo = _heli getVariable ["PHK_SLE_cargo", objNull];

// Destroy ropes we tracked
private _ropes = _heli getVariable ["PHK_SLE_ropes", []];
{
  if (!isNil "_x") then { ropeDestroy _x; };
} forEach _ropes;

// Extra safety: if ropes exist but list is empty (desync / locality weirdness), destroy any ropes on cargo
if (!isNull _cargo) then {
  { ropeDestroy _x; } forEach (ropes _cargo);
};

// Reset state
_heli setVariable ["PHK_SLE_cargo", objNull, true];
_heli setVariable ["PHK_SLE_ropes", [], true];
_heli setVariable ["PHK_SLE_hookInProgress", false, true];

// Restore cargo mass only if we actually clamped it
if (!isNull _cargo) then {
  private _didClamp = _cargo getVariable ["PHK_SLE_didClamp", false];
  if (_didClamp) then {
    private _orig = _cargo getVariable ["PHK_SLE_origMass", -1];
    if (_orig > 0) then { _cargo setMass _orig; };
  };
  _cargo setVariable ["PHK_SLE_didClamp", nil, true];
  _cargo setVariable ["PHK_SLE_origMass", nil, true];
};

if (hasInterface && {player isEqualTo driver _heli}) then {
  systemChat "[PHK SLE] Dropped / restored mass.";
};