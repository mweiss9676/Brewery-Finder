using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Capstone.Web.Models
{
    public class BeerModel
    {
        public int BeerId { get; set; }
        public string BeerName { get; set; }
        public string BeerDescription { get; set; }
        public bool IsBestSeller { get; set; }
        public decimal ABV { get; set; }
        public int IBU { get; set; }
        public DateTime DateBrewed { get; set; }
        public string BeerLabelImg { get; set; }
        public double AverageRating { get; set; }
        public int BreweryId { get; set; }

    }
}