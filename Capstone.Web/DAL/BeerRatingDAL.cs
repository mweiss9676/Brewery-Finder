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

                SqlCommand cmd = new SqlCommand(@"SELECT BeerRating.BeerId, BeerRating.BeerRating, BeerRating.UserId from BeerRating INNER JOIN Beer ON Beer.BeerId = BeerRating.BeerId WHERE BeerRating.BeerId = @beerId", conn);

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

                    //SqlCommand cmd = new SqlCommand(@"INSERT INTO BeerRating VALUES (@beerId, @beerRating, @userId)", conn);
                    SqlCommand cmd = new SqlCommand(@"IF EXISTS (SELECT * FROM BeerRating WHERE BeerId = @beerId AND UserId = @userId)
                                                      BEGIN
                                                      UPDATE BeerRating
                                                      SET BeerRating = @beerRating
                                                      WHERE BeerId = @BeerId AND UserId = @userId
                                                      END
                                                      ELSE
                                                      BEGIN
                                                      INSERT INTO BeerRating VALUES (@beerId, @beerRating, @userId)                                                                                                        
                                                      END", conn);

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

        /// <summary>
        /// Returns A List Of Users 'Favorite' Beer Names
        /// </summary>
        /// <param name="userId">User's Unique GUID</param>
        /// <returns>List Of Beer Names That User Has Given High Ratings</returns>
        public List<BeerModel> GetUserFavoriteBeerNames(string guid)
        {
            List<BeerModel> result = new List<BeerModel>();
            try
            {


                // Get All Beer Ratings For The User's GUID
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand(@"SELECT Beer.BeerID, Beer.BreweryId, 
                                                      Beer.BeerName, BeerRating.UserId, 
                                                      BeerRating.BeerRating
                                                      FROM Beer
                                                      JOIN BeerRating ON BeerRating.BeerID = BeerRating.BeerID 
                                                      WHERE UserId = @user 
                                                      AND Beer.BeerID = BeerRating.BeerId AND BeerRating > 3", conn);

                    cmd.Parameters.AddWithValue("@user", guid);

                    SqlDataReader reader = cmd.ExecuteReader();

                    

                    while (reader.Read())
                    {
                        BeerModel beer = new BeerModel();
                        beer.BeerId = (Convert.ToInt32(reader["BeerID"]));
                        beer.BreweryId = (Convert.ToInt32(reader["BreweryId"]));
                        beer.BeerName = (Convert.ToString(reader["BeerName"]));
                        result.Add(beer);
                    }
                    
                }
            }
            catch(SqlException ex)
            {
                Console.WriteLine(ex.Message);
            }

            return result;
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