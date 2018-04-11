using Capstone.Web.DAL;
using Capstone.Web.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Capstone.Web.Controllers
{
    public class HomeController : Controller
    {
        IBreweryDAL dal;
        public HomeController(IBreweryDAL dal)
        {
            this.dal = dal;
        }

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult ListPage(SearchStringModel searchresult)
        {
            var breweries = dal.SearchBreweries(searchresult);

            return View("ListPage", breweries);
        }

        public ActionResult BreweryInfo(int breweryId)
        {
            var result = dal.GetBreweryDetail(breweryId);

            return View("BreweryInfo", result);
        }
    }
}