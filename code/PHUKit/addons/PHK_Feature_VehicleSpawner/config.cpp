class CfgPatches {
    class PHK_feature_vehicleSpawner {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {"cba_main", "cba_xeh", "PHK_Core"};
    };
};

class CfgFunctions{
    class PHK_Feature_VehicleSpawner {
        tag = "PHK";
        class Feature_VehicleSpawner {
            file = "\phk_feature_vehiclepawner\functions";

            class addAction {};
            class xxx {};
        };
    };
};

class CfgRemoteExec {
    class Functions {
        mode = 1; jip = 1;
        class PHK_fnc_xxx { allowedTargets = 2; };
    };
};

class Extended_PostInit_EventHandlers {
    class PHK_feature_vehicleSpawner {
        init = "call compile preprocessFileLineNumbers '\phk_feature_vehiclespawner\XEH_postInit.sqf'";
    };
};