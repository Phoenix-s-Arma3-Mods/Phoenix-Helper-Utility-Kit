class CfgPatches
{
  class PHK_SLE
  {
    name = "PHUKit - Slingloading Extended";
    author = "PHUKit";
    requiredVersion = 2.10;
    requiredAddons[] = { "cba_main", "PHK_Core" };
    units[] = {};
    weapons[] = {};
  };
};

class CfgFunctions
{
  class PHK_Feature_Slingloading_Extended
  {
    tag = "PHK";

    class Feature_Slingloading_Extended
    {
      file = "\phk_feature_slingloading_extended\functions";

      class sle_preInit {};
      class sle_postInit {};

      class sle_addActionsLocal {};
      class sle_requestHook {};
      class sle_serverValidateAndExecHook {};
      class sle_localHook {};
      class sle_requestDrop {};
      class sle_serverExecDrop {};
      class sle_localDrop {};
      class sle_findCargoCandidate {};
      class sle_isWhitelistedHeli {};
    };
  };
};
