
if (!isServer) exitWith {};

[] spawn {

	uiSleep 0.5;

	private _points = allMissionObjects "PHK_VehicleSpawnPoint";

	{
		[_x] call PHK_fnc_spawnOne;
	} forEach _points;
};
