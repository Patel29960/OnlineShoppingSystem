using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace OnlineShoppingSystem.Admin
{
    public partial class ManageOrders : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindOrders();
            }
        }

        private void BindOrders()
        {
            string filter = ddlStatusFilter.SelectedValue;
            string sql = @"SELECT o.OrderId, o.OrderDate, o.TotalAmount, o.ShippingAddress, o.PaymentMethod, 
                                  o.OrderStatus, u.FullName, u.Email 
                           FROM Orders o 
                           INNER JOIN Users u ON o.UserId = u.UserId ";

            SqlParameter[] p = null;
            if (filter != "All")
            {
                sql += " WHERE o.OrderStatus = @Status ";
                p = new SqlParameter[] {
                    new SqlParameter("@Status", SqlDbType.NVarChar) { Value = filter }
                };
            }

            sql += " ORDER BY o.OrderId DESC";

            DataTable dt = DBHelper.GetData(sql, p);
            litOrderCount.Text = dt.Rows.Count.ToString();
            gvOrders.DataSource = dt;
            gvOrders.DataBind();

            // Set default selected values for each row's status dropdown
            for (int i = 0; i < gvOrders.Rows.Count; i++)
            {
                DropDownList ddl = (DropDownList)gvOrders.Rows[i].FindControl("ddlNewStatus");
                if (ddl != null && i < dt.Rows.Count)
                {
                    string status = dt.Rows[i]["OrderStatus"].ToString();
                    if (ddl.Items.FindByValue(status) != null)
                    {
                        ddl.SelectedValue = status;
                    }
                }
            }
        }

        protected void ddlStatusFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindOrders();
        }

        protected void gvOrders_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "UpdateStatus")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                int orderId = Convert.ToInt32(gvOrders.DataKeys[rowIndex].Value);

                DropDownList ddl = (DropDownList)gvOrders.Rows[rowIndex].FindControl("ddlNewStatus");
                if (ddl != null)
                {
                    string newStatus = ddl.SelectedValue;

                    string sql = "UPDATE Orders SET OrderStatus = @Status WHERE OrderId = @OrderId";
                    SqlParameter[] p = {
                        new SqlParameter("@Status", SqlDbType.NVarChar) { Value = newStatus },
                        new SqlParameter("@OrderId", SqlDbType.Int) { Value = orderId }
                    };

                    DBHelper.ExecuteNonQuery(sql, p);

                    pnlAlert.Visible = true;
                    litAlertMsg.Text = $"Order #{orderId} status successfully changed to <strong>{newStatus}</strong>.";
                    BindOrders();
                }
            }
        }
    }
}
