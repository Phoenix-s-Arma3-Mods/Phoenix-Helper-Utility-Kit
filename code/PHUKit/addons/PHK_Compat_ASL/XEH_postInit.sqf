[] spawn {
  // Wait until ASL postInit has installed its globals
  waitUntil { !isNil "ASL_Rope_Get_Lift_Capability" && !isNil "ASL_Rope_Adjust_Mass" && !isNil "ASL_RemoteExec" };

  waitUntil { !isNil "PHK_enable_feature_aslCompat" };

  // --- Override: compute lift capability with PHK global rules ---
  ASL_Rope_Get_Lift_Capability = {
    params ["_vehicle"];

    // If disabled, behave like stock ASL (best-effort)
    if !(missionNamespace getVariable ["PHK_enable_feature_aslCompat", true]) exitWith {
      private _l = getNumber (configFile >> "CfgVehicles" >> typeOf _vehicle >> "slingLoadMaxCargoMass");
      if (_l <= 0) then { _l = 4000; };
      _l
    };

    private _configLift = getNumber (configFile >> "CfgVehicles" >> typeOf _vehicle >> "slingLoadMaxCargoMass");
    private _lift = _configLift;

    // fallback if config missing/0
    if (_lift <= 0) then {
      _lift = missionNamespace getVariable ["PHK_ASL_defaultLiftIfMissing", 4000];
    };

    private _onlyInc = missionNamespace getVariable ["PHK_ASL_onlyIncreaseLift", true];

    // fixed override for all helis (before multiplier)
    private _override = missionNamespace getVariable ["PHK_ASL_globalLiftOverrideKg", 0];
    if (_override > 0) then {
      _lift = if (_onlyInc) then { _lift max _override } else { _override };
    };

    // multiplier for all helis
    private _mult = missionNamespace getVariable ["PHK_ASL_globalLiftMultiplier", 1.0];
    private _scaled = _lift * _mult;

    // never reduce (if enabled)
    if (_onlyInc) then {
      _scaled = _scaled max _lift;
    };

    _scaled
  };

  // --- Override: replace ASL hardcoded 0.8 with tunables ---
  ASL_Rope_Adjust_Mass = {
    params ["_obj","_heli",["_ropes",[]]];

    private _lift = [_heli] call ASL_Rope_Get_Lift_Capability;
    private _originalMass = getMass _obj;

    private _minLift = missionNamespace getVariable ["ASL_HEAVY_LIFTING_MIN_LIFT_OVERRIDE", 5000];

    private _fixedClamp = missionNamespace getVariable ["PHK_ASL_massClampOverrideKg", 0];
    private _multClamp  = missionNamespace getVariable ["PHK_ASL_massClampMultiplier", 0.8];
    private _targetMass = if (_fixedClamp > 0) then { _fixedClamp } else { _lift * _multClamp };

    // Same gate logic as ASL, just using configurable target mass
    if (_originalMass >= _targetMass && _lift >= _minLift) then {
      private _originalMassSet = (getMass _obj) == _originalMass;

      while { _obj in (ropeAttachedObjects _heli) && _originalMassSet } do {
        {
          private _ends = ropeEndPosition _x;
          private _endDistance = (_ends select 0) distance (_ends select 1);
          private _ropeLength = ropeLength _x;

          if ((_ropeLength - 2) <= _endDistance && ((position _heli) select 2) > 0) then {
            [[_obj, _targetMass], "ASL_Rope_Set_Mass", _obj, true] call ASL_RemoteExec;
            _originalMassSet = false;
          };
        } forEach _ropes;

        sleep 0.1;
      };

      while { _obj in (ropeAttachedObjects _heli) } do { sleep 0.5; };

      [[_obj, _originalMass], "ASL_Rope_Set_Mass", _obj, true] call ASL_RemoteExec;
    };
  };

  diag_log "[PHK_Compat_ASL] Patched ASL lift + clamp; CBA tunables active.";
};
