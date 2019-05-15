using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GDLC_HRApp
{
    public partial class Dashboard : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request["__EVENTTARGET"] == "jobClicked")
            {

                //write your server code here
                
                Response.Write("table cell clicked" + lvJobs.Items[1].GetDataKeyValue("id").ToString());
            }
            if (!IsPostBack)
            {
                loadJobs();
                loadTodoList();
                checkDueTasks();
            }
        }
        protected void loadJobs()
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlDataAdapter adapter = new SqlDataAdapter())
                {
                    DataTable dTable = new DataTable();
                    string selectquery = "select top(3) id,jobtitle,closingdate from tblJobVacancy where closingdate >= getutcdate() order by id desc";
                    adapter.SelectCommand = new SqlCommand(selectquery, connection);
                    try
                    {
                        connection.Open();
                        adapter.Fill(dTable);
                        lvJobs.DataSource = dTable;
                        lvJobs.DataBind();
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message + "', 'Error');", true);
                    }
                }
            }
        }
        protected void loadTodoList()
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlDataAdapter adapter = new SqlDataAdapter())
                {
                    DataTable dTable = new DataTable();
                    string selectquery = "select top(3) id,task,taskdate from tblEmployeeTodoList where completed = 0 order by id desc";
                    adapter.SelectCommand = new SqlCommand(selectquery, connection);
                    try
                    {
                        connection.Open();
                        adapter.Fill(dTable);
                        lvTodo.DataSource = dTable;
                        lvTodo.DataBind();
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message + "', 'Error');", true);
                    }
                }
            }
        }
        protected void checkDueTasks()
        {
            string selectquery = "select isnull(count(id),0) as duetasks from tblEmployeeTodoList where completed = 0 and taskdate <= getutcdate()";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(selectquery, connection))
                {
                    try
                    {
                        connection.Open();
                        SqlDataReader reader = command.ExecuteReader();
                        if (reader.Read())
                        {
                            if (Convert.ToInt32(reader["duetasks"]) > 0)
                                ntTodo.Show();
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message + "', 'Error');", true);
                    }
                }
            }
        }

        protected void lvJobs_SelectedIndexChanged(object sender, EventArgs e)
        {
            Response.Redirect("/Employee/JobVacancyView.aspx?jobId=" + lvJobs.SelectedValue);
        }

        protected void lvTodo_SelectedIndexChanged(object sender, EventArgs e)
        {
            Response.Redirect("/Employee/TODO/TodoView.aspx?taskId=" + lvTodo.SelectedValue);
        }

        protected void ntTodo_CallbackUpdate(object sender, Telerik.Web.UI.RadNotificationEventArgs e)
        {
            string selectquery = "select isnull(count(id),0) as duetasks from tblEmployeeTodoList where completed = 0 and taskdate <= getutcdate()";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(selectquery, connection))
                {
                    try
                    {
                        connection.Open();
                        SqlDataReader reader = command.ExecuteReader();
                        if (reader.Read())
                        {
                            ntTodo.Text = Convert.ToInt32(reader["duetasks"]).ToString() + " task(s) due";
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message + "', 'Error');", true);
                    }
                }
            }
        }
    }
}