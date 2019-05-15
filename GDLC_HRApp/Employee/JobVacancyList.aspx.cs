using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace GDLC_HRApp.Employee
{
    public partial class JobVacancyList : MasterPageChange
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            vacancyGrid.Rebind();
        }

        protected void vacancyGrid_SelectedIndexChanged(object sender, EventArgs e)
        {
            Response.Redirect("/Employee/JobVacancyView.aspx?jobId=" + vacancyGrid.SelectedValue);
        }
    }
}