using System;
using System.Security.Cryptography;
using System.Text;

namespace KhmerFestival.Helpers
{
    public static class PasswordHelper
    {
        public static string CreateSalt()
        {
            var bytes = new byte[32];
            using (var rng = RandomNumberGenerator.Create())
            {
                rng.GetBytes(bytes);
            }
            return Convert.ToBase64String(bytes);
        }

        public static string HashPassword(string password, string salt)
        {
            using (var sha = SHA256.Create())
            {
                var input = Encoding.UTF8.GetBytes(password + salt);
                return Convert.ToBase64String(sha.ComputeHash(input));
            }
        }
    }
}
