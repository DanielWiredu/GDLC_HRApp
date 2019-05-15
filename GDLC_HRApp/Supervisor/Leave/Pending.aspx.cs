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

namespace GDLC_HRApp.Supervisor.Leave
{
    public partial class Pending : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void leaveGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "View")
            {
                GridDataItem item = e.Item as GridDataItem;
                //string approvedStatus = item["ApprovedStatus"].Text;
                //if (approvedStatus == "1" || approvedStatus == "2") //cancel delete if leave is approved or denied
                //{
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Sorry, you cannot delete an approved or denied leave','Error');", true);
                //    return;
                //}
                ViewState["leaveId"] = item["Id"].Text;
                string query = "select * from vwLeave where Id = @Id";
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.Add("@Id", SqlDbType.Int).Value = ViewState["leaveId"].ToString();
                        try
                        {
                            connection.Open();
                            SqlDataReader reader = command.ExecuteReader();
                            if (reader.Read())
                            {
                                dpTransactionDate.SelectedDate = Convert.ToDateTime(reader["createddate"]);
                                txtStaffNo.Text = reader["staffno"].ToString();
                                txtEmployeeName.Text = reader["employeename"].ToString();
                                txtRank.Text = reader["rank"].ToString();
                                txtLeaveDays.Text = reader["leavedays"].ToString();
                                txtRemainingDays.Text = reader["daysremaining"].ToString();
                                txtSupervisor.Text = reader["supervisorname"].ToString();
                                txtSupervisorEmail.Text = reader["supervisoremail"].ToString();
                                dlLeaveType.SelectedValue = reader["leavetypeId"].ToString();
                                dpStartDate.SelectedDate = Convert.ToDateTime(reader["startdate"]);
                                txtDaysRequested.Text = reader["daysrequested"].ToString();
                                dpEndDate.SelectedDate = Convert.ToDateTime(reader["enddate"]);
                                txtDenialReason.Text = reader["deniedreason"].ToString();
                            }
                            reader.Close();
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "pop", "newModal();", true);
                        }
                        catch (Exception ex)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "','Error');", true);
                        }
                    }
                }
            }
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            leaveGrid.Rebind();
        }

        protected void btnApprove_Click(object sender, EventArgs e)
        {
            string query = "update tblLeave set ApprovedStatus=1, ApprovedBy=@ApprovedBy, ApprovedDate=@ApprovedDate where Id = @Id";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@ApprovedBy", SqlDbType.VarChar).Value = Context.User.Identity.Name;
                    command.Parameters.Add("@ApprovedDate", SqlDbType.DateTime).Value = DateTime.UtcNow;
                    command.Parameters.Add("@Id", SqlDbType.Int).Value = ViewState["leaveId"].ToString();
                    try
                    {
                        connection.Open();
                        rows = command.ExecuteNonQuery();
                        if (rows == 1)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Approved Successfully','Success');", true);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "pop", "closenewModal();", true);
                            leaveGrid.Rebind();
                            //send employee approval email
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "','Error');", true);
                    }
                }
            }
        }

        protected void btnReject_Click(object sender, EventArgs e)
        {
            string query = "update tblLeave set ApprovedStatus=2, DeniedBy=@DeniedBy, DeniedDate=@DeniedDate, DeniedReason=@DeniedReason where Id = @Id";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@DeniedBy", SqlDbType.VarChar).Value = Context.User.Identity.Name;
                    command.Parameters.Add("@DeniedDate", SqlDbType.DateTime).Value = DateTime.UtcNow;
                    command.Parameters.Add("@DeniedReason", SqlDbType.VarChar).Value = txtDenialReason.Text;
                    command.Parameters.Add("@Id", SqlDbType.Int).Value = ViewState["leaveId"].ToString();
                    try
                    {
                        connection.Open();
                        rows = command.ExecuteNonQuery();
                        if (rows == 1)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Denied Successfully','Success');", true);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "pop", "closenewModal();", true);
                            leaveGrid.Rebind();
                            //send employee rejection email
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
}