using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GDLC_HRApp
{
    public class MasterPageChange : System.Web.UI.Page
    {
        protected override void OnPreInit(EventArgs e)
        {
            //this.MasterPageFile = "~/Home.Master";
            if (Context.User.Identity.Name != null)  //check whether user is logged in or not
            {
                if (User.IsInRole("Employee"))
                {
                    this.MasterPageFile = "~/EmployeeHome.Master";
                }
                else if (User.IsInRole("Supervisor"))
                {
                    this.MasterPageFile = "~/SupervisorHome.Master";
                }
                else if (User.IsInRole("HR"))
                {
                    this.MasterPageFile = "~/Home.Master";
                }
            }
            base.OnPreInit(e);
        }
    }
}