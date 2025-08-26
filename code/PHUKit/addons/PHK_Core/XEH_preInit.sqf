// Register CBA settings category + any global toggles.
// Server owners can enable/disable features via Addon Options.

if (isNil "CBA_fnc_addSetting") exitWith {}; // CBA safeguard

private _cat = "PHUKit - Phoenix's Helper and Utilities Kit";

// PHK_Feature_PushVehicle CBA Settings
[
  "PHK_enable_feature_pushVehicle","CHECKBOX",
  ["Enable: Push Vehicle","Allow infantry to nudge stuck vehicles."],
  _cat, true, 1
] call CBA_fnc_addSetting;

[
  "PHK_pushVehicle_distance","SLIDER",
  ["Push Vehicle: Distance","How far a nudge moves the vehicle."],
  _cat, [0.2, 3, 1.2, 2], 1
] call CBA_fnc_addSetting;

// PHK_Feature_VehicleSpawner CBA Settings
[
  "PHK_enable_feature_vehicleSpawner",
  "CHECKBOX",
  ["Enable: Vehicle Spawner", "Allow use of Vehicle Spawner terminals."],
  _cat,
  true,
  1
] call CBA_fnc_addSetting;

[
  "PHK_vehicleSpawner_allowCustomClasses"
  "CHECKBOX",
  ["Enable: Custom Vehicle Classes", "Allow use of Custom mods/classes at Vehicle Spawner terminals."],
  _cat,
  true,
  1
] call CBA_fnc_addSetting;

[
  "PHK_vehicleSpawner_customClasses",
  "EDITBOX",
  ["Custom Vehicle Classes Allowed:", "Input/Remove Custom Vehicle Classes allowable"],
  _cat,
  "",
  1
] call CBA_fnc_addSetting;

[
  "PHK_vehicleSpawner_forceSideOnly",
  "CHECKBOX",
  ["Enable: Force Side-Only Vehicle Spawns", "Restrict spawnable vehicles to only vehicles available to the Player's Side (Bluefor, Opfor, Independent, Civilian)"],
  _cat,
  false,
  1
] call CBA_fnc_addSetting;