using Microsoft.AspNet.Identity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using System.Web;

namespace Capstone.Web.Authentication
{
    public class User : IUser
    {
        public Guid UserId { get; set; }
        public string Id => UserId.ToString();
        public string UserName { get; set; }
        public string PasswordHash { get; set; }
        public string SecurityStamp { get; set; }
        public IList<string> Roles { get; set; } = new List<string>();        
        public DateTime Password1stAttempt { get; set; }
        public int NumberOfAttempts { get; set; }
        
        public async Task<ClaimsIdentity> GenerateUserIdentityAsync(UserManager<User> manager)
        {
            // Note the authenticationType must match the one defined in CookieAuthenticationOptions.AuthenticationType
            var userIdentity = await manager.CreateIdentityAsync(this, DefaultAuthenticationTypes.ApplicationCookie);
            var claims = Roles.Select(role => new Claim(ClaimTypes.Role, role));
            userIdentity.AddClaims(claims);
            // Add custom user claims here
            return userIdentity;
        }
    }
}