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

namespace GDLC_HRApp.HR.Manage
{
    public partial class JobVacancies : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            vacancyGrid.Rebind();
        }

        protected void vacancyGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                GridDataItem item = e.Item as GridDataItem;

            }
        }

        protected void vacancyGrid_ItemDeleted(object sender, GridDeletedEventArgs e)
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

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string qualification = "";
            foreach (RadComboBoxItem item in dlJobQualification.CheckedItems)
            {
                qualification += item.Value + ",";
            }
            qualification = qualification.TrimEnd(',');

            string query = "insert into tblJobVacancy(jobtitle,closingdate,positionId,jobdescription,jobqualification,createdby) values(@jobtitle,@closingdate,@positionId,@jobdescription,@jobqualification,@createdby)";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@jobtitle", SqlDbType.VarChar).Value = txtJobTitle.Text;
                    command.Parameters.Add("@closingdate", SqlDbType.DateTime).Value = dpClosingDate.SelectedDate;
                    command.Parameters.Add("@positionId", SqlDbType.Int).Value = dlPosition.SelectedValue;
                    command.Parameters.Add("@jobdescription", SqlDbType.NVarChar).Value = txtJobDescription.Content;
                    command.Parameters.Add("@jobqualification", SqlDbType.VarChar).Value = qualification;
                    command.Parameters.Add("@createdby", SqlDbType.VarChar).Value = User.Identity.Name;
                    try
                    {
                        connection.Open();
                        rows = command.ExecuteNonQuery();
                        if (rows == 1)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Saved Successfully', 'Success');", true);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "closenewModal();", true);
                            vacancyGrid.Rebind();
                            txtJobTitle.Text = "";
                            dpClosingDate.Clear();
                            dlPosition.ClearSelection();
                            txtJobDescription.Content = "";
                            dlJobQualification.ClearSelection();
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