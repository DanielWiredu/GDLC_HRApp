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

namespace GDLC_HRApp.HR.Setups
{
    public partial class LeaveDays : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnExcelExport_Click(object sender, EventArgs e)
        {
            leaveDayGrid.MasterTableView.ExportToExcel();
        }

        protected void btnPDFExport_Click(object sender, EventArgs e)
        {
            leaveDayGrid.MasterTableView.ExportToPdf();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string query = "INSERT INTO tblLeaveDays(LeaveTypeId,RankId,LeaveDays,DaysBefore) VALUES(@LeaveTypeId,@RankId,@LeaveDays,@DaysBefore)";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@LeaveTypeId", SqlDbType.Int).Value = dlLeaveType.SelectedValue;
                    command.Parameters.Add("@RankId", SqlDbType.Int).Value = dlRank.SelectedValue;
                    command.Parameters.Add("@LeaveDays", SqlDbType.Int).Value = txtLeaveDays.Text;
                    command.Parameters.Add("@DaysBefore", SqlDbType.Int).Value = txtDaysBefore.Text;
                    try
                    {
                        connection.Open();
                        rows = command.ExecuteNonQuery();
                        if (rows == 1)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Leave Days Saved Successfully', 'Success');", true);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "closenewModal();", true);
                            leaveDayGrid.Rebind();
                            txtLeaveDays.Value = 0;
                            txtDaysBefore.Value = 0;
                        }
                    }
                    catch (SqlException ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string query = "Update tblLeaveDays SET LeaveTypeId=@LeaveTypeId,RankId=@RankId,LeaveDays=@LeaveDays,DaysBefore=@DaysBefore where Id=@Id";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@LeaveTypeId", SqlDbType.Int).Value = dlLeaveType1.SelectedValue;
                    command.Parameters.Add("@RankId", SqlDbType.Int).Value = dlRank1.SelectedValue;
                    command.Parameters.Add("@LeaveDays", SqlDbType.Int).Value = txtLeaveDays1.Text;
                    command.Parameters.Add("@DaysBefore", SqlDbType.Int).Value = txtDaysBefore1.Text;
                    command.Parameters.Add("@Id", SqlDbType.Int).Value = ViewState["ID"].ToString();
                    try
                    {
                        connection.Open();
                        rows = command.ExecuteNonQuery();
                        if (rows == 1)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Leave Days Updated Successfully', 'Success');", true);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "closeeditModal();", true);
                            leaveDayGrid.Rebind();
                        }
                    }
                    catch (SqlException ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }

        protected void leaveDayGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                GridDataItem item = e.Item as GridDataItem;
                ViewState["ID"] = item["Id"].Text;
                dlLeaveType1.SelectedValue = item["LeaveTypeId"].Text;
                dlRank1.SelectedValue = item["RankId"].Text;
                txtLeaveDays1.Text = item["LeaveDays"].Text;
                txtDaysBefore1.Text = item["DaysBefore"].Text;

                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "editModal();", true);
                e.Canceled = true;
            }
        }

        protected void leaveDayGrid_ItemDeleted(object sender, GridDeletedEventArgs e)
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
    }
}