using System.Data.Entity;
using System.Linq;
using System.Web.Mvc;
using KhmerFestival.Models;

namespace KhmerFestival.Areas.Admin.Controllers
{
    [Authorize(Roles = "Admin")]
    public class BinhLuanController : Controller
    {
        private readonly KhmerFestivalContext _db = new KhmerFestivalContext();

        public ActionResult Index(string trangThai = "ChoDuyet")
        {
            ViewBag.TrangThai = trangThai;
            return View(_db.BinhLuans.Include(x => x.NguoiDung).Include(x => x.LehHoi).Include(x => x.BaiViet)
                .Where(x => x.TrangThai == trangThai).OrderByDescending(x => x.NgayTao).ToList());
        }

        [HttpPost, ValidateAntiForgeryToken]
        public ActionResult UpdateStatus(int id, string trangThai)
        {
            var model = _db.BinhLuans.Find(id);
            if (model == null) return HttpNotFound();
            model.TrangThai = trangThai == "DaDuyet" ? "DaDuyet" : "BiAn";
            _db.SaveChanges();
            TempData["Success"] = "Đã cập nhật bình luận.";
            return RedirectToAction("Index");
        }
    }
}
