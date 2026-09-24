using System;
using System.Data;
using System.Data.SqlClient;

namespace OnlineShoppingSystem
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserId"] != null)
                {
                    Response.Redirect("Default.aspx");
                }
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string fullName = txtFullName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();
            string confirmPassword = txtConfirmPassword.Text.Trim();

            // Basic validation
            if (string.IsNullOrEmpty(fullName) || string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                pnlAlert.Visible = true;
                litAlertMsg.Text = "Please fill in all required fields.";
                return;
            }

            if (password != confirmPassword)
            {
                pnlAlert.Visible = true;
                litAlertMsg.Text = "Passwords do not match.";
                return;
            }

            try
            {
                // Check if email already registered
                string checkQuery = "SELECT COUNT(*) FROM Users WHERE Email = @Email";
                SqlParameter[] checkParams = {
                    new SqlParameter("@Email", SqlDbType.NVarChar, 100) { Value = email }
                };

                int existingCount = Convert.ToInt32(DBHelper.ExecuteScalar(checkQuery, checkParams));
                if (existingCount > 0)
                {
                    pnlAlert.Visible = true;
                    litAlertMsg.Text = "An account with this email address already exists. Please sign in.";
                    return;
                }

                // Insert new customer into database
                string insertQuery = @"INSERT INTO Users (FullName, Email, Password, Role, CreatedAt) 
                                       VALUES (@FullName, @Email, @Password, 'Customer', GETDATE())";

                SqlParameter[] insertParams = {
                    new SqlParameter("@FullName", SqlDbType.NVarChar, 100) { Value = fullName },
                    new SqlParameter("@Email", SqlDbType.NVarChar, 100) { Value = email },
                    new SqlParameter("@Password", SqlDbType.NVarChar, 100) { Value = password }
                };

                int rows = DBHelper.ExecuteNonQuery(insertQuery, insertParams);
                if (rows > 0)
                {
                    Response.Redirect("Login.aspx?registered=true");
                }
                else
                {
                    pnlAlert.Visible = true;
                    litAlertMsg.Text = "Unable to create account. Please try again.";
                }
            }
            catch (Exception ex)
            {
                pnlAlert.Visible = true;
                litAlertMsg.Text = "Error during registration: " + ex.Message;
            }
        }
    }
}
