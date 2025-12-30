Dự án này là dịch vụ "Region Mapping" (dịch tên địa phương cũ sang mô hình địa phương mới) được xây trên nền tảng ABP Framework (template ABP Microservice).

## Mô tả

Dịch vụ cung cấp API để chuyển tên địa phương/địa điểm từ hệ thống cũ sang tên/địa chỉ chuẩn của hệ thống mới. Ứng dụng sử dụng EF Core (Postgres) cho kết nối DB và Dapper cho các truy vấn thô cần tối ưu.

## Yêu cầu

- .NET SDK 10.x (phiên bản .NET 10 được dùng trong repo này)
- PostgreSQL (để chạy tích hợp cục bộ nếu cần)
- (Tùy chọn) Redis, RabbitMQ, Prometheus, Elasticsearch — có thể tắt để chạy local. Các flag cấu hình liên quan nằm trong `appsettings.json`.

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

## Các lệnh cơ bản (PowerShell)

Mở `pwsh` tại thư mục gốc của repository rồi chạy:

```powershell
# Build solution
dotnet build .\RegionMap.sln -c Debug
# Run the service
dotnet run --project .\RegionMap\RegionMap.csproj -c Debug
```

## Endpoint chính

- POST `/api/app/region-mapping/resolve` — nhập JSON chứa các trường (snake_case)

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
  "message": "Code_FOUND",
  "data": {
    "province_name": "Hà Nội",
    "ward_name": "Phúc Xá",
    "street_address": "Số 1, Phố X"
  }
}
```