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

// ----- Start of PHK_Feature_Slingloading_Extended -----
[
  "PHK_enable_feature_slingloadingExtended",
  "CHECKBOX",
  ["Enable: Slingloading Extended", "Adds heavy slingloading (rope physics + lift-kit mass clamp)."],
  [_baseCat, "Slingloading Extended Module"],
  true,
  2,
  {
    params ["_value"];
    missionNamespace setVariable ["PHK_SLE_enabled", _value, true];

    // -- If disabling, force-drop any active PHK SLE sling on all helis
    if (!_value && {isServer}) then {
      {
        if (_x isKindOf "Helicopter" && {!isNull (_x getVariable ["PHK_SLE_cargo", objNull])}) then {
          [_x] remoteExecCall ["PHK_fnc_sle_serverExecDrop", 2];
        };
      } forEach vehicles;
    };
  },
  false
] call CBA_fnc_addSetting;

[
  "PHK_sle_maxLiftMassKg",
  "SLIDER",
  ["SLE: Max Lift Mass (kg)", "Max cargo mass allowed for PHK heavy sling hook (lift kit behavior)."],
  [_baseCat, "Slingloading Extended Module"],
  [500, 100000, 12000, 0],
  2,
  {
    params ["_value"];
    missionNamespace setVariable ["PHK_SLE_maxLiftMassKg", _value, true];
  },
  false
] call CBA_fnc_addSetting;

[
  "PHK_sle_clampMassToKg",
  "SLIDER",
  ["SLE: Clamp Mass To (kg)", "When hooked, cargo mass is temporarily set to this value (lift kit strength)."],
  [_baseCat, "Slingloading Extended Module"],
  [200, 8000, 2000, 0],
  2,
  { params ["_value"]; missionNamespace setVariable ["PHK_SLE_clampMassToKg", _value, true]; },
  false
] call CBA_fnc_addSetting;


[
  "PHK_sle_ropeLength",
  "SLIDER",
  ["SLE: Rope Length (m)", "Rope length used by PHK heavy sling hook. WARNING: Long ropes can be unstable!!"],
  [_baseCat, "Slingloading Extended Module"],
  [5, 100, 10, 0],
  2,
  {
    params ["_value"];
    missionNamespace setVariable ["PHK_SLE_ropeLength", _value, true];
  },
  false
] call CBA_fnc_addSetting;

[
  "PHK_sle_ropeCount",
  "SLIDER",
  ["SLE: Rope Count", "Number of ropes (1-4). More ropes = more stable."],
  [_baseCat, "Slingloading Extended Module"],
  [1, 4, 4, 0],
  2,
  {
    params ["_value"];
    missionNamespace setVariable ["PHK_SLE_ropeCount", _value, true];
  },
  false
] call CBA_fnc_addSetting;

[
  "PHK_sle_whitelistEnabled",
  "CHECKBOX",
  ["SLE: Enable Helicopter Whitelist", "If enabled, only whitelisted helicopter classes can use PHK SLE."],
  [_baseCat, "Slingloading Extended Module"],
  false,
  2,
  {
    params ["_value"];
    missionNamespace setVariable ["PHK_SLE_whitelistEnabled", _value, true];
  },
  false
] call CBA_fnc_addSetting;

[
  "PHK_sle_heliWhitelist",
  "EDITBOX",
  ["SLE: Helicopter Whitelist", "Comma-separated classnames allowed to use PHK SLE (only if whitelist enabled)."],
  [_baseCat, "Slingloading Extended Module"],
  "",
  2,
  {
    params ["_value"];
    private _wl = [];
    if (_value isEqualType "" && {_value != ""}) then {
      _wl = (_value splitString ",") apply { toLower (_x splitString " " joinString "") };
      _wl = _wl select { _x != "" };
    };
    missionNamespace setVariable ["PHK_SLE_heliWhitelist", _wl, true];
  },
  false
] call CBA_fnc_addSetting;

if (isServer) then { call PHK_fnc_sle_preInit; };

// ----- End of PHK_Feature_Slingloading_Extended -----