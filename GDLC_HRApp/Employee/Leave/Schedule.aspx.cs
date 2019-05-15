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

namespace GDLC_HRApp.Employee.Leave
{
    public partial class Schedule : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                dpTransactionDate.SelectedDate = DateTime.UtcNow;
                dpStartDate.SelectedDate = DateTime.UtcNow;

                string UserId = Request.Cookies.Get("UserId").Value;
                loadEmployeeDetails(UserId);
            }
        }
        protected bool loadEmployeeDetails(string employeeId)
        {
            bool employeeFound = false;
            string query = "select StaffNo,EmployeeName,Rank from vwEmployee_Supervisor where EmployeeId = @EmployeeId";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@EmployeeId", SqlDbType.Int).Value = employeeId;
                    try
                    {
                        connection.Open();
                        SqlDataReader reader = command.ExecuteReader();
                        if (reader.Read())
                        {
                            txtStaffNo.Text = reader["StaffNo"].ToString();
                            txtEmployeeName.Text = reader["EmployeeName"].ToString();
                            txtRank.Text = reader["Rank"].ToString();
                            employeeFound = true;
                        }
                        reader.Close();
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "','Error');", true);
                    }
                }
            }
            return employeeFound;
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.Url.AbsoluteUri);
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (dpStartDate.SelectedDate.Value.DayOfWeek == DayOfWeek.Saturday || dpStartDate.SelectedDate.Value.DayOfWeek == DayOfWeek.Sunday)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Sorry, your leave cannot start on Saturday or Sunday', 'Error');", true);
                return;
            }
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("spAddLeaveSchedule", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("@EmployeeId", SqlDbType.Int).Value = Request.Cookies.Get("UserId").Value;
                    command.Parameters.Add("@LeaveTypeId", SqlDbType.Int).Value = dlLeaveType.SelectedValue;
                    command.Parameters.Add("@Startdate", SqlDbType.DateTime).Value = dpStartDate.SelectedDate;
                    command.Parameters.Add("@Enddate", SqlDbType.DateTime).Value = dpEndDate.SelectedDate;
                    command.Parameters.Add("@DaysRequested", SqlDbType.Int).Value = txtDaysRequested.Text;
                    command.Parameters.Add("@CreatedDate", SqlDbType.DateTime).Value = dpTransactionDate.SelectedDate;
                    command.Parameters.Add("@return_value", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
                    try
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                        int retVal = Convert.ToInt16(command.Parameters["@return_value"].Value);
                        if (retVal == 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Saved Successfully', 'Error');", true);
                            dlLeaveType.ClearSelection();
                            dpStartDate.Clear();
                            txtDaysRequested.Text = "";
                            dpEndDate.Clear();
                            leaveGrid.Rebind();
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }

        protected void txtDaysRequested_TextChanged(object sender, EventArgs e)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("spGetLeaveEndDate", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("@StartDate", SqlDbType.DateTime).Value = dpStartDate.SelectedDate;
                    command.Parameters.Add("@DaysRequested", SqlDbType.Int).Value = txtDaysRequested.Text.Trim();
                    command.Parameters.Add("@EndDate", SqlDbType.DateTime).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@return_value", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
                    try
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                        int retVal = Convert.ToInt32(command.Parameters["@return_value"].Value);
                        if (retVal == 0)
                        {
                            dpEndDate.SelectedDate = Convert.ToDateTime(command.Parameters["@EndDate"].Value);
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "','Error');", true);
                    }
                }
            }
        }

        protected void dpStartDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            txtDaysRequested.Text = "";
        }

        protected void leaveGrid_ItemDeleted(object sender, GridDeletedEventArgs e)
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