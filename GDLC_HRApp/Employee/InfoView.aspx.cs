using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GDLC_HRApp.Employee
{
    public partial class InfoView : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string userId = Request.Cookies.Get("UserId").Value;
                loadEmployeeInfo(userId);
                loadDependents(userId);
            }
        }
        protected void loadEmployeeInfo(string employeeId)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlDataAdapter adapter = new SqlDataAdapter())
                {
                    DataTable dTable = new DataTable();
                    string selectquery = "select * from vwEmployee where id = @employeeId";
                    adapter.SelectCommand = new SqlCommand(selectquery, connection);
                    adapter.SelectCommand.Parameters.Add("@employeeId", SqlDbType.Int).Value = employeeId;
                    try
                    {
                        connection.Open();
                        adapter.Fill(dTable);
                        lvEmployee.DataSource = dTable;
                        lvEmployee.DataBind();
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message + "', 'Error');", true);
                    }
                }
            }
        }
        protected void loadDependents(string employeeId)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlDataAdapter adapter = new SqlDataAdapter())
                {
                    DataTable dTable = new DataTable();
                    string selectquery = "select id,dependentname,dateofbirth,relation from tblEmployeeDependents where employeeid = @employeeId";
                    adapter.SelectCommand = new SqlCommand(selectquery, connection);
                    adapter.SelectCommand.Parameters.Add("@employeeId", SqlDbType.Int).Value = employeeId;
                    try
                    {
                        connection.Open();
                        adapter.Fill(dTable);
                        lvDependents.DataSource = dTable;
                        lvDependents.DataBind();
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