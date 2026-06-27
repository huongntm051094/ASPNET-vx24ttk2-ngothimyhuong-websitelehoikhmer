using System;
using System.Configuration;
using System.Web.Mvc;
using System.Web.Security;
using KhmerFestival.Helpers;
using KhmerFestival.Models;
using KhmerFestival.Models.ViewModels;
using KhmerFestival.Services;

namespace KhmerFestival.Controllers
{
    public class AccountController : Controller
    {
        private readonly KhmerFestivalContext _db = new KhmerFestivalContext();

        public ActionResult Register() => View(new RegisterViewModel());

        [HttpPost, ValidateAntiForgeryToken]
        public ActionResult Register(RegisterViewModel model)
        {
            var service = new AccountService(_db);
            if (service.EmailExists(model.Email)) ModelState.AddModelError("Email", "Email đã được đăng ký.");
            if (!ModelState.IsValid) return View(model);
            service.Register(model.HoTen, model.Email, model.MatKhau);
            TempData["Success"] = "Đăng ký thành công.";
            return RedirectToAction("Index", "Home");
        }

        public ActionResult Login(string returnUrl)
        {
            return View(new LoginViewModel { ReturnUrl = returnUrl });
        }

        [HttpPost, ValidateAntiForgeryToken]
        public ActionResult Login(LoginViewModel model)
        {
            if (!ModelState.IsValid) return View(model);
            var service = new AccountService(_db);
            service.CleanupExpiredTokens();
            var user = service.ValidateLogin(model.Email, model.MatKhau);
            if (user == null)
            {
                ModelState.AddModelError("", "Email hoặc mật khẩu không đúng.");
                return View(model);
            }

            var ticket = new FormsAuthenticationTicket(1, user.Email, DateTime.Now, DateTime.Now.AddMinutes(60), model.RememberMe, user.VaiTro);
            Response.Cookies.Add(new System.Web.HttpCookie(FormsAuthentication.FormsCookieName, FormsAuthentication.Encrypt(ticket)));
            Session["UserId"] = user.Id;
            Session["VaiTro"] = user.VaiTro;
            Session["HoTen"] = user.HoTen;

            if (!string.IsNullOrWhiteSpace(model.ReturnUrl) && Url.IsLocalUrl(model.ReturnUrl)) return Redirect(model.ReturnUrl);
            return RedirectToAction("Index", "Home");
        }

        public ActionResult Logout()
        {
            FormsAuthentication.SignOut();
            Session.Clear();
            return RedirectToAction("Index", "Home");
        }

        public ActionResult ForgotPassword() => View(new ForgotPasswordViewModel());

        [HttpPost, ValidateAntiForgeryToken]
        public ActionResult ForgotPassword(ForgotPasswordViewModel model)
        {
            if (!ModelState.IsValid) return View(model);
            new AccountService(_db).ResetPasswordByEmail(model.Email, model.MatKhauMoi);
            return RedirectToAction("ForgotPasswordConfirmation");
        }

        public ActionResult ForgotPasswordConfirmation() => View();

        public ActionResult ResetPassword(string token)
        {
            if (string.IsNullOrWhiteSpace(token) || new AccountService(_db).GetValidResetToken(token) == null)
            {
                ViewBag.InvalidToken = true;
            }
            return View(new ResetPasswordViewModel { Token = token });
        }

        [HttpPost, ValidateAntiForgeryToken]
        public ActionResult ResetPassword(ResetPasswordViewModel model)
        {
            if (!ModelState.IsValid) return View(model);
            try
            {
                new AccountService(_db).ResetPassword(model.Token, model.MatKhauMoi);
                TempData["Success"] = "Đặt lại mật khẩu thành công. Vui lòng đăng nhập.";
                return RedirectToAction("Login");
            }
            catch (InvalidOperationException ex)
            {
                ModelState.AddModelError("", ex.Message);
                return View(model);
            }
        }

        [Authorize]
        public new ActionResult Profile()
        {
            var user = _db.NguoiDungs.Find((int)Session["UserId"]);
            if (user == null) return RedirectToAction("Login");
            return View(new ProfileViewModel { HoTen = user.HoTen, Email = user.Email, NgayTao = user.NgayTao.ToString("dd/MM/yyyy") });
        }

        [HttpPost, Authorize, ValidateAntiForgeryToken]
        public new ActionResult Profile(ProfileViewModel model)
        {
            var user = _db.NguoiDungs.Find((int)Session["UserId"]);
            if (user == null) return RedirectToAction("Login");

            if (!ModelState.IsValid)
            {
                model.Email = user.Email;
                model.NgayTao = user.NgayTao.ToString("dd/MM/yyyy");
                return View(model);
            }

            user.HoTen = model.HoTen;
            if (!string.IsNullOrWhiteSpace(model.MatKhauMoi))
            {
                var currentHash = PasswordHelper.HashPassword(model.MatKhauCu ?? "", user.Salt);
                if (currentHash != user.MatKhau)
                {
                    ModelState.AddModelError("MatKhauCu", "Mật khẩu cũ không đúng.");
                    model.Email = user.Email;
                    model.NgayTao = user.NgayTao.ToString("dd/MM/yyyy");
                    return View(model);
                }
                user.Salt = PasswordHelper.CreateSalt();
                user.MatKhau = PasswordHelper.HashPassword(model.MatKhauMoi, user.Salt);
            }
            _db.SaveChanges();
            Session["HoTen"] = user.HoTen;
            TempData["Success"] = "Đã cập nhật hồ sơ.";
            return RedirectToAction("Profile");
        }
    }
}
