using System.Linq;
using System.Web.Mvc;
using KhmerFestival.Helpers;
using KhmerFestival.Models;
using KhmerFestival.Models.ViewModels;

namespace KhmerFestival.Controllers
{
    public class SearchController : Controller
    {
        private readonly KhmerFestivalContext _db = new KhmerFestivalContext();

        public ActionResult Index(string q)
        {
            q = SlugHelper.SafeKeyword(q);
            var vm = new SearchViewModel
            {
                TuKhoa = q,
                LehHois = string.IsNullOrWhiteSpace(q) ? Enumerable.Empty<Models.Entities.LehHoi>() : _db.LehHois.Where(x => !x.IsDeleted && x.TenLehHoi.Contains(q)).Take(20).ToList(),
                BaiViets = string.IsNullOrWhiteSpace(q) ? Enumerable.Empty<Models.Entities.BaiViet>() : _db.BaiViets.Where(x => !x.IsDeleted && x.TieuDe.Contains(q)).Take(20).ToList()
            };
            return View(vm);
        }
    }
}
