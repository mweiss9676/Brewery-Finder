using Microsoft.Owin.;
using Owin;

[assembly: OwinStartupAttribute(typeof(Capstone.Web.Startup))]
namespace Capstone.Web
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
            //CreateRolesandUsers();

            
        }

        private void CreateRolesAndUsers()
        {
            ApplicationDbContext context = new ApplicationDbContext();
        }
    }
}
