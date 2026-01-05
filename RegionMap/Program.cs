using System;
using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using RegionMap.Data;
using Serilog;
using Serilog.Events;
using Volo.Abp;
using Volo.Abp.Autofac;
using Volo.Abp.EntityFrameworkCore;
using Volo.Abp.EntityFrameworkCore.PostgreSql;

namespace RegionMap;

public class Program
{
    public static async Task<int> Main(string[] args)
    {
        Log.Logger = new LoggerConfiguration()
            .MinimumLevel.Debug()
            .MinimumLevel.Override("Microsoft", LogEventLevel.Information)
            .Enrich.FromLogContext()
            .WriteTo.Console()
            .WriteTo.File("Logs/logs.txt")
            .CreateBootstrapLogger();

        try
        {
            var builder = WebApplication.CreateBuilder(args);

            // ----------------------------
            // Host & logging
            // ----------------------------
            builder.Host
                .UseAutofac()
                .UseSerilog();

            // ----------------------------
            // PostgreSQL + EF Core (NO repos, NO migrations)
            // ----------------------------
            builder.Services.AddAbpDbContext<RegionMapDbContext>(options =>
            {
                // IMPORTANT: no default repositories
                options.AddDefaultRepositories(includeAllEntities: false);
            });

            builder.Services.AddEntityFrameworkNpgsql();

            builder.Services.AddSingleton<RegionMap.Services.Logging.IJsonLineLogger, RegionMap.Services.Logging.JsonLineFileLogger>();

            // ----------------------------
            // ABP application
            // ----------------------------
            await builder.AddApplicationAsync<RegionMapModule>();

            var app = builder.Build();

            await app.InitializeApplicationAsync();

            Log.Information("RegionMap service started.");

            await app.RunAsync();
            return 0;
        }
        catch (Exception ex)
        {
            Log.Fatal(ex, "RegionMap terminated unexpectedly!");
            return 1;
        }
        finally
        {
            Log.CloseAndFlush();
        }
    }
}
