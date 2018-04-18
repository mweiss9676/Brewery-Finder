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

        public List<BeerRatingModel> GetAllReviewsForOneBeer(int BeerId)
        {
            List<BeerRatingModel> list = new List<BeerRatingModel>();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                SqlCommand cmd = new SqlCommand(@"SELECT BeerRating.BeerId, BeerRating.BeerRating, BeerRating.UserId from BeerRating INNER JOIN Beer ON Beer.BeerId = BeerRating.BeerId WHERE BeerRating.BeerId = @beerId" , conn);

                cmd.Parameters.AddWithValue("@beerId", BeerId);

                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    list.Add(BeerRatingReader(reader));
                }
            }
            return list;
        }

        public void RateABeer(BeerRatingModel rating)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
/*(BeerId, BeerRating, UserId) */
                    SqlCommand cmd = new SqlCommand(@"INSERT INTO BeerRating VALUES (@beerId, @beerRating, @userId)", conn);

                    cmd.Parameters.AddWithValue("@beerId", rating.BeerId);
                    cmd.Parameters.AddWithValue("@beerRating", rating.BeerRating);
                    cmd.Parameters.AddWithValue("@userId", rating.UserId);
                    cmd.ExecuteNonQuery();
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
                UserId = Guid.Parse(reader["UserId"].ToString())
            };
        }
    }
}