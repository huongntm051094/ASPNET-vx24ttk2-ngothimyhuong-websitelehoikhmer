using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace KhmerFestival.Models.Entities
{
    public class BaiViet
    {
        public int Id { get; set; }

        [Required, StringLength(300), Display(Name = "Tiêu đề")]
        public string TieuDe { get; set; }

        [StringLength(500), Display(Name = "Tóm tắt")]
        public string TomTat { get; set; }

        [Display(Name = "Nội dung")]
        public string NoiDung { get; set; }

        [StringLength(500)]
        public string AnhDaiDien { get; set; }

        public int? NguoiTaoId { get; set; }
        public bool IsDeleted { get; set; }
        public DateTime NgayTao { get; set; } = DateTime.Now;

        public virtual NguoiDung NguoiTao { get; set; }
        public virtual ICollection<BinhLuan> BinhLuans { get; set; }
        public virtual ICollection<LehHoiBaiViet> LehHoiBaiViets { get; set; }
    }
}
