using System;
using System.Data;
using System.Data.SqlClient;

namespace OnlineShoppingSystem
{
    public partial class Profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx?login_required=true&ReturnUrl=Profile.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadUserProfile();
                LoadOrderHistory();
            }
        }

        private void LoadUserProfile()
        {
            int userId = Convert.ToInt32(Session["UserId"]);
            string query = "SELECT FullName, Email, Role, CreatedAt FROM Users WHERE UserId = @UserId";
            SqlParameter[] parameters = {
                new SqlParameter("@UserId", SqlDbType.Int) { Value = userId }
            };

            DataTable dt = DBHelper.GetData(query, parameters);
            if (dt.Rows.Count > 0)
            {
                DataRow r = dt.Rows[0];
                litFullName.Text = r["FullName"].ToString();
                litEmail.Text = r["Email"].ToString();
                litRole.Text = r["Role"].ToString();
                litJoinedDate.Text = Convert.ToDateTime(r["CreatedAt"]).ToString("MMM yyyy");
            }
        }

        private void LoadOrderHistory()
        {
            int userId = Convert.ToInt32(Session["UserId"]);
            string query = @"SELECT OrderId, OrderDate, TotalAmount, ShippingAddress, PaymentMethod, OrderStatus 
                             FROM Orders 
                             WHERE UserId = @UserId 
                             ORDER BY OrderId DESC";

            SqlParameter[] parameters = {
                new SqlParameter("@UserId", SqlDbType.Int) { Value = userId }
            };

            DataTable dt = DBHelper.GetData(query, parameters);
            litTotalOrders.Text = dt.Rows.Count.ToString();

            if (dt.Rows.Count > 0)
            {
                gvOrders.DataSource = dt;
                gvOrders.DataBind();
                gvOrders.Visible = true;
                pnlNoOrders.Visible = false;
            }
            else
            {
                gvOrders.Visible = false;
                pnlNoOrders.Visible = true;
            }
        }
    }
}
