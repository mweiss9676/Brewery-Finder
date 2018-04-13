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

        public BrewerController(IBeerDAL beerDAL)
        {
            this.beerDAL = beerDAL;
        }

        // GET: Brewer
        public ActionResult Index()
        {
            return View("Index");
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