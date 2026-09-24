using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace OnlineShoppingSystem
{
    public partial class Cart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx?login_required=true&ReturnUrl=Cart.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadCartItems();
            }
        }

        private void LoadCartItems()
        {
            int userId = Convert.ToInt32(Session["UserId"]);

            string query = @"SELECT c.CartId, c.Quantity, p.ProductId, p.ProductName, p.Price, p.ImageUrl, cat.CategoryName 
                             FROM Cart c 
                             INNER JOIN Products p ON c.ProductId = p.ProductId 
                             INNER JOIN Categories cat ON p.CategoryId = cat.CategoryId 
                             WHERE c.UserId = @UserId";

            SqlParameter[] parameters = {
                new SqlParameter("@UserId", SqlDbType.Int) { Value = userId }
            };

            DataTable dt = DBHelper.GetData(query, parameters);

            if (dt.Rows.Count > 0)
            {
                rptCartItems.DataSource = dt;
                rptCartItems.DataBind();
                pnlCartContent.Visible = true;
                pnlEmptyCart.Visible = false;

                // Compute Grand Total
                decimal grandTotal = 0;
                foreach (DataRow row in dt.Rows)
                {
                    decimal price = Convert.ToDecimal(row["Price"]);
                    int qty = Convert.ToInt32(row["Quantity"]);
                    grandTotal += (price * qty);
                }

                litSubtotal.Text = grandTotal.ToString("F2");
                litGrandTotal.Text = grandTotal.ToString("F2");
            }
            else
            {
                pnlCartContent.Visible = false;
                pnlEmptyCart.Visible = true;
            }

            // Sync master cart badge
            if (Master is SiteMaster masterPage)
            {
                masterPage.UpdateCartBadge();
            }
        }

        protected void rptCartItems_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int userId = Convert.ToInt32(Session["UserId"]);
            int cartId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Increase")
            {
                string sql = "UPDATE Cart SET Quantity = Quantity + 1 WHERE CartId = @CartId AND UserId = @UserId";
                SqlParameter[] p = {
                    new SqlParameter("@CartId", SqlDbType.Int) { Value = cartId },
                    new SqlParameter("@UserId", SqlDbType.Int) { Value = userId }
                };
                DBHelper.ExecuteNonQuery(sql, p);
                LoadCartItems();
            }
            else if (e.CommandName == "Decrease")
            {
                // Decrement or delete if reached 1
                string checkSql = "SELECT Quantity FROM Cart WHERE CartId = @CartId AND UserId = @UserId";
                SqlParameter[] cp = {
                    new SqlParameter("@CartId", SqlDbType.Int) { Value = cartId },
                    new SqlParameter("@UserId", SqlDbType.Int) { Value = userId }
                };
                object qtyObj = DBHelper.ExecuteScalar(checkSql, cp);
                int currentQty = qtyObj != null ? Convert.ToInt32(qtyObj) : 1;

                if (currentQty > 1)
                {
                    string sql = "UPDATE Cart SET Quantity = Quantity - 1 WHERE CartId = @CartId AND UserId = @UserId";
                    DBHelper.ExecuteNonQuery(sql, cp);
                }
                else
                {
                    string delSql = "DELETE FROM Cart WHERE CartId = @CartId AND UserId = @UserId";
                    DBHelper.ExecuteNonQuery(delSql, cp);
                }
                LoadCartItems();
            }
            else if (e.CommandName == "Remove")
            {
                string delSql = "DELETE FROM Cart WHERE CartId = @CartId AND UserId = @UserId";
                SqlParameter[] p = {
                    new SqlParameter("@CartId", SqlDbType.Int) { Value = cartId },
                    new SqlParameter("@UserId", SqlDbType.Int) { Value = userId }
                };
                DBHelper.ExecuteNonQuery(delSql, p);
                LoadCartItems();
            }
        }

        protected void btnClearCart_Click(object sender, EventArgs e)
        {
            int userId = Convert.ToInt32(Session["UserId"]);
            string sql = "DELETE FROM Cart WHERE UserId = @UserId";
            SqlParameter[] p = {
                new SqlParameter("@UserId", SqlDbType.Int) { Value = userId }
            };
            DBHelper.ExecuteNonQuery(sql, p);
            LoadCartItems();
        }
    }
}
