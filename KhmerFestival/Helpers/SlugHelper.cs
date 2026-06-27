using System.Text.RegularExpressions;

namespace KhmerFestival.Helpers
{
    public static class SlugHelper
    {
        public static string SafeKeyword(string value)
        {
            if (string.IsNullOrWhiteSpace(value)) return string.Empty;
            return Regex.Replace(value.Trim(), @"[^\p{L}\p{N}\s\-]", string.Empty);
        }
    }
}
