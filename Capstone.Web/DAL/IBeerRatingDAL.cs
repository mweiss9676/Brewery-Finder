using Capstone.Web.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capstone.Web.DAL
{
    public interface IBeerRatingDAL
    {
        void RateABeer(BeerRatingModel rating);
        List<BeerRatingModel> GetAllReviewsForOneBeer(int BeerId);
        List<BeerModel> GetUserFavoriteBeerNames(string guid);
    }
}
