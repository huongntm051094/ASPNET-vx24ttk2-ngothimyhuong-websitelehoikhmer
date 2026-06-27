$ErrorActionPreference = "Stop"

$docPath = (Resolve-Path "DK24TTK2- bao cao_NguyenVanKhanh.doc").Path
$backupPath = Join-Path (Split-Path $docPath) "DK24TTK2- bao cao_NguyenVanKhanh.before-khmer-edit.doc"
if (-not (Test-Path $backupPath)) {
    Copy-Item -LiteralPath $docPath -Destination $backupPath -Force
}

$word = New-Object -ComObject Word.Application
$word.Visible = $false
$word.DisplayAlerts = 0

function Replace-All($doc, [string]$find, [string]$replace) {
    return
    $range = $doc.Content
    $findObj = $range.Find
    $findObj.ClearFormatting() | Out-Null
    $findObj.Replacement.ClearFormatting() | Out-Null
    $findObj.Text = $find
    $findObj.Replacement.Text = $replace
    $findObj.Forward = $true
    $findObj.Wrap = 1
    $findObj.Format = $false
    $findObj.MatchCase = $false
    $findObj.MatchWholeWord = $false
    $findObj.MatchWildcards = $false
    $findObj.Execute($find, $false, $false, $false, $false, $false, $true, 1, $false, $replace, 2) | Out-Null
}

function Set-ParagraphTextByIndex($doc, [hashtable]$map) {
    $visible = 0
    foreach ($p in $doc.Paragraphs) {
        $text = ($p.Range.Text -replace "`r|`a", "").Trim()
        if ($text.Length -gt 0) {
            $visible++
            if ($map.ContainsKey($visible)) {
                $range = $p.Range
                $range.End = $range.End - 1
                try {
                    $range.Text = $map[$visible]
                } catch {
                    Write-Host "Skip paragraph index ${visible}: $($_.Exception.Message)"
                }
            }
        }
    }
}

$doc = $word.Documents.Open($docPath, $false, $false)

$global = @(
    @("QUẢN LÝ CHI TIÊU CÁ NHÂN", "GIỚI THIỆU LỄ HỘI KHMER"),
    @("Đồ án xây dựng website quản lý chi tiêu cá nhân", "Đồ án xây dựng website giới thiệu lễ hội truyền thống của người Khmer"),
    @("website quản lý chi tiêu cá nhân", "website giới thiệu lễ hội Khmer"),
    @("Website quản lý chi tiêu cá nhân", "Website giới thiệu lễ hội Khmer"),
    @("hệ thống quản lý chi tiêu cá nhân", "hệ thống giới thiệu lễ hội Khmer"),
    @("Hệ thống quản lý chi tiêu cá nhân", "Hệ thống giới thiệu lễ hội Khmer"),
    @("quản lý chi tiêu cá nhân", "giới thiệu lễ hội Khmer"),
    @("Quản lý chi tiêu cá nhân", "Giới thiệu lễ hội Khmer"),
    @("Bootstrap 4", "Bootstrap 5"),
    @("Chart.js", "Bootstrap 5"),
    @("BCrypt", "SHA256 kết hợp Salt"),
    @("BCrypt.Net-Next", "SHA256 kết hợp Salt"),
    @("cost factor 12", "salt ngẫu nhiên"),
    @("Users", "NguoiDung"),
    @("Categories", "DanhMuc"),
    @("Wallets", "LehHoi"),
    @("Transactions", "BaiViet"),
    @("Budgets", "BinhLuan"),
    @("AppDbContext", "KhmerFestivalContext"),
    @("Bootstrap 4 Documentation", "Bootstrap 5 Documentation")
)
foreach ($pair in $global) { Replace-All $doc $pair[0] $pair[1] }

