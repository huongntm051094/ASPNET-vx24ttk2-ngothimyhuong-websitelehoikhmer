using System;
using System.Data.Entity;
using System.Linq;
using System.Web.Mvc;
using KhmerFestival.Models;
using KhmerFestival.Models.ViewModels;

namespace KhmerFestival.Controllers
{
    public class HomeController : Controller
    {
        private readonly KhmerFestivalContext _db = new KhmerFestivalContext();

        public ActionResult Index()
        {
            var vm = new HomeViewModel
            {
                SapDienRa = _db.LehHois.Include(x => x.DanhMuc)
                    .Where(x => !x.IsDeleted && x.NgayBatDau >= DateTime.Today)
                    .OrderBy(x => x.NgayBatDau).Take(6).ToList(),
                BaiVietMoi = _db.BaiViets.Where(x => !x.IsDeleted).OrderByDescending(x => x.NgayTao).Take(6).ToList(),
                DanhMucs = _db.DanhMucs.OrderBy(x => x.TenDanhMuc).ToList()
            };
            return View(vm);
        }

        public ActionResult About()
        {
            return View();
        }
    }
}
