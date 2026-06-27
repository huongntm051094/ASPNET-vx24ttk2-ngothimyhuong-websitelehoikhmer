$ErrorActionPreference = "Stop"

$path = (Resolve-Path "DK24TTK2- bao cao_NguyenVanKhanh_KhmerFestival.doc").Path

$map = @{
    207 = "Sơ đồ ERD thể hiện các bảng chính của hệ thống gồm NguoiDung, DanhMuc, LehHoi, HinhAnh, BaiViet, LehHoi_BaiViet, BinhLuan và ResetPasswordToken. Các bảng được liên kết bằng khóa ngoại để đảm bảo mỗi lễ hội thuộc đúng danh mục, mỗi hình ảnh thuộc đúng lễ hội, bài viết có thể liên kết với nhiều lễ hội và bình luận luôn gắn với đúng người dùng. Thiết kế này giúp dữ liệu văn hóa - lễ hội được tổ chức rõ ràng, dễ mở rộng và bảo đảm tính toàn vẹn dữ liệu."

    208 = "Bảng NguoiDung"
    209 = "Bảng 2: Cấu trúc bảng NguoiDung"
    210 = "Cột"; 211 = "Kiểu dữ liệu"; 212 = "Mô tả"
    213 = "Id"; 214 = "int, PK, Identity"; 215 = "Khóa chính tài khoản"
    216 = "HoTen"; 217 = "nvarchar(100)"; 218 = "Họ tên người dùng"
    219 = "Email"; 220 = "nvarchar(150), Unique"; 221 = "Email đăng nhập"
    222 = "MatKhau"; 223 = "nvarchar(256)"; 224 = "Mật khẩu đã băm"
    225 = "Salt"; 226 = "nvarchar(64)"; 227 = "Chuỗi salt ngẫu nhiên"
    228 = "VaiTro"; 229 = "nvarchar(20)"; 230 = "Vai trò tài khoản: Admin hoặc Member"
    231 = "TrangThai"; 232 = "nvarchar(20)"; 233 = "Trạng thái tài khoản: HoatDong hoặc Khoa"
    234 = "NgayTao"; 235 = "datetime"; 236 = "Thời điểm tạo tài khoản"

    237 = "Bảng DanhMuc"
    238 = "Bảng 3: Cấu trúc bảng DanhMuc"
    239 = "Cột"; 240 = "Kiểu dữ liệu"; 241 = "Mô tả"
    242 = "Id"; 243 = "int, PK, Identity"; 244 = "Khóa chính danh mục"
    245 = "TenDanhMuc"; 246 = "nvarchar(100)"; 247 = "Tên danh mục lễ hội"
    248 = "MoTa"; 249 = "nvarchar(500), null"; 250 = "Mô tả danh mục"
    251 = "LehHois"; 252 = "Navigation"; 253 = "Danh sách lễ hội thuộc danh mục"

    254 = "Bảng LehHoi"
    255 = "Bảng 4: Cấu trúc bảng LehHoi"
    256 = "Cột"; 257 = "Kiểu dữ liệu"; 258 = "Mô tả"
    259 = "Id"; 260 = "int, PK, Identity"; 261 = "Khóa chính lễ hội"
    262 = "DanhMucId"; 263 = "int, FK"; 264 = "Danh mục của lễ hội"
    265 = "TenLehHoi"; 266 = "nvarchar(200)"; 267 = "Tên lễ hội"
    268 = "TomTat"; 269 = "nvarchar(500), null"; 270 = "Tóm tắt ngắn"
    271 = "MoTa"; 272 = "nvarchar(max), null"; 273 = "Mô tả chi tiết"
    274 = "YNghiaVanHoa"; 275 = "nvarchar(max), null"; 276 = "Ý nghĩa văn hóa"
    277 = "NgayBatDau"; 278 = "datetime, null"; 279 = "Ngày bắt đầu lễ hội"
    280 = "NgayKetThuc"; 281 = "datetime, null"; 282 = "Ngày kết thúc lễ hội"
    283 = "DiaDiem"; 284 = "nvarchar(200), null"; 285 = "Địa điểm tổ chức"
    286 = "TinhThanh"; 287 = "nvarchar(100), null"; 288 = "Tỉnh/thành"
    289 = "AnhDaiDien"; 290 = "nvarchar(500), null"; 291 = "Đường dẫn ảnh đại diện"
    292 = "IsDeleted"; 293 = "bit"; 294 = "Cờ xóa mềm"
    295 = "NgayTao"; 296 = "datetime"; 297 = "Thời điểm tạo"
    298 = "NguoiTaoId"; 299 = "int, FK, null"; 300 = "Người tạo lễ hội"

    301 = "Bảng HinhAnh"
    302 = "Bảng 5: Cấu trúc bảng HinhAnh"
    303 = "Cột"; 304 = "Kiểu dữ liệu"; 305 = "Mô tả"
    306 = "Id"; 307 = "int, PK, Identity"; 308 = "Khóa chính hình ảnh"
    309 = "LehHoiId"; 310 = "int, FK"; 311 = "Lễ hội sở hữu hình ảnh"
    312 = "DuongDan"; 313 = "nvarchar(500)"; 314 = "Đường dẫn ảnh"
    315 = "MoTa"; 316 = "nvarchar(200), null"; 317 = "Mô tả ảnh"
    318 = "LaDaiDien"; 319 = "bit"; 320 = "Đánh dấu ảnh đại diện"
    321 = "NgayTao"; 322 = "datetime"; 323 = "Thời điểm tạo"

    324 = "Bảng BaiViet"
    325 = "Bảng 6: Cấu trúc bảng BaiViet"
    326 = "Cột"; 327 = "Kiểu dữ liệu"; 328 = "Mô tả"
    329 = "Id"; 330 = "int, PK, Identity"; 331 = "Khóa chính bài viết"
    332 = "TieuDe"; 333 = "nvarchar(300)"; 334 = "Tiêu đề bài viết"
    335 = "TomTat"; 336 = "nvarchar(500), null"; 337 = "Tóm tắt bài viết"
    338 = "NoiDung"; 339 = "nvarchar(max), null"; 340 = "Nội dung bài viết"
    341 = "AnhDaiDien"; 342 = "nvarchar(500), null"; 343 = "Đường dẫn ảnh đại diện"
    344 = "NguoiTaoId"; 345 = "int, FK, null"; 346 = "Người tạo bài viết"
    347 = "IsDeleted"; 348 = "bit"; 349 = "Cờ xóa mềm"
    350 = "NgayTao"; 351 = "datetime"; 352 = "Thời điểm tạo"

    353 = "Bảng BinhLuan"
    354 = "Bảng 7: Cấu trúc bảng BinhLuan"
    355 = "Cột"; 356 = "Kiểu dữ liệu"; 357 = "Mô tả"
    358 = "Id"; 359 = "int, PK, Identity"; 360 = "Khóa chính bình luận"
    361 = "NguoiDungId"; 362 = "int, FK"; 363 = "Người gửi bình luận"
    364 = "LehHoiId"; 365 = "int, FK, null"; 366 = "Lễ hội được bình luận"
    367 = "BaiVietId"; 368 = "int, FK, null"; 369 = "Bài viết được bình luận"
    370 = "NoiDung"; 371 = "nvarchar(500)"; 372 = "Nội dung bình luận"
    373 = "TrangThai"; 374 = "nvarchar(20)"; 375 = "ChoDuyet, DaDuyet hoặc TuChoi"
    376 = "NgayTao"; 377 = "datetime"; 378 = "Thời điểm gửi bình luận"

    379 = "Mô tả các mối quan hệ (Relationships)"
    380 = "• NguoiDung - BinhLuan là quan hệ 1-N; mỗi người dùng có thể gửi nhiều bình luận."
    381 = "• DanhMuc - LehHoi là quan hệ 1-N; mỗi danh mục có thể chứa nhiều lễ hội."
    382 = "• LehHoi - HinhAnh là quan hệ 1-N; mỗi lễ hội có thể có nhiều hình ảnh."
    383 = "• LehHoi - BaiViet là quan hệ N-N thông qua bảng LehHoi_BaiViet."
    384 = "• BinhLuan liên kết tùy chọn với LehHoi hoặc BaiViet để hỗ trợ bình luận trên cả hai loại nội dung."
    385 = "• ResetPasswordToken liên kết NguoiDung theo quan hệ N-1, phục vụ chức năng khôi phục mật khẩu đơn giản."
}

$word = New-Object -ComObject Word.Application
$word.Visible = $false
$word.DisplayAlerts = 0
$doc = $word.Documents.Open($path, $false, $false)

try {
    $visibleIndex = 0
    foreach ($paragraph in $doc.Paragraphs) {
        $text = ($paragraph.Range.Text -replace "`r|`a", "").Trim()
        if ($text.Length -gt 0) {
            $visibleIndex++
            if ($map.ContainsKey($visibleIndex)) {
                try {
                    $range = $paragraph.Range
                    if ($range.End -gt $range.Start) { $range.End = $range.End - 1 }
                    $range.Text = $map[$visibleIndex]
                }
                catch {
                    Write-Output "Skipped locked paragraph ${visibleIndex}: $($_.Exception.Message)"
                }
            }
        }
    }
    $doc.Save()
}
finally {
    $doc.Close($false)
    $word.Quit()
}

"Cleaned current ERD region in $path"
