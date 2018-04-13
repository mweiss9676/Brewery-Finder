using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Capstone.Web.Models
{
    public class AddBeerModel
    {
        public string BreweryName { get; set; }
        public string BeerName { get; set; }
        public string BeerTypeName { get; set; }
        public string BeerDescription { get; set; }
        public int ABV { get; set; }
        public int IBU { get; set; }
        public DateTime DateBrewed { get; set; }
        public string BeerLabelImg { get; set; }
    }
}