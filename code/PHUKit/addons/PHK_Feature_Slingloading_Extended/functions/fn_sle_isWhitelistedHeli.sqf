params ["_heli"];
if (isNull _heli) exitWith { false };

private _wlEnabled = missionNamespace getVariable ["PHK_SLE_whitelistEnabled", false];
if (!_wlEnabled) exitWith { true };

private _list = missionNamespace getVariable ["PHK_SLE_heliWhitelist", []];
if (_list isEqualTo []) exitWith { false };

(toLower typeOf _heli) in _list
