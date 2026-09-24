using System;
using System.Web.UI;

namespace OnlineShoppingSystem.Admin
{
    public partial class AdminMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Security check: Only authenticated users with Admin role can access
            if (Session["UserId"] == null || Session["UserRole"] == null || Session["UserRole"].ToString() != "Admin")
            {
                Response.Redirect("~/Login.aspx?error=admin_required");
                return;
            }

            if (!IsPostBack)
            {
                litAdminName.Text = Session["UserName"] != null ? Session["UserName"].ToString() : "Admin";
            }
        }
    }
}
