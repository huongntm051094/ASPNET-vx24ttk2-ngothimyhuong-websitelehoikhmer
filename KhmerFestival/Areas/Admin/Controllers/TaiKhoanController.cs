using System.Linq;
using System.Web.Mvc;
using KhmerFestival.Models;

namespace KhmerFestival.Areas.Admin.Controllers
{
    [Authorize(Roles = "Admin")]
    public class TaiKhoanController : Controller
    {
        private readonly KhmerFestivalContext _db = new KhmerFestivalContext();

        public ActionResult Index(string q)
        {
            var query = _db.NguoiDungs.AsQueryable();
            if (!string.IsNullOrWhiteSpace(q)) query = query.Where(x => x.Email.Contains(q) || x.HoTen.Contains(q));
            ViewBag.Query = q;
            return View(query.OrderByDescending(x => x.NgayTao).ToList());
        }
    }
}
