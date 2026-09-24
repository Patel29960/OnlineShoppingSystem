using System;
using System.Web;

namespace OnlineShoppingSystem
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
        }

        void Session_Start(object sender, EventArgs e)
        {
            // Initialize default session values
            Session["UserId"] = null;
            Session["UserName"] = null;
            Session["UserEmail"] = null;
            Session["UserRole"] = null; // "Customer" or "Admin"
        }
    }
}
