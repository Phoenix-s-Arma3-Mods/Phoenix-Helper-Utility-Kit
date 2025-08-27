class CfgPatches {
    class PHK_feature_vehicleSpawner {
        units[] = {"PHK_Module_CreateVehicleSpawnLocation","PHK_Module_AddVehicleSpawner", "PHK_Module_RemoveVehicleSpawner"};
        weapons[] = {};
        requiredAddons[] = {"cba_main", "cba_xeh", "PHK_Core"};
    };
};

class CfgFunctions{
    class PHK_Feature_VehicleSpawner {
        tag = "PHK";
        class Feature_VehicleSpawner {
            file = "\phk_feature_vehiclespawner\functions";

            class addAction {};
            class addActionToSpawner {};
            class removeActionFromSpawner {};
            class canSpawn {};
            class spawn {};
            class findHelipad {};

            class spawnServer {};
            class markSpawnerServer {};
            class unmarkSpawnerServer {};

            class zeusAddSpawner {};
            class zeusCreateNewSpawnLocation {};
            class zeusRemoveSpawner {};
        };
    };
};

class CfgRemoteExec {
    class Functions {
        mode = 1; jip = 1;
        class PHK_fnc_spawnServer { allowedTargets = 2; };
        class PHK_fnc_markSpawnerServer { allowedTargets = 2; };
        class PHK_fnc_unmarkSpawnerServer { allowedTargets = 2; };
        class PHK_fnc_addActionToSpawner { allowedTargets = 0; };
        class PHK_fnc_removeActionFromSpawner { allowedTargets = 0; };
    };
};

class CfgFactionClasses {
    class PHK_Modules {
        displayName = "PHUKit";
        priority = 2;
        side = 7;
    };
};

class CfgVehicles {
    class Logic;
    class Module_F: Logic {
        class AttributesBase;
    };

    class PHK_Module_CreateVehicleSpawnLocation: Module_F {
        scope = 2;
        scopeCurator = 2;
        displayName = "Create New Vehicle Spawn Location";
        category = "PHK_Modules";
        icon = "\A3\modules_f\data\portraitModule_ca.paa";
        function = "PHK_fnc_zeusCreateNewSpawnLocation";
        functionPriority = 1;
        isGlobal = 1;
        isTriggerActivated = 0;
        curatorCanAttach = 0;
    };

    class PHK_Module_AddVehicleSpawner: Module_F {
        scope = 2;
        scopeCurator = 2;
        displayName = "Add Menu - Vehicle Spawner";
        category = "PHK_Modules";
        icon = "\A3\modules_f\data\portraitModule_ca.paa";
        function = "PHK_fnc_zeusAddSpawner";
        functionPriority = 1;
        isGlobal = 1;
        isTriggerActivated = 0;
        curatorCanAttach = 1;
    };

    class PHK_Module_RemoveVehicleSpawner: Module_F {
        scope = 2;
        scopeCurator = 2;
        displayName = "Remove Menu - Vehicle Spawner";
        category = "PHK_Modules";
        icon = "A3\modules_f\data\portraitModule_ca.paa";
        function = "PHK_fnc_zeusRemoveSpawner";
        functionPriority = 1;
        isGlobal = 1;
        isTriggerActivated = 0;
        curatorCanAttach = 1;
    };
};

class Extended_PostInit_EventHandlers {
    class PHK_feature_vehicleSpawner {
        init = "call compile preprocessFileLineNumbers '\phk_feature_vehiclespawner\XEH_postInit.sqf'";
    };
};