$paragraphMap = @{
    7 = "GIỚI THIỆU LỄ HỘI KHMER"
    17 = "Sau thời gian học tập và hoàn thành báo cáo môn Chuyên đề ASP.NET, tôi xin được bày tỏ lòng biết ơn chân thành đến thầy Đoàn Phước Miền đã tận tình giảng dạy và hướng dẫn tôi trong suốt quá trình học tập, nghiên cứu và xây dựng website giới thiệu lễ hội Khmer."
    18 = "Nhờ những kiến thức và kinh nghiệm thực tiễn mà thầy truyền đạt, tôi đã có cơ hội tiếp cận với các công nghệ lập trình web trên nền tảng ASP.NET MVC 5, hiểu rõ hơn quy trình xây dựng một ứng dụng web từ thiết kế giao diện, xử lý nghiệp vụ, xác thực người dùng đến quản trị nội dung và lưu trữ dữ liệu bằng SQL Server."
    19 = "Trong quá trình thực hiện báo cáo, tôi đã gặp nhiều khó khăn khi phân tích yêu cầu, thiết kế cơ sở dữ liệu, tổ chức khu vực quản trị và xử lý các chức năng như tìm kiếm, bình luận, upload hình ảnh lễ hội. Tuy nhiên, với sự hướng dẫn tận tâm và các góp ý của thầy, tôi đã từng bước hoàn thiện hệ thống."
    20 = "Môn học giúp tôi nâng cao kỹ năng lập trình C#, ASP.NET MVC 5, Entity Framework 6, Razor View, Bootstrap 5 và các kỹ thuật bảo mật web cơ bản. Đây là nền tảng quan trọng để tôi tiếp tục phát triển các dự án web thực tế trong tương lai."
    29 = "CHƯƠNG 1: NGHIÊN CỨU LÝ THUYẾT`t2"
    34 = "1.5. Bootstrap 5, jQuery và TinyMCE`t3"
    36 = "2.1. Mô tả bài toán`t4"
    41 = "2.3.1. Bảng NguoiDung`t7"
    42 = "2.3.2. Bảng DanhMuc`t8"
    43 = "2.3.3. Bảng LehHoi`t8"
    44 = "2.3.4. Bảng BaiViet`t9"
    45 = "2.3.5. Bảng BinhLuan`t9"
    49 = "2.5.2. Luồng quản lý lễ hội`t10"
    50 = "2.5.3. Luồng xem chi tiết, tìm kiếm và bình luận`t10"
    58 = "3.4. Màn hình trang chủ`t19"
    59 = "3.5. Màn hình danh sách lễ hội`t20"
    60 = "3.6. Màn hình chi tiết lễ hội`t20"
    61 = "3.7. Màn hình bài viết`t21"
    62 = "3.8. Màn hình quản lý danh mục lễ hội`t22"
    63 = "3.9. Màn hình thêm danh mục`t23"
    64 = "3.10. Màn hình sửa danh mục`t24"
    65 = "3.11. Màn hình quản lý lễ hội`t24"
    66 = "3.12. Màn hình thêm lễ hội`t25"
    67 = "3.13. Màn hình sửa lễ hội`t26"
    68 = "3.14. Màn hình quản lý bài viết`t26"
    69 = "3.15. Màn hình thêm bài viết`t27"
    70 = "3.16. Màn hình sửa bài viết`t28"
    71 = "3.17. Màn hình quản lý bình luận`t29"
    72 = "3.18. Màn hình đổi mật khẩu`t30"
    79 = "Hình 1. Sơ đồ ngữ cảnh website giới thiệu lễ hội Khmer`t4"
    80 = "Hình 2. Sơ đồ ERD cơ sở dữ liệu`t7"
    86 = "Hình 8. Giao diện trang chủ`t19"
    87 = "Hình 9. Giao diện danh sách lễ hội`t20"
    88 = "Hình 10. Giao diện chi tiết lễ hội`t20"
    89 = "Hình 11. Giao diện bài viết`t21"
    90 = "Hình 12. Giao diện danh mục`t22"
    93 = "Hình 15. Giao diện quản lý lễ hội`t24"
    94 = "Hình 16. Giao diện thêm lễ hội`t25"
    95 = "Hình 17. Giao diện sửa lễ hội`t26"
    96 = "Hình 18. Giao diện quản lý bài viết`t26"
    97 = "Hình 19. Giao diện thêm bài viết`t27"
    98 = "Hình 20. Giao diện sửa bài viết`t28"
    99 = "Hình 21. Giao diện quản lý bình luận`t29"
    102 = "Bảng 1: Công nghệ sử dụng trong hệ thống`t3"
    103 = "Bảng 2: Cấu trúc bảng NguoiDung`t7"
    104 = "Bảng 3: Cấu trúc bảng DanhMuc`t8"
    105 = "Bảng 4: Cấu trúc bảng LehHoi`t8"
    106 = "Bảng 5: Cấu trúc bảng BaiViet`t9"
    107 = "Bảng 6: Cấu trúc bảng BinhLuan`t9"
    110 = "Đồ án xây dựng website giới thiệu lễ hội truyền thống của người Khmer tại Việt Nam. Hệ thống phục vụ hai nhóm người dùng chính: khách truy cập có thể xem thông tin lễ hội, bài viết, tìm kiếm và bình luận; quản trị viên có thể quản lý danh mục, lễ hội, bài viết, hình ảnh, bình luận và tài khoản."
    111 = "Hệ thống được phát triển bằng ASP.NET MVC 5 trên .NET Framework, sử dụng Razor View, Bootstrap 5, jQuery và TinyMCE cho giao diện. Dữ liệu được lưu trữ trên Microsoft SQL Server và truy cập thông qua Entity Framework 6."
    112 = "Cơ chế xác thực dùng FormsAuthentication; mật khẩu được băm bằng SHA256 kết hợp Salt. Các thao tác POST áp dụng Anti-Forgery Token, phân quyền khu vực Admin bằng Authorize(Roles = `"Admin`"), đồng thời các chức năng upload ảnh kiểm tra định dạng và dung lượng."
    113 = "Kết quả của đồ án là một website có đầy đủ các chức năng cốt lõi: trang chủ giới thiệu lễ hội nổi bật, danh sách và chi tiết lễ hội, blog bài viết, tìm kiếm, bình luận chờ duyệt, đăng ký đăng nhập, hồ sơ cá nhân và khu vực quản trị nội dung."
    116 = "Văn hóa Khmer Nam Bộ có nhiều lễ hội đặc sắc như Chol Chnam Thmay, Ok Om Bok, lễ Dâng y Kathina, lễ hội đua ghe Ngo và lễ Đom Lơng Néak Tà. Tuy nhiên, thông tin về các lễ hội thường phân tán ở nhiều nguồn, khó tra cứu tập trung theo tên, thời gian, địa điểm hoặc danh mục."
    117 = "Một website giới thiệu lễ hội Khmer giúp hệ thống hóa thông tin văn hóa, hình ảnh, bài viết liên quan và tạo kênh tham khảo thuận tiện cho người học, khách du lịch và cộng đồng quan tâm. Đây cũng là bài toán phù hợp để vận dụng kiến thức ASP.NET MVC, Entity Framework, SQL Server, xác thực người dùng, upload hình ảnh và thiết kế giao diện responsive."
    119 = "• Xây dựng website cho phép khách truy cập xem danh sách, chi tiết lễ hội và bài viết liên quan."
    120 = "• Hỗ trợ tìm kiếm lễ hội theo tên, lọc theo danh mục, tỉnh/thành và năm tổ chức."
    121 = "• Cung cấp chức năng đăng ký, đăng nhập, đổi mật khẩu và đặt lại mật khẩu đơn giản."
    122 = "• Cho phép thành viên gửi bình luận cho lễ hội hoặc bài viết; bình luận được quản trị viên duyệt trước khi hiển thị."
    123 = "• Xây dựng khu vực Admin để quản lý danh mục, lễ hội, bài viết, hình ảnh, bình luận và tài khoản."
    124 = "• Bảo vệ dữ liệu bằng phân quyền, Anti-Forgery Token, Entity Framework và kiểm tra upload ảnh."
    126 = "Đối tượng sử dụng gồm khách truy cập, thành viên và quản trị viên. Phạm vi đồ án tập trung vào website tiếng Việt giới thiệu lễ hội Khmer tại Việt Nam; không triển khai thanh toán, đặt vé sự kiện, ứng dụng mobile native hoặc đa ngôn ngữ."
    128 = "Đề tài được thực hiện theo các bước: đọc và phân tích PRD; thiết kế mô hình dữ liệu; xây dựng dự án ASP.NET MVC 5; hiện thực các module public, tài khoản và admin; tạo dữ liệu mẫu lễ hội Khmer; kiểm thử các luồng đăng nhập, quản trị, tìm kiếm, bình luận và hiển thị hình ảnh."
    133 = "Trong dự án, các Controller được chia theo module Home, LehHoi, BaiViet, Search, Contact, Account và khu vực Admin gồm Dashboard, DanhMuc, LehHoi, BaiViet, BinhLuan, TaiKhoan. Cách tổ chức này giúp mã nguồn dễ đọc, dễ bảo trì và phân tách rõ chức năng public với chức năng quản trị."
    135 = "Entity Framework 6 đóng vai trò ORM, ánh xạ các lớp thực thể NguoiDung, DanhMuc, LehHoi, HinhAnh, BaiViet, LehHoi_BaiViet, BinhLuan và ResetPasswordToken thành các bảng trong SQL Server. KhmerFestivalContext cung cấp DbSet cho từng thực thể và cấu hình quan hệ bằng Fluent API."
    138 = "FormsAuthentication được dùng để tạo cookie đăng nhập theo email. Mật khẩu không được lưu dạng văn bản thuần mà được băm bằng SHA256 kết hợp Salt. Khi đăng nhập, hệ thống lấy Salt của tài khoản, băm mật khẩu người dùng nhập và so sánh với giá trị MatKhau trong cơ sở dữ liệu."
    139 = "Khu vực Admin được bảo vệ bằng Authorize(Roles = `"Admin`"). Sau khi đăng nhập thành công, hệ thống lưu UserId, VaiTro và HoTen vào Session để hỗ trợ xử lý nghiệp vụ và hiển thị thông tin người dùng."
    141 = "Tất cả thao tác thay đổi dữ liệu sử dụng phương thức POST và ValidateAntiForgeryToken để giảm nguy cơ CSRF. Razor tự mã hóa nội dung khi hiển thị, giúp hạn chế XSS. Entity Framework tạo truy vấn có tham số để giảm nguy cơ SQL Injection; upload ảnh chỉ chấp nhận .jpg, .jpeg, .png và dung lượng tối đa 2MB."
    142 = "Bootstrap 5, jQuery và TinyMCE"
    143 = "Bootstrap 5 cung cấp hệ thống lưới, navbar, card, bảng và form responsive. jQuery hỗ trợ validation phía trình duyệt. TinyMCE được dùng trong khu vực Admin để nhập nội dung HTML cho mô tả lễ hội và bài viết."
    149 = "ASP.NET MVC 5 / .NET Framework"
    152 = "Razor, Bootstrap 5, jQuery"
    154 = "Soạn thảo nội dung"
    155 = "TinyMCE"
    156 = "Nhập mô tả lễ hội và bài viết dạng HTML"
    161 = "FormsAuthentication, SHA256 + Salt"
    162 = "Quản lý phiên và bảo vệ mật khẩu"
    165 = "Hệ thống cần giới thiệu thông tin lễ hội Khmer một cách tập trung, trực quan và dễ tra cứu. Khách truy cập có thể xem danh sách lễ hội, đọc chi tiết, xem thư viện ảnh, xem bài viết liên quan và tìm kiếm theo từ khóa. Thành viên có thể gửi bình luận, còn quản trị viên chịu trách nhiệm quản lý toàn bộ nội dung."
    166 = "Phiên bản triển khai hiện tại có đầy đủ module public, module tài khoản và khu vực Admin. Dữ liệu mẫu gồm các lễ hội thật như Chol Chnam Thmay, Ok Om Bok, lễ Dâng y Kathina, lễ hội đua ghe Ngo, lễ Vu Lan Khmer và lễ Đom Lơng Néak Tà."
    168 = "Hình 1. Sơ đồ ngữ cảnh website giới thiệu lễ hội Khmer"
    171 = "Yêu cầu chức năng là các chức năng cụ thể mà hệ thống phải thực hiện để đáp ứng nhu cầu sử dụng của khách truy cập, thành viên và quản trị viên. Đối với website giới thiệu lễ hội Khmer, các chức năng tập trung vào xem thông tin, tìm kiếm, bình luận và quản lý nội dung."
    173 = "Hệ thống cho phép khách truy cập xem trang chủ, danh sách lễ hội, chi tiết lễ hội và bài viết."
    174 = "Hệ thống cho phép người dùng đăng ký, đăng nhập và đăng xuất khỏi tài khoản."
    175 = "Hệ thống cho phép người dùng đổi mật khẩu và đặt lại mật khẩu đơn giản bằng email đã đăng ký."
    176 = "Hệ thống cho phép tìm kiếm lễ hội và bài viết theo từ khóa."
    177 = "Hệ thống cho phép lọc lễ hội theo danh mục, tỉnh/thành và năm tổ chức."
    178 = "Hệ thống cho phép thành viên gửi bình luận; bình luận mới ở trạng thái chờ duyệt."
    179 = "Hệ thống cho phép Admin quản lý danh mục lễ hội."
    180 = "Hệ thống cho phép Admin thêm, sửa, xem chi tiết và xóa mềm lễ hội."
    181 = "Hệ thống cho phép Admin upload nhiều ảnh, xóa ảnh và đặt ảnh đại diện cho lễ hội."
    182 = "Hệ thống cho phép Admin quản lý bài viết và gắn bài viết với lễ hội liên quan."
    183 = "Hệ thống cho phép Admin duyệt hoặc ẩn bình luận."
    184 = "Hệ thống cho phép Admin khóa hoặc mở khóa tài khoản người dùng."
    185 = "Hệ thống hiển thị Dashboard quản trị gồm tổng số lễ hội, bài viết, bình luận chờ duyệt và tài khoản."
    186 = "Hệ thống phân quyền rõ ràng giữa khách truy cập, thành viên và quản trị viên."
    187 = "Các chức năng quản trị chỉ truy cập được khi tài khoản có vai trò Admin."
    191 = "Bảo mật: Mật khẩu người dùng phải được băm bằng SHA256 kết hợp Salt trước khi lưu vào cơ sở dữ liệu."
    192 = "Bảo mật đăng nhập: Hệ thống kiểm tra email, mật khẩu và trạng thái tài khoản trước khi tạo phiên đăng nhập."
    193 = "Phân quyền: Khu vực Admin chỉ cho phép tài khoản có vai trò Admin truy cập."
    196 = "Tính dễ sử dụng: Giao diện cần rõ ràng, dễ thao tác, các chức năng chính được bố trí trên thanh menu và sidebar quản trị."
    199 = "Hiệu năng: Danh sách lễ hội hỗ trợ tìm kiếm, lọc và phân trang để tránh tải quá nhiều dữ liệu cùng lúc."
    200 = "Độ chính xác: Dữ liệu lễ hội, bài viết, hình ảnh và bình luận phải được liên kết đúng khóa ngoại."
    201 = "Độ tin cậy: Các thao tác thêm, sửa, xóa mềm và duyệt bình luận phải cập nhật nhất quán trong cơ sở dữ liệu."
    203 = "Khả năng mở rộng: Hệ thống có thể mở rộng thêm bản đồ địa điểm, lịch sự kiện, đa ngôn ngữ hoặc API cho ứng dụng di động."
    207 = "Sơ đồ ERD thể hiện các bảng chính của hệ thống gồm NguoiDung, DanhMuc, LehHoi, HinhAnh, BaiViet, LehHoi_BaiViet, BinhLuan và ResetPasswordToken. Các bảng được liên kết bằng khóa ngoại nhằm đảm bảo tính toàn vẹn dữ liệu và hỗ trợ quản lý nội dung lễ hội."
}
Set-ParagraphTextByIndex $doc $paragraphMap

