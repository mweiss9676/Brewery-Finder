﻿using Ninject;
using Ninject.Web.Common.WebHost;
using Ninject.Web.WebApi;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;
using Capstone.Web.DAL;
using System.Web.Routing;

namespace Capstone.Web
{
    public class MvcApplication : NinjectHttpApplication
    {
        protected override void OnApplicationStarted()
        {
            base.OnApplicationStarted();

            //GlobalConfiguration.Configure(WebApiConfig.Register);
            AreaRegistration.RegisterAllAreas();
            //FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
        }

        protected override IKernel CreateKernel()
        {
            var kernel = new StandardKernel();

            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            // Configure Bindings
            kernel.Bind<IBreweryDAL>().To<BreweryDAL>().WithConstructorArgument("connectionString",connectionString);
            kernel.Bind<IBeerDAL>().To<BeerDAL>().WithConstructorArgument("connectionString",connectionString);
            kernel.Bind<IUserDAL>().To<UserDAL>().WithConstructorArgument("connectionString",connectionString);
            kernel.Bind<IBeerRatingDAL>().To<BeerRatingDAL>().WithConstructorArgument("connectionString", connectionString);

            //GlobalConfiguration.Configuration.DependencyResolver = new NinjectDependencyResolver(kernel);

            return kernel;
        }
    }
}
