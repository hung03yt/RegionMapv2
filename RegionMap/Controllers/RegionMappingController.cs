using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Text.Json;
using System.IO;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using Dapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using RegionMap.Services;
using RegionMap.Data;
using RegionMap.Services.Logging;
using Volo.Abp.Auditing;
using YamlDotNet.Core.Tokens;

namespace RegionMap.Controllers;

[DisableAuditing]
[ApiController]
[Route("api/region-mapping")]
[AllowAnonymous]
[IgnoreAntiforgeryToken]
public class RegionMappingController : ControllerBase
{
    private readonly RegionMapDbContext _dbContext;
    private readonly ILogger<RegionMappingController> _logger;
    private readonly IJsonLineLogger _jsonLogger;

    public RegionMappingController(RegionMapDbContext dbContext, ILogger<RegionMappingController> logger, IJsonLineLogger jsonLogger)
    {
        _dbContext = dbContext;
        _logger = logger;
        _jsonLogger = jsonLogger;
    }

    [HttpPost("resolve")]
    public async Task<ActionResult<RegionResolveResultDto>> Resolve([FromBody] RegionOldMappingDto input)
    {
        try
        {
            if (input == null || string.IsNullOrWhiteSpace(input.ProvinceName))
            {
                return StatusCode(StatusCodes.Status200OK,
                    new RegionResolveResultDto
                    {
                        Status = false,
                        Code = "NOT_FOUND",
                        Message = "missing province",
                        Data = new RegionResolveDataDto
                        {
                            ProvinceName = null,
                            ProvinceCode = null,
                            WardName = null,
                            WardCode = null,
                            StreetAddress = null
                        }
                    });
            }

            int specialCase = CheckSpecialCase(input);


            var provinceNorm = Normalize(input.ProvinceName);
            var districtNorm = Normalize(input.DistrictName ?? string.Empty);
            var wardNorm = Normalize(input.WardName ?? string.Empty);
            
            using var connection = _dbContext.Database.GetDbConnection();
            if (connection.State == ConnectionState.Closed)
                await connection.OpenAsync();
            
            
            if (!string.IsNullOrWhiteSpace(wardNorm))
            {
                var wardIdValue = long.MinValue;
                if (specialCase == 0){
                    if (string.IsNullOrWhiteSpace(districtNorm))
                    {
                        var res = new RegionResolveResultDto
                        {
                            Status = false,
                            Code = "NOT_FOUND",
                            Message = "district missing",
                            Data = new RegionResolveDataDto { ProvinceName = null, WardName = null, StreetAddress = null }
                        };
                        await _jsonLogger.AppendJsonLineAsync(new { request = input, response = res }, "bad_responses.txt", includeTime: true, level: "ERROR");
                        return Ok(res);
                    }

                    // 1) province id (may return 0 or 1 ids for now)
                    var provIds = await GetUnitIdAsync(connection, provinceNorm, "PROVINCE", null);
                    if (provIds == null || provIds.Length == 0)
                    {
                        var res = new RegionResolveResultDto { Status = false, Code = "NOT_FOUND", Message = "unit NOT_FOUND", Data = new RegionResolveDataDto { ProvinceName = null, WardName = null, StreetAddress = null } };
                        await _jsonLogger.AppendJsonLineAsync(new { request = input, response = res }, "bad_responses.txt", includeTime: true, level: "ERROR");
                        return Ok(res);
                    }
                    var provId = provIds[0];

                    // 2) district id (must be child of province) — query using all province ids
                    var districtIds = await GetUnitIdAsync(connection, districtNorm, "DISTRICT", provIds);
                    if (districtIds == null || districtIds.Length == 0)
                    {
                        var res = new RegionResolveResultDto { Status = false, Code = "NOT_FOUND", Message = "unit NOT_FOUND", Data = new RegionResolveDataDto { ProvinceName = null, WardName = null, StreetAddress = null } };
                        await _jsonLogger.AppendJsonLineAsync(new { request = input, response = res }, "bad_responses.txt", includeTime: true, level: "ERROR");
                        return Ok(res);
                    }
                    var districtId = districtIds[0];

                    // 3) ward id (must be child of district) — query using all district ids
                    var wardIds = await GetUnitIdAsync(connection, wardNorm, "WARD", districtIds);
                    if (wardIds == null || wardIds.Length == 0)
                    {
                        var res = new RegionResolveResultDto { Status = false, Code = "NOT_FOUND", Message = "unit NOT_FOUND", Data = new RegionResolveDataDto { ProvinceName = null, WardName = null, StreetAddress = null } };
                        await _jsonLogger.AppendJsonLineAsync(new { request = input, response = res }, "bad_responses.txt", includeTime: true, level: "ERROR");
                        return Ok(res);
                    }
                    var wardId = wardIds[0];
                    wardIdValue = wardId;
                }
                var wardNewSql = @"
                    SELECT
                        p.province_name AS ProvinceName,
                        p.province_code AS ProvinceCode,
                        w.ward_name     AS WardName,
                        w.ward_code     AS WardCode,
                        wm.is_ambigious AS IsAmbigious
                    FROM dvhc_new_ward_mapping wm
                    JOIN dvhc_new_provinces p ON p.province_id = wm.province_new_id
                    JOIN dvhc_new_wards w ON w.ward_id = wm.ward_new_id
                    WHERE wm.ward_old_id = @WardOldId
                    LIMIT 1
                ";
                if (specialCase != 0)
                {
                    wardIdValue = specialCase;
                }
                var wardResult = await connection.QueryFirstOrDefaultAsync<RegionNewMappingDto>(wardNewSql, new { WardOldId = wardIdValue });

                if (wardResult == null)
                {
                    var res = new RegionResolveResultDto { Status = false, Code = "NOT_FOUND", Message = wardIdValue.ToString(), Data = new RegionResolveDataDto { ProvinceName = null, WardName = null, StreetAddress = null } };
                    await _jsonLogger.AppendJsonLineAsync(new { request = input, response = res }, "bad_responses.txt", includeTime: true, level: "ERROR");
                    return Ok(res);
                }

                var code = (wardResult.IsAmbigious.HasValue && wardResult.IsAmbigious.Value == 1) ? "AMBIGUOUS" : "FOUND";
                if (code == "AMBIGUOUS")
                {
                    return Ok(new RegionResolveResultDto
                    {
                        Status = true,
                        Code = code,
                        Message = "unit AMBIGUOUS",
                        Data = new RegionResolveDataDto
                        {
                            ProvinceName = wardResult.ProvinceName,
                            ProvinceCode = wardResult.ProvinceCode,
                            WardName = null,
                            WardCode = null,
                            StreetAddress = input.StreetAddress
                        }
                    });
                }

                return Ok(new RegionResolveResultDto
                {
                    Status = true,
                    Code = code,
                    Message = "unit FOUND",
                    Data = new RegionResolveDataDto
                    {
                        ProvinceName = wardResult.ProvinceName,
                        ProvinceCode = wardResult.ProvinceCode,
                        WardName = wardResult.WardName,
                        WardCode = wardResult.WardCode,
                        StreetAddress = input.StreetAddress
                    }
                });

                // New behavior: return all possible mappings (no LIMIT 1). Keep the old single-result logic commented above for recovery.
                // var wardNewSqlAll = @"
                //     SELECT
                //         p.province_name AS ProvinceName,
                //         p.province_code AS ProvinceCode,
                //         w.ward_name     AS WardName,
                //         w.ward_code     AS WardCode,
                //         wm.is_ambigious AS IsAmbigious
                //     FROM dvhc_new_ward_mapping wm
                //     JOIN dvhc_new_provinces p ON p.province_id = wm.province_new_id
                //     JOIN dvhc_new_wards w ON w.ward_id = wm.ward_new_id
                //     WHERE wm.ward_old_id = @WardOldId
                // ";
                // if (specialCase != 0)
                // {
                //     wardIdValue = specialCase;
                // }
                // var wardResults = (await connection.QueryAsync<RegionNewMappingDto>(wardNewSqlAll, new { WardOldId = wardIdValue })).ToList();

                // if (wardResults == null || wardResults.Count == 0)
                // {
                //     var res = new RegionResolveResultDto { Status = false, Code = "NOT_FOUND", Message = "unit NOT_FOUND", Data = new RegionResolveDataDto { ProvinceName = null, WardName = null, StreetAddress = null } };
                //     await _jsonLogger.AppendJsonLineAsync(new { request = input, response = res }, "bad_responses.txt", includeTime: true, level: "ERROR");
                //     return Ok(res);
                // }

                // // Map results to the response DTOs
                // var matches = wardResults.Select(w => new RegionResolveDataDto
                // {
                //     ProvinceName = w.ProvinceName,
                //     ProvinceCode = w.ProvinceCode,
                //     WardName = w.WardName,
                //     WardCode = w.WardCode,
                //     StreetAddress = input.StreetAddress
                // }).ToArray();

                // // If multiple, return them in the 'matches' field (added to RegionResolveResultDto). If only one, still include matches for consistency.
                // return Ok(new RegionResolveResultDto
                // {
                //     Status = true,
                //     Code = wardResults.Count > 1 ? "FOUND_MULTIPLE" : "FOUND",
                //     Message = wardResults.Count > 1 ? "multiple units FOUND" : "unit FOUND",
                //     Data = matches.FirstOrDefault(),
                //     // 'Matches' property added to RegionResolveResultDto to carry all candidates.
                //     Matches = matches
                // });
            }

            // empty ward -> province only flow
            var provinceOldIds = await GetUnitIdAsync(connection, provinceNorm, "PROVINCE", null);

            if (provinceOldIds == null || provinceOldIds.Length == 0)
            {
                return Ok(new RegionResolveResultDto
                {
                    Status = false,
                    Code = "NOT_FOUND",
                    Message = "unit NOT_FOUND",
                    Data = new RegionResolveDataDto
                    {
                        ProvinceName = null,
                        WardName = null,
                        StreetAddress = null
                    }
                });
            }
            var provinceOldId = provinceOldIds[0];

            var provinceNewSql = @"
                SELECT p.province_name AS ProvinceName, p.province_code AS ProvinceCode
                FROM dvhc_new_provinces_mapping pm
                JOIN dvhc_new_provinces p ON p.province_id = pm.province_new_id
                WHERE pm.province_old_id = @ProvinceOldId
                LIMIT 1
            ";

            var newProvince = await connection.QueryFirstOrDefaultAsync<RegionNewMappingDto>(provinceNewSql, new { ProvinceOldId = provinceOldId });

            if (newProvince == null)
            {
                return Ok(new RegionResolveResultDto
                {
                    Status = false,
                    Code = "NOT_FOUND",
                    Message = "unit NOT_FOUND",
                    Data = new RegionResolveDataDto
                    {
                        ProvinceName = null,
                        WardName = null,
                        StreetAddress = null
                    }
                });
            }

            return Ok(new RegionResolveResultDto
            {
                Status = true,
                Code = "FOUND",
                Message = "unit FOUND",
                Data = new RegionResolveDataDto
                {
                    ProvinceName = newProvince.ProvinceName,
                    ProvinceCode = newProvince.ProvinceCode,
                    WardName = null,
                    WardCode = null,
                    StreetAddress = input.StreetAddress
                }
            });
        }
        catch (Exception ex)
        {
            return Ok(new RegionResolveResultDto
            {
                Status = false,
                Code = "ERROR",
                Message = ex.Message,
                Data = new RegionResolveDataDto
                {
                    ProvinceName = null,
                    WardName = null,
                    StreetAddress = null
                }
            });
        }
    }

