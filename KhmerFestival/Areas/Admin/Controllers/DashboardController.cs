using System;
using System.Data.Entity;
using System.Linq;
using System.Web.Mvc;
using KhmerFestival.Models;
using KhmerFestival.Models.ViewModels;

namespace KhmerFestival.Areas.Admin.Controllers
{
    [Authorize(Roles = "Admin")]
    public class DashboardController : Controller
    {
        private readonly KhmerFestivalContext _db = new KhmerFestivalContext();

        public ActionResult Index()
        {
            var vm = new DashboardViewModel
            {
                TongLehHoi = _db.LehHois.Count(x => !x.IsDeleted),
                TongBaiViet = _db.BaiViets.Count(x => !x.IsDeleted),
                TongBinhLuanChoDuyet = _db.BinhLuans.Count(x => x.TrangThai == "ChoDuyet"),
                TongTaiKhoan = _db.NguoiDungs.Count(),
                BinhLuanMoi = _db.BinhLuans.Include(x => x.NguoiDung).Where(x => x.TrangThai == "ChoDuyet").OrderByDescending(x => x.NgayTao).Take(5).ToList(),
                LehHoiSapDienRa = _db.LehHois.Where(x => !x.IsDeleted && x.NgayBatDau >= DateTime.Today).OrderBy(x => x.NgayBatDau).Take(5).ToList()
            };
            return View(vm);
        }
    }
}
