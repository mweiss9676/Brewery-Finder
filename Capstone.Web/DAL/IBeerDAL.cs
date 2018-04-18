using Capstone.Web.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capstone.Web.DAL
{
    public interface IBeerDAL
    {
        List<BeerModel> GetBeerSearchResults(string searchString, string latitude, string longitude, decimal searchRadius);

        BeerModel GetBeerDetail(int beerId);

        List<string> GetListOfBeerTypes();

        void AddNewBeer(AddBeerModel beer);

        IList<BeerModel> GetAllBeers();

        void RemoveBeer(string beerName);

        List<BeerModel> GetBreweryBeers(int breweryId);

    }
}
