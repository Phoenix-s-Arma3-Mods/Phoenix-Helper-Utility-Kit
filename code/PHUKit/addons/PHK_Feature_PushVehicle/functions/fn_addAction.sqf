/*
 * Client: add a context action that appears only when PHK_fnc_canPush is true.
 */
//OLD: if (!hasInterface) exitWith {};
if (!hasInterface) exitWith {-1};

private _p = player;
private _id = _p getVariable ["PHK_push_actionId", -1];
if (_id != -1) exitWith {}; // already added

_id = _p addAction [
  "Push Vehicle",
  { [_this select 1] call PHK_fnc_push; },   // caller -> PHK_fnc_push
  nil, 1.5, true, true, "",
  // show only when canPush
  "[_this] call PHK_fnc_canPush"
];

_p setVariable ["PHK_push_actionId", _id];
