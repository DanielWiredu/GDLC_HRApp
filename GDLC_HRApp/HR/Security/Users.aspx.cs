using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Drawing;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;

namespace GDLC_HRApp.HR.Security
{
    public partial class Users : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void userGrid_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem item = e.Item as GridDataItem;
                TableCell status = item["ACTIVE"];
                TableCell uname = item["USERNAME"];
                if (status.Text == "True")
                {
                    uname.BackColor = Color.GreenYellow;
                }
                else if (status.Text == "False")
                {
                    uname.BackColor = Color.Pink;
                }

            }
        }

        protected void userGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "ToggleActive")
            {
                //Get the GridEditFormInsertItem(for Editform mode) of the RadGrid  
                GridDataItem dataItem = (GridDataItem)e.Item;

                string userid = dataItem.GetDataKeyValue("ID").ToString();
                TableCell status = dataItem["ACTIVE"];
                string newstatus = null;
                if (status.Text == "True")
                {
                    newstatus = "0";
                }
                else if (status.Text == "False")
                {
                    newstatus = "1";
                }

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "update tblEmployees set active = '" + newstatus + "' where ID = '" + userid + "'";
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        try
                        {
                            connection.Open();
                            rows = command.ExecuteNonQuery();
                            if (rows > 0)
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Active Status Changed Successfully', 'Success');", true);
                                userGrid.Rebind();
                            }
                        }
                        catch (Exception ex)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                            e.Canceled = true;
                        }
                    }
                }
            }

            if (e.CommandName == "Edit")
            {
                GridDataItem item = e.Item as GridDataItem;

                ViewState["id"] = item["ID"].Text;
                txtUsername.Text = item["Username"].Text;
                dlRole.SelectedText = item["Userroles"].Text;
                TableCell status = item["ACTIVE"];
                chkActive.Checked = Convert.ToBoolean(status.Text);

                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "showusermodal();", true);
                e.Canceled = true;
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string query = "";
            byte[] hashedPassword = new byte[0];
            query = "Update tblEmployees SET userroles=@uroles,active=@active WHERE id=@id";
            if (!String.IsNullOrEmpty(txtPassword.Text.Trim()))
            {
                hashedPassword = GetSHA1(txtPassword.Text.Trim());
                query = "Update tblEmployees SET userpassword=@upass,userroles=@uroles,active=@active WHERE id=@id";
            }
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    if (!String.IsNullOrEmpty(txtPassword.Text.Trim()))
                    {
                        command.Parameters.Add("@upass", SqlDbType.VarBinary).Value = hashedPassword;
                    }
                    command.Parameters.Add("@uroles", SqlDbType.VarChar).Value = dlRole.SelectedText;
                    command.Parameters.Add("@active", SqlDbType.Bit).Value = chkActive.Checked;
                    command.Parameters.Add("@id", SqlDbType.Int).Value = ViewState["id"].ToString();
                    try
                    {
                        connection.Open();
                        rows = command.ExecuteNonQuery();
                        if (rows == 1)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('User Updated Successfully', 'Success');", true);
                            userGrid.Rebind();
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "pop", "closeusermodal();", true);
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }
        private static byte[] GetSHA1(string password)
        {
            SHA1CryptoServiceProvider sha = new SHA1CryptoServiceProvider();
            return sha.ComputeHash(System.Text.Encoding.ASCII.GetBytes(password));
        }
    }
}