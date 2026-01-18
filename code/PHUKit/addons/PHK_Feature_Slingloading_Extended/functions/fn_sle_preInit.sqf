/*
  PHK_fnc_sle_preInit
  - Server-side: caches settings into missionNamespace (replicated) for easy reads elsewhere.
  - Settings are REGISTERED in PHK_Core.
*/
if (!isServer) exitWith {};

private _enabled = missionNamespace getVariable ["PHK_enable_feature_slingloadingExtended", true];
missionNamespace setVariable ["PHK_SLE_enabled", _enabled, true];

private _maxKg = missionNamespace getVariable ["PHK_sle_maxLiftMassKg", 12000];
missionNamespace setVariable ["PHK_SLE_maxLiftMassKg", _maxKg, true];

private _ropeLen = missionNamespace getVariable ["PHK_sle_ropeLength", 12];
missionNamespace setVariable ["PHK_SLE_ropeLength", _ropeLen, true];

private _ropeCnt = missionNamespace getVariable ["PHK_sle_ropeCount", 4];
missionNamespace setVariable ["PHK_SLE_ropeCount", _ropeCnt, true];

missionNamespace setVariable ["PHK_SLE_clampMassEnabled", true, true];

private _clampTo = missionNamespace getVariable ["PHK_sle_clampMassToKg", 2000];
missionNamespace setVariable ["PHK_SLE_clampMassToKg", _clampTo, true];

private _wlEnabled = missionNamespace getVariable ["PHK_sle_whitelistEnabled", false];
missionNamespace setVariable ["PHK_SLE_whitelistEnabled", _wlEnabled, true];

private _wlRaw = missionNamespace getVariable ["PHK_sle_heliWhitelist", ""];
private _wl = [];
if (_wlRaw isEqualType "" && {_wlRaw != ""}) then {
  // Split by commas, trim spaces, drop empties
  _wl = (_wlRaw splitString ",") apply { toLower (_x splitString " " joinString "") };
  _wl = _wl select { _x != "" };
};
missionNamespace setVariable ["PHK_SLE_heliWhitelist", _wl, true];
