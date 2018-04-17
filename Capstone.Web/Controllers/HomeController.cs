using Capstone.Web.DAL;
using Capstone.Web.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Newtonsoft.Json;
using Microsoft.AspNet.Identity;

namespace Capstone.Web.Controllers
{
    public class HomeController : Controller
    {
        IBreweryDAL breweryDAL;
        IBeerDAL beerDAL;

        //string userLatitude, userLongitude;

        public HomeController(IBreweryDAL breweryDAL, IBeerDAL beerDAL)
        {
            this.breweryDAL = breweryDAL;
            this.beerDAL = beerDAL;
        }

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult BreweryInfo(int id)
        {
            var result = breweryDAL.GetBreweryDetail(id);

            return View("BreweryInfo", result);
        }

        public string GetSearchResultsJson(string searchResult)
        {
            SearchResultsModel searchResults = new SearchResultsModel();

            searchResults.Breweries = breweryDAL.SearchBreweries(searchResult, Session["UserLatitude"].ToString(), Session["UserLongitude"].ToString());
            searchResults.Beers = beerDAL.Beers(searchResult);

            var result = JsonConvert.SerializeObject(searchResults);

            return result;
        }

        public ActionResult BeerInfo(int id)
        {
            var result = beerDAL.GetBeerDetail(id);

            return View("BeerInfo", result);
        }
        
        public void GetUserLocationJson(string latitude, string longitude)
        {
            // See if the user has a shopping cart stored in session
            Session["UserLatitude"] = latitude;
            Session["UserLongitude"] = longitude;
        }
    }
}