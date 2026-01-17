class CfgPatches
{
    class PHK_Feature_VehicleSpawnPoint
    {
        name = "PHUKit - Vehicle Spawn Point";
        author = "PHUKit";
        requiredAddons[] = {"A3_Modules_F", "A3_Editor_F"};
        units[] = {"PHK_VehicleSpawnPoint"};
        weapons[] = {};
    };
};

class CfgVehicles
{
    class Land_Sign_Sphere10cm_F;

    class PHK_VehicleSpawnPoint : Land_Sign_Sphere10cm_F
    {
        scope = 2;
        scopeCurator = 2;
        displayName = "PHK Vehicle Spawn Point";
        editorCategory = "PHK_EdCat_PhuKit";
        editorSubcategory = "PHK_EdSubcat_Spawning";

        // Distinct identity in Eden
        icon = "\PHK_Feature_VehicleSpawnPoint\data\ui\phk_vsp_ca.paa";
        editorPreview = "\PHK_Feature_VehicleSpawnPoint\data\ui\phk_vsp_preview_ca.paa";

        mapSize = 0.5;

        armor = 0;
        enableSimulation = 0;
    };
};


class CfgFunctions
{
    class PHK
    {
        class VehicleSpawnPoint
        {
        file = "\PHK_Feature_VehicleSpawnPoint\functions";
        class spawnAll { postInit = 1; };
        class spawnOne {};
        };
    };
};


class Cfg3DEN
{
    class Object
    {
        class AttributeCategories
        {
        class PHK_VSP_Category
        {
            displayName = "Custom Vehicle Spawn Point";
            collapsed = 0;

            class Attributes
            {
            class PHK_VSP_Classname
            {
                displayName = "Vehicle classname";
                tooltip = "CfgVehicles classname to spawn at mission start (server-side). Example: B_MRAP_01_F";
                property = "PHK_VSP_Classname";
                control = "Edit";
                expression = "_this setVariable ['PHK_VSP_Classname', _value, true];";
                defaultValue = "''";
                typeName = "STRING";
            };

            class PHK_VSP_Delay
            {
                displayName = "Spawn delay (sec)";
                tooltip = "Delay after mission start before spawning.";
                property = "PHK_VSP_Delay";
                control = "EditShort";
                expression = "_this setVariable ['PHK_VSP_Delay', parseNumber _value, true];";
                defaultValue = "'5'";
                typeName = "STRING";
            };

            class PHK_VSP_DeleteMarker
            {
                displayName = "Delete marker after spawn";
                tooltip = "If enabled, deletes the spawn point object after it spawns the vehicle.";
                property = "PHK_VSP_DeleteMarker";
                control = "Checkbox";
                expression = "_this setVariable ['PHK_VSP_DeleteMarker', _value, true];";
                defaultValue = "true";
                typeName = "BOOL";
            };

            class PHK_VSP_AlignToSurface
            {
                displayName = "Align to surface";
                tooltip = "If enabled, aligns spawned vehicle to ground normal (useful for uneven terrain).";
                property = "PHK_VSP_AlignToSurface";
                control = "Checkbox";
                expression = "_this setVariable ['PHK_VSP_AlignToSurface', _value, true];";
                defaultValue = "true";
                typeName = "BOOL";
            };

            class PHK_VSP_SpawnCrewed
            {
            displayName = "Spawn crewed";
            tooltip = "If enabled, spawns the vehicle with its default crew (CfgVehicles >> classname >> crew).";
            property = "PHK_VSP_SpawnCrewed";
            control = "Checkbox";
            expression = "_this setVariable ['PHK_VSP_SpawnCrewed', _value, true];";
            defaultValue = "false";
            typeName = "BOOL";
            };
            };

        };
        };
    };
};
