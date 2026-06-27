namespace KhmerFestival.Models.Entities
{
    public class LehHoiBaiViet
    {
        public int LehHoiId { get; set; }
        public int BaiVietId { get; set; }

        public virtual LehHoi LehHoi { get; set; }
        public virtual BaiViet BaiViet { get; set; }
    }
}
