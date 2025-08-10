// Register CBA settings category + any global toggles.
// Server owners can enable/disable features via Addon Options.

// When you add a new feature, also add a server-enforced toggle here, e.g.:
// [
//   "PHK_enable_feature_earplugs", "CHECKBOX",
//   ["Enable: Earplugs", "Allow the Earplugs feature."],
//   _cat, true, 1  // default on, server-enforced
// ] call CBA_fnc_addSetting;


if (isNil "CBA_fnc_addSetting") exitWith {}; // CBA safeguard

private _cat = "PHUKit - Phoenix's Helper and Utilities Kit";

// Example client preference used by multiple features (adjust as you like)
[
  "PHK_client_hintDuration",
  "SLIDER",
  ["Hint Duration (s)", "How long short notifications stay on screen."],
  _cat,
  [0.5, 5, 1.2, 1],
  0 // client setting
] call CBA_fnc_addSetting;


// Global toggle (server-enforced)
[
  "PHK_enable_feature_pushVehicle","CHECKBOX",
  ["Enable: Push Vehicle","Allow infantry to nudge stuck vehicles."],
  _cat, true, 1
] call CBA_fnc_addSetting;

// Server-enforced push distance (meters)
[
  "PHK_pushVehicle_distance","SLIDER",
  ["Push Vehicle: Distance","How far a nudge moves the vehicle."],
  _cat, [0.2, 3, 1.2, 2], 1
] call CBA_fnc_addSetting;
