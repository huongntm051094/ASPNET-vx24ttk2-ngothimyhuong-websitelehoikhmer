$ErrorActionPreference = "Stop"

$path = (Resolve-Path "DK24TTK2- bao cao_NguyenVanKhanh_KhmerFestival.doc").Path
$map = @{
    541 = "• Mật khẩu mới được lưu bằng chuỗi băm SHA256 kết hợp salt mới; trạng thái tài khoản được đưa về HoatDong nếu cần."
    650 = "Quá trình thực hiện giúp củng cố kiến thức về tổ chức dự án MVC, model binding, Razor, Entity Framework, quan hệ cơ sở dữ liệu, xác thực cookie, băm mật khẩu và các biện pháp bảo mật web cơ bản."
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
                $range = $paragraph.Range
                if ($range.End -gt $range.Start) { $range.End = $range.End - 1 }
                $range.Text = $map[$visibleIndex]
            }
        }
    }
    $doc.Save()
}
finally {
    $doc.Close($false)
    $word.Quit()
}

"Fixed leftover old terms in $path"
