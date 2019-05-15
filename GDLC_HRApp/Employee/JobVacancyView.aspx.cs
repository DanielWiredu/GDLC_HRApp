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

namespace GDLC_HRApp.Employee
{
    public partial class JobVacancyView : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string jobId = Request.QueryString["jobId"].ToString();
                string query = "select * from vwJobVacancy where Id = @Id";
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.Add("@Id", SqlDbType.Int).Value = jobId;
                        try
                        {
                            connection.Open();
                            SqlDataReader reader = command.ExecuteReader();
                            if (reader.Read())
                            {
                                dvJobTitle.InnerText = reader["JobTitle"].ToString();
                                dvClosingDate.InnerText = Convert.ToDateTime(reader["ClosingDate"]).ToString("dd-MMM-yyyy");
                                dvPosition.InnerText = reader["Position"].ToString();
                                dvJobQualification.InnerText = reader["JobQualification"].ToString();
                                dvJobDescription.InnerHtml = reader["JobDescription"].ToString();
                            }
                            reader.Close();
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
}