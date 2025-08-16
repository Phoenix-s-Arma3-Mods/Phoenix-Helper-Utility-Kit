class CfgPatches {
  class PHK_feature_pushVehicle {
    units[] = {};
    weapons[] = {};
    requiredAddons[] = {"cba_main", "cba_xeh","PHK_Core"};
  };
};

class CfgFunctions {
  class PHK_Feature_PushVehicle {
    tag = "PHK";
    class Feature_PushVehicle {
      file = "\phk_feature_pushvehicle\functions";
      class addAction {};
      class canPush {};
      class getPushVector {};
      class push {};
      class pushServer {};
    };
  };
};

class CfgRemoteExec {
  class Functions {
    mode = 1; jip = 1;
    class PHK_fnc_pushServer { allowedTargets = 2; };
  };
};

class Extended_PostInit_EventHandlers {
  class PHK_feature_pushVehicle {
    init = "call compile preprocessFileLineNumbers '\phk_feature_pushvehicle\XEH_postInit.sqf'";
  };
};