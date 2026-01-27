if (isNil "CBA_fnc_addSetting") exitWith {};

private _baseCat = "PHUKit - Phoenix's Helper and Utilities Kit";
private _subCat  = "Advanced Sling Loading (Compat)";

[
  "PHK_enable_feature_aslCompat",
  "CHECKBOX",
  ["Enable: ASL Compat Tuning","Enable PHK compat patch that overrides ASL lift math & thresholds."],
  [_baseCat, _subCat],
  true,
  2,
  {},
  false
] call CBA_fnc_addSetting;

// If heli has slingLoadMaxCargoMass <= 0, use this instead (ASL hardcoded 4000 replacement)
[
  "PHK_ASL_defaultLiftIfMissing",
  "SLIDER",
  ["ASL: Default Lift When Missing (kg)","Used when a helicopter has no slingLoadMaxCargoMass configured."],
  [_baseCat, _subCat],
  [0, 200000, 4000, 0],
  2,
  {},
  false
] call CBA_fnc_addSetting;

// GLOBAL: apply to ALL helicopters
[
  "PHK_ASL_globalLiftMultiplier",
  "SLIDER",
  ["ASL: Global Lift Multiplier","Multiplies EVERY helicopter's computed lift capability. 1.0 = no change."],
  [_baseCat, _subCat],
  [0.1, 50, 1.0, 2],
  2,
  {},
  false
] call CBA_fnc_addSetting;

// GLOBAL: fixed lift for ALL helicopters (0 disables)
[
  "PHK_ASL_globalLiftOverrideKg",
  "SLIDER",
  ["ASL: Global Lift Override (kg)","If > 0, forces ALL helicopters to use this lift capability (before multiplier). 0 disables."],
  [_baseCat, _subCat],
  [0, 500000, 0, 0],
  2,
  {},
  false
] call CBA_fnc_addSetting;

// Recommended safety: never reduce lift
[
  "PHK_ASL_onlyIncreaseLift",
  "CHECKBOX",
  ["ASL: Only Increase Lift","Global override/multiplier will never reduce a helicopter's original configured lift."],
  [_baseCat, _subCat],
  true,
  2,
  {},
  false
] call CBA_fnc_addSetting;

// Controls when ASL engages the heavy-lift mass trick (feeds ASL's own override var too)
[
  "PHK_ASL_heavyLiftMinLiftKg",
  "SLIDER",
  ["ASL: Heavy Lift Minimum Lift (kg)","Minimum lift capability required before ASL engages heavy-lift mass adjustment."],
  [_baseCat, _subCat],
  [0, 500000, 5000, 0],
  2,
  {
    // keep ASL's native override var in sync
    if (isServer) then {
      missionNamespace setVariable ["ASL_HEAVY_LIFTING_MIN_LIFT_OVERRIDE", _this, true];
    } else {
      // optional: keep local copy without broadcasting
      missionNamespace setVariable ["ASL_HEAVY_LIFTING_MIN_LIFT_OVERRIDE", _this, false];
    };
  },
  false
] call CBA_fnc_addSetting;

// Replaces ASL hardcoded 0.8 (cargo mass becomes lift * multiplier)
[
  "PHK_ASL_massClampMultiplier",
  "SLIDER",
  ["ASL: Mass Clamp Multiplier","When heavy-lift triggers, cargo mass is set to (lift * multiplier). ASL hardcodes 0.8."],
  [_baseCat, _subCat],
  [0.05, 2.0, 0.8, 2],
  2,
  {},
  false
] call CBA_fnc_addSetting;

// Optional: fixed clamp target mass (0 disables; if enabled, overrides multiplier)
[
  "PHK_ASL_massClampOverrideKg",
  "SLIDER",
  ["ASL: Mass Clamp Override (kg)","If > 0, heavy-lift sets cargo mass to this fixed value instead of lift*multiplier. 0 disables."],
  [_baseCat, _subCat],
  [0, 500000, 0, 0],
  2,
  {},
  false
] call CBA_fnc_addSetting;

// Ensure ASL variable exists with the default at mission start too
if (isServer) then {
  missionNamespace setVariable ["ASL_HEAVY_LIFTING_MIN_LIFT_OVERRIDE", PHK_ASL_heavyLiftMinLiftKg, true];
};