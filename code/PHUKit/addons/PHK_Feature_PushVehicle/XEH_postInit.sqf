if (!hasInterface) exitWith {};
["[PHK PushVehicle] postInit start"] call PHK_fnc_log;

if !(["feature_pushVehicle"] call PHK_fnc_isFeatureEnabled) exitWith {
  ["[PHK Push] disabled via settings"] call PHK_fnc_log;
};

private _id = [] call PHK_fnc_addAction;
["[PHK PushVehicle] addAction id %1", _id] call PHK_fnc_log;
