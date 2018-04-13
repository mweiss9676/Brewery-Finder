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

        BeerModel GetBeer();

        List<string> GetListOfBeerTypes();

        void AddNewBeer(AddBeerModel beer);

        void RemoveBeer(int beerId);
    }
}
