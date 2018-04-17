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
        IBeerRatingDAL beerRatingDAL;

        public HomeController(IBreweryDAL breweryDAL, IBeerDAL beerDAL, IBeerRatingDAL beerRatingDAL)
        {
            this.breweryDAL = breweryDAL;
            this.beerDAL = beerDAL;
            this.beerRatingDAL = beerRatingDAL;
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

        public ActionResult BeerInfo(int id)
        {
            var result = beerDAL.GetBeerDetail(id);

            return View("BeerInfo", result);
        }

        public ActionResult BeerRating(BeerRatingModel model)
        {
            List<BeerRatingModel> list = beerRatingDAL.GetAllReviewsForOneBeer(model.BeerId);
            return PartialView("BeerRating", list);
        }
    }
}