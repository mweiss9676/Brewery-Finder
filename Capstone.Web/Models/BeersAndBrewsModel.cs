using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Capstone.Web.Models
{
    public class BeersAndBrewsModel
    {
        List<BeerModel> Beers { get; set; }
        List<BreweryModel> Breweries { get; set; }
    }
}