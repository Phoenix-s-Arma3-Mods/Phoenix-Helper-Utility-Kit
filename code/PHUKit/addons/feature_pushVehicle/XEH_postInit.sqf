if (!hasInterface) exitWith {};
if !(["feature_pushVehicle"] call PHK_fnc_isFeatureEnabled) exitWith {};

[] call PHK_fnc_addAction;  // adds the scroll-wheel action on clients
