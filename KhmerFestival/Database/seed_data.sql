IF NOT EXISTS (SELECT 1 FROM NguoiDung WHERE Email = 'admin@khmer-lehoi.vn')
BEGIN
    INSERT INTO NguoiDung (HoTen, Email, MatKhau, Salt, VaiTro, TrangThai)
    VALUES (N'Quản trị viên', 'admin@khmer-lehoi.vn', 'VXwSAWz6UVf4UuCAm5ev5G/lJrNvRiIPWgXMifHSrsg=', 'default-admin-salt', 'Admin', 'HoatDong');
END
ELSE
BEGIN
    UPDATE NguoiDung SET HoTen = N'Quản trị viên' WHERE Email = 'admin@khmer-lehoi.vn';
END

DELETE FROM LehHoi_BaiViet;
DELETE FROM HinhAnh;
DELETE FROM BinhLuan;
DELETE FROM BaiViet;
DELETE FROM LehHoi;
DELETE FROM DanhMuc;

INSERT INTO DanhMuc (TenDanhMuc, MoTa) VALUES
(N'Lễ hội truyền thống', N'Các lễ hội cộng đồng gắn với lịch năm mới, trăng rằm và sinh hoạt phum sóc của người Khmer Nam Bộ.'),
(N'Lễ hội tôn giáo', N'Các nghi lễ Phật giáo Nam Tông Khmer, thể hiện tinh thần hướng thiện và gắn kết với chùa.'),
(N'Lễ hội nông nghiệp', N'Các lễ hội cầu mùa, tri ân thiên nhiên, nguồn nước và đời sống sản xuất của cộng đồng Khmer.');

DECLARE @AdminId INT = (SELECT TOP 1 Id FROM NguoiDung WHERE Email = 'admin@khmer-lehoi.vn');
DECLARE @TruyenThong INT = (SELECT Id FROM DanhMuc WHERE TenDanhMuc = N'Lễ hội truyền thống');
DECLARE @TonGiao INT = (SELECT Id FROM DanhMuc WHERE TenDanhMuc = N'Lễ hội tôn giáo');
DECLARE @NongNghiep INT = (SELECT Id FROM DanhMuc WHERE TenDanhMuc = N'Lễ hội nông nghiệp');

INSERT INTO LehHoi (DanhMucId, TenLehHoi, TomTat, MoTa, YNghiaVanHoa, NgayBatDau, NgayKetThuc, DiaDiem, TinhThanh, AnhDaiDien, NguoiTaoId)
VALUES
(@TruyenThong, N'Chol Chnam Thmay - Tết cổ truyền Khmer',
 N'Tết mừng năm mới của người Khmer, thường diễn ra vào giữa tháng 4 dương lịch.',
 N'<p>Chol Chnam Thmay là dịp người Khmer dọn dẹp nhà cửa, đến chùa làm phước, tắm Phật, chúc Tết ông bà cha mẹ và tham gia các trò chơi dân gian trong phum sóc.</p>',
 N'Lễ hội thể hiện lòng biết ơn tổ tiên, sự kính trọng Tam Bảo và khát vọng một năm mới bình an, sung túc.',
 '2027-04-14', '2027-04-16', N'Các chùa Khmer Nam Bộ', N'Sóc Trăng', '/Content/Uploads/Seed/chol-chnam-thmay.jpg', @AdminId),
(@TruyenThong, N'Ok Om Bok - Lễ cúng trăng',
 N'Lễ tạ ơn Mặt Trăng sau mùa vụ, gắn với cốm dẹp, đèn gió và sinh hoạt cộng đồng.',
 N'<p>Ok Om Bok diễn ra vào rằm tháng 10 âm lịch. Người dân dâng cốm dẹp, khoai, chuối, dừa và cầu mong mùa màng thuận lợi, đời sống no ấm.</p>',
 N'Lễ hội phản ánh tín ngưỡng nông nghiệp, lòng tri ân thiên nhiên và sự gắn bó cộng đồng của người Khmer.',
 '2026-11-24', '2026-11-25', N'Khu vực chùa và quảng trường trung tâm', N'Sóc Trăng', '/Content/Uploads/Seed/ok-om-bok.jpg', @AdminId),
(@TonGiao, N'Lễ Dâng y Kathina',
 N'Nghi lễ Phật giáo Nam Tông dâng y cà sa cho chư tăng sau mùa an cư kiết hạ.',
 N'<p>Phật tử chuẩn bị y Kathina, vật phẩm sinh hoạt và cùng rước lễ đến chùa. Nghi thức thường diễn ra trang trọng với sự tham gia của đông đảo bà con Khmer.</p>',
 N'Lễ Dâng y Kathina đề cao tinh thần bố thí, hộ trì Tam Bảo và sự gắn kết giữa nhà chùa với cộng đồng.',
 '2026-10-20', '2026-11-18', N'Chùa Som Rong và các chùa Khmer', N'Sóc Trăng', '/Content/Uploads/Seed/kathina.webp', @AdminId),
