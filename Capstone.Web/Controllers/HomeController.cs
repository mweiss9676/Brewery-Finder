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

        //public ActionResult ListPage(SearchStringModel searchresult)
        //{
        //    SearchResultsModel searchResults = new SearchResultsModel();

        //    searchResults.Breweries = breweryDAL.SearchBreweries(searchresult);
        //    searchResults.Beers = beerDAL.Beers(searchresult);


        //    return View("ListPage", searchResults);
        //}

        public ActionResult BreweryInfo(BreweryModel brewery)
        {
            var result = breweryDAL.GetBreweryDetail(brewery.BreweryId);

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