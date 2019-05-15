using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;

namespace GDLC_HRApp.Employee.Leave
{
    public partial class Leave : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void leaveGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Delete")
            {
                GridDataItem item = e.Item as GridDataItem;
                string approvedStatus = item["ApprovedStatus"].Text;
                if (approvedStatus == "1" || approvedStatus == "2") //cancel delete if leave is approved or denied
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Sorry, you cannot delete an approved or denied leave','Error');", true);
                    return;
                }
                string Id = item["Id"].Text;
                string query = "delete from tblLeave where Id = @Id";
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.Add("@Id", SqlDbType.Int).Value = Id;
                        try
                        {
                            connection.Open();
                            rows = command.ExecuteNonQuery();
                            if (rows == 1)
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Deleted Successfully','Success');", true);
                                leaveGrid.Rebind();
                            }
                        }
                        catch (Exception ex)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "','Error');", true);
                        }
                    }
                }
            }
        }

        protected void leaveGrid_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem item = e.Item as GridDataItem;
                if (item["ApprovedStatus"].Text == "2")
                {
                    item.BackColor = Color.LightPink;
                }
                else if (item["ApprovedStatus"].Text == "1")
                {
                    item.BackColor = Color.GreenYellow;
                }
            }
        }
    }
}