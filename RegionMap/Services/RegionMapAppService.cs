using Volo.Abp.Application.Services;
using RegionMap.Localization;

namespace RegionMap.Services;

/* Inherit your application services from this class. */
public abstract class RegionMapAppService : ApplicationService
{
    protected RegionMapAppService()
    {
        LocalizationResource = typeof(RegionMapResource);
    }
}