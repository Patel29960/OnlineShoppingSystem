using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace OnlineShoppingSystem
{
    public partial class Products : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCategoryDropdown();

                // Check if category is passed via QueryString
                if (!string.IsNullOrEmpty(Request.QueryString["cat"]))
                {
                    string catId = Request.QueryString["cat"];
                    if (ddlCategories.Items.FindByValue(catId) != null)
                    {
                        ddlCategories.SelectedValue = catId;
                    }
                }

                LoadProductList();
            }
        }

        private void LoadCategoryDropdown()
        {
            string query = "SELECT CategoryId, CategoryName FROM Categories ORDER BY CategoryName";
            DataTable dt = DBHelper.GetData(query);
            ddlCategories.DataSource = dt;
            ddlCategories.DataTextField = "CategoryName";
            ddlCategories.DataValueField = "CategoryId";
            ddlCategories.DataBind();
            ddlCategories.Items.Insert(0, new ListItem("All Categories", "0"));
        }

        private void LoadProductList()
        {
            string searchQuery = txtSearch.Text.Trim();
            int categoryId = 0;
            int.TryParse(ddlCategories.SelectedValue, out categoryId);
            string sortOption = ddlSort.SelectedValue;

            string sql = @"SELECT p.ProductId, p.ProductName, p.Price, p.Description, p.ImageUrl, 
                                  p.StockQuantity, p.IsFeatured, c.CategoryName 
                           FROM Products p 
                           INNER JOIN Categories c ON p.CategoryId = c.CategoryId 
                           WHERE 1=1 ";

            List<SqlParameter> parameters = new List<SqlParameter>();

            if (!string.IsNullOrEmpty(searchQuery))
            {
                sql += " AND (p.ProductName LIKE @Search OR p.Description LIKE @Search) ";
                parameters.Add(new SqlParameter("@Search", SqlDbType.NVarChar) { Value = "%" + searchQuery + "%" });
            }

            if (categoryId > 0)
            {
                sql += " AND p.CategoryId = @CategoryId ";
                parameters.Add(new SqlParameter("@CategoryId", SqlDbType.Int) { Value = categoryId });
            }

            // Sorting logic
            switch (sortOption)
            {
                case "price_asc":
                    sql += " ORDER BY p.Price ASC ";
                    break;
                case "price_desc":
                    sql += " ORDER BY p.Price DESC ";
                    break;
                case "name_asc":
                    sql += " ORDER BY p.ProductName ASC ";
                    break;
                default:
                    sql += " ORDER BY p.ProductId DESC ";
                    break;
            }

            DataTable dt = DBHelper.GetData(sql, parameters.ToArray());
            litProductCount.Text = dt.Rows.Count.ToString();

            if (dt.Rows.Count > 0)
            {
                rptProducts.DataSource = dt;
                rptProducts.DataBind();
                rptProducts.Visible = true;
                pnlNoProducts.Visible = false;
            }
            else
            {
                rptProducts.Visible = false;
                pnlNoProducts.Visible = true;
            }
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            LoadProductList();
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            ddlCategories.SelectedValue = "0";
            ddlSort.SelectedValue = "newest";
            LoadProductList();
        }

        protected void rptProducts_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "AddToCart")
            {
                if (Session["UserId"] == null)
                {
                    Response.Redirect("Login.aspx?login_required=true");
                    return;
                }

                int userId = Convert.ToInt32(Session["UserId"]);
                int productId = Convert.ToInt32(e.CommandArgument);

                AddToCart(userId, productId, 1);

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
