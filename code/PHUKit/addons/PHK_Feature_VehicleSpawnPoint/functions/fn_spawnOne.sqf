params ["_point"];
if (isNull _point) exitWith {};
if (!isServer) exitWith {};

private _spawnCrewed = _point getVariable ["PHK_VSP_SpawnCrewed", false];

private _already = _point getVariable ["PHK_VSP_Spawned", false];
if (_already) exitWith {};

private _classname = _point getVariable ["PHK_VSP_Classname", ""];
_classname = trim _classname;
if (_classname isEqualTo "") exitWith {};

if (!isClass (configFile >> "CfgVehicles" >> _classname)) exitWith {
	diag_log format ["[PHK_VSP] Invalid classname '%1' at %2", _classname, getPosATL _point];
};

private _delay = _point getVariable ["PHK_VSP_Delay", 0];
_delay = _delay max 0;
private _deleteMarker = _point getVariable ["PHK_VSP_DeleteMarker", true];
private _align = _point getVariable ["PHK_VSP_AlignToSurface", false];

_point setVariable ["PHK_VSP_Spawned", true, true];

[_point, _classname, _delay, _deleteMarker, _align, _spawnCrewed] spawn {
	params ["_p", "_cls", "_dly", "_del", "_aln", "_spawnCrewed"];

	if (_dly > 0) then { uiSleep _dly; };
	if (isNull _p) exitWith {};

	private _posATL = getPosATL _p;
	private _dir = getDir _p;

	private _veh = createVehicle [_cls, _posATL, [], 0, "NONE"];
	_veh setDir _dir;
	_veh setPosATL _posATL;

	if (_aln) then {
		private _n = surfaceNormal (getPosASL _veh);
		_veh setVectorUp _n;
	};

	if (_spawnCrewed) then {
		createVehicleCrew _veh;

		{
			_x moveInAny _veh;
		} forEach (crew _veh);
	};


	_veh allowDamage false;
	uiSleep 0.1;
	_veh allowDamage true;

	_p setVariable ["PHK_VSP_Vehicle", _veh, true];

	if (_del) then {
		deleteVehicle _p;
	} else {
		_p hideObjectGlobal true;
		_p enableSimulationGlobal false;
	};

	diag_log format ["[PHK_VSP] Spawned %1 at %2", _cls, _posATL];
};
