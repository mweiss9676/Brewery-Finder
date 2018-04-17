using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using Capstone.Web.Models;

namespace Capstone.Web.DAL
{
    public class BeerRatingDAL : IBeerRatingDAL
    {
        private string connectionString;

        public BeerRatingDAL(string connectionString)
        {
            this.connectionString = connectionString;
        }

        public List<int> GetAllReviewsForOneBeer(int BeerId)
        {
            List<int> list = new List<int>();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                SqlCommand cmd = new SqlCommand("@SELECT BeerRating.BeerRating from BeerRating WHERE BeerId = @beerId", conn);

                cmd.Parameters.AddWithValue("@beerId", BeerId);

                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    list.Add(Convert.ToInt32(reader["BeerRating"]));
                }
            }
            return list;
        }

        public void RateABeer(BeerRatingModel beerRatingModel)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand(@"INSERT INTO BeerRating (BeerId, BeerRating, UserId) VALUES (@beerId, @beerRating, @userId)", conn);

                    cmd.Parameters.AddWithValue("@beerId", beerRatingModel.BeerId);
                    cmd.Parameters.AddWithValue("@beerRating", beerRatingModel.BeerRating);
                    cmd.Parameters.AddWithValue("@userId", beerRatingModel.UserId);
                }
            }
            catch (SqlException ex)
            {
                Console.WriteLine(ex);
            }

        }

        private BeerRatingModel BeerRatingReader(SqlDataReader reader)
        {
            return new BeerRatingModel()
            {
                BeerId = Convert.ToInt32(reader["BeerId"]),
                BeerRating = Convert.ToInt32(reader["BeerRating"]),
                //UserId = new Guid(reader[])
            };
        }
    }
}