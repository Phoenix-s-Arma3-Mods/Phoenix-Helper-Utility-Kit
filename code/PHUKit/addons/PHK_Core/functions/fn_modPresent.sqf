/*
 * ["ace_main"] call PHK_fnc_modPresent
 * Returns true if an addon is loaded (by CfgPatches class).
 */
params [["_addon","",[""]]];
isClass (configFile >> "CfgPatches" >> _addon)
