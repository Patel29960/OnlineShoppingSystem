using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI.WebControls;

namespace OnlineShoppingSystem.Admin
{
    public partial class EditProduct : System.Web.UI.Page
    {
        private int _productId = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["id"] != null && int.TryParse(Request.QueryString["id"], out _productId))
            {
                if (!IsPostBack)
                {
                    LoadCategories();
                    LoadProductDetails();
                }
            }
            else
            {
                Response.Redirect("ManageProducts.aspx");
            }
        }

        private void LoadCategories()
        {
            string query = "SELECT CategoryId, CategoryName FROM Categories ORDER BY CategoryName";
            DataTable dt = DBHelper.GetData(query);
            ddlCategory.DataSource = dt;
            ddlCategory.DataTextField = "CategoryName";
            ddlCategory.DataValueField = "CategoryId";
            ddlCategory.DataBind();
            ddlCategory.Items.Insert(0, new ListItem("-- Select Category --", "0"));
        }

        private void LoadProductDetails()
        {
            string query = "SELECT ProductId, ProductName, CategoryId, Price, Description, ImageUrl, StockQuantity, IsFeatured FROM Products WHERE ProductId = @ProductId";
            SqlParameter[] parameters = {
                new SqlParameter("@ProductId", SqlDbType.Int) { Value = _productId }
            };

            DataTable dt = DBHelper.GetData(query, parameters);
            if (dt.Rows.Count > 0)
            {
                DataRow r = dt.Rows[0];
                txtProductName.Text = r["ProductName"].ToString();
                ddlCategory.SelectedValue = r["CategoryId"].ToString();
                txtPrice.Text = Convert.ToDecimal(r["Price"]).ToString("F2");
                txtStock.Text = r["StockQuantity"].ToString();
                chkFeatured.Checked = Convert.ToBoolean(r["IsFeatured"]);
                txtImageUrl.Text = r["ImageUrl"].ToString();
                imgCurrent.ImageUrl = r["ImageUrl"].ToString();
                txtDescription.Text = r["Description"].ToString();
            }
            else
            {
                Response.Redirect("ManageProducts.aspx");
            }
        }

        protected void btnUpdateProduct_Click(object sender, EventArgs e)
        {
            string productName = txtProductName.Text.Trim();
            int categoryId = 0;
            int.TryParse(ddlCategory.SelectedValue, out categoryId);

            decimal price = 0;
            decimal.TryParse(txtPrice.Text.Trim(), out price);

            int stock = 0;
            int.TryParse(txtStock.Text.Trim(), out stock);

            bool isFeatured = chkFeatured.Checked;
            string description = txtDescription.Text.Trim();
            string imageUrl = txtImageUrl.Text.Trim();

            if (string.IsNullOrEmpty(productName) || categoryId <= 0 || price <= 0)
            {
                pnlAlert.Visible = true;
                litAlertMsg.Text = "Please fill in all mandatory fields with valid values.";
                return;
            }

            // Handle optional new image upload
            if (fuProductImage.HasFile)
            {
                try
                {
                    string ext = Path.GetExtension(fuProductImage.FileName).ToLower();
                    if (ext == ".jpg" || ext == ".jpeg" || ext == ".png" || ext == ".webp")
                    {
                        string fileName = "prod_" + DateTime.Now.Ticks + ext;
                        string savePath = Server.MapPath("~/images/") + fileName;

                        string dir = Server.MapPath("~/images/");
                        if (!Directory.Exists(dir))
                        {
                            Directory.CreateDirectory(dir);
                        }

                        fuProductImage.SaveAs(savePath);
                        imageUrl = "images/" + fileName;
                    }
                    else
                    {
                        pnlAlert.Visible = true;
                        litAlertMsg.Text = "Only .jpg, .png, and .webp image files are allowed.";
                        return;
                    }
                }
                catch (Exception ex)
                {
                    pnlAlert.Visible = true;
                    litAlertMsg.Text = "Error uploading image: " + ex.Message;
                    return;
                }
            }

            try
            {
                string updateSql = @"UPDATE Products 
                                     SET ProductName = @ProductName, 
                                         CategoryId = @CategoryId, 
                                         Price = @Price, 
                                         Description = @Description, 
                                         ImageUrl = @ImageUrl, 
                                         StockQuantity = @StockQuantity, 
                                         IsFeatured = @IsFeatured 
                                     WHERE ProductId = @ProductId";

                SqlParameter[] parameters = {
                    new SqlParameter("@ProductName", SqlDbType.NVarChar, 150) { Value = productName },
                    new SqlParameter("@CategoryId", SqlDbType.Int) { Value = categoryId },
                    new SqlParameter("@Price", SqlDbType.Decimal) { Value = price },
                    new SqlParameter("@Description", SqlDbType.NVarChar) { Value = description },
                    new SqlParameter("@ImageUrl", SqlDbType.NVarChar, 500) { Value = imageUrl },
                    new SqlParameter("@StockQuantity", SqlDbType.Int) { Value = stock },
                    new SqlParameter("@IsFeatured", SqlDbType.Bit) { Value = isFeatured },
                    new SqlParameter("@ProductId", SqlDbType.Int) { Value = _productId }
                };

                int affected = DBHelper.ExecuteNonQuery(updateSql, parameters);
                if (affected > 0)
                {
                    Response.Redirect("ManageProducts.aspx?updated=true");
                }
                else
                {
                    pnlAlert.Visible = true;
                    litAlertMsg.Text = "No changes were recorded. Please try again.";
                }
            }
            catch (Exception ex)
            {
                pnlAlert.Visible = true;
                litAlertMsg.Text = "Database update error: " + ex.Message;
            }
        }
    }
}
