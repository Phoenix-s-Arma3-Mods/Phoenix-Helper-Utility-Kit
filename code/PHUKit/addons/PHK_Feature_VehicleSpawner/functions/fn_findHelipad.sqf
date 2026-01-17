params ["_terminal"];

private _pads = nearestObjects [_terminal, ["Land_HelipadEmpty_F"], 100];
if (_pads isEqualTo []) exitWith { [] };

private _pad = _pads select 0;
[_pad, getPosATL _pad, getDir _pad]