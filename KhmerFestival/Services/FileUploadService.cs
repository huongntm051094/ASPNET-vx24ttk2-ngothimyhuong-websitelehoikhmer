using System;
using System.IO;
using System.Linq;
using System.Web;

namespace KhmerFestival.Services
{
    public class FileUploadService
    {
        private static readonly string[] AllowedExtensions = { ".jpg", ".jpeg", ".png" };
        private static readonly string[] AllowedMimeTypes = { "image/jpeg", "image/png" };
        private const int MaxBytes = 2 * 1024 * 1024;

        public string SaveImage(HttpPostedFileBase file, string virtualFolder)
        {
            if (file == null || file.ContentLength == 0) return null;
            var ext = Path.GetExtension(file.FileName).ToLowerInvariant();
            if (!AllowedExtensions.Contains(ext) || !AllowedMimeTypes.Contains(file.ContentType) || file.ContentLength > MaxBytes)
            {
                throw new InvalidOperationException("Ảnh upload chỉ chấp nhận .jpg/.jpeg/.png và tối đa 2MB.");
            }

            var folder = HttpContext.Current.Server.MapPath(virtualFolder);
            Directory.CreateDirectory(folder);
            var fileName = Guid.NewGuid().ToString("N") + ext;
            var path = Path.Combine(folder, fileName);
            file.SaveAs(path);
            return VirtualPathUtility.Combine(virtualFolder, fileName);
        }
    }
}
