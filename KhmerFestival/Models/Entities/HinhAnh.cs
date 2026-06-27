using System;
using System.ComponentModel.DataAnnotations;

namespace KhmerFestival.Models.Entities
{
    public class HinhAnh
    {
        public int Id { get; set; }
        public int LehHoiId { get; set; }

        [Required, StringLength(500)]
        public string DuongDan { get; set; }

        [StringLength(200)]
        public string MoTa { get; set; }

        public bool LaDaiDien { get; set; }
        public DateTime NgayTao { get; set; } = DateTime.Now;

        public virtual LehHoi LehHoi { get; set; }
    }
}
