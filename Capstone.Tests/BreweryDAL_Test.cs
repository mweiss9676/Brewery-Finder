using System;
using System.Collections.Generic;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Transactions;
using Capstone.Web.Models;
using Capstone.Web.DAL;

namespace Capstone.Tests
{
    [TestClass]
    public class AddBreweryTest
    {
        static string connectionString = @"Server=.\SQLEXPRESS;Initial Catalog = BreweryDB; Integrated Security = True";

        [TestMethod]
        public void AddBrewery_Test()
        {
            // Arrange
            BreweryDAL breweryDAL = new BreweryDAL(connectionString);

            string name;

            using (TransactionScope transact = new TransactionScope())
            {
                AddBreweryModel brewery = new AddBreweryModel
                {
                    BreweryName = "Jimmy's Place",
                    BreweryAddress = "776 County Road 30A",
                    BreweryCity = "Ashland",
                    BreweryCountry = "USA",
                    BreweryDistrict = "OH",
                    BreweryPostalCode = "44805",
                    History = "Making Home-Brews since 2016",
                    YearFounded = 2016,
                    Email = "j_vanetta@yahoo.com",
                    Phone = "419-631-6637",
                    HoursOfOperation = "From Dusk til' Dawn",
                    BreweryProfileImg = "none",
                    BreweryBackgroundImg = "none",
                    BreweryHeaderImage = "none"
                };

                breweryDAL.SetBreweryCoords(brewery);

                breweryDAL.AddBrewery(brewery);

                name = brewery.BreweryName;

                // Act
                List<string> results = breweryDAL.GetAllBreweryNames();

                // Assert
                Assert.IsTrue(results.Contains(name));
            }
        }
    }
}
