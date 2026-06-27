using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using KhmerFestival.Models;
using KhmerFestival.Models.Entities;
using KhmerFestival.Services;

namespace KhmerFestival.Areas.Admin.Controllers
{
    [Authorize(Roles = "Admin")]
    public class LehHoiController : Controller
    {
        private readonly KhmerFestivalContext _db = new KhmerFestivalContext();

        public ActionResult Index(string q, int? danhMucId)
        {
            var query = _db.LehHois.Include(x => x.DanhMuc).Where(x => !x.IsDeleted);
            if (!string.IsNullOrWhiteSpace(q)) query = query.Where(x => x.TenLehHoi.Contains(q));
            if (danhMucId.HasValue) query = query.Where(x => x.DanhMucId == danhMucId.Value);
            ViewBag.DanhMucId = new SelectList(_db.DanhMucs, "Id", "TenDanhMuc", danhMucId);
            ViewBag.Query = q;
            return View(query.OrderByDescending(x => x.NgayTao).ToList());
        }

        public ActionResult Create()
        {
            FillDanhMuc();
            return View("Form", new LehHoi());
        }

        public ActionResult Details(int id)
        {
            var model = _db.LehHois
                .Include(x => x.DanhMuc)
                .Include(x => x.NguoiTao)
                .Include(x => x.HinhAnhs)
                .Include(x => x.BinhLuans.Select(b => b.NguoiDung))
                .Include(x => x.LehHoiBaiViets.Select(lb => lb.BaiViet))
                .FirstOrDefault(x => x.Id == id && !x.IsDeleted);
            if (model == null) return HttpNotFound();
            return View(model);
        }

        [HttpPost, ValidateAntiForgeryToken, ValidateInput(false)]
        public ActionResult Create(LehHoi model, HttpPostedFileBase anhDaiDien)
        {
            ValidateDates(model);
            if (!ModelState.IsValid)
            {
                FillDanhMuc(model.DanhMucId);
                return View("Form", model);
            }
            SaveImage(model, anhDaiDien);
            model.NgayTao = DateTime.Now;
            model.NguoiTaoId = Session["UserId"] as int?;
            _db.LehHois.Add(model);
            _db.SaveChanges();
            if (!string.IsNullOrWhiteSpace(model.AnhDaiDien))
            {
                _db.HinhAnhs.Add(new HinhAnh { LehHoiId = model.Id, DuongDan = model.AnhDaiDien, LaDaiDien = true });
                _db.SaveChanges();
            }
            TempData["Success"] = "Đã thêm lễ hội.";
            return RedirectToAction("Index");
        }

        public ActionResult Edit(int id)
        {
            var model = _db.LehHois.Find(id);
            if (model == null || model.IsDeleted) return HttpNotFound();
            FillDanhMuc(model.DanhMucId);
            return View("Form", model);
        }

        [HttpPost, ValidateAntiForgeryToken, ValidateInput(false)]
        public ActionResult Edit(LehHoi model, HttpPostedFileBase anhDaiDien)
        {
            ValidateDates(model);
            if (!ModelState.IsValid)
            {
                FillDanhMuc(model.DanhMucId);
                return View("Form", model);
            }
            SaveImage(model, anhDaiDien);
            _db.Entry(model).State = EntityState.Modified;
            _db.SaveChanges();
            TempData["Success"] = "Đã cập nhật lễ hội.";
            return RedirectToAction("Index");
        }

        public ActionResult Images(int id)
        {
            var model = _db.LehHois.Include(x => x.HinhAnhs).FirstOrDefault(x => x.Id == id && !x.IsDeleted);
            if (model == null) return HttpNotFound();
            return View(model);
        }

        [HttpPost, ValidateAntiForgeryToken]
        public ActionResult UploadImages(int id, IEnumerable<HttpPostedFileBase> images)
        {
            var model = _db.LehHois.Find(id);
            if (model == null || model.IsDeleted) return HttpNotFound();
            foreach (var image in images ?? Enumerable.Empty<HttpPostedFileBase>())
            {
                var path = new FileUploadService().SaveImage(image, "~/Content/Uploads/LehHoi/");
                if (!string.IsNullOrWhiteSpace(path))
                {
                    _db.HinhAnhs.Add(new HinhAnh { LehHoiId = id, DuongDan = path, LaDaiDien = false });
                }
            }
            _db.SaveChanges();
            TempData["Success"] = "Đã upload ảnh.";
            return RedirectToAction("Images", new { id });
        }

        [HttpPost, ValidateAntiForgeryToken]
        public ActionResult SetCover(int id)
        {
            var image = _db.HinhAnhs.Include(x => x.LehHoi).FirstOrDefault(x => x.Id == id);
            if (image == null) return HttpNotFound();
            var all = _db.HinhAnhs.Where(x => x.LehHoiId == image.LehHoiId).ToList();
            foreach (var item in all) item.LaDaiDien = item.Id == id;
            image.LehHoi.AnhDaiDien = image.DuongDan;
            _db.SaveChanges();
            TempData["Success"] = "Đã đặt ảnh đại diện.";
            return RedirectToAction("Images", new { id = image.LehHoiId });
        }

        [HttpPost, ValidateAntiForgeryToken]
        public ActionResult DeleteImage(int id)
        {
            var image = _db.HinhAnhs.Include(x => x.LehHoi).FirstOrDefault(x => x.Id == id);
            if (image == null) return HttpNotFound();
            var lehHoiId = image.LehHoiId;
            if (image.LaDaiDien && image.LehHoi.AnhDaiDien == image.DuongDan) image.LehHoi.AnhDaiDien = null;
            _db.HinhAnhs.Remove(image);
            _db.SaveChanges();
            TempData["Success"] = "Đã xóa ảnh.";
            return RedirectToAction("Images", new { id = lehHoiId });
        }

        [HttpPost, ValidateAntiForgeryToken]
        public ActionResult Delete(int id)
        {
            var model = _db.LehHois.Find(id);
            if (model == null) return HttpNotFound();
            model.IsDeleted = true;
            _db.SaveChanges();
            TempData["Success"] = "Đã xóa mềm lễ hội.";
            return RedirectToAction("Index");
        }

        private void FillDanhMuc(int? selected = null)
        {
            ViewBag.DanhMucId = new SelectList(_db.DanhMucs.OrderBy(x => x.TenDanhMuc), "Id", "TenDanhMuc", selected);
        }

        private void ValidateDates(LehHoi model)
        {
            if (model.NgayBatDau.HasValue && model.NgayKetThuc.HasValue && model.NgayKetThuc < model.NgayBatDau)
                ModelState.AddModelError("NgayKetThuc", "Ngày kết thúc phải lớn hơn hoặc bằng ngày bắt đầu.");
        }

        private void SaveImage(LehHoi model, HttpPostedFileBase image)
        {
            if (image == null || image.ContentLength == 0) return;
            model.AnhDaiDien = new FileUploadService().SaveImage(image, "~/Content/Uploads/LehHoi/");
        }
    }
}
