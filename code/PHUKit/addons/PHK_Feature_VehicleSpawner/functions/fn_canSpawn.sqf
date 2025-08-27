if (vehicle player != player) exitWith {false};

private _terminal = _this select 0;
if (isNull _terminal) exitWith {false};

if !(_terminal getVariable ["PHK_vehicleSpawner_isSpawner", false]) exitWith {false};

private _distance = player distance _terminal;
["Distance check: player at " + (str (getPos player)) + ", terminal at " + (str (getPos _terminal)) + ", distance: " + (str _distance)] call PHK_fnc_log;

if (_distance > 7) exitWith {false};

// // DEBUG (comment me out later)
// ["Vehicle spawner check passed for: " + (name _terminal) + " at distance " + (str _distance)] call PHK_fnc_log;

// // call BIS logger to troubleshoot distance problem:
// ["Spawn Check: Player %1 at %2, Terminal: %3 at %4, distance: %5", 
//     name player, getPos player, typeOf _terminal, getPos _terminal, player distance _terminal] call BIS_fnc_logFormat;
// // extra call to PHK_log for easy readability when i'm being stupid
// ["Distance check: player at " + (str (getPos player)) + ", terminal (" + (typeOf _terminal) + ") at " + (str (getPos _terminal)) + ", distance: " + (str _distance)] call PHK_fnc_log;

true