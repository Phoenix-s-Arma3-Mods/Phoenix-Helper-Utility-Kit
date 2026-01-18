params ["_heli"];
if (isNull _heli) exitWith { objNull };

private _pos = getPosATL _heli;

// Start simple: nearest “slingload-ish” objects within radius
private _candidates = nearestObjects [_pos, ["LandVehicle","Ship","ReammoBox_F","ThingX"], 25];
_candidates = _candidates select {
  _x != _heli &&
  {alive _x} &&
  // avoid hooking people
  {!(_x isKindOf "Man")}
};

// Choose closest
private _best = objNull;
private _bestD = 1e9;
{
  private _d = _x distance _heli;
  if (_d < _bestD) then { _best = _x; _bestD = _d; };
} forEach _candidates;

_best
