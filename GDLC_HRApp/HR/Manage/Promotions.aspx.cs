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
    public partial class Promotions : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            promotionGrid.Rebind();
        }

        protected void promotionGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                GridDataItem item = e.Item as GridDataItem;

            }
        }

        protected void promotionGrid_ItemDeleted(object sender, GridDeletedEventArgs e)
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
            string query = "insert into tblPromotions(employeeId,prevpositionId,newpositionId,datepromoted,createdby) values(@employeeId,@prevpositionId,@newpositionId,@datepromoted,@createdby)";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@employeeId", SqlDbType.Int).Value = dlEmployee.SelectedValue;
                    command.Parameters.Add("@prevpositionId", SqlDbType.Int).Value = dlPrevPosition.SelectedValue;
                    command.Parameters.Add("@newpositionId", SqlDbType.Int).Value = dlNewPosition.SelectedValue;
                    command.Parameters.Add("@datepromoted", SqlDbType.DateTime).Value = dpDatePromoted.SelectedDate;
                    command.Parameters.Add("@createdby", SqlDbType.VarChar).Value = User.Identity.Name;
                    try
                    {
                        connection.Open();
                        rows = command.ExecuteNonQuery();
                        if (rows == 1)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Saved Successfully', 'Success');", true);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "closenewModal();", true);
                            promotionGrid.Rebind();
                            dlEmployee.ClearSelection();
                            dlPrevPosition.ClearSelection();
                            dlNewPosition.ClearSelection();
                            dpDatePromoted.Clear();
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