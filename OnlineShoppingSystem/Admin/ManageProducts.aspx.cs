using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace OnlineShoppingSystem.Admin
{
    public partial class ManageProducts : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["updated"] == "true")
                {
                    pnlAlert.Visible = true;
                    litAlertMsg.Text = "Product details updated successfully!";
                }

                BindProducts();
            }
        }

        private void BindProducts()
        {
            string search = txtSearch.Text.Trim();
            string sql = @"SELECT p.ProductId, p.ProductName, p.Price, p.Description, p.ImageUrl, 
                                  p.StockQuantity, p.IsFeatured, c.CategoryName 
                           FROM Products p 
                           INNER JOIN Categories c ON p.CategoryId = c.CategoryId ";

            SqlParameter[] parameters = null;

            if (!string.IsNullOrEmpty(search))
            {
                sql += " WHERE p.ProductName LIKE @Search OR c.CategoryName LIKE @Search ";
                parameters = new SqlParameter[] {
                    new SqlParameter("@Search", SqlDbType.NVarChar) { Value = "%" + search + "%" }
                };
            }

            sql += " ORDER BY p.ProductId DESC";

            DataTable dt = DBHelper.GetData(sql, parameters);
            litCount.Text = dt.Rows.Count.ToString();
            gvProducts.DataSource = dt;
            gvProducts.DataBind();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindProducts();
        }

        protected void gvProducts_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteProduct")
            {
                int productId = Convert.ToInt32(e.CommandArgument);

                try
                {
                    string delSql = "DELETE FROM Products WHERE ProductId = @ProductId";
                    SqlParameter[] p = {
                        new SqlParameter("@ProductId", SqlDbType.Int) { Value = productId }
                    };

                    int affected = DBHelper.ExecuteNonQuery(delSql, p);
                    if (affected > 0)
                    {
                        pnlAlert.Visible = true;
                        litAlertMsg.Text = "Product deleted successfully from the catalog.";
                        BindProducts();
                    }
                }
                catch (Exception ex)
                {
                    pnlAlert.Visible = true;
                    litAlertMsg.Text = "Error deleting product: " + ex.Message;
                }
            }
        }
    }
}
