class CfgPatches {
  class PHK_feature_pushVehicle {
    name = "PHUKit - Push Vehicle";
    author = "Your Team";
    requiredVersion = 2.06;
    requiredAddons[] = {"PHK_core"};
    units[] = {};
    weapons[] = {};
    version = "1.0.0";
  };
};

class CfgFunctions {
  class PHK {
    tag = "PHK";
    class feature_pushVehicle {
      file = "\PHUKit\feature_pushVehicle\functions";
      class addAction {};
      class canPush {};
      class getPushVector {};
      class push {};
      class pushServer {};
    };
  };
};

class Extended_PostInit_EventHandlers {
  class PHK_feature_pushVehicle_postInit {
    init = "call compile preprocessFileLineNumbers '\PHUKit\feature_pushVehicle\XEH_postInit.sqf'";
  };
};

// Whitelist the server-side mover
class CfgRemoteExec {
  class Functions {
    mode = 1; jip = 1;
    class PHK_fnc_pushServer { allowedTargets = 2; }; // server only
  };
};
