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
                    YearFounded = 2016
                };

                breweryDAL.SetBreweryCoords(brewery);

                breweryDAL.AddBrewery(brewery);
            }

            // Act
            List<string> results = breweryDAL.GetAllBreweryNames();

            // Assert
            Assert.IsTrue(results.Contains("Jimmy's Place"));
        }
    }
}
