using Capstone.Web.DAL;
using Capstone.Web.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Newtonsoft.Json;


namespace Capstone.Web.Controllers
{
    public class HomeController : Controller
    {
        IBreweryDAL breweryDAL;
        IBeerDAL beerDAL;
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

            searchResults.Breweries = breweryDAL.SearchBreweries(searchResult);
            searchResults.Beers = beerDAL.Beers(searchResult);

            var result = JsonConvert.SerializeObject(searchResults);

            return result;
        }
    }
}