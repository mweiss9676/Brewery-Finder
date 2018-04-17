using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Capstone.Web.Models
{
    public class BeerRatingModel
    {      
        public int BeerId { get; set; }
        public int BeerRating { get; set; }   
        public Guid UserId { get; set; }
    }
}