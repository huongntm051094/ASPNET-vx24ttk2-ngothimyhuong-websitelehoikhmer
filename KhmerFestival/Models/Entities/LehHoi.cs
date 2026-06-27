using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace KhmerFestival.Models.Entities
{
    public class LehHoi
    {
        public int Id { get; set; }

        [Required, Display(Name = "Danh mục")]
        public int DanhMucId { get; set; }

        [Required, StringLength(200), Display(Name = "Tên lễ hội")]
        public string TenLehHoi { get; set; }

        [StringLength(500), Display(Name = "Tóm tắt")]
        public string TomTat { get; set; }

        [Display(Name = "Mô tả")]
        public string MoTa { get; set; }
        [Display(Name = "Ý nghĩa văn hóa")]
        public string YNghiaVanHoa { get; set; }
        [Display(Name = "Ngày bắt đầu")]
        public DateTime? NgayBatDau { get; set; }
        [Display(Name = "Ngày kết thúc")]
        public DateTime? NgayKetThuc { get; set; }

        [StringLength(200), Display(Name = "Địa điểm")]
        public string DiaDiem { get; set; }

        [StringLength(100), Display(Name = "Tỉnh/thành")]
        public string TinhThanh { get; set; }

        [StringLength(500)]
        public string AnhDaiDien { get; set; }

        public bool IsDeleted { get; set; }
        public DateTime NgayTao { get; set; } = DateTime.Now;
        public int? NguoiTaoId { get; set; }

        public virtual DanhMuc DanhMuc { get; set; }
        public virtual NguoiDung NguoiTao { get; set; }
        public virtual ICollection<HinhAnh> HinhAnhs { get; set; }
        public virtual ICollection<BinhLuan> BinhLuans { get; set; }
        public virtual ICollection<LehHoiBaiViet> LehHoiBaiViets { get; set; }
    }
}
