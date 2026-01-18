/*
  PHK_fnc_sle_addActionsLocal
  - Adds Hook/Drop actions to the heli *locally* for this client.
*/
params ["_veh"];
if (isNull _veh) exitWith {};
if !(_veh isKindOf "Helicopter") exitWith {};
if !(missionNamespace getVariable ["PHK_SLE_enabled", true]) exitWith {};

if !([_veh] call PHK_fnc_sle_isWhitelistedHeli) exitWith {};

if (_veh getVariable ["PHK_SLE_actionsAdded", false]) exitWith {};
_veh setVariable ["PHK_SLE_actionsAdded", true];

_veh addAction [
  "<t color='#88FF88'>PHK SLE: Hook (Heavy)</t>",
  { params ["_target", "_caller"]; [_target] call PHK_fnc_sle_requestHook; },
  nil, 1.5, false, true, "",
  // condition: caller is in vehicle + is pilot if requirePilot
  "(missionNamespace getVariable ['PHK_SLE_enabled', true]) && (_this isEqualTo driver _target) && {alive _target} && {isNull (_target getVariable ['PHK_SLE_cargo', objNull])}"
];

_veh addAction [
  "<t color='#FF8888'>PHK SLE: Drop</t>",
  { params ["_target", "_caller"]; [_target] call PHK_fnc_sle_requestDrop; },
  nil, 1.5, false, true, "",
  "(missionNamespace getVariable ['PHK_SLE_enabled', true]) && (_this isEqualTo driver _target) && {alive _target} && {!isNull (_target getVariable ['PHK_SLE_cargo', objNull])}"
];
