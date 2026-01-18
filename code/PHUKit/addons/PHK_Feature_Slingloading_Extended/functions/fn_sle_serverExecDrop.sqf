params ["_heli"];
if (isNull _heli) exitWith {};
[_heli] remoteExecCall ["PHK_fnc_sle_localDrop", owner _heli];
