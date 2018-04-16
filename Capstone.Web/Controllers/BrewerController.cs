using Capstone.Web.DAL;
using Capstone.Web.Models;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using GoogleMaps.LocationServices;

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

        public ApplicationUserManager UserManager {  get => HttpContext.GetOwinContext().GetUserManager<ApplicationUserManager>(); }
        
        
        

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
            SetBreweryCoords(brewery);

            breweryDAL.AddBrewery(brewery);
            return RedirectToAction("GreatSuccess");
        }

        


        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> GrantRoleToUser(string username, string role)
        {            
            var user = await UserManager.FindByNameAsync(username);
            user.Roles.Add(role);
            await UserManager.UpdateAsync(user);

            return RedirectToAction("blah");
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

        /// <summary>
        /// Helper Method that uses Google GeoCode API to get Latitude and Longitude from an address
        /// - JV
        /// </summary>
        /// <param name="brewery">the brewery model containing address information</param>
        public void SetBreweryCoords(AddBreweryModel brewery)
        {
            string address = brewery.BreweryAddress + ", " + brewery.BreweryCity + ", " + brewery.BreweryDistrict + "," + brewery.BreweryPostalCode;

            var geoCoder = new GoogleLocationService("AIzaSyBd0o2LU8lvSyx2etULu-bEEiSl7EKTJFM");

            var breweryLocation = geoCoder.GetLatLongFromAddress(address);

            brewery.BreweryLatitude = breweryLocation.Latitude;
            brewery.BreweryLongitude = breweryLocation.Longitude;
        } 
    }
}