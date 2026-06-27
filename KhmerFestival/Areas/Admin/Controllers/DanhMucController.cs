using System.Data.Entity;
using System.Linq;
using System.Web.Mvc;
using KhmerFestival.Models;
using KhmerFestival.Models.Entities;

namespace KhmerFestival.Areas.Admin.Controllers
{
    [Authorize(Roles = "Admin")]
    public class DanhMucController : Controller
    {
        private readonly KhmerFestivalContext _db = new KhmerFestivalContext();

        public ActionResult Index()
        {
            return View(_db.DanhMucs.Include(x => x.LehHois).OrderBy(x => x.TenDanhMuc).ToList());
        }

        public ActionResult Create() => View("Form", new DanhMuc());

        [HttpPost, ValidateAntiForgeryToken]
        public ActionResult Create(DanhMuc model)
        {
            if (!ModelState.IsValid) return View("Form", model);
            _db.DanhMucs.Add(model);
            _db.SaveChanges();
            TempData["Success"] = "Đã thêm danh mục.";
            return RedirectToAction("Index");
        }

        public ActionResult Edit(int id)
        {
            var model = _db.DanhMucs.Find(id);
            if (model == null) return HttpNotFound();
            return View("Form", model);
        }

        [HttpPost, ValidateAntiForgeryToken]
        public ActionResult Edit(DanhMuc model)
        {
            if (!ModelState.IsValid) return View("Form", model);
            _db.Entry(model).State = EntityState.Modified;
            _db.SaveChanges();
            TempData["Success"] = "Đã cập nhật danh mục.";
            return RedirectToAction("Index");
        }

        [HttpPost, ValidateAntiForgeryToken]
        public ActionResult Delete(int id)
        {
            var model = _db.DanhMucs.Include(x => x.LehHois).FirstOrDefault(x => x.Id == id);
            if (model == null) return HttpNotFound();
            if (model.LehHois.Any(x => !x.IsDeleted))
            {
                TempData["Error"] = "Không thể xóa danh mục đang có lễ hội.";
                return RedirectToAction("Index");
            }
            _db.DanhMucs.Remove(model);
            _db.SaveChanges();
            TempData["Success"] = "Đã xóa danh mục.";
            return RedirectToAction("Index");
        }
    }
}
