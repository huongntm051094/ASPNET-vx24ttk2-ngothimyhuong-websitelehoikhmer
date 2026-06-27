using System.Data.Entity;
using KhmerFestival.Models.Entities;

namespace KhmerFestival.Models
{
    public class KhmerFestivalContext : DbContext
    {
        public KhmerFestivalContext() : base("name=KhmerFestivalContext") { }

        public DbSet<NguoiDung> NguoiDungs { get; set; }
        public DbSet<DanhMuc> DanhMucs { get; set; }
        public DbSet<LehHoi> LehHois { get; set; }
        public DbSet<HinhAnh> HinhAnhs { get; set; }
        public DbSet<BaiViet> BaiViets { get; set; }
        public DbSet<LehHoiBaiViet> LehHoiBaiViets { get; set; }
        public DbSet<BinhLuan> BinhLuans { get; set; }
        public DbSet<ResetPasswordToken> ResetPasswordTokens { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<NguoiDung>().ToTable("NguoiDung");
            modelBuilder.Entity<DanhMuc>().ToTable("DanhMuc");
            modelBuilder.Entity<LehHoi>().ToTable("LehHoi");
            modelBuilder.Entity<HinhAnh>().ToTable("HinhAnh");
            modelBuilder.Entity<BaiViet>().ToTable("BaiViet");
            modelBuilder.Entity<LehHoiBaiViet>().ToTable("LehHoi_BaiViet");
            modelBuilder.Entity<BinhLuan>().ToTable("BinhLuan");
            modelBuilder.Entity<ResetPasswordToken>().ToTable("ResetPasswordToken");

            modelBuilder.Entity<NguoiDung>().HasIndex(x => x.Email).IsUnique();
            modelBuilder.Entity<ResetPasswordToken>().HasIndex(x => x.Token).IsUnique();

            modelBuilder.Entity<LehHoiBaiViet>().HasKey(x => new { x.LehHoiId, x.BaiVietId });
            modelBuilder.Entity<LehHoiBaiViet>()
                .HasRequired(x => x.LehHoi).WithMany(x => x.LehHoiBaiViets).HasForeignKey(x => x.LehHoiId);
            modelBuilder.Entity<LehHoiBaiViet>()
                .HasRequired(x => x.BaiViet).WithMany(x => x.LehHoiBaiViets).HasForeignKey(x => x.BaiVietId);

            modelBuilder.Entity<BinhLuan>()
                .HasRequired(x => x.NguoiDung).WithMany(x => x.BinhLuans).HasForeignKey(x => x.NguoiDungId);
            modelBuilder.Entity<BinhLuan>()
                .HasOptional(x => x.LehHoi).WithMany(x => x.BinhLuans).HasForeignKey(x => x.LehHoiId);
            modelBuilder.Entity<BinhLuan>()
                .HasOptional(x => x.BaiViet).WithMany(x => x.BinhLuans).HasForeignKey(x => x.BaiVietId);

            base.OnModelCreating(modelBuilder);
        }
    }
}
