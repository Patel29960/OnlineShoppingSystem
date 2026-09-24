using System;
using System.Data;
using System.Data.SqlClient;

namespace OnlineShoppingSystem
{
    public partial class ProductDetails : System.Web.UI.Page
    {
        private int _productId = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["id"] != null && int.TryParse(Request.QueryString["id"], out _productId))
            {
                if (!IsPostBack)
                {
                    LoadProductDetails();
                }
            }
            else
            {
                Response.Redirect("Products.aspx");
            }
        }

        private void LoadProductDetails()
        {
            string query = @"SELECT p.ProductId, p.ProductName, p.Price, p.Description, p.ImageUrl, 
                                    p.StockQuantity, c.CategoryName 
                             FROM Products p 
                             INNER JOIN Categories c ON p.CategoryId = c.CategoryId 
                             WHERE p.ProductId = @ProductId";

            SqlParameter[] parameters = {
                new SqlParameter("@ProductId", SqlDbType.Int) { Value = _productId }
            };

            DataTable dt = DBHelper.GetData(query, parameters);

            if (dt.Rows.Count > 0)
            {
                DataRow row = dt.Rows[0];
                string productName = row["ProductName"].ToString();
                decimal price = Convert.ToDecimal(row["Price"]);
                string category = row["CategoryName"].ToString();
                string desc = row["Description"].ToString();
                string imageUrl = row["ImageUrl"].ToString();
                int stock = Convert.ToInt32(row["StockQuantity"]);

                Page.Title = productName;
                litBreadcrumbName.Text = productName;
                litProductName.Text = productName;
                litCategory.Text = category;
                litPrice.Text = "$" + price.ToString("F2");
                litDescription.Text = string.IsNullOrEmpty(desc) ? "No detailed description available." : desc;
                litStock.Text = stock.ToString();
                imgProduct.ImageUrl = string.IsNullOrEmpty(imageUrl) ? "https://placehold.co/600x600?text=No+Image" : imageUrl;

                // Adjust quantity max based on actual stock
                txtQuantity.Attributes["max"] = stock > 0 ? stock.ToString() : "1";
            }
            else
            {
                Response.Redirect("Products.aspx");
            }
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx?login_required=true&ReturnUrl=" + Server.UrlEncode(Request.RawUrl));
                return;
            }

            int qty = 1;
            int.TryParse(txtQuantity.Text, out qty);
            if (qty < 1) qty = 1;

            int userId = Convert.ToInt32(Session["UserId"]);

            AddToCart(userId, _productId, qty);

            if (Master is SiteMaster masterPage)
            {
                masterPage.UpdateCartBadge();
            }

            pnlAlert.Visible = true;
            litAlertMsg.Text = $"{qty} item(s) added to your shopping cart successfully!";
        }

        private void AddToCart(int userId, int productId, int quantity)
        {
            string checkQuery = "SELECT CartId, Quantity FROM Cart WHERE UserId = @UserId AND ProductId = @ProductId";
            SqlParameter[] checkParams = {
                new SqlParameter("@UserId", SqlDbType.Int) { Value = userId },
                new SqlParameter("@ProductId", SqlDbType.Int) { Value = productId }
            };

            DataTable dt = DBHelper.GetData(checkQuery, checkParams);

            if (dt.Rows.Count > 0)
            {
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
