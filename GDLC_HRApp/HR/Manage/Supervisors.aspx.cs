﻿using System;
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
    public partial class Supervisors : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void supervisorGrid_ItemDeleted(object sender, GridDeletedEventArgs e)
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
        protected void dlEmployee_ItemDataBound(object sender, RadComboBoxItemEventArgs e)
        {
            e.Item.Text = ((DataRowView)e.Item.DataItem)["FullName"].ToString();
            e.Item.Value = ((DataRowView)e.Item.DataItem)["ID"].ToString();
        }

        protected void dlEmployee_DataBound(object sender, EventArgs e)
        {
            //set the initial footer label
            ((Literal)dlEmployee.Footer.FindControl("employeeCount")).Text = Convert.ToString(dlEmployee.Items.Count);
        }

        protected void dlEmployee_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            String sql = "SELECT top(30) ID,FullName FROM [vwEmployee] WHERE Active = 1 AND FullName LIKE '%" + e.Text.ToUpper() + "%'";
            employeeSource.SelectCommand = sql;
            dlEmployee.DataBind();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (dlEmployee.SelectedValue == "")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Select Employee', 'Error');", true);
                return;
            }
            string query = "Insert Into tblSupervisors(SupervisorId) Values(@SupervisorId)";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@SupervisorId", SqlDbType.Int).Value = dlEmployee.SelectedValue;
                    try
                    {
                        connection.Open();
                        rows = command.ExecuteNonQuery();
                        if (rows == 1)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Saved Successfully', 'Success');", true);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "closenewModal();", true);
                            supervisorGrid.Rebind();
                            dlEmployee.ClearSelection();
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }
    }
}