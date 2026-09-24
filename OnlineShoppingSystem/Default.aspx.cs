using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace OnlineShoppingSystem
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCategories();
                LoadFeaturedProducts();
            }
        }

        private void LoadCategories()
        {
            string query = "SELECT CategoryId, CategoryName, Description, ImageUrl FROM Categories ORDER BY CategoryId";
            DataTable dt = DBHelper.GetData(query);
            rptCategories.DataSource = dt;
            rptCategories.DataBind();
        }

        private void LoadFeaturedProducts()
        {
            string query = @"SELECT p.ProductId, p.ProductName, p.Price, p.Description, p.ImageUrl, 
                                    p.StockQuantity, c.CategoryName 
                             FROM Products p 
                             INNER JOIN Categories c ON p.CategoryId = c.CategoryId 
                             WHERE p.IsFeatured = 1 
                             ORDER BY p.ProductId";
            DataTable dt = DBHelper.GetData(query);
            rptFeatured.DataSource = dt;
            rptFeatured.DataBind();
        }

        protected void rptFeatured_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "AddToCart")
            {
                // Verify user is logged in
                if (Session["UserId"] == null)
                {
                    Response.Redirect("Login.aspx?login_required=true");
                    return;
                }

                int userId = Convert.ToInt32(Session["UserId"]);
                int productId = Convert.ToInt32(e.CommandArgument);

                // Add or increment item in Cart table
                AddToCart(userId, productId, 1);

                // Update master page cart badge count
                if (Master is SiteMaster masterPage)
                {
                    masterPage.UpdateCartBadge();
                }

                pnlAlert.Visible = true;
                litAlertMsg.Text = "Item successfully added to your shopping cart!";
            }
        }

        private void AddToCart(int userId, int productId, int quantity)
        {
            // Check if item already in cart
            string checkQuery = "SELECT CartId, Quantity FROM Cart WHERE UserId = @UserId AND ProductId = @ProductId";
            SqlParameter[] checkParams = {
                new SqlParameter("@UserId", SqlDbType.Int) { Value = userId },
                new SqlParameter("@ProductId", SqlDbType.Int) { Value = productId }
            };

            DataTable dt = DBHelper.GetData(checkQuery, checkParams);

            if (dt.Rows.Count > 0)
            {
                // Increment existing quantity
                string updateQuery = "UPDATE Cart SET Quantity = Quantity + @Qty WHERE UserId = @UserId AND ProductId = @ProductId";
                SqlParameter[] updateParams = {
                    new SqlParameter("@Qty", SqlDbType.Int) { Value = quantity },
                    new SqlParameter("@UserId", SqlDbType.Int) { Value = userId },
                    new SqlParameter("@ProductId", SqlDbType.Int) { Value = productId }
                };
                DBHelper.ExecuteNonQuery(updateQuery, updateParams);
            }
            else
            {
                // Insert new cart item
                string insertQuery = "INSERT INTO Cart (UserId, ProductId, Quantity, AddedAt) VALUES (@UserId, @ProductId, @Qty, GETDATE())";
                SqlParameter[] insertParams = {
                    new SqlParameter("@UserId", SqlDbType.Int) { Value = userId },
                    new SqlParameter("@ProductId", SqlDbType.Int) { Value = productId },
                    new SqlParameter("@Qty", SqlDbType.Int) { Value = quantity }
                };
                DBHelper.ExecuteNonQuery(insertQuery, insertParams);
            }
        }
    }
}
