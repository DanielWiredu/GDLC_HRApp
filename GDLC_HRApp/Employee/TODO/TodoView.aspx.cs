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

namespace GDLC_HRApp.Employee.TODO
{
    public partial class TodoView : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ViewState["taskId"] = Request.QueryString["taskId"].ToString();
                string query = "select Task,TaskDate,Completed from tblEmployeeTodoList where Id = @Id";
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.Add("@Id", SqlDbType.Int).Value = ViewState["taskId"].ToString();
                        try
                        {
                            connection.Open();
                            SqlDataReader reader = command.ExecuteReader();
                            if (reader.Read())
                            {
                                dvTask.InnerText = reader["Task"].ToString();
                                dvTaskDate.InnerText = Convert.ToDateTime(reader["TaskDate"]).ToString("dd-MMM-yyyy h:mm tt");
                                if (Convert.ToBoolean(reader["Completed"]))
                                    dvStatus.InnerText = "Completed";
                                else
                                    dvStatus.InnerText = "Pending";

                            }
                            reader.Close();
                        }
                        catch (SqlException ex)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                        }
                    }
                }
                if (dvStatus.InnerText == "Completed")
                    btnComplete.Enabled = false;
            }
        }

        protected void btnComplete_Click(object sender, EventArgs e)
        {
            string query = "update tblEmployeeTodoList set completed = 1 where Id = @Id";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@Id", SqlDbType.VarChar).Value = ViewState["taskId"].ToString();
                    try
                    {
                        connection.Open();
                        int rows = command.ExecuteNonQuery();
                        if (rows == 1)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Completed Successfully', 'Success');", true);
                            dvStatus.InnerText = "Completed";
                            btnComplete.Enabled = false;
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