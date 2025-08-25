params ["_terminal"];

private _pads = nearestObjects [_terminal, ["Land_HelipadEmpty_F"], 100];
if ((count _pads) == 0) exitWith { [] };

private _pad = _pads select 0;
[getPosATL _pad, getDir _pad]