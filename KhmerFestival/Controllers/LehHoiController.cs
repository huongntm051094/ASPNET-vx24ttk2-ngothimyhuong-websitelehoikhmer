using System;
using System.Data.Entity;
using System.Linq;
using System.Web.Mvc;
using KhmerFestival.Helpers;
using KhmerFestival.Models;
using KhmerFestival.Models.ViewModels;
using KhmerFestival.Services;

namespace KhmerFestival.Controllers
{
    public class LehHoiController : Controller
    {
        private readonly KhmerFestivalContext _db = new KhmerFestivalContext();

        public ActionResult Index(string q, int? danhMucId, string tinhThanh, int? nam, int page = 1)
        {
            const int pageSize = 10;
            q = SlugHelper.SafeKeyword(q);
            var query = _db.LehHois.Include(x => x.DanhMuc).Where(x => !x.IsDeleted);
            if (!string.IsNullOrWhiteSpace(q)) query = query.Where(x => x.TenLehHoi.Contains(q));
            if (danhMucId.HasValue) query = query.Where(x => x.DanhMucId == danhMucId.Value);
            if (!string.IsNullOrWhiteSpace(tinhThanh)) query = query.Where(x => x.TinhThanh == tinhThanh);
            if (nam.HasValue) query = query.Where(x => x.NgayBatDau.HasValue && x.NgayBatDau.Value.Year == nam.Value);

            var total = query.Count();
            var vm = new LehHoiListViewModel
            {
                Items = query.OrderBy(x => x.NgayBatDau).Skip((page - 1) * pageSize).Take(pageSize).ToList(),
                DanhMucs = _db.DanhMucs.OrderBy(x => x.TenDanhMuc).ToList(),
                TuKhoa = q,
                DanhMucId = danhMucId,
                TinhThanh = tinhThanh,
                Nam = nam,
                Page = page,
                TotalPages = Math.Max(1, (int)Math.Ceiling(total / (double)pageSize))
            };
            return View(vm);
        }

        [Authorize]
        public ActionResult Details(int id)
        {
            var model = _db.LehHois
                .Include(x => x.DanhMuc)
                .Include(x => x.HinhAnhs)
                .Include(x => x.BinhLuans.Select(b => b.NguoiDung))
                .Include(x => x.LehHoiBaiViets.Select(lb => lb.BaiViet))
                .FirstOrDefault(x => x.Id == id && !x.IsDeleted);
            if (model == null) return HttpNotFound();
            ViewBag.Related = _db.LehHois.Where(x => !x.IsDeleted && x.Id != id && x.DanhMucId == model.DanhMucId).Take(3).ToList();
            return View(model);
        }

        [HttpPost, ValidateAntiForgeryToken]
        public ActionResult TaoBinhLuan(int lehHoiId, string noiDung)
        {
            if (!User.Identity.IsAuthenticated) return RedirectToAction("Login", "Account", new { ReturnUrl = Url.Action("Details", new { id = lehHoiId }) });
            if (string.IsNullOrWhiteSpace(noiDung) || noiDung.Length > 500)
            {
                TempData["Error"] = "Nội dung bình luận bắt buộc và tối đa 500 ký tự.";
                return RedirectToAction("Details", new { id = lehHoiId });
            }
            new BinhLuanService(_db).TaoChoLehHoi((int)Session["UserId"], lehHoiId, noiDung.Trim());
            TempData["Success"] = "Bình luận đang chờ duyệt.";
            return RedirectToAction("Details", new { id = lehHoiId });
        }
    }
}
