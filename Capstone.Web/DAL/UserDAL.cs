using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using Capstone.Web.Models;

namespace Capstone.Web.DAL
{
    public class UserDAL : IUserDAL
    {
        private string connectionString;

        public UserDAL(string connectionString)
        {
            this.connectionString = connectionString;
        }

        public UserRolesModel GetUserRole(string userId)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand(@"SELECT * FROM UserRoles
                                                      WHERE UserId = @userId", conn);

                    cmd.Parameters.AddWithValue("@userId", userId);

                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        UserRolesModel user = new UserRolesModel();
                        user.Role = Convert.ToString(reader["Role"]);

                        return user;
                    }
                }

            }
            catch (SqlException ex)
            {
                Console.WriteLine(ex);
            }
            return null;
        }
    }
}