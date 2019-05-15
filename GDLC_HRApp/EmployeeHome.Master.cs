using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;

namespace GDLC_HRApp
{
    public partial class EmployeeHome : System.Web.UI.MasterPage
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection connection = new SqlConnection(connectionString);
        SqlCommand command;
        int rows = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Configuration config = WebConfigurationManager.OpenWebConfiguration("~/Web.Config");
            SessionStateSection section = (SessionStateSection)config.GetSection("system.web/sessionState");
            int timeout = (int)section.Timeout.TotalMinutes * 1000 * 60;
            ScriptManager.RegisterStartupScript(this.upSessionExpire, this.upSessionExpire.GetType(), "key", "SessionExpireAlert(" + timeout + ");", true);
            //ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "key", "SessionExpireAlert(" + 60000 + ");", true);

            if (!IsPostBack)
            {
                lblUser.Text = Context.User.Identity.Name;
                imgProfile.Src = Request.Cookies.Get("ProfilePath").Value;
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (Context.User.Identity.Name != lblUser.Text)
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "", "toastr.error('Error occured while changing password. Please login again and retry', 'Error');", true);
                return;
            }
            byte[] hashedPassword = GetSHA1(txtPassword.Text.Trim());

            string query = "update tblUsers set UserPassword=@upass where UserName=@uname";
            command = new SqlCommand(query, connection);
            command.Parameters.Add("@upass", SqlDbType.VarBinary).Value = hashedPassword;
            command.Parameters.Add("@uname", SqlDbType.VarChar).Value = lblUser.Text;
            try
            {
                if (connection.State == ConnectionState.Closed)
                    connection.Open();
                rows = command.ExecuteNonQuery();
                if (rows == 1)
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "", "toastr.success('Password Changed Successfully', 'Success');", true);
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "pop", "closepassmodal();", true);
                }
                command.Dispose();
            }
            catch (SqlException ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
            }
            finally
            {
                connection.Dispose();
            }
        }

        private static byte[] GetSHA1(string password)
        {
            SHA1CryptoServiceProvider sha = new SHA1CryptoServiceProvider();
            return sha.ComputeHash(System.Text.Encoding.ASCII.GetBytes(password));
        }
    }
}