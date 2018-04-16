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

    }
}