// Register CBA settings category + any global toggles.
// Server owners can enable/disable features via Addon Options.

// // // reminder of API structure for future additions // // //
// [
//   "varName",
//   "TYPE",
//   ["Title","Tooltip"],
//   <STRING|ARRAY category>, <valueInfo>, <isGlobal?>, // e.g.: [category, subcategory], defaultValue, (0,1,2 - globalSetting)
//   <onChanged CODE?>,
//   <needRestart?>
// ]
// // // // // // // // // // // // // // // // // // // // //

if (isNil "CBA_fnc_addSetting") exitWith {}; // CBA safeguard

private _baseCat = "PHUKit - Phoenix's Helper and Utilities Kit";

// ----- PHK_Feature_PushVehicle -----
[
  "PHK_enable_feature_pushVehicle",
  "CHECKBOX",
  ["Enable: Push Vehicle","Allow infantry to nudge stuck vehicles."],
  [_baseCat, "Push Vehicle Module"],
  true,
  2,
  {},
  false
] call CBA_fnc_addSetting;

[
  "PHK_pushVehicle_distance",
  "SLIDER",
  ["Push Vehicle: Distance","How far a nudge moves the vehicle."],
  [_baseCat, "Push Vehicle Module"], 
  [0.2, 5, 1.2, 2], 
  2,
  {},
  false
] call CBA_fnc_addSetting;
// ----- End of PHK_Feature_PushVehicle -----

// ----- Start of PHK_Feature_VehicleSpawner -----
[
  "PHK_enable_feature_vehicleSpawner",
  "CHECKBOX",
  ["Enable: Vehicle Spawner", "Allow use of Vehicle Spawner terminals."],
  [_baseCat, "Vehicle Spawner Module"],
  true,
  2,
  {},
  false
] call CBA_fnc_addSetting;

// [
//   "PHK_vehicleSpawner_allowCustomClasses",
//   "CHECKBOX",
//   ["Enable: Custom Vehicle Classes", "Allow use of Custom mods/classes at Vehicle Spawner terminals."],
//   [_baseCat, "Vehicle Spawner Module"],
//   true,
//   2,
//   {},
//   false
// ] call CBA_fnc_addSetting;

// [
//   "PHK_vehicleSpawner_customClasses",
//   "EDITBOX",
//   ["Custom Vehicle Classes Allowed:", "Input/Remove Custom Vehicle Classes allowable"],
//   [_baseCat, "Vehicle Spawner Module"],
//   "",
//   2,
//   {},
//   false
// ] call CBA_fnc_addSetting;

// [
//   "PHK_vehicleSpawner_forceSideOnly",
//   "CHECKBOX",
//   ["Enable: Force Side-Only Vehicle Spawns", "Restrict spawnable vehicles to only vehicles available to the Player's Side (Bluefor, Opfor, Independent, Civilian)"],
//   [_baseCat, "Vehicle Spawner Module"],
//   false,
//   2,
//   {},
//   false
// ] call CBA_fnc_addSetting;

// ----- End of PHK_Feature_VehicleSpawner -----