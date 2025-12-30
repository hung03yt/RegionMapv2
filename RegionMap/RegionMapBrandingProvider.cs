using Microsoft.Extensions.Localization;
using RegionMap.Localization;
using Volo.Abp.DependencyInjection;
using Volo.Abp.Ui.Branding;

namespace RegionMap;

[Dependency(ReplaceServices = true)]
public class RegionMapBrandingProvider : DefaultBrandingProvider
{
    private IStringLocalizer<RegionMapResource> _localizer;

    public RegionMapBrandingProvider(IStringLocalizer<RegionMapResource> localizer)
    {
        _localizer = localizer;
    }

    public override string AppName => _localizer["AppName"];
}