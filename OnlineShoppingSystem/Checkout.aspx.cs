using System;
using System.Data;
using System.Data.SqlClient;

namespace OnlineShoppingSystem
{
    public partial class Checkout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx?login_required=true&ReturnUrl=Checkout.aspx");
                return;
            }

            if (!IsPostBack)
            {
                if (Session["UserName"] != null)
                {
                    txtName.Text = Session["UserName"].ToString();
                }
                LoadCheckoutSummary();
            }
        }

        private void LoadCheckoutSummary()
        {
            int userId = Convert.ToInt32(Session["UserId"]);
            string query = @"SELECT c.CartId, c.Quantity, p.ProductId, p.ProductName, p.Price 
                             FROM Cart c 
                             INNER JOIN Products p ON c.ProductId = p.ProductId 
                             WHERE c.UserId = @UserId";

            SqlParameter[] parameters = {
                new SqlParameter("@UserId", SqlDbType.Int) { Value = userId }
            };

            DataTable dt = DBHelper.GetData(query, parameters);

            if (dt.Rows.Count == 0)
            {
                Response.Redirect("Cart.aspx");
                return;
            }

            rptCheckoutItems.DataSource = dt;
            rptCheckoutItems.DataBind();

            decimal total = 0;
            foreach (DataRow row in dt.Rows)
            {
                total += Convert.ToDecimal(row["Price"]) * Convert.ToInt32(row["Quantity"]);
            }

            litSubtotal.Text = total.ToString("F2");
            litGrandTotal.Text = total.ToString("F2");
        }

        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            int userId = Convert.ToInt32(Session["UserId"]);
            string name = txtName.Text.Trim();
            string address = txtAddress.Text.Trim();
            string city = txtCity.Text.Trim();
            string zip = txtZip.Text.Trim();
            string phone = txtPhone.Text.Trim();
            string paymentMethod = rblPayment.SelectedValue;

            if (string.IsNullOrEmpty(address) || string.IsNullOrEmpty(city) || string.IsNullOrEmpty(phone))
            {
                pnlAlert.Visible = true;
                litAlertMsg.Text = "Please complete all shipping address fields.";
                return;
            }

            string fullShippingAddress = $"{name}, {address}, {city} - {zip} (Phone: {phone})";

            try
            {
                // 1. Fetch current cart items
                string cartQuery = @"SELECT c.ProductId, c.Quantity, p.Price 
                                     FROM Cart c 
                                     INNER JOIN Products p ON c.ProductId = p.ProductId 
                                     WHERE c.UserId = @UserId";
                SqlParameter[] cartParams = {
                    new SqlParameter("@UserId", SqlDbType.Int) { Value = userId }
                };

                DataTable cartDt = DBHelper.GetData(cartQuery, cartParams);
                if (cartDt.Rows.Count == 0)
                {
                    Response.Redirect("Cart.aspx");
                    return;
                }

                decimal grandTotal = 0;
                foreach (DataRow r in cartDt.Rows)
                {
                    grandTotal += Convert.ToDecimal(r["Price"]) * Convert.ToInt32(r["Quantity"]);
                }

                // 2. Insert into Orders table and retrieve new OrderId
                string insertOrderSql = @"INSERT INTO Orders (UserId, OrderDate, TotalAmount, ShippingAddress, PaymentMethod, OrderStatus) 
                                          VALUES (@UserId, GETDATE(), @TotalAmount, @ShippingAddress, @PaymentMethod, 'Pending');
                                          SELECT SCOPE_IDENTITY();";

                SqlParameter[] orderParams = {
                    new SqlParameter("@UserId", SqlDbType.Int) { Value = userId },
                    new SqlParameter("@TotalAmount", SqlDbType.Decimal) { Value = grandTotal },
                    new SqlParameter("@ShippingAddress", SqlDbType.NVarChar, 500) { Value = fullShippingAddress },
                    new SqlParameter("@PaymentMethod", SqlDbType.NVarChar, 50) { Value = paymentMethod }
                };

                object orderIdObj = DBHelper.ExecuteScalar(insertOrderSql, orderParams);
                int orderId = Convert.ToInt32(orderIdObj);

                // 3. Insert each item into OrderDetails table
                foreach (DataRow r in cartDt.Rows)
                {
                    int productId = Convert.ToInt32(r["ProductId"]);
                    int qty = Convert.ToInt32(r["Quantity"]);
                    decimal unitPrice = Convert.ToDecimal(r["Price"]);

                    string insertDetailSql = @"INSERT INTO OrderDetails (OrderId, ProductId, Quantity, UnitPrice) 
                                               VALUES (@OrderId, @ProductId, @Quantity, @UnitPrice)";
                    SqlParameter[] detailParams = {
                        new SqlParameter("@OrderId", SqlDbType.Int) { Value = orderId },
                        new SqlParameter("@ProductId", SqlDbType.Int) { Value = productId },
                        new SqlParameter("@Quantity", SqlDbType.Int) { Value = qty },
                        new SqlParameter("@UnitPrice", SqlDbType.Decimal) { Value = unitPrice }
                    };
                    DBHelper.ExecuteNonQuery(insertDetailSql, detailParams);
                }

                // 4. Clear User's Cart
                string clearCartSql = "DELETE FROM Cart WHERE UserId = @UserId";
                SqlParameter[] clearParams = {
                    new SqlParameter("@UserId", SqlDbType.Int) { Value = userId }
                };
                DBHelper.ExecuteNonQuery(clearCartSql, clearParams);

                // 5. Update Navbar Cart Badge
                if (Master is SiteMaster masterPage)
                {
                    masterPage.UpdateCartBadge();
                }

                // 6. Redirect to Order Confirmation
                Response.Redirect("OrderSuccess.aspx?orderId=" + orderId);
            }
            catch (Exception ex)
            {
                pnlAlert.Visible = true;
                litAlertMsg.Text = "An error occurred while placing your order: " + ex.Message;
            }
        }
    }
}
