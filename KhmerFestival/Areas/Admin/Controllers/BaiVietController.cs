using System;
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
    public class BaiVietController : Controller
    {
        private readonly KhmerFestivalContext _db = new KhmerFestivalContext();

        public ActionResult Index(string q)
        {
            var query = _db.BaiViets.Where(x => !x.IsDeleted);
            if (!string.IsNullOrWhiteSpace(q)) query = query.Where(x => x.TieuDe.Contains(q));
            ViewBag.Query = q;
            return View(query.OrderByDescending(x => x.NgayTao).ToList());
        }

        public ActionResult Create()
        {
            FillLehHoi();
            return View("Form", new BaiViet());
        }

        public ActionResult Details(int id)
        {
            var model = _db.BaiViets
                .Include(x => x.NguoiTao)
                .Include(x => x.BinhLuans.Select(b => b.NguoiDung))
                .Include(x => x.LehHoiBaiViets.Select(lb => lb.LehHoi))
                .FirstOrDefault(x => x.Id == id && !x.IsDeleted);
            if (model == null) return HttpNotFound();
            return View(model);
        }

        [HttpPost, ValidateAntiForgeryToken, ValidateInput(false)]
        public ActionResult Create(BaiViet model, HttpPostedFileBase anhDaiDien, int[] selectedLehHoiIds)
        {
            if (!ModelState.IsValid)
            {
                FillLehHoi(selectedLehHoiIds);
                return View("Form", model);
            }
            model.AnhDaiDien = new FileUploadService().SaveImage(anhDaiDien, "~/Content/Uploads/BaiViet/");
            model.NgayTao = DateTime.Now;
            model.NguoiTaoId = Session["UserId"] as int?;
            _db.BaiViets.Add(model);
            _db.SaveChanges();
            SaveRelatedFestivals(model.Id, selectedLehHoiIds);
            TempData["Success"] = "Đã thêm bài viết.";
            return RedirectToAction("Index");
        }

        public ActionResult Edit(int id)
        {
            var model = _db.BaiViets.Include(x => x.LehHoiBaiViets).FirstOrDefault(x => x.Id == id);
            if (model == null || model.IsDeleted) return HttpNotFound();
            FillLehHoi(model.LehHoiBaiViets.Select(x => x.LehHoiId).ToArray());
            return View("Form", model);
        }

        [HttpPost, ValidateAntiForgeryToken, ValidateInput(false)]
        public ActionResult Edit(BaiViet model, HttpPostedFileBase anhDaiDien, int[] selectedLehHoiIds)
        {
            if (!ModelState.IsValid)
            {
                FillLehHoi(selectedLehHoiIds);
                return View("Form", model);
            }
            var newImage = new FileUploadService().SaveImage(anhDaiDien, "~/Content/Uploads/BaiViet/");
            if (!string.IsNullOrWhiteSpace(newImage)) model.AnhDaiDien = newImage;
            _db.Entry(model).State = EntityState.Modified;
            _db.SaveChanges();
            SaveRelatedFestivals(model.Id, selectedLehHoiIds);
            TempData["Success"] = "Đã cập nhật bài viết.";
            return RedirectToAction("Index");
        }

        [HttpPost, ValidateAntiForgeryToken]
        public ActionResult Delete(int id)
        {
            var model = _db.BaiViets.Find(id);
            if (model == null) return HttpNotFound();
            model.IsDeleted = true;
            _db.SaveChanges();
            TempData["Success"] = "Đã xóa mềm bài viết.";
            return RedirectToAction("Index");
        }

        private void FillLehHoi(int[] selected = null)
        {
            ViewBag.LehHois = _db.LehHois.Where(x => !x.IsDeleted).OrderBy(x => x.TenLehHoi).ToList();
            ViewBag.SelectedLehHoiIds = selected ?? new int[0];
        }

        private void SaveRelatedFestivals(int baiVietId, int[] selectedLehHoiIds)
        {
            var current = _db.LehHoiBaiViets.Where(x => x.BaiVietId == baiVietId).ToList();
            _db.LehHoiBaiViets.RemoveRange(current);
            foreach (var lehHoiId in selectedLehHoiIds ?? new int[0])
            {
                _db.LehHoiBaiViets.Add(new LehHoiBaiViet { BaiVietId = baiVietId, LehHoiId = lehHoiId });
            }
            _db.SaveChanges();
        }
    }
}
