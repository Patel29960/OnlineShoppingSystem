using System;
using System.Data;
using System.Data.SqlClient;

namespace OnlineShoppingSystem
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Display friendly alerts based on redirect query parameters
                if (Request.QueryString["registered"] == "true")
                {
                    pnlSuccess.Visible = true;
                    litSuccessMsg.Text = "Account registered successfully! Please sign in with your credentials.";
                }
                else if (Request.QueryString["error"] == "admin_required")
                {
                    pnlAlert.Visible = true;
                    litAlertMsg.Text = "Please sign in with an Administrator account to access the Admin Panel.";
                }
                else if (Request.QueryString["login_required"] == "true")
                {
                    pnlAlert.Visible = true;
                    litAlertMsg.Text = "Please log in to add items to your cart or proceed to checkout.";
                }

                // If already logged in, redirect accordingly
                if (Session["UserId"] != null)
                {
                    if (Session["UserRole"] != null && Session["UserRole"].ToString() == "Admin")
                    {
                        Response.Redirect("Admin/Dashboard.aspx");
                    }
                    else
                    {
                        Response.Redirect("Default.aspx");
                    }
                }
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();

            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                pnlAlert.Visible = true;
                litAlertMsg.Text = "Please enter both your email address and password.";
                return;
            }

            try
            {
                // Query database for matching user credentials
                string query = "SELECT UserId, FullName, Email, Password, Role FROM Users WHERE Email = @Email AND Password = @Password";
                SqlParameter[] parameters = {
                    new SqlParameter("@Email", SqlDbType.NVarChar, 100) { Value = email },
                    new SqlParameter("@Password", SqlDbType.NVarChar, 100) { Value = password }
                };

                DataTable dt = DBHelper.GetData(query, parameters);

                if (dt.Rows.Count > 0)
                {
                    // Successful login: Set up user session
                    DataRow user = dt.Rows[0];
                    Session["UserId"] = user["UserId"].ToString();
                    Session["UserName"] = user["FullName"].ToString();
                    Session["UserEmail"] = user["Email"].ToString();
                    string role = user["Role"].ToString();
                    Session["UserRole"] = role;

                    // Redirect based on user role
                    if (role.Equals("Admin", StringComparison.OrdinalIgnoreCase))
                    {
                        Response.Redirect("Admin/Dashboard.aspx");
                    }
                    else
                    {
                        string returnUrl = Request.QueryString["ReturnUrl"];
                        if (!string.IsNullOrEmpty(returnUrl))
                        {
                            Response.Redirect(returnUrl);
                        }
                        else
                        {
                            Response.Redirect("Default.aspx");
                        }
                    }
                }
                else
                {
                    pnlAlert.Visible = true;
                    litAlertMsg.Text = "Invalid email or password. Please verify your credentials.";
                }
            }
            catch (Exception ex)
            {
                pnlAlert.Visible = true;
                litAlertMsg.Text = "Database connection error: " + ex.Message;
            }
        }
    }
}
