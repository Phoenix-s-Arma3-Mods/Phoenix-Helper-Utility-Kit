["PHUKit Core initialized"] call PHK_fnc_log;

// PHK_SLE XEH_postInit.sqf
if (hasInterface) then {
  call PHK_fnc_sle_postInit;
};
