using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI.WebControls;

namespace OnlineShoppingSystem.Admin
{
    public partial class AddProduct : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCategories();
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

        protected void btnAddProduct_Click(object sender, EventArgs e)
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
                pnlSuccess.Visible = false;
                litAlertMsg.Text = "Please fill in all mandatory fields with valid values.";
                return;
            }

            // Handle file upload if present
            if (fuProductImage.HasFile)
            {
                try
                {
                    string ext = Path.GetExtension(fuProductImage.FileName).ToLower();
                    if (ext == ".jpg" || ext == ".jpeg" || ext == ".png" || ext == ".webp")
                    {
                        string fileName = "prod_" + DateTime.Now.Ticks + ext;
                        string savePath = Server.MapPath("~/images/") + fileName;

                        // Ensure directory exists
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
                        pnlSuccess.Visible = false;
                        litAlertMsg.Text = "Only .jpg, .png, and .webp image files are allowed.";
                        return;
                    }
                }
                catch (Exception ex)
                {
                    pnlAlert.Visible = true;
                    pnlSuccess.Visible = false;
                    litAlertMsg.Text = "Error uploading image: " + ex.Message;
                    return;
                }
            }

            // Default image if neither URL nor file provided
            if (string.IsNullOrEmpty(imageUrl))
            {
                imageUrl = "https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?w=600&auto=format&fit=crop&q=80";
            }

            try
            {
                string insertSql = @"INSERT INTO Products (ProductName, CategoryId, Price, Description, ImageUrl, StockQuantity, IsFeatured, CreatedAt) 
                                     VALUES (@ProductName, @CategoryId, @Price, @Description, @ImageUrl, @StockQuantity, @IsFeatured, GETDATE())";

                SqlParameter[] parameters = {
                    new SqlParameter("@ProductName", SqlDbType.NVarChar, 150) { Value = productName },
                    new SqlParameter("@CategoryId", SqlDbType.Int) { Value = categoryId },
                    new SqlParameter("@Price", SqlDbType.Decimal) { Value = price },
                    new SqlParameter("@Description", SqlDbType.NVarChar) { Value = description },
                    new SqlParameter("@ImageUrl", SqlDbType.NVarChar, 500) { Value = imageUrl },
                    new SqlParameter("@StockQuantity", SqlDbType.Int) { Value = stock },
                    new SqlParameter("@IsFeatured", SqlDbType.Bit) { Value = isFeatured }
                };

                int affected = DBHelper.ExecuteNonQuery(insertSql, parameters);

                if (affected > 0)
                {
                    pnlAlert.Visible = false;
                    pnlSuccess.Visible = true;
                    litSuccessMsg.Text = $"Product <strong>'{productName}'</strong> added successfully to inventory! <a href='ManageProducts.aspx' style='color: var(--accent); font-weight:700;'>View in Inventory &rarr;</a>";
                    ClearFields();
                }
                else
                {
                    pnlAlert.Visible = true;
                    pnlSuccess.Visible = false;
                    litAlertMsg.Text = "Unable to add product. Please verify your inputs.";
                }
            }
            catch (Exception ex)
            {
                pnlAlert.Visible = true;
                pnlSuccess.Visible = false;
                litAlertMsg.Text = "Database error: " + ex.Message;
            }
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            ClearFields();
            pnlAlert.Visible = false;
            pnlSuccess.Visible = false;
        }

        private void ClearFields()
        {
            txtProductName.Text = "";
            ddlCategory.SelectedValue = "0";
            txtPrice.Text = "";
            txtStock.Text = "15";
            chkFeatured.Checked = false;
            txtImageUrl.Text = "";
            txtDescription.Text = "";
        }
    }
}
