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
using System.Text.RegularExpressions;
using GoogleMaps.LocationServices;

namespace Capstone.Web.Controllers
{
    public class HomeController : Controller
    {
        private string locationServiceApiKey = "AIzaSyBd0o2LU8lvSyx2etULu-bEEiSl7EKTJFM";

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

        public ActionResult BreweryInfo(int Id)
        {
            BreweryDetailModel breweryInfo = new BreweryDetailModel();
            breweryInfo.Brewery = breweryDAL.GetBreweryDetail(Id);
            breweryInfo.Beers = beerDAL.GetBreweryBeers(Id);

            return View("BreweryInfo", breweryInfo);
        }

        public string GetSearchResultsJson(string searchResult)
        {
            SearchResultsModel searchResults = new SearchResultsModel();
            var breweries = breweryDAL.SearchBreweries(searchResult);
            var beers = beerDAL.GetBeerSearchResults(searchResult);

            Regex location = new Regex(@"(?<=\snear\s|\sby\s|\sat\s|\sin\s|\sclose\sto\s|\saround\s|\swithin\s)(.+)$");

            GeoCoordinate userCoord;

            if (location.IsMatch(searchResult))
            {
                var match = location.Match(searchResult);
                string address = match.Groups[0].ToString();


                var geoCoder = new GoogleLocationService(locationServiceApiKey);
                var searchLocation = geoCoder.GetLatLongFromAddress(address);

                userCoord = new GeoCoordinate(searchLocation.Latitude, searchLocation.Longitude);
            }
            else
            {
                userCoord = new GeoCoordinate(Convert.ToDouble(Session["UserLatitude"]), Convert.ToDouble(Session["UserLongitude"]));
            }

            searchResults.Breweries = breweries.OrderBy(brewery => userCoord.GetDistanceTo(new GeoCoordinate(brewery.BreweryLatitude, brewery.BreweryLongitude))).ToList();
            searchResults.Beers = beers.OrderBy(beer => userCoord.GetDistanceTo(new GeoCoordinate(breweryDAL.GetBreweryDetail(beer.BreweryId).BreweryLatitude, breweryDAL.GetBreweryDetail(beer.BreweryId).BreweryLongitude))).ToList();

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
            ViewBag.BeerId = id;

            return PartialView("BeerRating", list);
        }

        [HttpPost]
        public ActionResult BeerRating(BeerRatingModel model)
        {
            model.UserId = Guid.Parse(User.Identity.GetUserId());
            beerRatingDAL.RateABeer(model);
            return RedirectToAction("Index", model);
        }
    }
}