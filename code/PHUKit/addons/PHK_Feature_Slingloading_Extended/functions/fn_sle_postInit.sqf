/*
  PHK_fnc_sle_postInit
  - Adds actions locally on each client when they enter a heli.
*/
diag_log "[PHK SLE] sle_postInit running";
systemChat "[PHK SLE] sle_postInit running";

if (!hasInterface) exitWith {};
if !(missionNamespace getVariable ["PHK_SLE_enabled", true]) exitWith {};

[] spawn {
  waitUntil { !isNull player };

  // Add actions whenever player gets into a vehicle seat
  player addEventHandler ["GetInMan", {
    params ["_unit", "_role", "_vehicle", "_turret"];
    [_vehicle] call PHK_fnc_sle_addActionsLocal;
  }];

  // Also handle current vehicle on JIP / respawn cases
  if (!isNull objectParent player) then {
    [objectParent player] call PHK_fnc_sle_addActionsLocal;
  };
};
