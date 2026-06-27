using System.Collections.Generic;
using KhmerFestival.Models.Entities;

namespace KhmerFestival.Models.ViewModels
{
    public class HomeViewModel
    {
        public IEnumerable<LehHoi> SapDienRa { get; set; }
        public IEnumerable<BaiViet> BaiVietMoi { get; set; }
        public IEnumerable<DanhMuc> DanhMucs { get; set; }
    }

    public class LehHoiListViewModel
    {
        public IEnumerable<LehHoi> Items { get; set; }
        public IEnumerable<DanhMuc> DanhMucs { get; set; }
        public string TuKhoa { get; set; }
        public int? DanhMucId { get; set; }
        public string TinhThanh { get; set; }
        public int? Nam { get; set; }
        public int Page { get; set; }
        public int TotalPages { get; set; }
    }

    public class SearchViewModel
    {
        public string TuKhoa { get; set; }
        public IEnumerable<LehHoi> LehHois { get; set; }
        public IEnumerable<BaiViet> BaiViets { get; set; }
    }
}
