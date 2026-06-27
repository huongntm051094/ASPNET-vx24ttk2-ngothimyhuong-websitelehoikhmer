using System;
using System.Data.Entity;
using System.Linq;
using KhmerFestival.Helpers;
using KhmerFestival.Models;
using KhmerFestival.Models.Entities;

namespace KhmerFestival.Services
{
    public class AccountService
    {
        private readonly KhmerFestivalContext _db;

        public AccountService(KhmerFestivalContext db)
        {
            _db = db;
        }

        public bool EmailExists(string email)
        {
            return _db.NguoiDungs.Any(x => x.Email == email);
        }

        public NguoiDung Register(string hoTen, string email, string password)
        {
            var salt = PasswordHelper.CreateSalt();
            var user = new NguoiDung
            {
                HoTen = hoTen,
                Email = email,
                Salt = salt,
                MatKhau = PasswordHelper.HashPassword(password, salt),
                VaiTro = "Member",
                TrangThai = "HoatDong",
                NgayTao = DateTime.Now
            };
            _db.NguoiDungs.Add(user);
            _db.SaveChanges();
            return user;
        }

        public NguoiDung ValidateLogin(string email, string password)
        {
            var user = _db.NguoiDungs.FirstOrDefault(x => x.Email == email && x.TrangThai == "HoatDong");
            if (user == null) return null;
            var hash = PasswordHelper.HashPassword(password, user.Salt);
            return hash == user.MatKhau ? user : null;
        }

        public ResetPasswordToken CreateResetToken(string email)
        {
            var user = _db.NguoiDungs.FirstOrDefault(x => x.Email == email && x.TrangThai == "HoatDong");
            if (user == null) return null;

            var token = new ResetPasswordToken
            {
                NguoiDungId = user.Id,
                Token = Guid.NewGuid().ToString("N"),
                NgayTao = DateTime.Now,
                NgayHetHan = DateTime.Now.AddMinutes(30),
                DaSuDung = false
            };
            _db.ResetPasswordTokens.Add(token);
            _db.SaveChanges();
            return token;
        }

        public ResetPasswordToken GetValidResetToken(string token)
        {
            return _db.ResetPasswordTokens.Include(x => x.NguoiDung)
                .FirstOrDefault(x => x.Token == token && !x.DaSuDung && x.NgayHetHan >= DateTime.Now);
        }

        public void ResetPassword(string token, string newPassword)
        {
            var reset = GetValidResetToken(token);
            if (reset == null) throw new InvalidOperationException("Token không hợp lệ hoặc đã hết hạn.");
            var salt = PasswordHelper.CreateSalt();
            reset.NguoiDung.Salt = salt;
            reset.NguoiDung.MatKhau = PasswordHelper.HashPassword(newPassword, salt);
            reset.DaSuDung = true;
            _db.SaveChanges();
        }

        public bool ResetPasswordByEmail(string email, string newPassword)
        {
            var user = _db.NguoiDungs.FirstOrDefault(x => x.Email == email && x.TrangThai == "HoatDong");
            if (user == null) return false;

            var salt = PasswordHelper.CreateSalt();
            user.Salt = salt;
            user.MatKhau = PasswordHelper.HashPassword(newPassword, salt);
            _db.SaveChanges();
            return true;
        }

        public void CleanupExpiredTokens()
        {
            var expired = _db.ResetPasswordTokens.Where(x => x.NgayHetHan < DateTime.Now && !x.DaSuDung).ToList();
            _db.ResetPasswordTokens.RemoveRange(expired);
            _db.SaveChanges();
        }
    }
}
