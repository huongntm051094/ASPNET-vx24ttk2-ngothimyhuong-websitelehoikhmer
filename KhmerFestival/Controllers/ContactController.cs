using System.Web.Mvc;
using KhmerFestival.Services;

namespace KhmerFestival.Controllers
{
    public class ContactController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost, ValidateAntiForgeryToken]
        public ActionResult Index(string hoTen, string email, string noiDung)
        {
            if (string.IsNullOrWhiteSpace(hoTen) || string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(noiDung))
            {
                ModelState.AddModelError("", "Vui lòng nhập đầy đủ thông tin liên hệ.");
                return View();
            }
            TempData["Success"] = "Cảm ơn bạn đã liên hệ. Chúng tôi sẽ phản hồi sớm.";
            return RedirectToAction("Index");
        }
    }
}
