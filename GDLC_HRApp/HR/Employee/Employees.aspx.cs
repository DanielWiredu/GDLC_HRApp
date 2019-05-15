using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace GDLC_HRApp.HR.Employee
{
    public partial class Employees : MasterPageChange
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            employeeGrid.Rebind();
        }

        protected void employeeGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                GridDataItem item = e.Item as GridDataItem;
                Response.Redirect("/HR/Employee/EditEmployee.aspx?staffno=" + item["StaffNo"].Text);
            }
        }
    }
}