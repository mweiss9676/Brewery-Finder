using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Capstone.Web.Models
{
    public class SearchResultsModel
    {
        public IList<BreweryModel> Breweries { get; set; }
        public List<BeerModel> Beers { get; set; }
    }
}