$moreReplacements = @(
    @("Bảng NguoiDung", "Bảng NguoiDung"),
    @("Khóa chính tài khoản", "Khóa chính người dùng"),
    @("Mật khẩu đã băm SHA256 kết hợp Salt", "Mật khẩu đã băm SHA256"),
    @("Số điện thoại", "Salt dùng để băm mật khẩu"),
    @("Vai trò tài khoản; phiên bản hiện tại sử dụng User", "Vai trò tài khoản: Admin hoặc Member"),
    @("Trạng thái khóa tài khoản", "Trạng thái tài khoản: HoatDong hoặc BiKhoa"),
    @("Số lần đăng nhập sai liên tiếp", "Ngày tạo tài khoản"),
    @("Cờ xóa mềm", "Thông tin mô tả hoặc cờ trạng thái"),
    @("Bảng DanhMuc", "Bảng DanhMuc"),
    @("Khóa chính danh mục", "Khóa chính danh mục lễ hội"),
    @("Null nếu là danh mục hệ thống", "Tên danh mục lễ hội"),
    @("Tự tham chiếu để tạo cấp cha - con", "Mô tả ngắn về danh mục"),
    @("1: Thu; 2: Chi", "Danh mục như lễ hội truyền thống, tôn giáo, nông nghiệp"),
    @("Bảng LehHoi", "Bảng LehHoi"),
    @("Khóa chính ví", "Khóa chính lễ hội"),
    @("Chủ sở hữu ví", "Danh mục của lễ hội"),
    @("Tên ví", "Tên lễ hội"),
    @("1: Tiền mặt; 2: Ngân hàng; 3: Ví điện tử", "Tóm tắt, mô tả và ý nghĩa văn hóa"),
    @("Số dư hiện tại", "Ngày bắt đầu, ngày kết thúc"),
    @("Ví mặc định", "Địa điểm, tỉnh/thành và ảnh đại diện"),
    @("Bảng BaiViet", "Bảng BaiViet"),
    @("Khóa chính giao dịch", "Khóa chính bài viết"),
    @("Chủ sở hữu giao dịch", "Người tạo bài viết"),
    @("Danh mục giao dịch", "Tiêu đề bài viết"),
    @("Ví phát sinh", "Tóm tắt bài viết"),
    @("Ví nhận khi chuyển khoản", "Nội dung HTML"),
    @("Số tiền giao dịch", "Ảnh đại diện"),
    @("1: Thu; 2: Chi; 3: Chuyển khoản", "Cờ xóa mềm"),
    @("Ngày giao dịch", "Ngày tạo bài viết"),
    @("Bảng BinhLuan", "Bảng BinhLuan"),
    @("Khóa chính ngân sách", "Khóa chính bình luận"),
    @("Chủ sở hữu ngân sách", "Người gửi bình luận"),
    @("Danh mục chi được giới hạn", "Lễ hội hoặc bài viết được bình luận"),
    @("Hạn mức", "Nội dung bình luận"),
    @("Số đã chi được cập nhật", "Trạng thái: ChoDuyet, DaDuyet, BiAn"),
    @("Tháng áp dụng", "Ngày tạo bình luận"),
    @("Năm áp dụng", "Ràng buộc chỉ bình luận một đối tượng"),
    @("Users - Categories, LehHoi, BaiViet, BinhLuan là quan hệ 1-N; mỗi bản ghi nghiệp vụ thuộc một người dùng.", "NguoiDung - BinhLuan là quan hệ 1-N; mỗi bình luận thuộc một người dùng."),
    @("Categories tự tham chiếu qua ParentCategoryId để biểu diễn danh mục cha và danh mục con tối đa hai cấp.", "DanhMuc - LehHoi là quan hệ 1-N; mỗi lễ hội thuộc một danh mục."),
    @("LehHoi - BaiViet có hai quan hệ: WalletId là ví nguồn; ToWalletId là ví nhận tùy chọn khi chuyển khoản.", "LehHoi - HinhAnh là quan hệ 1-N; mỗi lễ hội có nhiều hình ảnh."),
    @("Categories - BaiViet và Categories - BinhLuan là quan hệ 1-N.", "LehHoi - BaiViet là quan hệ N-N thông qua bảng LehHoi_BaiViet."),
    @("Các khóa ngoại được cấu hình WillCascadeOnDelete(false) để tránh xóa dây chuyền dữ liệu tài chính.", "BinhLuan liên kết tùy chọn đến LehHoi hoặc BaiViet và có ràng buộc chỉ chọn một đối tượng bình luận."),
    @("Luồng thêm giao dịch", "Luồng quản lý lễ hội"),
    @("Luồng xem Dashboard và báo cáo", "Luồng xem chi tiết, tìm kiếm và bình luận"),
    @("UC06`tXem Dashboard", "UC06`tXem trang chủ"),
    @("UC07`tXem danh sách danh mục", "UC07`tXem danh sách lễ hội"),
    @("UC08`tThêm danh mục", "UC08`tXem chi tiết lễ hội"),
    @("UC09`tSửa danh mục", "UC09`tTìm kiếm"),
    @("UC10`tXóa danh mục", "UC10`tGửi bình luận"),
    @("UC11`tXem danh sách ví", "UC11`tQuản lý danh mục lễ hội"),
    @("UC12`tThêm ví", "UC12`tThêm danh mục"),
    @("UC13`tSửa ví", "UC13`tSửa danh mục"),
    @("UC14`tXóa ví", "UC14`tXóa danh mục"),
    @("UC15`tXem danh sách giao dịch", "UC15`tQuản lý lễ hội"),
    @("UC16`tThêm giao dịch Thu", "UC16`tThêm lễ hội"),
    @("UC17`tThêm giao dịch Chi", "UC17`tSửa lễ hội"),
    @("UC18`tThêm giao dịch Chuyển khoản", "UC18`tQuản lý ảnh lễ hội"),
    @("UC19`tSửa giao dịch", "UC19`tQuản lý bài viết"),
    @("UC20`tXóa giao dịch", "UC20`tThêm bài viết"),
    @("UC21`tLọc giao dịch", "UC21`tSửa bài viết"),
    @("UC22`tXem danh sách ngân sách", "UC22`tDuyệt bình luận"),
    @("UC23`tThêm ngân sách", "UC23`tẨn bình luận"),
    @("UC24`tSửa ngân sách", "UC24`tQuản lý tài khoản"),
    @("UC25`tXóa ngân sách", "UC25`tKhóa hoặc mở khóa tài khoản"),
    @("UC26`tXem báo cáo lễ hội và bài viết", "UC26`tLọc lễ hội"),
    @("UC27`tLọc báo cáo theo thời gian", "UC27`tXem bài viết"),
    @("UC28`tXem biểu đồ lễ hội và bài viết", "UC28`tGắn bài viết với lễ hội"),
    @("UC29`tXem thông tin bình luận trên Dashboard", "UC29`tXem bình luận chờ duyệt"),
    @("UC30`tXem lễ hội gần đây", "UC30`tXem lễ hội sắp diễn ra")
)
foreach ($pair in $moreReplacements) { Replace-All $doc $pair[0] $pair[1] }

