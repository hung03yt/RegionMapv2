using RegionMap.Localization;
using Volo.Abp.Authorization.Permissions;
using Volo.Abp.Localization;
using Volo.Abp.MultiTenancy;

namespace RegionMap.Permissions;

public class RegionMapPermissionDefinitionProvider : PermissionDefinitionProvider
{
    public override void Define(IPermissionDefinitionContext context)
    {
        var myGroup = context.AddGroup(RegionMapPermissions.GroupName);


        
        //Define your own permissions here. Example:
        //myGroup.AddPermission(RegionMapPermissions.MyPermission1, L("Permission:MyPermission1"));
    }

    private static LocalizableString L(string name)
    {
        return LocalizableString.Create<RegionMapResource>(name);
    }
}
