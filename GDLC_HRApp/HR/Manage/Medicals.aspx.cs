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

namespace GDLC_HRApp.HR.Manage
{
    public partial class Medicals : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            medicalGrid.Rebind();
        }

        protected void medicalGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                GridDataItem item = e.Item as GridDataItem;
                
            }
        }

        protected void medicalGrid_ItemDeleted(object sender, GridDeletedEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + e.Exception.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Deleted Successfully', 'Success');", true);
            }
        }
        protected void dlEmployee_ItemDataBound(object sender, RadComboBoxItemEventArgs e)
        {
            e.Item.Text = ((DataRowView)e.Item.DataItem)["FullName"].ToString() + " - " + ((DataRowView)e.Item.DataItem)["StaffNo"].ToString();
            e.Item.Value = ((DataRowView)e.Item.DataItem)["Id"].ToString();
        }

        protected void dlEmployee_DataBound(object sender, EventArgs e)
        {
            //set the initial footer label
            ((Literal)dlEmployee.Footer.FindControl("employeeCount")).Text = Convert.ToString(dlEmployee.Items.Count);
        }

        protected void dlEmployee_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            String sql = "SELECT top (30) Id, FullName, StaffNo FROM [vwEmployee] WHERE (FullName LIKE '%" + e.Text.ToUpper() + "%' OR StaffNo LIKE '%" + e.Text.ToUpper() + "%')";
            employeeSource.SelectCommand = sql;
            dlEmployee.DataBind();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string query = "insert into tblEmployeeMedicals(employeeId,healthfacility,startdate,enddate,createdby) values(@employeeId,@healthfacility,@startdate,@enddate,@createdby)";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@employeeId", SqlDbType.Int).Value = dlEmployee.SelectedValue;
                    command.Parameters.Add("@healthfacility", SqlDbType.VarChar).Value = txtHealthFacility.Text;
                    command.Parameters.Add("@startdate", SqlDbType.DateTime).Value = dpStartdate.SelectedDate;
                    command.Parameters.Add("@enddate", SqlDbType.DateTime).Value = dpEnddate.SelectedDate;
                    command.Parameters.Add("@createdby", SqlDbType.VarChar).Value = User.Identity.Name;
                    try
                    {
                        connection.Open();
                        rows = command.ExecuteNonQuery();
                        if (rows == 1)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Saved Successfully', 'Success');", true);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "closenewModal();", true);
                            medicalGrid.Rebind();
                            dlEmployee.ClearSelection();
                            txtHealthFacility.Text = "";
                            dpStartdate.Clear();
                            dpEnddate.Clear();
                        }
                    }
                    catch (SqlException ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }
    }
}