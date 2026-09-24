using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace OnlineShoppingSystem
{
    /// <summary>
    /// Centralized ADO.NET Database Helper class.
    /// Provides simple, clean, and reusable methods for database operations
    /// using standard ADO.NET (SqlConnection, SqlCommand, SqlDataAdapter).
    /// </summary>
    public static class DBHelper
    {
        // Retrieves the connection string defined in Web.config
        public static string GetConnectionString()
        {
            if (ConfigurationManager.ConnectionStrings["OnlineShoppingDB"] != null)
            {
                return ConfigurationManager.ConnectionStrings["OnlineShoppingDB"].ConnectionString;
            }
            // Fallback default connection string for LocalDB
            return @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=OnlineShoppingDB;Integrated Security=True;Connect Timeout=30;";
        }

        /// <summary>
        /// Executes a SELECT query and returns the results as a DataTable.
        /// Ideal for populating GridViews, Repeaters, and DropDownLists.
        /// </summary>
        public static DataTable GetData(string query, SqlParameter[] parameters = null)
        {
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(GetConnectionString()))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    if (parameters != null)
                    {
                        cmd.Parameters.AddRange(parameters);
                    }
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }
            return dt;
        }

        /// <summary>
        /// Executes an INSERT, UPDATE, or DELETE query.
        /// Returns the number of affected rows.
        /// </summary>
        public static int ExecuteNonQuery(string query, SqlParameter[] parameters = null)
        {
            int rowsAffected = 0;
            using (SqlConnection con = new SqlConnection(GetConnectionString()))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    if (parameters != null)
                    {
                        cmd.Parameters.AddRange(parameters);
                    }
                    con.Open();
                    rowsAffected = cmd.ExecuteNonQuery();
                }
            }
            return rowsAffected;
        }

        /// <summary>
        /// Executes a query that returns a single scalar value (e.g. COUNT(*), SCOPE_IDENTITY()).
        /// </summary>
        public static object ExecuteScalar(string query, SqlParameter[] parameters = null)
        {
            object result = null;
            using (SqlConnection con = new SqlConnection(GetConnectionString()))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    if (parameters != null)
                    {
                        cmd.Parameters.AddRange(parameters);
                    }
                    con.Open();
                    result = cmd.ExecuteScalar();
                }
            }
            return result;
        }
    }
}
