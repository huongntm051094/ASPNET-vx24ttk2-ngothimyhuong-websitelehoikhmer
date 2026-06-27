using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using KhmerFestival.App_Start;

namespace KhmerFestival
{
    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
        }

        protected void Application_PostAuthenticateRequest()
        {
            var cookie = Request.Cookies[FormsAuthentication.FormsCookieName];
            if (cookie == null) return;

            var ticket = FormsAuthentication.Decrypt(cookie.Value);
            if (ticket == null || ticket.Expired) return;

            var identity = new FormsIdentity(ticket);
            var roles = string.IsNullOrWhiteSpace(ticket.UserData) ? new string[0] : ticket.UserData.Split(',');
            Context.User = new System.Security.Principal.GenericPrincipal(identity, roles);
        }
    }
}
