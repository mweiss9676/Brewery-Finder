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
        List<BeerModel> Beers(string searchString);

<<<<<<< HEAD
        BeerModel GetBeerDetail(int beerId);
=======
        BeerModel GetBeer();
>>>>>>> fea86dcf4b3c44df5337a8a4b7683771f9d63f10

        List<string> GetListOfBeerTypes();

        void AddNewBeer(AddBeerModel beer);

<<<<<<< HEAD
        IList<BeerModel> GetAllBeers();
=======
        void RemoveBeer(int beerId);
>>>>>>> fea86dcf4b3c44df5337a8a4b7683771f9d63f10
    }
}
