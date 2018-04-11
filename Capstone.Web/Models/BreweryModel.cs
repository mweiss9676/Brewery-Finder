using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Capstone.Web.Models
{
    public class BreweryModel
    {
        public int BreweryId { get; set; }
        public string BreweryName { get; set; }
        public string BreweryAddress { get; set; }
        public string BreweryCity { get; set; }
        public string BreweryPostalCode { get; set; }
        public string BreweryDistrict { get; set; }
        public string BreweryCountry { get; set; }
        public string History { get; set; }
        public int YearFounded { get; set; }
        public string BreweryProfileImg { get; set; }
        public string BreweryBackgroundImg { get; set; }
        public string BreweryHeaderImage { get; set; }

    }
}