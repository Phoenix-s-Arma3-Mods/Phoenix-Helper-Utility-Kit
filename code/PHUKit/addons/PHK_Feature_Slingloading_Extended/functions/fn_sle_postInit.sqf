/*
  PHK_fnc_sle_postInit
  - Adds actions locally on each client when they enter a heli.
*/
if (!hasInterface) exitWith {};

[] spawn {
  waitUntil { !isNull player };

  diag_log "[PHK SLE] sle_postInit running";
  systemChat "[PHK SLE] sle_postInit running";

  if !(missionNamespace getVariable ["PHK_SLE_enabled", true]) exitWith {};

  player addEventHandler ["GetInMan", {
    params ["_unit", "_role", "_vehicle", "_turret"];

    // If disabled mid-session, do nothing
    if !(missionNamespace getVariable ["PHK_SLE_enabled", true]) exitWith {};

    [_vehicle] call PHK_fnc_sle_addActionsLocal;
  }];

  // Handle already-in-vehicle (JIP / respawn / mission start)
  private _veh = objectParent player;
  if (!isNull _veh) then {
    [_veh] call PHK_fnc_sle_addActionsLocal;
  };
};
