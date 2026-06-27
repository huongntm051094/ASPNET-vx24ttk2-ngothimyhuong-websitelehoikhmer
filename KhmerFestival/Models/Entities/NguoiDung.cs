using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace KhmerFestival.Models.Entities
{
    public class NguoiDung
    {
        public int Id { get; set; }

        [Required, StringLength(100)]
        public string HoTen { get; set; }

        [Required, EmailAddress, StringLength(150)]
        public string Email { get; set; }

        [Required, StringLength(256)]
        public string MatKhau { get; set; }

        [Required, StringLength(64)]
        public string Salt { get; set; }

        [Required, StringLength(20)]
        public string VaiTro { get; set; } = "Member";

        [Required, StringLength(20)]
        public string TrangThai { get; set; } = "HoatDong";

        public DateTime NgayTao { get; set; } = DateTime.Now;

        public virtual ICollection<BinhLuan> BinhLuans { get; set; }
    }
}