$tailMap = @{
    378 = "Khi đăng ký, hệ thống kiểm tra ModelState và email trùng. Mật khẩu được băm bằng SHA256 kết hợp Salt trước khi lưu vào bảng NguoiDung. Sau khi đăng nhập thành công, hệ thống tạo FormsAuthentication cookie và lưu UserId, VaiTro, HoTen vào Session."
    379 = "Khi đăng nhập, hệ thống tìm tài khoản theo email, kiểm tra trạng thái HoatDong và so sánh mật khẩu đã băm. Nếu thông tin hợp lệ, người dùng được chuyển về trang trước đó hoặc trang chủ; nếu tài khoản có vai trò Admin thì có thể truy cập khu vực quản trị."
    381 = "Admin có thể thêm lễ hội bằng biểu mẫu gồm tên, danh mục, tóm tắt, mô tả HTML, ngày bắt đầu, ngày kết thúc, địa điểm, tỉnh/thành, ý nghĩa văn hóa và ảnh đại diện. File ảnh được kiểm tra định dạng và dung lượng trước khi lưu."
    382 = "Khi chỉnh sửa hoặc xóa lễ hội, hệ thống cập nhật dữ liệu trong bảng LehHoi. Xóa lễ hội được thực hiện theo cơ chế xóa mềm bằng IsDeleted để không làm mất dữ liệu liên quan."
    384 = "Trang chi tiết lễ hội truy vấn thông tin lễ hội, danh mục, thư viện ảnh, bài viết liên quan và bình luận đã duyệt. Nếu người dùng gửi bình luận, hệ thống lưu trạng thái ChoDuyet để Admin kiểm tra trước khi hiển thị công khai."
    385 = "Chức năng tìm kiếm nhận từ khóa trên header, lọc các lễ hội và bài viết có tiêu đề phù hợp. Danh sách lễ hội còn hỗ trợ lọc theo danh mục, tỉnh/thành và năm tổ chức."
    518 = "Sơ đồ kiến trúc thể hiện cách các thành phần trong hệ thống phối hợp với nhau khi người dùng thao tác trên website. Ở phía Client, người dùng sử dụng trình duyệt để truy cập giao diện được xây dựng bằng HTML, CSS, Bootstrap 5, jQuery và Razor View. Khi người dùng xem lễ hội, tìm kiếm, đăng nhập hoặc bình luận, trình duyệt gửi HTTP request đến ứng dụng ASP.NET MVC 5."
    519 = "Tại tầng ASP.NET MVC 5, RouteConfig xác định đường dẫn request và chuyển request đến Controller phù hợp. Controller tiếp nhận dữ liệu, kiểm tra hợp lệ, xử lý nghiệp vụ và sử dụng ViewModel để truyền dữ liệu sang Razor View. Khu vực Admin được tổ chức trong Area riêng và bảo vệ bằng phân quyền Admin."
    520 = "Tầng dữ liệu được xây dựng bằng Entity Framework 6. Controller làm việc với KhmerFestivalContext để truy vấn và cập nhật dữ liệu thông qua LINQ. SQL Server lưu trữ các bảng NguoiDung, DanhMuc, LehHoi, HinhAnh, BaiViet, LehHoi_BaiViet, BinhLuan và ResetPasswordToken."
    521 = "Ngoài ra, hệ thống sử dụng Bootstrap 5 để xây dựng giao diện responsive, jQuery cho validation và TinyMCE trong khu vực Admin để soạn thảo nội dung HTML. Cách tổ chức này giúp tách rõ phần giao diện, xử lý nghiệp vụ và lưu trữ dữ liệu."
    526 = "Màn hình đăng nhập cho phép người dùng nhập email và mật khẩu để truy cập hệ thống. Sau khi xác thực thành công, người dùng được chuyển về trang trước đó hoặc trang chủ."
    528 = "• Mật khẩu được xác thực bằng SHA256 kết hợp Salt."
    529 = "• Tài khoản bị khóa sẽ không được phép đăng nhập vào hệ thống."
    533 = "Người dùng nhập họ tên, email, mật khẩu và xác nhận mật khẩu. Dữ liệu được kiểm tra bằng Data Annotation trước khi gửi."
    535 = "• Mật khẩu được băm bằng SHA256 kết hợp Salt trước khi lưu."
    536 = "• Tài khoản mới mặc định có vai trò Member và trạng thái HoatDong."
    540 = "Màn hình quên mật khẩu được triển khai đơn giản cho môi trường đồ án: người dùng nhập email, mật khẩu mới và xác nhận mật khẩu mới. Nếu email tồn tại, hệ thống cập nhật mật khẩu mới."
    541 = "• Không hiển thị thông báo phân biệt email có tồn tại hay không."
    542 = "• Mật khẩu mới được băm bằng SHA256 kết hợp Salt trước khi cập nhật."
    543 = "• Sau khi hoàn tất, người dùng quay lại màn hình đăng nhập."
    547 = "Trang chủ giới thiệu website, hiển thị banner lễ hội Khmer, danh sách lễ hội sắp diễn ra, bài viết mới nhất và danh mục lễ hội."
    548 = "• Hiển thị sáu lễ hội gần nhất theo ngày bắt đầu."
    549 = "• Hiển thị sáu bài viết mới nhất."
    550 = "• Sidebar danh mục giúp người dùng lọc nhanh lễ hội."
    554 = "Danh sách lễ hội hiển thị dạng card gồm ảnh đại diện, tên lễ hội, địa điểm, ngày diễn ra và tóm tắt. Người dùng có thể tìm kiếm, lọc và phân trang."
    555 = "• Lọc theo danh mục, tỉnh/thành và năm tổ chức."
    556 = "• Tìm kiếm theo tên lễ hội."
    557 = "• Mỗi card dẫn đến trang chi tiết lễ hội."
    561 = "Màn hình chi tiết lễ hội hiển thị đầy đủ mô tả, thời gian, địa điểm, ý nghĩa văn hóa, thư viện ảnh, bài viết liên quan và bình luận đã duyệt."
    562 = "• Thành viên có thể gửi bình luận."
    563 = "• Bình luận mới ở trạng thái chờ duyệt."
    564 = "• Lễ hội liên quan được lấy theo cùng danh mục."
    568 = "Màn hình bài viết hiển thị danh sách bài viết và trang chi tiết bài viết. Bài viết có thể gắn với một hoặc nhiều lễ hội liên quan."
    569 = "• Nội dung bài viết hỗ trợ HTML từ TinyMCE."
    570 = "• Bài viết có ảnh đại diện và tác giả."
    571 = "• Người dùng có thể bình luận bài viết."
    575 = "Màn hình quản lý danh mục trong Admin hiển thị tên danh mục và số lễ hội thuộc danh mục đó."
    576 = "• Admin có thể thêm, sửa và xóa danh mục."
    577 = "• Không cho xóa danh mục đang có lễ hội."
    578 = "• Danh mục được dùng để lọc lễ hội ở frontend."
    582 = "Admin nhập tên danh mục và mô tả. Dữ liệu được kiểm tra trước khi lưu."
    583 = "• Tên danh mục là bắt buộc."
    584 = "• Mô tả giúp người dùng hiểu nhóm lễ hội."
    585 = "• Danh mục mới xuất hiện trong bộ lọc lễ hội."
    589 = "Màn hình sửa danh mục cho phép Admin cập nhật tên và mô tả danh mục đã tạo."
    590 = "• Dữ liệu liên quan được giữ nguyên."
    591 = "• Hệ thống kiểm tra hợp lệ trước khi lưu."
    592 = "• Thông tin sau khi sửa được cập nhật ở frontend và Admin."
    596 = "Màn hình quản lý lễ hội hiển thị danh sách lễ hội kèm danh mục, ngày bắt đầu, trạng thái và các thao tác chi tiết, sửa, quản lý ảnh, xóa mềm."
    597 = "• Hỗ trợ tìm kiếm theo tên lễ hội."
    598 = "• Hỗ trợ lọc theo danh mục."
    599 = "• Xóa lễ hội theo cơ chế xóa mềm."
    603 = "Biểu mẫu thêm lễ hội cho phép nhập thông tin đầy đủ, chọn danh mục và upload ảnh đại diện."
    604 = "• Ngày kết thúc phải lớn hơn hoặc bằng ngày bắt đầu."
    605 = "• Ảnh đại diện chỉ chấp nhận .jpg, .jpeg, .png và tối đa 2MB."
    606 = "• Sau khi lưu, ảnh đại diện được thêm vào thư viện hình ảnh."
    610 = "Màn hình sửa lễ hội nạp lại dữ liệu cũ và cho phép cập nhật thông tin, thay đổi ảnh đại diện nếu cần."
    611 = "• Cho phép cập nhật mô tả HTML và ý nghĩa văn hóa."
    612 = "• Giữ nguyên ảnh cũ nếu không upload ảnh mới."
    613 = "• Dữ liệu sau khi sửa được hiển thị ở frontend."
    617 = "Trang quản lý bài viết hiển thị danh sách bài viết, hỗ trợ tìm kiếm theo tiêu đề và các thao tác chi tiết, sửa, xóa mềm."
    618 = "• Bài viết có tiêu đề, tóm tắt, nội dung HTML và ảnh đại diện."
    619 = "• Có thể gắn bài viết với lễ hội liên quan."
    620 = "• Xóa bài viết theo cơ chế xóa mềm."
    624 = "Màn hình thêm bài viết cho phép nhập tiêu đề, tóm tắt, nội dung, upload ảnh và chọn các lễ hội liên quan."
    625 = "• Tiêu đề là bắt buộc."
    626 = "• Nội dung HTML được soạn bằng TinyMCE."
    627 = "• Bài viết sau khi tạo hiển thị ở trang blog."
    631 = "Màn hình sửa bài viết cho phép cập nhật nội dung, ảnh đại diện và danh sách lễ hội liên quan."
    632 = "• Giữ ảnh cũ nếu không chọn ảnh mới."
    633 = "• Cập nhật lại quan hệ nhiều-nhiều giữa bài viết và lễ hội."
    634 = "• Nội dung sau khi sửa được hiển thị ở frontend."
    638 = "Trang quản lý bình luận cho phép Admin lọc bình luận theo trạng thái chờ duyệt, đã duyệt hoặc bị ẩn."
    639 = "• Admin có thể duyệt bình luận để hiển thị công khai."
    640 = "• Admin có thể ẩn bình luận vi phạm."
    641 = "• Bình luận liên kết với lễ hội hoặc bài viết."
    645 = "Người dùng phải nhập mật khẩu hiện tại, mật khẩu mới và xác nhận mật khẩu mới."
    646 = "• Mật khẩu hiện tại được xác minh bằng SHA256 kết hợp Salt."
    647 = "• Mật khẩu mới được băm lại với Salt mới."
    648 = "• Thông báo thành công được hiển thị sau khi cập nhật."
    651 = "Đồ án đã hoàn thành website giới thiệu lễ hội Khmer bằng ASP.NET MVC 5 và SQL Server. Hệ thống đáp ứng các nghiệp vụ cốt lõi: xem lễ hội, bài viết, tìm kiếm, bình luận, xác thực người dùng và quản trị nội dung."
    652 = "Quá trình thực hiện giúp củng cố kiến thức về tổ chức dự án MVC, Razor View, Entity Framework, quan hệ cơ sở dữ liệu, FormsAuthentication, băm mật khẩu, upload file, phân quyền Admin và các biện pháp bảo mật web cơ bản."
    654 = "• Chức năng khôi phục mật khẩu hiện được đơn giản hóa, chưa gửi liên kết xác nhận qua email."
    655 = "• Chưa hỗ trợ bản đồ địa điểm, lịch nhắc sự kiện và đa ngôn ngữ."
    656 = "• Chưa có chức năng xuất dữ liệu lễ hội/bài viết ra PDF hoặc Excel."
    657 = "• Ứng dụng mới tối ưu cho trình duyệt, chưa có API và ứng dụng di động riêng."
    658 = "• Chưa có hệ thống log tập trung và bộ kiểm thử tự động đầy đủ."
    660 = "• Bổ sung khôi phục mật khẩu bằng token có thời hạn và gửi email khi cấu hình SMTP."
    661 = "• Bổ sung bản đồ địa điểm, lịch sự kiện và bộ lọc lễ hội nâng cao."
    662 = "• Xuất dữ liệu lễ hội, bài viết và bình luận ra Excel/PDF."
    663 = "• Phát triển REST API và ứng dụng di động, đồng bộ dữ liệu theo thời gian thực."
    664 = "• Tăng cường logging, kiểm thử unit/integration và triển khai tự động lên IIS hoặc cloud."
    666 = "Microsoft. (2023). ASP.NET MVC 5 Overview. https://docs.microsoft.com/aspnet/mvc"
    667 = "Microsoft. (2023). Entity Framework 6. https://docs.microsoft.com/ef/ef6/"
    668 = "Bootstrap. (2026). Bootstrap 5 Documentation. https://getbootstrap.com/docs/5.3/"
    669 = "OWASP. (2023). OWASP Top Ten. https://owasp.org/www-project-top-ten/"
    670 = "TinyMCE. (2026). TinyMCE Documentation. https://www.tiny.cloud/docs/"
    671 = "Microsoft. (2023). Forms Authentication in ASP.NET. https://docs.microsoft.com/aspnet"
    672 = "Microsoft. (2023). SQL Server Documentation. https://docs.microsoft.com/sql/"
    673 = "Microsoft. (2023). Session and State Management in ASP.NET. https://docs.microsoft.com/aspnet"
    674 = "Bootstrap Icons and responsive web design references."
}
Set-ParagraphTextByIndex $doc $tailMap

$doc.Save()
$doc.Close($true)
$word.Quit()

[System.Runtime.InteropServices.Marshal]::ReleaseComObject($doc) | Out-Null
[System.Runtime.InteropServices.Marshal]::ReleaseComObject($word) | Out-Null
