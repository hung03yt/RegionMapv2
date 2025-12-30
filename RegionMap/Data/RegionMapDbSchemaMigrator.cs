using Volo.Abp.DependencyInjection;
using Microsoft.EntityFrameworkCore;

namespace RegionMap.Data;

public class RegionMapDbSchemaMigrator : ITransientDependency
{
    private readonly IServiceProvider _serviceProvider;

    public RegionMapDbSchemaMigrator(
        IServiceProvider serviceProvider)
    {
        _serviceProvider = serviceProvider;
    }

    public async Task MigrateAsync()
    {
        
        /* We intentionally resolving the RegionMapDbContext
         * from IServiceProvider (instead of directly injecting it)
         * to properly get the connection string of the current tenant in the
         * current scope.
         */

        await _serviceProvider
            .GetRequiredService<RegionMapDbContext>()
            .Database
            .MigrateAsync();

    }
}
