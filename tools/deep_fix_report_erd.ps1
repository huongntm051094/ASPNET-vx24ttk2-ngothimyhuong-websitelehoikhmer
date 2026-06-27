$ErrorActionPreference = "Stop"

$path = (Resolve-Path "DK24TTK2- bao cao_NguyenVanKhanh_KhmerFestival.doc").Path

$map = @{
    102 = "Bảng 1: Công nghệ sử dụng trong hệ thống`t3"
    103 = "Bảng 2: Cấu trúc bảng NguoiDung`t7"
    104 = "Bảng 3: Cấu trúc bảng DanhMuc`t8"
    105 = "Bảng 4: Cấu trúc bảng LeHoi`t8"
    106 = "Bảng 5: Cấu trúc bảng HinhAnh`t9"
    107 = "Bảng 6: Cấu trúc bảng BaiViet`t9"
    108 = "Bảng 7: Cấu trúc bảng BinhLuan`t9"

    207 = "Sơ đồ ERD thể hiện các bảng chính của hệ thống gồm NguoiDung, DanhMuc, LehHoi, HinhAnh, BaiViet, LehHoi_BaiViet, BinhLuan và ResetPasswordToken. Các bảng được liên kết bằng khóa ngoại để đảm bảo mỗi lễ hội thuộc đúng danh mục, mỗi hình ảnh thuộc đúng lễ hội, bài viết có thể liên kết với nhiều lễ hội và bình luận luôn gắn với đúng người dùng. Thiết kế này giúp dữ liệu văn hóa - lễ hội được tổ chức rõ ràng, dễ mở rộng và bảo đảm tính toàn vẹn dữ liệu."

    210 = "Bảng NguoiDung"
    211 = "Bảng 2: Cấu trúc bảng NguoiDung"
    215 = "Id"
    216 = "int, PK, Identity"
    217 = "Khóa chính tài khoản"
    218 = "HoTen"
    219 = "nvarchar(100)"
    220 = "Họ tên người dùng"
    221 = "Email"
    222 = "nvarchar(150), Unique"
    223 = "Email đăng nhập"
    224 = "MatKhau"
    225 = "nvarchar(256)"
    226 = "Mật khẩu đã băm"
    227 = "Salt"
    228 = "nvarchar(64)"
    229 = "Chuỗi salt ngẫu nhiên"
    230 = "VaiTro"
    231 = "nvarchar(20)"
    232 = "Vai trò tài khoản: Admin hoặc Member"
    233 = "TrangThai"
    234 = "nvarchar(20)"
    235 = "Trạng thái tài khoản: HoatDong hoặc Khoa"
    236 = "NgayTao"
    237 = "datetime"
    238 = "Thời điểm tạo tài khoản"
    239 = "Ghi chú"
    240 = "Navigation"
    241 = "Có quan hệ 1-N với bảng BinhLuan"
    242 = "Ràng buộc"
    243 = "Unique"
    244 = "Email không được trùng"

    245 = "Bảng DanhMuc"
    246 = "Bảng 3: Cấu trúc bảng DanhMuc"
    250 = "Id"
    251 = "int, PK, Identity"
    252 = "Khóa chính danh mục"
    253 = "TenDanhMuc"
    254 = "nvarchar(100)"
    255 = "Tên danh mục lễ hội"
    256 = "MoTa"
    257 = "nvarchar(500), null"
    258 = "Mô tả danh mục"
    259 = "LehHois"
    260 = "Navigation"
    261 = "Danh sách lễ hội thuộc danh mục"
    262 = "Ràng buộc"
    263 = "Required"
    264 = "Tên danh mục là bắt buộc"
    265 = "Quan hệ"
    266 = "1-N"
    267 = "Một danh mục có nhiều lễ hội"
    268 = "Ghi chú"
    269 = "Dùng cho bộ lọc"
    270 = "Hỗ trợ nhóm lễ hội trên website"

    271 = "Bảng LehHoi"
    272 = "Bảng 4: Cấu trúc bảng LehHoi"
    276 = "Id"
    277 = "int, PK, Identity"
    278 = "Khóa chính lễ hội"
    279 = "DanhMucId"
    280 = "int, FK"
    281 = "Danh mục của lễ hội"
    282 = "TenLehHoi"
    283 = "nvarchar(200)"
    284 = "Tên lễ hội"
    285 = "TomTat"
    286 = "nvarchar(500), null"
    287 = "Tóm tắt ngắn"
    288 = "MoTa"
    289 = "nvarchar(max), null"
    290 = "Mô tả chi tiết"
    291 = "YNghiaVanHoa"
    292 = "nvarchar(max), null"
    293 = "Ý nghĩa văn hóa"
    294 = "NgayBatDau"
    295 = "datetime, null"
    296 = "Ngày bắt đầu lễ hội"
    297 = "NgayKetThuc"
    298 = "datetime, null"
    299 = "Ngày kết thúc lễ hội"

    300 = "Bảng HinhAnh"
    301 = "Bảng 5: Cấu trúc bảng HinhAnh"
    305 = "Id"
    306 = "int, PK, Identity"
    307 = "Khóa chính hình ảnh"
    308 = "LehHoiId"
    309 = "int, FK"
    310 = "Lễ hội sở hữu hình ảnh"
    311 = "DuongDan"
    312 = "nvarchar(500)"
    313 = "Đường dẫn ảnh"
    314 = "MoTa"
    315 = "nvarchar(200), null"
    316 = "Mô tả ảnh"
    317 = "LaDaiDien"
    318 = "bit"
    319 = "Đánh dấu ảnh đại diện"
    320 = "NgayTao"
    321 = "datetime"
    322 = "Thời điểm tạo"

    323 = "Bảng BaiViet"
    324 = "Bảng 6: Cấu trúc bảng BaiViet"
    325 = "Cột"
    326 = "Kiểu dữ liệu"
    327 = "Mô tả"
    328 = "Id"
    329 = "int, PK, Identity"
    330 = "Khóa chính bài viết"
    331 = "TieuDe"
    332 = "nvarchar(300)"
    333 = "Tiêu đề bài viết"
    334 = "TomTat"
    335 = "nvarchar(500), null"
    336 = "Tóm tắt bài viết"
    337 = "NoiDung"
    338 = "nvarchar(max), null"
    339 = "Nội dung bài viết"

    340 = "Bảng BinhLuan"
    341 = "Bảng 7: Cấu trúc bảng BinhLuan"
    342 = "Cột"
    343 = "Kiểu dữ liệu"
    344 = "Mô tả"
    345 = "Id"
    346 = "int, PK, Identity"
    347 = "Khóa chính bình luận"
    348 = "NguoiDungId"
    349 = "int, FK"
    350 = "Người gửi bình luận"
    351 = "LehHoiId"
    352 = "int, FK, null"
    353 = "Lễ hội được bình luận"
    354 = "BaiVietId"
    355 = "int, FK, null"
    356 = "Bài viết được bình luận"
    357 = "NoiDung"
    358 = "nvarchar(500)"
    359 = "Nội dung bình luận"
    360 = "TrangThai"
    361 = "nvarchar(20)"
    362 = "ChoDuyet, DaDuyet hoặc TuChoi"
    363 = "NgayTao"
    364 = "datetime"
    365 = "Thời điểm gửi bình luận"
    366 = "Ghi chú"
    367 = "Nullable FK"
    368 = "Bình luận gắn với lễ hội hoặc bài viết"

    370 = "Mô tả các mối quan hệ (Relationships)"
    371 = "• NguoiDung - BinhLuan là quan hệ 1-N; mỗi người dùng có thể gửi nhiều bình luận."
    372 = "• DanhMuc - LehHoi là quan hệ 1-N; mỗi danh mục có thể chứa nhiều lễ hội."
    373 = "• LehHoi - HinhAnh là quan hệ 1-N; mỗi lễ hội có thể có nhiều hình ảnh."
    374 = "• LehHoi - BaiViet là quan hệ N-N thông qua bảng LehHoi_BaiViet."
    375 = "• BinhLuan liên kết tùy chọn với LehHoi hoặc BaiViet để hỗ trợ bình luận trên cả hai loại nội dung."
    376 = "Luồng nghiệp vụ chính"
    377 = "Luồng đăng ký và đăng nhập"
    378 = "Khi đăng ký, hệ thống kiểm tra ModelState và email trùng. Mật khẩu được băm bằng SHA256 kết hợp salt trước khi lưu. Sau khi tạo NguoiDung, tài khoản mặc định có vai trò Member và trạng thái HoatDong."
    379 = "Khi đăng nhập, hệ thống tìm tài khoản theo email, kiểm tra trạng thái và xác minh mật khẩu bằng salt đã lưu. Đăng nhập thành công tạo FormsAuthentication cookie và điều hướng người dùng theo vai trò."
    380 = "Luồng quản lý lễ hội"
    381 = "Quản trị viên tạo hoặc cập nhật lễ hội bằng biểu mẫu trong khu vực Admin. Controller kiểm tra dữ liệu bắt buộc, kiểm tra ngày bắt đầu - ngày kết thúc, lưu ảnh đại diện nếu có và ghi nhận người tạo lễ hội. Các lễ hội bị xóa mềm bằng cờ IsDeleted để tránh mất dữ liệu."
    382 = "Khi quản lý hình ảnh, quản trị viên có thể tải thêm ảnh cho từng lễ hội, đặt ảnh đại diện hoặc xóa ảnh phụ. Nếu ảnh đại diện thay đổi, trường AnhDaiDien của lễ hội được cập nhật để trang công khai hiển thị đúng hình chính."
    383 = "Luồng xem trang chủ, tìm kiếm và quản trị"
    384 = "Trang chủ truy vấn các lễ hội sắp diễn ra, bài viết mới và danh mục để hiển thị cho người dùng. Chức năng tìm kiếm trả về các lễ hội và bài viết có tiêu đề phù hợp với từ khóa."
    385 = "Trang quản trị tổng hợp số lượng lễ hội, bài viết, bình luận chờ duyệt, bình luận mới và lễ hội sắp diễn ra. Mọi thao tác trong Admin đều yêu cầu tài khoản có vai trò Admin."
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
                    if ($range.End -gt $range.Start) {
                        $range.End = $range.End - 1
                    }
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

"Deep fixed ERD/schema content in $path"
