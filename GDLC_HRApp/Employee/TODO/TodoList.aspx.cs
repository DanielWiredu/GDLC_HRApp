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

namespace GDLC_HRApp.Employee.TODO
{
    public partial class TodoList : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                dpTaskDate.MinDate = DateTime.UtcNow;
            }
        }

        protected void todoGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Complete")
            {
                GridDataItem item = e.Item as GridDataItem;
                string taskId = item["Id"].Text;
                string query = "update tblEmployeeTodoList set completed = 1 where Id = @Id";
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.Add("@Id", SqlDbType.VarChar).Value = taskId;
                        try
                        {
                            connection.Open();
                            int rows = command.ExecuteNonQuery();
                            if (rows == 1)
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Completed Successfully', 'Success');", true);
                                todoGrid.Rebind();
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

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            todoGrid.Rebind();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string employeeId = Request.Cookies["UserId"].Value;
            string query = "insert into tblEmployeeTodoList(task,taskdate,employeeId) values(@task,@taskdate,@employeeId)";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@task", SqlDbType.VarChar).Value = txtTask.Text;
                    command.Parameters.Add("@taskdate", SqlDbType.DateTime).Value = dpTaskDate.SelectedDate;
                    command.Parameters.Add("@employeeId", SqlDbType.Int).Value = employeeId;
                    try
                    {
                        connection.Open();
                        int rows = command.ExecuteNonQuery();
                        if (rows == 1)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Saved Successfully', 'Success');", true);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "closenewModal();", true);
                            todoGrid.Rebind();
                            dpTaskDate.Clear();
                            txtTask.Text = "";
                        }
                    }
                    catch (SqlException ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }

        protected void todoGrid_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem item = e.Item as GridDataItem;
                TableCell status = item["Completed"];
                //TableCell uname = item["USERNAME"];
                if (status.Text == "True")
                {
                    item.BackColor = Color.GreenYellow;
                }
                else if (status.Text == "False")
                {
                    item.BackColor = Color.Pink;
                }

            }
        }
    }
}