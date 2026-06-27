using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace KhmerFestival.Models.Entities
{
    public class DanhMuc
    {
        public int Id { get; set; }

        [Required, StringLength(100), Display(Name = "Tên danh mục")]
        public string TenDanhMuc { get; set; }

        [StringLength(500), Display(Name = "Mô tả")]
        public string MoTa { get; set; }

        public virtual ICollection<LehHoi> LehHois { get; set; }
    }
}
