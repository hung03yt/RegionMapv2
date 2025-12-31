using System;

namespace RegionMap.Services;
public class RegionNewMappingDto
{
    public string ProvinceName { get; set; } = default!;
    public string ProvinceCode { get; set; } = default!;
    public string WardName { get; set; } = default!;
    public string WardCode { get; set; } = default!;
    public int? IsAmbigious { get; set; }
}
