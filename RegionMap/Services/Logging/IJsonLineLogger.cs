using System.Text.Json;
using System.Threading.Tasks;

namespace RegionMap.Services.Logging;

/// <summary>
/// Writes JSON objects as single-line entries to files. Implementations should be safe to call from multiple threads.
/// </summary>
public interface IJsonLineLogger
{
    Task AppendJsonLineAsync(object payload, string fileName = "logs.txt", bool includeTime = true, string level = "ERROR", JsonSerializerOptions? options = null);
}
