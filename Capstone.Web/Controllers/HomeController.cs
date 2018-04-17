using Capstone.Web.DAL;
using Capstone.Web.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Newtonsoft.Json;
using Microsoft.AspNet.Identity;
using System.Device.Location;

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
            var breweries = breweryDAL.SearchBreweries(searchResult);

            GeoCoordinate userCoord = new GeoCoordinate(Convert.ToDouble(Session["UserLatitude"]), Convert.ToDouble(Session["UserLongitude"]));

            searchResults.Breweries = breweries.OrderBy(brewery => userCoord.GetDistanceTo(new GeoCoordinate(brewery.BreweryLatitude, brewery.BreweryLongitude))).ToList();

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
            Session["UserLatitude"] = latitude;
            Session["UserLongitude"] = longitude;
        }

        public ActionResult BeerRating(int id)
        {
            List<BeerRatingModel> list = beerRatingDAL.GetAllReviewsForOneBeer(id);

            return PartialView("BeerRating", list);
        }
    }
}