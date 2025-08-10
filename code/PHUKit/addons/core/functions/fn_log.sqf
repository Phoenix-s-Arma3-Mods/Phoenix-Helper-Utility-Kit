/*
 * ["message"] call PHK_fnc_log;
 */
params [["_msg","",[""]]];
diag_log text format ["[PHUKit][Core] %1", _msg];
