Dự án này là dịch vụ "Region Mapping" (dịch tên địa phương cũ sang mô hình địa phương mới) được xây trên nền tảng ABP Framework (template ABP Microservice).

## Mô tả

Dịch vụ cung cấp API để chuyển tên địa phương/địa điểm từ hệ thống cũ sang tên/địa chỉ chuẩn của hệ thống mới. Ứng dụng sử dụng EF Core (Postgres) cho kết nối DB và Dapper cho các truy vấn thô cần tối ưu.

## Yêu cầu

- .NET SDK 10.x (phiên bản .NET 10 được dùng trong repo này)
- PostgreSQL (để chạy tích hợp cục bộ nếu cần)
- nodejs
- Abp CLI (nếu chưa có, di chuyển đến root của project và sử dụng lệnh dotnet tool install -g Volo.Abp.Cli )

## Database

- Chuỗi kết nối database chính được định nghĩa trong `RegionMap/appsettings.json`:

```
"ConnectionStrings": {
  "Default": "Host=localhost;Port=5432;Database=RegionMap;User ID=postgres;Password=password;",
  "RegionMappingService": "Host=localhost;Port=5432;Database=dvhc_region_map;User ID=postgres;Password=password;Timeout=240;"
}
```

- File `sql/dvhc_dump.sql` (nếu có trong repo) chứa thông tin để import dữ liệu vào PostgreSQL (database import sẽ là postgres theo nội dung hiện tại).
- File `sql/regionmap_dump.sql` chứa thông tin abp của project.

- Cách import:
Trong pgadmin4, chuột phải vào Servers/PostgreSQL xx/Database, chọn Create Database
Chọn tên database là RegionMap với regionmap_dump.sql và dvhc_region_map với dvhc_dump.sql
Chuột phải vào database mới, chọn restore
Ở Format, chọn Plain
Ở Filename, nhấn để tìm file, chuyển định dạng tìm kiếm sang .sql
Chọn file .sql tương ứng
Nhấn Restore

## Cài đặt
Mở `pwsh` tại thư mục gốc của repository rồi chạy:
abp install-libs

Cài đặt các database đã nhắc đến ở trên

## Các lệnh cơ bản (PowerShell)

Mở `pwsh` tại thư mục gốc của repository rồi chạy:

```powershell
# Build solution
dotnet build .\RegionMap.sln -c Debug
# Run the service
dotnet run --project .\RegionMap\RegionMap.csproj -c Debug
```

## Lưu ý
Trong trường hợp có lỗi xảy ra do lỗi tin cậy chứng chỉ:
dotnet dev-certs https --trust --verbose

Nếu không được, thử:
dotnet dev-certs https --clean
dotnet dev-certs https --trust
*Phương pháp 2 này sẽ loại bỏ toàn bộ chứng chỉ dev trên thiết bị nên ưu tiên sử dụng phương pháp 1 trước*

## Endpoint chính

- POST `/api/region-mapping/resolve` — nhập JSON chứa các trường (snake_case)

Input mẫu (`RegionOldMappingDto`):

```json
{
  "province_name": "Thành phố Hà Nội",
  "district_name": "Quận Ba Đình",
  "ward_name": "Phường Trúc Bạch",
  "street_address": "Số 1, Phố X"
}
```

Response mẫu:

```json
{
    "status": true,
    "code": "FOUND",
    "message": "unit FOUND",
    "data": {
        "province_name": "Thành phố Hà Nội",
        "province_code": "01",
        "ward_name": "Phường Ba Đình",
        "ward_code": "00004",
        "street_address": "Số 1, Phố X"
    }
}
```