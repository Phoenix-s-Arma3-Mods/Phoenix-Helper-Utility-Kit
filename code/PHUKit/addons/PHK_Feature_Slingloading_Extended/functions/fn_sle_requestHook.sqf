params ["_heli"];
if (isNull _heli || {!alive _heli}) exitWith {};
if (!(missionNamespace getVariable ["PHK_SLE_enabled", true])) exitWith {};

if (driver _heli != player) exitWith {};

private _cargo = [_heli] call PHK_fnc_sle_findCargoCandidate;
if (isNull _cargo) exitWith { systemChat "[PHK SLE] No cargo candidate found."; };

[_heli, _cargo] remoteExecCall ["PHK_fnc_sle_serverValidateAndExecHook", 2];
