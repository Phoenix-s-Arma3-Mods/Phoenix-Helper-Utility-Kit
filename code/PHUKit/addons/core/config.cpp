#include "script_component.hpp"

class CfgPatches {
  class PHK_core {
    name = "PHUKit - Core";
    author = "Phoenix";
    requiredVersion = 2.06;
    requiredAddons[] = {"cba_main"};
    units[] = {};
    weapons[] = {};
    version = "1.0.0";
  };
};

class CfgFunctions {
  class PHK {
    tag = "PHK";
    class core {
      file = "\PHUKit\core\functions";
      class log {};
      class isFeatureEnabled {};
      class modPresent {};
    };
  };
};

// CBA Extended Event Handlers
class Extended_PreInit_EventHandlers {
  class PHK_core_preInit {
    init = "call compile preprocessFileLineNumbers '\PHUKit\core\XEH_preInit.sqf'";
  };
};
class Extended_PostInit_EventHandlers {
  class PHK_core_postInit {
    init = "call compile preprocessFileLineNumbers '\PHUKit\core\XEH_postInit.sqf'";
  };
};
