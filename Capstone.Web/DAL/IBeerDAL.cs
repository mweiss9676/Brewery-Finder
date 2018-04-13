﻿using Capstone.Web.Models;
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

        BeerModel GetBeerDetail(int beerId);

        BeerModel GetBeer();

        List<string> GetListOfBeerTypes();

        void AddNewBeer(AddBeerModel beer);

        IList<BeerModel> GetAllBeers();

        void RemoveBeer(int beerId);
    }
}
