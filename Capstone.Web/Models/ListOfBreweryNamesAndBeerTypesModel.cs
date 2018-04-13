using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Capstone.Web.Models
{
    public class ListOfBreweryNamesAndBeerTypesModel
    {
        public List<string> BreweryNames { get; set; }
        public List<string> BeerTypes { get; set; }
    }
}