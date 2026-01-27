class CfgPatches {
  class PHK_Compat_ASL {
    units[] = {};
    weapons[] = {};
    requiredVersion = 2.10;
    requiredAddons[] = {
      "cba_main",
      "cba_xeh",
      "SA_AdvancedSlingLoading",
      "PHK_Core"
    };
  };
};

class Extended_PreInit_EventHandlers {
  class PHK_Compat_ASL {
    init = "call compile preprocessFileLineNumbers '\PHK_Compat_ASL\XEH_preInit.sqf'";
  };
};

class Extended_PostInit_EventHandlers {
  class PHK_Compat_ASL {
    init = "call compile preprocessFileLineNumbers '\PHK_Compat_ASL\XEH_postInit.sqf'";
  };
};
