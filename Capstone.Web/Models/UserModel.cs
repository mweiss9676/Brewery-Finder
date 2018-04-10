using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Capstone.Web.Models
{
    public class UserModel
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string UserAddress { get; set; }
        public string UserCity { get; set; }
        public string UserPostalCode { get; set; }
        public string UserDistrict { get; set; }
        public string UserCountry { get; set; }
        public string Role { get; set; }
        public string Username { get; set; }
        public string UserEmail { get; set; }
        public DateTime Password1stAttempt { get; set; }
        public int NumberOfAttempts { get; set; }
        public string ProfilePic { get; set; }
    }
}