    private int CheckSpecialCase(RegionOldMappingDto input)
    {
        // block 1: Xã Tam Dân Huyện Phú Ninh, Tỉnh Quảng Nam
        if (input.WardName == "Xã Tam Dân" || input.WardName == "Tam Dân") {
            var districtNorm = Normalize(input.DistrictName ?? string.Empty);
            var provinceNorm = Normalize(input.ProvinceName);

            var districtCandidates = BuildCandidates(districtNorm);
            var provinceCandidates = BuildCandidates(provinceNorm);

            if (
                districtCandidates.Contains("phu ninh") &&
                provinceCandidates.Contains("quang nam")
            )
            {
                return 6971;
            }
        }

        //block 2: 5 đặc khu bạch long vĩ, cồn cỏ, hoàng sa, côn đảo, lý sơn
        {
            var districtNorm = Normalize(input.DistrictName ?? string.Empty);
            var provinceNorm = Normalize(input.ProvinceName);

            var districtCandidates = BuildCandidates(districtNorm);
            var provinceCandidates = BuildCandidates(provinceNorm);

            // case 1: Huyện Bạch Long Vĩ – TP Hải Phòng
            if (
                districtCandidates.Contains("bach long vi") &&
                provinceCandidates.Contains("hai phong")
            )
                return 10810;

            // case 2: Huyện Cồn Cỏ – Tỉnh Quảng Trị
            if (
                districtCandidates.Contains("con co") &&
                provinceCandidates.Contains("quang tri")
            )
                return 10812;

            // case 3: Huyện Hoàng Sa – TP Đà Nẵng
            if (
                districtCandidates.Contains("hoang sa") &&
                provinceCandidates.Contains("da nang")
            )
                return 10814;

            // case 4: Huyện Lý Sơn – Tỉnh Quảng Ngãi
            if (
                districtCandidates.Contains("ly son") &&
                provinceCandidates.Contains("quang ngai")
            )
                return 10818;

            // case 5: Huyện Côn Đảo – Tỉnh Bà Rịa - Vũng Tàu
            if (
                districtCandidates.Contains("con dao") &&
                provinceCandidates.Contains("ba ria - vung tau")
            )
                return 10816;
        }
        return 0;
    }

