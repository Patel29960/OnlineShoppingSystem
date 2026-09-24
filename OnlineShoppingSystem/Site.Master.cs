using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace OnlineShoppingSystem
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CheckUserAuthentication();
                UpdateCartBadge();
            }
        }

        private void CheckUserAuthentication()
        {
            if (Session["UserId"] != null)
            {
                pnlLoggedIn.Visible = true;
                pnlAnonymous.Visible = false;
                litUserName.Text = Session["UserName"] != null ? Session["UserName"].ToString() : "Account";

                // Show Admin Panel shortcut if logged in user is Admin
                if (Session["UserRole"] != null && Session["UserRole"].ToString() == "Admin")
                {
                    phAdminLink.Visible = true;
                }
                else
                {
                    phAdminLink.Visible = false;
                }
            }
            else
            {
                pnlLoggedIn.Visible = false;
                pnlAnonymous.Visible = true;
                phAdminLink.Visible = false;
            }
        }

        public void UpdateCartBadge()
        {
            if (Session["UserId"] != null)
            {
                int userId = Convert.ToInt32(Session["UserId"]);
                string query = "SELECT ISNULL(SUM(Quantity), 0) FROM Cart WHERE UserId = @UserId";
                SqlParameter[] parameters = {
                    new SqlParameter("@UserId", SqlDbType.Int) { Value = userId }
                };

                object countObj = DBHelper.ExecuteScalar(query, parameters);
                int count = countObj != null ? Convert.ToInt32(countObj) : 0;
                litCartCount.Text = count.ToString();
            }
            else
            {
                litCartCount.Text = "0";
            }
        }
    }
}
