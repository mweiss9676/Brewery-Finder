using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using Capstone.Web.Models;
using System.Configuration;

namespace Capstone.Web.DAL
{
    public class BeerDAL : IBeerDAL
    {
   
        private string connectionString;

        public BeerDAL(string connectionString)
        {
            this.connectionString = connectionString;
        }

        public List<BeerModel> GetBeerSearchResults(string searchString, string latitude, string longitude, decimal searchRadius)
        {
            Dictionary<string, BeerModel> searchResults = new Dictionary<string, BeerModel>();

            Regex reg = new Regex(@"(?:\s)");

            var searchParameters = reg.Split(searchString);

            try
            {
                for (int i = 0; i < searchParameters.Length; i++)
                {

                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        conn.Open();
                        string searchTerm = searchParameters[i];

                        SqlCommand cmd = new SqlCommand(@"DECLARE @user_lat DECIMAL(12, 9)
                                                          DECLARE @user_lng DECIMAL(12, 9)
                                                          SET @user_lat=@latitude SET @user_lng=@longitude
                                                          DECLARE @orig geography = geography::Point(@user_lat, @user_lng, 4326);
                                                          SELECT * FROM Beer
                                                          JOIN BeerTypes ON BeerTypes.BeerTypeId = Beer.BeerTypeId
                                                          WHERE (BeerName LIKE @beer
                                                          OR Beer.BeerDescription LIKE @description
                                                          OR BeerTypes.BeerType LIKE @beertype)
                                                          AND (@orig.STDistance(geography::Point(
                                                                    (SELECT TOP 1 Brewery.BreweryLatitude FROM Brewery
                                                                     JOIN Beer ON Beer.BreweryId = Brewery.BreweryId
                                                                     JOIN BeerTypes ON BeerTypes.BeerTypeId = Beer.BeerTypeId 
                                                                     WHERE BeerName LIKE @beer
                                                                     OR Beer.BeerDescription LIKE @description
                                                                     OR BeerTypes.BeerType LIKE @beertype), 
                                                                     (SELECT TOP 1 Brewery.BreweryLongitude FROM Brewery
                                                                     JOIN Beer ON Beer.BreweryId = Brewery.BreweryId
                                                                     JOIN BeerTypes ON BeerTypes.BeerTypeId = Beer.BeerTypeId 
                                                                     WHERE BeerName LIKE @beer
                                                                     OR Beer.BeerDescription LIKE @description
                                                                     OR BeerTypes.BeerType LIKE @beertype), 4326)) < @searchRadius)", conn);

                        cmd.Parameters.AddWithValue("@beer", $"%{searchTerm}%");
                        cmd.Parameters.AddWithValue("@description", $"%{searchTerm}%");
                        cmd.Parameters.AddWithValue("@beertype", $"%{searchTerm}%");
                        cmd.Parameters.AddWithValue("@latitude", latitude);
                        cmd.Parameters.AddWithValue("@longitude", longitude);
                        cmd.Parameters.AddWithValue("@searchRadius", searchRadius);


                        SqlDataReader reader = cmd.ExecuteReader();

                        while (reader.Read())
                        {
                            BeerModel beer = BeerReader(reader);
                            if (!searchResults.ContainsKey(beer.BeerName))
                            {
                                searchResults.Add(beer.BeerName, beer);
                            }
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                Console.WriteLine(ex);
            }

            var searchResultsList = searchResults.Values.ToList();

            return searchResultsList;
        }

        public BeerModel GetBeerDetail(int beerId)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand(@"SELECT * FROM Beer WHERE BeerId = @beerId", conn);
                    cmd.Parameters.AddWithValue("@beerId", beerId);

                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        BeerModel beer = BeerReader(reader);
                        return beer;
                    }
                }
            }
            catch (SqlException ex)
            {
                throw ex;
            }
            return null;
        }