    [HttpGet("ping")]
    public Task<ActionResult<string>> Ping()
    {
        return Task.FromResult<ActionResult<string>>("pong");
    }

    private static string Normalize(string input)
    {
        if (string.IsNullOrWhiteSpace(input))
            return string.Empty;

        input = input.Trim().ToLowerInvariant();

        // Replace common Vietnamese-specific characters
        input = input
        .Replace('\u0111', 'd') // đ
        .Replace('\u0110', 'd') // Đ
        .Replace('\u00F0', 'd') // ð (eth)
        .Replace('\u00D0', 'd'); // Ð (eth)

        // Decompose and remove diacritics
        var normalized = input.Normalize(NormalizationForm.FormD);
        var sb = new StringBuilder();
        foreach (var ch in normalized)
        {
            var uc = CharUnicodeInfo.GetUnicodeCategory(ch);
            if (uc != UnicodeCategory.NonSpacingMark)
                sb.Append(ch);
        }

        var withoutDiacritics = sb.ToString().Normalize(NormalizationForm.FormC);

        // Remove punctuation and collapse whitespace
        withoutDiacritics = Regex.Replace(
            withoutDiacritics,
            @"[^0-9a-zA-Z\s\-'\u2019]",
            " "
        );
        withoutDiacritics = Regex.Replace(withoutDiacritics, "\\s+", " ").Trim();

        // Remove leading zeros from numbers
        withoutDiacritics = Regex.Replace(withoutDiacritics, @"\b0+(?=\d)", "");

        return withoutDiacritics;
    }

