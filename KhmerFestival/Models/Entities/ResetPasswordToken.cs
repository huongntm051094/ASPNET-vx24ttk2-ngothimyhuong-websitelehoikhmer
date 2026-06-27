using System;
using System.ComponentModel.DataAnnotations;

namespace KhmerFestival.Models.Entities
{
    public class ResetPasswordToken
    {
        public int Id { get; set; }
        public int NguoiDungId { get; set; }

        [Required, StringLength(128)]
        public string Token { get; set; }

        public DateTime NgayTao { get; set; } = DateTime.Now;
        public DateTime NgayHetHan { get; set; }
        public bool DaSuDung { get; set; }

        public virtual NguoiDung NguoiDung { get; set; }
    }
}
