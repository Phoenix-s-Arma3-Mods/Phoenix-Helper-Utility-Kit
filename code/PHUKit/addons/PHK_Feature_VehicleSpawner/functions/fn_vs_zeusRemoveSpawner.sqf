params ["_logic", "_units", "_activated"];
if (!_activated) exitWith {};

private _targets = synchronizedObjects _logic;
if (_targets isEqualTo []) then {
	_targets = nearestObjects [getPosATL _logic, ["All"], 5];
	_targets = _targets select { !(_x isKindOf "Logic") };
};

{
	[_x] remoteExecCall ["PHK_fnc_unmarkSpawnerServer", 2];
} forEach _targets;

deleteVehicle _logic;