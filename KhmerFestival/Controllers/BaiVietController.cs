using System.Data.Entity;
using System.Linq;
using System.Web.Mvc;
using KhmerFestival.Models;
using KhmerFestival.Services;

namespace KhmerFestival.Controllers
{
    public class BaiVietController : Controller
    {
        private readonly KhmerFestivalContext _db = new KhmerFestivalContext();

        public ActionResult Index()
        {
            return View(_db.BaiViets.Where(x => !x.IsDeleted).OrderByDescending(x => x.NgayTao).ToList());
        }

        [Authorize]
        public ActionResult Details(int id)
        {
            var model = _db.BaiViets.Include(x => x.NguoiTao)
                .Include(x => x.BinhLuans.Select(b => b.NguoiDung))
                .FirstOrDefault(x => x.Id == id && !x.IsDeleted);
            if (model == null) return HttpNotFound();
            return View(model);
        }

        [HttpPost, ValidateAntiForgeryToken]
        public ActionResult TaoBinhLuan(int baiVietId, string noiDung)
        {
            if (!User.Identity.IsAuthenticated) return RedirectToAction("Login", "Account", new { ReturnUrl = Url.Action("Details", new { id = baiVietId }) });
            if (string.IsNullOrWhiteSpace(noiDung) || noiDung.Length > 500)
            {
                TempData["Error"] = "Nội dung bình luận bắt buộc và tối đa 500 ký tự.";
                return RedirectToAction("Details", new { id = baiVietId });
            }
            new BinhLuanService(_db).TaoChoBaiViet((int)Session["UserId"], baiVietId, noiDung.Trim());
            TempData["Success"] = "Bình luận đang chờ duyệt.";
            return RedirectToAction("Details", new { id = baiVietId });
        }
    }
}
