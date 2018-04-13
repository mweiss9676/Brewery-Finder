using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using Capstone.Web.Models;

namespace Capstone.Web.DAL
{
    public class BeerDAL : IBeerDAL
    {

        private string connectionString;

        public BeerDAL(string connectionString)
        {
            this.connectionString = connectionString;
        }

        public List<BeerModel> Beers(string searchString)
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
                        SqlCommand cmd = new SqlCommand(@"SELECT * FROM Beer
                                                          JOIN BeerTypes ON BeerTypes.BeerTypeId = Beer.BeerTypeId
                                                          WHERE BeerName LIKE @beer
                                                          OR Beer.BeerDescription LIKE @description
                                                          OR BeerTypes.BeerType LIKE @beertype", conn);


                        cmd.Parameters.AddWithValue("@beer", $"%{searchTerm}%");
                        cmd.Parameters.AddWithValue("@description", $"%{searchTerm}%");
                        cmd.Parameters.AddWithValue("@beertype", $"%{searchTerm}%");

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

        public BeerModel GetBeer()
        {
            throw new NotImplementedException();
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

        private BeerModel BeerReader(SqlDataReader reader)
        {
            return new BeerModel()
            {
                BeerId = Convert.ToInt32(reader["BeerId"]),
                BeerName = Convert.ToString(reader["BeerName"]),
                BeerDescription = Convert.ToString(reader["BeerDescription"]),
                BeerLabelImg = Convert.ToString(reader["BeerLabelImg"]),

            };
        }
    }
}