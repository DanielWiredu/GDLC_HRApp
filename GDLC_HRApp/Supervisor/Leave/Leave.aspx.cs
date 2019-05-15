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

namespace GDLC_HRApp.Supervisor.Leave
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
            if (e.CommandName == "View")
            {
                GridDataItem item = e.Item as GridDataItem;
                string Id = item["Id"].Text;
                string query = "select * from vwLeave where Id = @Id";
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.Add("@Id", SqlDbType.Int).Value = Id;
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

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            leaveGrid.Rebind();
        }
    }
}