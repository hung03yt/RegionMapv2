using System;
using System.Collections.Concurrent;
using System.IO;
using System.Text.Json;
using System.Threading.Tasks;
using Serilog;

namespace RegionMap.Services.Logging;
    public class JsonLineFileLogger : IJsonLineLogger
    {
        private static readonly ConcurrentDictionary<string, Serilog.ILogger> _loggers = new();

        public async Task AppendJsonLineAsync(object payload, string fileName = "logs.txt", bool includeTime = true, string level = "ERROR", JsonSerializerOptions? options = null)
        {
            options ??= new JsonSerializerOptions
            {
                PropertyNamingPolicy = JsonNamingPolicy.CamelCase,
                WriteIndented = false
            };

            object entry = payload;
            if (includeTime)
            {
                entry = new
                {
                    time = DateTimeOffset.UtcNow.ToOffset(TimeSpan.FromHours(7)).ToString("o"),
                    response = payload
                };
            }

            var json = JsonSerializer.Serialize(entry, options);

            // Prefix with timestamp (YYYY-MM-DDTHH:mm:ss) and level tag (e.g. ERROR)
            var timestamp = DateTimeOffset.UtcNow.ToOffset(TimeSpan.FromHours(7)).ToString("yyyy-MM-dd'T'HH:mm:ss");
            var levelTag = (level ?? "ERROR").ToUpperInvariant();
            var line = $"{timestamp} {levelTag}: {json}";

            var logger = GetOrCreateLoggerForFile(fileName);

            // Map level tag to Serilog level for the Write call
            var serilogLevel = levelTag switch
            {
                "ERROR" => Serilog.Events.LogEventLevel.Error,
                "WARNING" => Serilog.Events.LogEventLevel.Warning,
                _ => Serilog.Events.LogEventLevel.Information
            };

            await Task.Run(() => logger.Write(serilogLevel, "{Message}", line));
        }

        private Serilog.ILogger GetOrCreateLoggerForFile(string fileName)
        {
            return _loggers.GetOrAdd(fileName, fn =>
            {
                var logsDir = Path.Combine(Directory.GetCurrentDirectory(), "Logs");
                Directory.CreateDirectory(logsDir);
                var path = Path.Combine(logsDir, fn);

                // Configure a per-file logger that writes only the message text (so we can control the JSON layout)
                var l = new LoggerConfiguration()
                    .MinimumLevel.Information()
                    .WriteTo.File(path, outputTemplate: "{Message:lj}{NewLine}")
                    .CreateLogger();

                return l;
            });
        }
    }
