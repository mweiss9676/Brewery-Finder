using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using Capstone.Web.Models;
using System.Configuration;
using System.Text.RegularExpressions;

namespace Capstone.Web.DAL
{
    public class BreweryDAL : IBreweryDAL
    {
        private string connectionString;

        public BreweryDAL(string connectionString)
        {
            this.connectionString = connectionString;
        }

       

        public IList<BreweryModel> GetAllBreweries()
        {
            List<BreweryModel> breweries = new List<BreweryModel>();
            // Use SQL Reader to get a list of all brewery models
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand(@"SELECT * FROM Brewery", conn);

                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        BreweryModel brewery = BreweryReader(reader);
                        breweries.Add(brewery);
                    }
                }
            }
            catch (SqlException ex)
            {
                throw ex;
            }

            return breweries;
        }

        public BreweryModel GetBreweryDetail()
        {
            // Use SQL REader to get the details of a single brewery
            BreweryModel brewery;

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand(/*@""*/);

                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        brewery = BreweryReader(reader);
                        return brewery;
                    }
                }
            }
            catch (SqlException ex)
            {
                throw ex;
            }
            return null;
        }

        public HashSet<BreweryModel> SearchBreweries(SearchResultModel searchString)
        {
            HashSet<BreweryModel> searchResults = new HashSet<BreweryModel>();

            Regex reg = new Regex(@"(?:\s)");

            var searchParameters = reg.Split(searchString.SearchString);

            try
            {

                for (int i = 0; i < searchParameters.Length; i++)
                {

                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        conn.Open();

                        string searchTerm = searchParameters[i];
                        SqlCommand cmd = new SqlCommand(@"SELECT * FROM Brewery
                                                      WHERE BreweryName LIKE @brewery
                                                      OR BreweryDistrict LIKE @district
                                                      OR BreweryCity LIKE @city
                                                      OR BreweryPostalCode LIKE @postal", conn);

                        cmd.Parameters.AddWithValue("@brewery", $"%{searchTerm}%");
                        cmd.Parameters.AddWithValue("@district", $"%{searchTerm}%");
                        cmd.Parameters.AddWithValue("@city", $"%{searchTerm}%");
                        cmd.Parameters.AddWithValue("@postal", $"%{searchTerm}%");

                        SqlDataReader reader = cmd.ExecuteReader();

                        while (reader.Read())
                        {
                            BreweryModel brewery = BreweryReader(reader);
                            searchResults.Add(brewery);
                        }
                    }                    
                }
            }
            catch (SqlException ex)
            {
                Console.WriteLine(ex);
            }

            return searchResults;
        }

        private BreweryModel BreweryReader(SqlDataReader reader)
        {
            return new BreweryModel()
            {
                BreweryName = Convert.ToString(reader["BreweryName"]),
                BreweryAddress = Convert.ToString(reader["BreweryAddress"]),
                BreweryCity = Convert.ToString(reader["BreweryCity"]),
                BreweryPostalCode = Convert.ToString(reader["BreweryPostalCode"]),
                BreweryDistrict = Convert.ToString(reader["BreweryDistrict"]),
                BreweryCountry = Convert.ToString(reader["BreweryCountry"]),
                History = Convert.ToString(reader["History"]),
                YearFounded = Convert.ToInt32(reader["YearFounded"]),
                BreweryProfileImg = Convert.ToString(reader["BreweryProfileImg"]),
                BreweryBackgroundImg = Convert.ToString(reader["BreweryBackgroundImg"]),
                BreweryHeaderImage = Convert.ToString(reader["BreweryHeaderImg"])
            };
        }
    }
}