        public void AddNewBeer(AddBeerModel beer)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand(@"INSERT INTO Beer (BreweryId, BeerName, BeerTypeId, BeerDescription, ABV, IBU, DateBrewed, BeerLabelImg)
                                                      VALUES ((SELECT Brewery.BreweryId FROM Brewery
                                                              WHERE Brewery.BreweryName = @breweryName),
                                                              @beerName,
                                                              (SELECT BeerTypes.BeerTypeId FROM BeerTypes
                                                              WHERE BeerTypes.BeerType = @beerTypeName), @beerDescription, @abv, @ibu, @dateBrewed, @beerLabelImg)", conn);

                    cmd.Parameters.AddWithValue("@breweryName", beer.BreweryName);
                    cmd.Parameters.AddWithValue("@beerName", beer.BeerName);
                    cmd.Parameters.AddWithValue("@beerTypeName", beer.BeerTypeName);
                    cmd.Parameters.AddWithValue("@beerDescription", beer.BeerDescription);
                    cmd.Parameters.AddWithValue("@abv", beer.ABV);
                    cmd.Parameters.AddWithValue("@ibu", beer.IBU);
                    cmd.Parameters.AddWithValue("@dateBrewed", beer.DateBrewed);
                    cmd.Parameters.AddWithValue("@beerLabelImg", beer.BeerLabelImg);

                    cmd.ExecuteNonQuery();
                }
            }
            catch(SqlException ex)
            {
                Console.WriteLine(ex);
            }
        }

        public List<string> GetListOfBeerTypes()
        {
            try
            {
                List<string> beerTypes = new List<string>();

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand(@"SELECT BeerTypes.BeerType FROM BeerTypes", conn);

                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        beerTypes.Add(Convert.ToString(reader["BeerType"]));
                    }

                    return beerTypes;
                }
            }
            catch (SqlException ex)
            {
                Console.WriteLine(ex);
                return null;
            }
        }

        public IList<BeerModel> GetAllBeers()
        {
            List<BeerModel> beers = new List<BeerModel>();
            // Use SQL Reader to get a list of all brewery models
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand(@"SELECT * FROM Beer", conn);

                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        BeerModel beer = BeerReader(reader);
                        beers.Add(beer);
                    }
                }
            }
            catch (SqlException ex)
            {
                throw ex;
            }

            return beers;
        }

        //DID NOT TEST THIS. 
        public void RemoveBeer(string beerName)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand(@"DELETE FROM Beer
                                                      WHERE Beer.BeerName = @beerName", conn);

                    cmd.Parameters.AddWithValue("@beerName", beerName);

                    cmd.ExecuteNonQuery();
                }
            }
            catch (SqlException ex)
            {
                Console.WriteLine(ex); ;
            }
        }

        public BeerModel GetBeer()
        {
            throw new NotImplementedException();
        }

        public List<BeerModel> GetBreweryBeers(int breweryId)
        {
            try
            {
                List<BeerModel> results = new List<BeerModel>();

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand(@"SELECT * FROM Beer 
                                                      JOIN Brewery ON Brewery.BreweryId = Beer.BreweryId
                                                      WHERE Brewery.BreweryId = @breweryId", conn);
                    cmd.Parameters.AddWithValue("@breweryId", breweryId);

                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        BeerModel beer = BeerReader(reader);
                        results.Add(beer);
                    }

                    return results;
                }
            }
            catch (SqlException ex)
            {
                throw ex;
            }
        }

        // Add Method for Updating a Beer 
        //public void UpdateBeer(UpdateBeerModel beer)
        //{
        //    try
        //    {
        //        using (SqlConnection conn = new SqlConnection(connectionString))
        //        {
        //            conn.Open();

        //            SqlCommand cmd = new SqlCommand(@"UPDATE Beer
        //                                              SET BeerName = @name,
        //                                              BeerDescription = @description,
        //                                              IsBestSeller = @bestSeller
        //                                              ABV = @abv, IBU = @ibu, DateBrewed = @dateBrewed,
        //                                              BeerLabelImg = @beerImg,
        //                                              WHERE BeerID = @beerId;", conn);

        //            cmd.Parameters.AddWithValue("@beerId", beer.BeerId);
        //            cmd.Parameters.AddWithValue("@name", beer.BeerName);
        //            cmd.Parameters.AddWithValue("@description", beer.BeerDescription);
        //            cmd.Parameters.AddWithValue("@bestSeller", beer.IsBestSeller);
        //            cmd.Parameters.AddWithValue("@abv", beer.ABV);
        //            cmd.Parameters.AddWithValue("@ibu", beer.IBU);
        //            cmd.Parameters.AddWithValue("@dateBrewed", beer.DateBrewed);
        //            cmd.Parameters.AddWithValue("@beerImg", beer.BeerLabelImg);

        //            cmd.ExecuteNonQuery();
        //        }
        //    }
        //    catch (SqlException ex)
        //    {
        //        Console.WriteLine(ex);
        //    }
        //}

        private BeerModel BeerReader(SqlDataReader reader)
        {
            return new BeerModel()
            {
                BeerId = Convert.ToInt32(reader["BeerId"]),
                BeerName = Convert.ToString(reader["BeerName"]),
                BeerDescription = Convert.ToString(reader["BeerDescription"]),
                BeerLabelImg = Convert.ToString(reader["BeerLabelImg"] as string ?? "NA"),
                ABV = Convert.ToDecimal(reader["ABV"] as decimal?),
                IBU = Convert.ToInt32(reader["IBU"] as int?),
                DateBrewed = Convert.ToDateTime(reader["DateBrewed"]),
                BreweryId = Convert.ToInt32(reader["BreweryId"])
            };
        }
    }
}