    private static async Task<long[]> GetUnitIdAsync(IDbConnection connection, string nameNorm, string level, long[]? parentIds)
    {
        if (string.IsNullOrWhiteSpace(nameNorm))
            return Array.Empty<long>();

        // lookup, no alias, normalized vs name_norm
        if (parentIds != null && parentIds.Length > 0)
        {
            var sqlWithParent = @"
                SELECT id FROM cores_units_old
                WHERE level::text = @Level AND parent_id = ANY(@ParentIds) AND name_norm = @Name AND is_deleted::text IN ('0','f','false')
                LIMIT 1
            ";
            var id = await connection.QueryFirstOrDefaultAsync<long?>(sqlWithParent, new { Level = level, ParentIds = parentIds, Name = nameNorm });
            if (id.HasValue) return new[] { id.Value };
        }
        else
        {
            var sqlNoParent = @"
                SELECT id FROM cores_units_old
                WHERE level::text = @Level AND name_norm = @Name AND is_deleted::text IN ('0','f','false')
                LIMIT 1
            ";
            var id = await connection.QueryFirstOrDefaultAsync<long?>(sqlNoParent, new { Level = level, Name = nameNorm });
            if (id.HasValue) return new[] { id.Value };
        }

        // lookup, no alias, normalized core vs name_core_norm
        var candidates = new List<string> { nameNorm };
        // common administrative prefixes in normalized form
        var prefixes = new[] { "quan", "huyen", "thi xa", "thi tran", "phuong", "xa" , "thanh pho", "tp", "tp.", "tinh" };
        foreach (var p in prefixes)
        {
            if (nameNorm.StartsWith(p + " ", StringComparison.Ordinal))
            {
                var trimmed = nameNorm.Substring(p.Length).Trim();
                if (!string.IsNullOrWhiteSpace(trimmed) && !candidates.Contains(trimmed))
                    candidates.Add(trimmed);
            }
        }

        if (parentIds != null && parentIds.Length > 0)
        {
            var sqlWithParent = @"
                SELECT id FROM cores_units_old
                WHERE level::text = @Level AND parent_id = ANY(@ParentIds) AND name_core_norm = @Name AND is_deleted::text IN ('0','f','false')
                LIMIT 1
            ";
            foreach (var candidate in candidates)
            {
                var id = await connection.QueryFirstOrDefaultAsync<long?>(sqlWithParent, new { Level = level, ParentIds = parentIds, Name = candidate });
                if (id.HasValue) return new[] { id.Value };
            }
        }
        else
        {
            var sqlNoParent = @"
                SELECT id FROM cores_units_old
                WHERE level::text = @Level AND name_core_norm = @Name AND is_deleted::text IN ('0','f','false')
                LIMIT 1
            ";
            foreach (var candidate in candidates)
            {
                var id = await connection.QueryFirstOrDefaultAsync<long?>(sqlNoParent, new { Level = level, Name = candidate });
                if (id.HasValue) return new[] { id.Value };
            }
        }

        //direct lookup failed, try alias
        // direct lookup failed, try alias
        if (parentIds != null && parentIds.Length > 0)
        {
            var aliasSqlWithParent = @"
                SELECT a.unit_id
                FROM cores_units_old_alias a
                JOIN cores_units_old u ON u.id = a.unit_id
                WHERE a.alias_norm = @Name
                AND a.is_active::text IN ('1','t','true')
                AND a.is_deleted::text IN ('0','f','false')
                AND u.parent_id = ANY(@ParentIds)
                AND u.is_deleted::text IN ('0','f','false')
                ORDER BY a.priority ASC
            ";

            foreach (var candidate in candidates)
            {
                var aliasIds = (await connection.QueryAsync<long>(
                    aliasSqlWithParent,
                    new { Name = candidate, ParentIds = parentIds, Level = level }
                )).ToArray();

                if (aliasIds != null && aliasIds.Length > 0)
                    return aliasIds;
            }
        }
        else
        {
            var aliasSqlNoParent = @"
                SELECT a.unit_id
                FROM cores_units_old_alias a
                JOIN cores_units_old u ON u.id = a.unit_id
                WHERE a.alias_norm = @Name
                AND u.level::text = @Level
                AND a.is_active::text IN ('1','t','true')
                AND a.is_deleted::text IN ('0','f','false')
                AND u.is_deleted::text IN ('0','f','false')
                ORDER BY a.priority ASC
            ";

            foreach (var candidate in candidates)
            {
                var aliasIds = (await connection.QueryAsync<long>(
                    aliasSqlNoParent,
                    new { Name = candidate, Level = level }
                )).ToArray();

                if (aliasIds != null && aliasIds.Length > 0)
                    return aliasIds;
            }
        }


        return Array.Empty<long>();
    }

    private static List<string> BuildCandidates(string nameNorm)
    {
        var candidates = new List<string> { nameNorm };

        var prefixes = new[]
        {
            "quan", "huyen", "thi xa", "thi tran",
            "phuong", "xa", "thanh pho", "tp", "tp.", "tinh"
        };

        foreach (var p in prefixes)
        {
            if (nameNorm.StartsWith(p + " ", StringComparison.Ordinal))
            {
                var trimmed = nameNorm.Substring(p.Length).Trim();
                if (!string.IsNullOrWhiteSpace(trimmed) && !candidates.Contains(trimmed))
                    candidates.Add(trimmed);
            }
        }

        return candidates;
    }

}
