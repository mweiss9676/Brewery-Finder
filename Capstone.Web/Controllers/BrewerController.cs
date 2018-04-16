using Capstone.Web.DAL;
using Capstone.Web.Models;
using Microsoft.AspNet.Identity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Capstone.Web.Controllers
{
    public class BrewerController : Controller
    {
        private IBeerDAL beerDAL;
        private IBreweryDAL breweryDAL;
        private IUserDAL userDAL;

        public BrewerController(IBeerDAL beerDAL, IBreweryDAL breweryDAL, IUserDAL userDAL)
        {
            this.beerDAL = beerDAL;
            this.breweryDAL = breweryDAL;
            this.userDAL = userDAL;
        }

        // GET: Brewer
        public ActionResult Index()
        {
            ListOfBreweryNamesAndBeerTypesModel breweriesAndBeers = new ListOfBreweryNamesAndBeerTypesModel();
            breweriesAndBeers.BreweryNames = breweryDAL.GetAllBreweryNames();
            breweriesAndBeers.BeerTypes = beerDAL.GetListOfBeerTypes();
            breweriesAndBeers.User = userDAL.GetUserRole(User.Identity.GetUserId());

            return View("Index", breweriesAndBeers);
        }

        [HttpPost]
        public ActionResult AddBrewery(AddBreweryModel brewery)
        {
            // This Gets and Sets Lat and Long of Brewery from the Brewery Address - JV
            breweryDAL.SetBreweryCoords(brewery); 

            breweryDAL.AddBrewery(brewery);

            return RedirectToAction("GreatSuccess");
        }

        [HttpPost]
        public ActionResult AddBeer(AddBeerModel beer)
        {
            beerDAL.AddNewBeer(beer);
            return RedirectToAction("GreatSuccess");
        }

        public ActionResult GreatSuccess()
        {
            return View("GreatSuccess");
        }
    }
}