using System.ComponentModel.DataAnnotations;

namespace KhmerFestival.Models.ViewModels
{
    public class RegisterViewModel
    {
        [Required, StringLength(100), Display(Name = "Họ tên")]
        public string HoTen { get; set; }

        [Required, EmailAddress, StringLength(150)]
        public string Email { get; set; }

        [Required, MinLength(6), DataType(DataType.Password), Display(Name = "Mật khẩu")]
        public string MatKhau { get; set; }

        [Required, DataType(DataType.Password), Compare("MatKhau"), Display(Name = "Nhập lại mật khẩu")]
        public string XacNhanMatKhau { get; set; }
    }

    public class LoginViewModel
    {
        [Required, EmailAddress]
        public string Email { get; set; }

        [Required, DataType(DataType.Password), Display(Name = "Mật khẩu")]
        public string MatKhau { get; set; }

        public bool RememberMe { get; set; }
        public string ReturnUrl { get; set; }
    }

    public class ForgotPasswordViewModel
    {
        [Required, EmailAddress]
        public string Email { get; set; }

        [Required, MinLength(6), DataType(DataType.Password), Display(Name = "Mật khẩu mới")]
        public string MatKhauMoi { get; set; }

        [Required, DataType(DataType.Password), Compare("MatKhauMoi"), Display(Name = "Nhập lại mật khẩu mới")]
        public string XacNhanMatKhau { get; set; }
    }

    public class ResetPasswordViewModel
    {
        [Required]
        public string Token { get; set; }

        [Required, MinLength(6), DataType(DataType.Password), Display(Name = "Mật khẩu mới")]
        public string MatKhauMoi { get; set; }

        [Required, DataType(DataType.Password), Compare("MatKhauMoi"), Display(Name = "Nhập lại mật khẩu")]
        public string XacNhanMatKhau { get; set; }
    }

    public class ProfileViewModel
    {
        [Required, StringLength(100), Display(Name = "Họ tên")]
        public string HoTen { get; set; }
        public string Email { get; set; }
        public string NgayTao { get; set; }

        [DataType(DataType.Password), Display(Name = "Mật khẩu cũ")]
        public string MatKhauCu { get; set; }
        [MinLength(6), DataType(DataType.Password), Display(Name = "Mật khẩu mới")]
        public string MatKhauMoi { get; set; }
        [DataType(DataType.Password), Compare("MatKhauMoi"), Display(Name = "Nhập lại mật khẩu mới")]
        public string XacNhanMatKhauMoi { get; set; }
    }
}
