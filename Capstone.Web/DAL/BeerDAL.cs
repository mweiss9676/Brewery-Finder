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

        public List<BeerModel> Beers(SearchStringModel searchString)
        {
            Dictionary<string, BeerModel> searchResults = new Dictionary<string, BeerModel>();

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
                        SqlCommand cmd = new SqlCommand(@"SELECT * FROM Beer
                                                          WHERE BeerName LIKE @beer
                                                          OR Beer.BeerDescription LIKE @description", conn);

                        cmd.Parameters.AddWithValue("@beer", $"%{searchTerm}%");
                        cmd.Parameters.AddWithValue("@description", $"%{searchTerm}%");

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