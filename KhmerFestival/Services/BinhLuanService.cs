using System;
using KhmerFestival.Models;
using KhmerFestival.Models.Entities;

namespace KhmerFestival.Services
{
    public class BinhLuanService
    {
        private readonly KhmerFestivalContext _db;

        public BinhLuanService(KhmerFestivalContext db)
        {
            _db = db;
        }

        public void TaoChoLehHoi(int nguoiDungId, int lehHoiId, string noiDung)
        {
            _db.BinhLuans.Add(new BinhLuan
            {
                NguoiDungId = nguoiDungId,
                LehHoiId = lehHoiId,
                NoiDung = noiDung,
                TrangThai = "ChoDuyet",
                NgayTao = DateTime.Now
            });
            _db.SaveChanges();
        }

        public void TaoChoBaiViet(int nguoiDungId, int baiVietId, string noiDung)
        {
            _db.BinhLuans.Add(new BinhLuan
            {
                NguoiDungId = nguoiDungId,
                BaiVietId = baiVietId,
                NoiDung = noiDung,
                TrangThai = "ChoDuyet",
                NgayTao = DateTime.Now
            });
            _db.SaveChanges();
        }
    }
}
