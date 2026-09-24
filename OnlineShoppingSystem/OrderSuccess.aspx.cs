using System;
using System.Data;
using System.Data.SqlClient;

namespace OnlineShoppingSystem
{
    public partial class OrderSuccess : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                string orderIdStr = Request.QueryString["orderId"];
                int orderId = 0;
                if (int.TryParse(orderIdStr, out orderId))
                {
                    LoadOrderDetails(orderId);
                }
                else
                {
                    Response.Redirect("Default.aspx");
                }
            }
        }

        private void LoadOrderDetails(int orderId)
        {
            int userId = Convert.ToInt32(Session["UserId"]);
            string query = "SELECT OrderId, OrderDate, TotalAmount, ShippingAddress, PaymentMethod FROM Orders WHERE OrderId = @OrderId AND UserId = @UserId";
            SqlParameter[] p = {
                new SqlParameter("@OrderId", SqlDbType.Int) { Value = orderId },
                new SqlParameter("@UserId", SqlDbType.Int) { Value = userId }
            };

            DataTable dt = DBHelper.GetData(query, p);
            if (dt.Rows.Count > 0)
            {
                DataRow r = dt.Rows[0];
                litOrderId.Text = r["OrderId"].ToString();
                litOrderDate.Text = Convert.ToDateTime(r["OrderDate"]).ToString("dd MMM yyyy, hh:mm tt");
                litPayment.Text = r["PaymentMethod"].ToString();
                litTotal.Text = Convert.ToDecimal(r["TotalAmount"]).ToString("F2");
                litShipping.Text = r["ShippingAddress"].ToString();
            }
            else
            {
                Response.Redirect("Default.aspx");
            }
        }
    }
}
