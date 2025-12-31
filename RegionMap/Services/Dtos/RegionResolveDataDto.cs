using System.Text.Json.Serialization;

namespace RegionMap.Services;

public class RegionResolveDataDto
{
    [JsonPropertyName("province_name")]
    public string? ProvinceName { get; set; }

    [JsonPropertyName("province_code")]
    public string? ProvinceCode { get; set; }

    [JsonPropertyName("ward_name")]
    public string? WardName { get; set; }

    [JsonPropertyName("ward_code")]
    public string? WardCode { get; set; }

    [JsonPropertyName("street_address")]
    public string? StreetAddress { get; set; }
}
