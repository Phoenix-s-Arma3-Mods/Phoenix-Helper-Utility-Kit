class CfgPatches {
  class PHK_Core {
    units[] = {};
    weapons[] = {};
    requiredAddons[] = {"cba_main", "cba_xeh"};
    requiredVersion = 2.06;
    author = "Phoenix";
  };
};

class CfgEditorCategories {
  class PHK_EdCat_PhuKit {
    displayName = "PHUKit";
  };
};

class CfgEditorSubcategories {
  class PHK_EdSubcat_Spawning {
    displayName = "Spawning";
  };
};

class CfgFunctions {
  class PHK_Core {
    tag = "PHK";
    class Core {
      file = "\PHK_Core\functions";
      class log {};
      class isFeatureEnabled {};
      class modPresent {};
    };
  };
};

class Extended_PreInit_EventHandlers {
  class PHK_Core {
    init = "call compile preprocessFileLineNumbers '\PHK_Core\XEH_preInit.sqf'";
  };
};
class Extended_PostInit_EventHandlers {
  class PHK_Core {
    init = "call compile preprocessFileLineNumbers '\PHK_Core\XEH_postInit.sqf'";
  };
};