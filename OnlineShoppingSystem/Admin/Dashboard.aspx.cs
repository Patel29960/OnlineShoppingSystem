using System;
using System.Data;

namespace OnlineShoppingSystem.Admin
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadStats();
                LoadRecentOrders();
            }
        }

        private void LoadStats()
        {
            // Fetch metric counts using ADO.NET ExecuteScalar
            object usersCount = DBHelper.ExecuteScalar("SELECT COUNT(*) FROM Users");
            object productsCount = DBHelper.ExecuteScalar("SELECT COUNT(*) FROM Products");
            object ordersCount = DBHelper.ExecuteScalar("SELECT COUNT(*) FROM Orders");
            object categoriesCount = DBHelper.ExecuteScalar("SELECT COUNT(*) FROM Categories");

            litTotalUsers.Text = usersCount != null ? usersCount.ToString() : "0";
            litTotalProducts.Text = productsCount != null ? productsCount.ToString() : "0";
            litTotalOrders.Text = ordersCount != null ? ordersCount.ToString() : "0";
            litTotalCategories.Text = categoriesCount != null ? categoriesCount.ToString() : "0";
        }

        private void LoadRecentOrders()
        {
            string query = @"SELECT TOP 5 o.OrderId, o.OrderDate, o.TotalAmount, o.PaymentMethod, o.OrderStatus, 
                                          u.FullName, u.Email 
                             FROM Orders o 
                             INNER JOIN Users u ON o.UserId = u.UserId 
                             ORDER BY o.OrderId DESC";

            DataTable dt = DBHelper.GetData(query);
            gvRecentOrders.DataSource = dt;
            gvRecentOrders.DataBind();
        }
    }
}
