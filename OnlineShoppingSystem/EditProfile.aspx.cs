using System;
using System.Data;
using System.Data.SqlClient;

namespace OnlineShoppingSystem
{
    public partial class EditProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadCurrentData();
            }
        }

        private void LoadCurrentData()
        {
            int userId = Convert.ToInt32(Session["UserId"]);
            string query = "SELECT FullName, Email FROM Users WHERE UserId = @UserId";
            SqlParameter[] parameters = {
                new SqlParameter("@UserId", SqlDbType.Int) { Value = userId }
            };

            DataTable dt = DBHelper.GetData(query, parameters);
            if (dt.Rows.Count > 0)
            {
                txtFullName.Text = dt.Rows[0]["FullName"].ToString();
                txtEmail.Text = dt.Rows[0]["Email"].ToString();
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            int userId = Convert.ToInt32(Session["UserId"]);
            string fullName = txtFullName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string newPass = txtNewPassword.Text.Trim();

            if (string.IsNullOrEmpty(fullName) || string.IsNullOrEmpty(email))
            {
                pnlAlert.Visible = true;
                litAlertMsg.Text = "Please fill in all required fields.";
                return;
            }

            try
            {
                // Verify email is not duplicate for another user
                string checkQuery = "SELECT COUNT(*) FROM Users WHERE Email = @Email AND UserId <> @UserId";
                SqlParameter[] checkParams = {
                    new SqlParameter("@Email", SqlDbType.NVarChar, 100) { Value = email },
                    new SqlParameter("@UserId", SqlDbType.Int) { Value = userId }
                };

                int duplicateCount = Convert.ToInt32(DBHelper.ExecuteScalar(checkQuery, checkParams));
                if (duplicateCount > 0)
                {
                    pnlAlert.Visible = true;
                    litAlertMsg.Text = "That email address is already in use by another account.";
                    return;
                }

                string updateSql;
                SqlParameter[] updateParams;

                if (!string.IsNullOrEmpty(newPass))
                {
                    updateSql = "UPDATE Users SET FullName = @FullName, Email = @Email, Password = @Password WHERE UserId = @UserId";
                    updateParams = new SqlParameter[] {
                        new SqlParameter("@FullName", SqlDbType.NVarChar, 100) { Value = fullName },
                        new SqlParameter("@Email", SqlDbType.NVarChar, 100) { Value = email },
                        new SqlParameter("@Password", SqlDbType.NVarChar, 100) { Value = newPass },
                        new SqlParameter("@UserId", SqlDbType.Int) { Value = userId }
                    };
                }
                else
                {
                    updateSql = "UPDATE Users SET FullName = @FullName, Email = @Email WHERE UserId = @UserId";
                    updateParams = new SqlParameter[] {
                        new SqlParameter("@FullName", SqlDbType.NVarChar, 100) { Value = fullName },
                        new SqlParameter("@Email", SqlDbType.NVarChar, 100) { Value = email },
                        new SqlParameter("@UserId", SqlDbType.Int) { Value = userId }
                    };
                }

                int affected = DBHelper.ExecuteNonQuery(updateSql, updateParams);
                if (affected > 0)
                {
                    Session["UserName"] = fullName;
                    Session["UserEmail"] = email;

                    pnlAlert.Visible = false;
                    pnlSuccess.Visible = true;
                    litSuccessMsg.Text = "Your profile information has been successfully updated!";
                }
            }
            catch (Exception ex)
            {
                pnlAlert.Visible = true;
                litAlertMsg.Text = "Error updating profile: " + ex.Message;
            }
        }
    }
}
