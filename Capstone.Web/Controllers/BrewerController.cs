using Capstone.Web.DAL;
using Capstone.Web.Models;
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

        public BrewerController(IBeerDAL beerDAL, IBreweryDAL breweryDAL)
        {
            this.beerDAL = beerDAL;
            this.breweryDAL = breweryDAL;
        }

        // GET: Brewer
        public ActionResult Index()
        {
            ListOfBreweryNamesAndBeerTypesModel breweriesAndBeers = new ListOfBreweryNamesAndBeerTypesModel();
            breweriesAndBeers.BreweryNames = breweryDAL.GetAllBreweryNames();
            breweriesAndBeers.BeerTypes = beerDAL.GetListOfBeerTypes();

            return View("Index", breweriesAndBeers);
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