(@TonGiao, N'Lễ Vu Lan của đồng bào Khmer Nam Bộ',
 N'Dịp báo hiếu, tưởng nhớ công ơn cha mẹ, ông bà và cầu an cầu siêu tại chùa.',
 N'<p>Trong mùa Vu Lan, đồng bào Khmer đến chùa tụng kinh, dâng lễ, làm phước và tưởng nhớ người đã khuất theo truyền thống Phật giáo Nam Tông.</p>',
 N'Lễ hội nuôi dưỡng đạo hiếu, lòng biết ơn và tinh thần hướng thiện trong đời sống gia đình, cộng đồng.',
 '2026-08-28', '2026-08-28', N'Các chùa Khmer Nam Bộ', N'Trà Vinh', '/Content/Uploads/Seed/vu-lan-khmer.webp', @AdminId),
(@NongNghiep, N'Lễ hội đua ghe Ngo',
 N'Hoạt động văn hóa - thể thao đặc sắc của người Khmer, thường diễn ra cùng mùa Ok Om Bok.',
 N'<p>Những đội ghe Ngo đại diện cho các chùa, phum sóc cùng tranh tài trên sông trong tiếng trống, tiếng reo hò và không khí lễ hội sôi nổi.</p>',
 N'Đua ghe Ngo là biểu tượng của sức mạnh tập thể, tinh thần đoàn kết và văn hóa sông nước Nam Bộ.',
 '2026-11-25', '2026-11-25', N'Sông Maspero', N'Sóc Trăng', '/Content/Uploads/Seed/dua-ghe-ngo.webp', @AdminId),
(@NongNghiep, N'Lễ hội Đom Lơng Néak Tà',
 N'Nghi lễ cúng thần bảo hộ phum sóc của người Khmer, tiêu biểu tại Trà Vinh.',
 N'<p>Người dân chuẩn bị lễ vật, rước lễ và cầu xin Néak Tà bảo hộ xóm làng, mùa màng thuận lợi, cuộc sống bình yên.</p>',
 N'Lễ hội thể hiện tín ngưỡng dân gian Khmer, lòng biết ơn đất đai và khát vọng cộng đồng an lành.',
 '2027-03-10', '2027-03-10', N'Phum sóc Khmer', N'Trà Vinh', '/Content/Uploads/Seed/neak-ta-tra-vinh.webp', @AdminId);

INSERT INTO HinhAnh (LehHoiId, DuongDan, MoTa, LaDaiDien)
SELECT Id, AnhDaiDien, N'Ảnh đại diện lễ hội', 1 FROM LehHoi WHERE AnhDaiDien IS NOT NULL;

INSERT INTO BaiViet (TieuDe, TomTat, NoiDung, AnhDaiDien, NguoiTaoId)
VALUES
(N'Chol Chnam Thmay và không khí Tết trong phum sóc Khmer',
 N'Tìm hiểu những nghi thức quan trọng trong Tết cổ truyền của người Khmer Nam Bộ.',
 N'<p>Chol Chnam Thmay không chỉ là ngày đầu năm mới mà còn là dịp để mỗi gia đình Khmer hướng về chùa, về tổ tiên và về cộng đồng. Các nghi thức tắm Phật, dâng cơm cho sư sãi, chúc thọ ông bà cha mẹ làm nên nét đẹp nhân văn của lễ hội.</p>',
 '/Content/Uploads/Seed/chol-chnam-thmay.jpg', @AdminId),
(N'Ok Om Bok và ý nghĩa của lễ cúng trăng',
 N'Lễ cúng trăng là một trong những dấu ấn văn hóa đặc sắc nhất của đồng bào Khmer.',
 N'<p>Trong đêm rằm, người Khmer dâng cốm dẹp và sản vật mùa vụ để tạ ơn Mặt Trăng. Ở Sóc Trăng, Trà Vinh và nhiều địa phương Nam Bộ, lễ hội còn gắn với đua ghe Ngo, thả đèn nước và những sinh hoạt cộng đồng rộn ràng.</p>',
 '/Content/Uploads/Seed/ok-om-bok.jpg', @AdminId),
(N'Đua ghe Ngo - sức mạnh cộng đồng trên dòng sông Nam Bộ',
 N'Đua ghe Ngo là điểm nhấn văn hóa, thể thao và tín ngưỡng của người Khmer.',
 N'<p>Mỗi chiếc ghe Ngo là niềm tự hào của một ngôi chùa và phum sóc. Từ khâu đóng ghe, tập luyện đến ngày tranh tài đều thể hiện tinh thần đoàn kết, kỷ luật và niềm vui hội lớn.</p>',
 '/Content/Uploads/Seed/dua-ghe-ngo.webp', @AdminId);

INSERT INTO LehHoi_BaiViet (LehHoiId, BaiVietId)
SELECT lh.Id, bv.Id FROM LehHoi lh CROSS JOIN BaiViet bv
WHERE (lh.TenLehHoi LIKE N'%Chol Chnam%' AND bv.TieuDe LIKE N'%Chol Chnam%')
   OR (lh.TenLehHoi LIKE N'%Ok Om Bok%' AND bv.TieuDe LIKE N'%Ok Om Bok%')
   OR (lh.TenLehHoi LIKE N'%đua ghe Ngo%' AND bv.TieuDe LIKE N'%Đua ghe Ngo%');
