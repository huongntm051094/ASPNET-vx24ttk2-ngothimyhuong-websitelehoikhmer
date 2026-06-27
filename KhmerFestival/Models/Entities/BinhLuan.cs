using System;
using System.ComponentModel.DataAnnotations;

namespace KhmerFestival.Models.Entities
{
    public class BinhLuan
    {
        public int Id { get; set; }
        public int NguoiDungId { get; set; }
        public int? LehHoiId { get; set; }
        public int? BaiVietId { get; set; }

        [Required, StringLength(500)]
        public string NoiDung { get; set; }

        [Required, StringLength(20)]
        public string TrangThai { get; set; } = "ChoDuyet";

        public DateTime NgayTao { get; set; } = DateTime.Now;

        public virtual NguoiDung NguoiDung { get; set; }
        public virtual LehHoi LehHoi { get; set; }
        public virtual BaiViet BaiViet { get; set; }
    }
}
