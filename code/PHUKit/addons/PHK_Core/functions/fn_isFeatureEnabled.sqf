/*
 * ["feature_key"] call PHK_fnc_isFeatureEnabled
 * Returns true/false based on the CBA server toggle.
 * Map your feature keys to their CBA setting names here.
 */
params [["_feature","",[""]]];

//private _map = createHashMapFromArray [
  // ["feature_earplugs","PHK_enable_feature_earplugs"]
//];
private _map = createHashMapFromArray [
  ["feature_pushVehicle","PHK_enable_feature_pushVehicle"],
  ["feature_vehicleSpawner","PHK_enable_feature_vehicleSpawner"]
];


private _var = _map getOrDefault [_feature, ""];
if (_var isEqualTo "") exitWith {true}; // unknown → treat as enabled
missionNamespace getVariable [_var, true]
