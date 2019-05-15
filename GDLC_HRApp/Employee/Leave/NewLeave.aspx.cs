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
using System.Net.Mail;

namespace GDLC_HRApp.Employee.Leave
{
    public partial class NewLeave : MasterPageChange
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
            string query = "select * from vwEmployee_Supervisor where EmployeeId = @EmployeeId";
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
                            txtSupervisor.Text = reader["SupervisorName"].ToString();
                            txtSupervisorEmail.Text = reader["SupervisorEmail"].ToString();
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

        protected void dlLeaveType_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("spGetLeaveTypeAllocatedDays", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("@LeaveTypeId", SqlDbType.Int).Value = dlLeaveType.SelectedValue;
                    command.Parameters.Add("@EmployeeId", SqlDbType.Int).Value = Request.Cookies.Get("UserId").Value;
                    command.Parameters.Add("@TransactionDate", SqlDbType.DateTime).Value = dpTransactionDate.SelectedDate;
                    command.Parameters.Add("@AllocatedDays", SqlDbType.Int).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@DaysBefore", SqlDbType.Int).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@return_value", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
                    try
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                        int retVal = Convert.ToInt32(command.Parameters["@return_value"].Value);
                        if (retVal == 0)
                        {
                            txtLeaveDays.Text = command.Parameters["@AllocatedDays"].Value.ToString();
                            hfDaysBefore.Value = command.Parameters["@DaysBefore"].Value.ToString();
                            txtDaysRequested.MaxValue = Convert.ToDouble(txtLeaveDays.Text);
                            txtRemainingDays.Text = "";
                            txtDaysRequested.Text = "";
                            dpStartDate.MinDate = dpTransactionDate.SelectedDate.Value.AddDays(Convert.ToDouble(hfDaysBefore.Value));
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "','Error');", true);
                    }
                }
            }
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
                using (SqlCommand command = new SqlCommand("spApplyLeave", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("@EmployeeId", SqlDbType.Int).Value = Request.Cookies.Get("UserId").Value;
                    command.Parameters.Add("@LeaveTypeId", SqlDbType.Int).Value = dlLeaveType.SelectedValue;
                    command.Parameters.Add("@Startdate", SqlDbType.DateTime).Value = dpStartDate.SelectedDate;
                    command.Parameters.Add("@Enddate", SqlDbType.DateTime).Value = dpEndDate.SelectedDate;
                    command.Parameters.Add("@LeaveDays", SqlDbType.Int).Value = txtLeaveDays.Text;
                    command.Parameters.Add("@DaysRequested", SqlDbType.Int).Value = txtDaysRequested.Text;
                    command.Parameters.Add("@DaysRemaining", SqlDbType.Int).Value = txtRemainingDays.Text;
                    command.Parameters.Add("@CreatedDate", SqlDbType.DateTime).Value = dpTransactionDate.SelectedDate;
                    command.Parameters.Add("@return_value", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
                    try
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                        int retVal = Convert.ToInt16(command.Parameters["@return_value"].Value);
                        if (retVal == 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Submitted Successfully', 'Error');", true);

                            sendEmail(txtEmployeeName.Text, txtSupervisor.Text, txtSupervisorEmail.Text);

                            dlLeaveType.ClearSelection();
                            dpStartDate.Clear();
                            txtDaysRequested.Text = "";
                            dpEndDate.Clear();
                            txtLeaveDays.Text = "";
                            txtRemainingDays.Text = "";
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }
        protected void sendEmail(string employeeName, string supervisorName, string supervisorEmail)
        {
            try
            {
                string mailSubject = "LEAVE APPLICATION - " + employeeName;
                string message = "Dear " + supervisorName + ", <br><br>";
                message += "Please note that a leave application has been submitted by <strong>" + employeeName + "</strong> from the HR Software. <br><br> ";
                message += "<strong><a href='http://pascal09-001-site20.gtempurl.com/' target='_blank'>Click here</a></strong> to log on to the portal for more details and approval. <br /><br />";
                message += "<strong>This is an auto generated email. Please do not reply.</strong>";
                MailMessage myMessage = new MailMessage();
                myMessage.From = (new MailAddress("daniel.wiredu@eupacwebs.com", "GDLC HR Software"));
                myMessage.To.Add(new MailAddress(supervisorEmail));
                myMessage.Subject = mailSubject;
                myMessage.Body = message;
                myMessage.IsBodyHtml = true;
                SmtpClient mySmtpClient = new SmtpClient();
                mySmtpClient.Send(myMessage);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "mailsuccess", "toastr.success('Email Sent Successfully', 'Success');", true);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "mailerror", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
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
                            int remDays = Convert.ToInt32(txtLeaveDays.Text) - Convert.ToInt32(txtDaysRequested.Text.Trim());
                            if (remDays < 0)
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Sorry, days requested cannot be more than allocated leave days','Error');", true);
                                dpEndDate.Clear();
                            }
                            dpEndDate.SelectedDate = Convert.ToDateTime(command.Parameters["@EndDate"].Value);
                            txtRemainingDays.Text = remDays.ToString();
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
    }
}