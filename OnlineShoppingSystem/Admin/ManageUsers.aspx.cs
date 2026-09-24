using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace OnlineShoppingSystem.Admin
{
    public partial class ManageUsers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindUsers();
            }
        }

        private void BindUsers()
        {
            string sql = "SELECT UserId, FullName, Email, Role, CreatedAt FROM Users ORDER BY UserId DESC";
            DataTable dt = DBHelper.GetData(sql);
            litUserCount.Text = dt.Rows.Count.ToString();
            gvUsers.DataSource = dt;
            gvUsers.DataBind();
        }

        protected void gvUsers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int targetUserId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "ToggleRole")
            {
                // Fetch current role
                string checkSql = "SELECT Role FROM Users WHERE UserId = @UserId";
                SqlParameter[] cp = { new SqlParameter("@UserId", SqlDbType.Int) { Value = targetUserId } };
                object roleObj = DBHelper.ExecuteScalar(checkSql, cp);

                if (roleObj != null)
                {
                    string currentRole = roleObj.ToString();
                    string newRole = currentRole.Equals("Admin", StringComparison.OrdinalIgnoreCase) ? "Customer" : "Admin";

                    string updateSql = "UPDATE Users SET Role = @Role WHERE UserId = @UserId";
                    SqlParameter[] up = {
                        new SqlParameter("@Role", SqlDbType.NVarChar, 20) { Value = newRole },
                        new SqlParameter("@UserId", SqlDbType.Int) { Value = targetUserId }
                    };
                    DBHelper.ExecuteNonQuery(updateSql, up);

                    pnlAlert.Visible = true;
                    litAlertMsg.Text = $"User role updated to <strong>{newRole}</strong>.";
                    BindUsers();
                }
            }
            else if (e.CommandName == "DeleteUser")
            {
                try
                {
                    string delSql = "DELETE FROM Users WHERE UserId = @UserId";
                    SqlParameter[] p = { new SqlParameter("@UserId", SqlDbType.Int) { Value = targetUserId } };
                    DBHelper.ExecuteNonQuery(delSql, p);

                    pnlAlert.Visible = true;
                    litAlertMsg.Text = "User account removed successfully.";
                    BindUsers();
                }
                catch (Exception ex)
                {
                    pnlAlert.Visible = true;
                    litAlertMsg.Text = "Error deleting user: " + ex.Message;
                }
            }
        }
    }
}
