using System.Configuration;
using System.Net.Mail;

namespace KhmerFestival.Services
{
    public class MailService
    {
        public void Send(string to, string subject, string body)
        {
            var from = ConfigurationManager.AppSettings["SmtpFrom"] ?? "no-reply@khmer-lehoi.vn";
            using (var message = new MailMessage(from, to, subject, body))
            using (var client = new SmtpClient())
            {
                message.IsBodyHtml = true;
                client.Send(message);
            }
        }
    }
}
