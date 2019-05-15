using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Security.Cryptography;

namespace GDLC_HRApp
{
    public partial class Login : System.Web.UI.Page
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection connection = new SqlConnection(connectionString);
        SqlCommand command;
        SqlDataReader reader;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.IsAuthenticated && !string.IsNullOrEmpty(Request.QueryString["ReturnUrl"]))
                    // This is an unauthorized, authenticated request...
                    Response.Redirect("/Errors/UnauthorizedAccess.aspx");

                //if (!String.IsNullOrEmpty(Context.User.Identity.Name))
                //{
                //    try
                //    {
                //        //save audit trail
                //        command = new SqlCommand("spAddAuditTrail", connection);
                //        command.CommandType = CommandType.StoredProcedure;
                //        command.Parameters.Add("@actiondate", SqlDbType.DateTime).Value = DateTime.Now;
                //        command.Parameters.Add("@actionby", SqlDbType.VarChar).Value = Context.User.Identity.Name;
                //        command.Parameters.Add("@actiondescription", SqlDbType.VarChar).Value = "LOGOUT Successful";
                //        command.Parameters.Add("@actionid", SqlDbType.VarChar).Value = Context.User.Identity.Name;
                //        connection.Open();
                //        command.ExecuteNonQuery();
                //        command.Dispose();
                //    }
                //    catch (Exception ex)
                //    {
                //        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "','Login Failed');", true);
                //    }
                //    finally
                //    {
                //        connection.Dispose();
                //    }
                //}

                FormsAuthentication.SignOut();
                Session.Abandon();

                //clear authentication cookie
                HttpCookie cookie1 = new HttpCookie(FormsAuthentication.FormsCookieName, "");
                cookie1.Expires = DateTime.Now.AddYears(-1);
                Response.Cookies.Add(cookie1);

                //
                HttpCookie cookie2 = new HttpCookie("ASP.NET_SessionId", "");
                cookie2.Expires = DateTime.Now.AddYears(-1);
                Response.Cookies.Add(cookie2);

                //clear user cookies
                HttpCookie ckLoginUser = new HttpCookie("LoginUser", "");
                ckLoginUser.Expires = DateTime.Now.AddYears(-1);
                Response.Cookies.Add(ckLoginUser);

                HttpCookie ckUserId = new HttpCookie("UserId", "");
                ckUserId.Expires = DateTime.Now.AddYears(-1);
                Response.Cookies.Add(ckUserId);

                HttpCookie ckProfilePath = new HttpCookie("ProfilePath", "");
                ckProfilePath.Expires = DateTime.Now.AddYears(-1);
                Response.Cookies.Add(ckProfilePath);

                // Clear cache
                //Response.Cache.SetCacheability(HttpCacheability.NoCache);
                //Response.Cache.SetExpires(DateTime.Now.AddSeconds(-1));
                //Response.Cache.SetNoStore();

                //Clear cookies
                //string[] cookies = Request.Cookies.AllKeys;
                //foreach (string cookie in cookies)
                //{
                //    Response.Cookies[cookie].Expires = DateTime.Now.AddDays(-1);
                //}
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            //Response.Redirect("/Dashboard.aspx");
            try
            {
                string query = "select id,username,userpassword,userroles,active,profilepath from tblEmployees where UserName = @username";
                command = new SqlCommand(query, connection);
                command.Parameters.Add("@username", SqlDbType.VarChar).Value = txtUsername.Value.Trim();
                if (connection.State == ConnectionState.Closed)
                    connection.Open();
                reader = command.ExecuteReader();
                if (reader.Read())
                {
                    if (!Convert.ToBoolean(reader["Active"]))
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.warning('Your Account is Deactivated...Please contact the Administrator','Login Failed');", true);
                        return;
                    }
                    byte[] hashedPassword = reader["UserPassword"] as byte[];
                    if (MatchSHA1(hashedPassword, GetSHA1(txtPassword.Value.Trim())))
                    {
                        string userrole = reader["Userroles"].ToString();

                        HttpCookie ckLoginUser = new HttpCookie("LoginUser", reader["username"].ToString());
                        HttpCookie ckUserId = new HttpCookie("UserId", reader["id"].ToString());
                        HttpCookie ckProfilePath = new HttpCookie("ProfilePath", reader["profilepath"].ToString());

                        FormsAuthentication.SetAuthCookie(txtUsername.Value.Trim(), false);

                        FormsAuthenticationTicket ticket1 = new FormsAuthenticationTicket(
                                   1,                                   // version
                                                                        //this.txtUsername.Text.Trim(),   // get username  from the form
                                reader["username"].ToString(),
                                DateTime.Now,                        // issue time is now
                                DateTime.Now.AddMinutes(60),         // expires in 30 minutes
                                false,      // cookie is not persistent
                                userrole                            // role assignment is stored in userData
                                );
                        reader.Close();
                        command.Dispose();
                        HttpCookie cookie1 = new HttpCookie(FormsAuthentication.FormsCookieName, FormsAuthentication.Encrypt(ticket1));
                        Response.Cookies.Add(cookie1);

                        //ckUserkey.Expires = DateTime.Now.AddMinutes(50);
                        Response.Cookies.Add(ckLoginUser);
                        Response.Cookies.Add(ckUserId);
                        Response.Cookies.Add(ckProfilePath);

                        //save audit trail
                        //command = new SqlCommand("spAddAuditTrail", connection);
                        //command.CommandType = CommandType.StoredProcedure;
                        //command.Parameters.Add("@actiondate", SqlDbType.DateTime).Value = DateTime.Now;
                        //command.Parameters.Add("@actionby", SqlDbType.VarChar).Value = txtUsername.Text.Trim();
                        //command.Parameters.Add("@actiondescription", SqlDbType.VarChar).Value = "LOGIN Successful";
                        //command.Parameters.Add("@actionid", SqlDbType.VarChar).Value = txtUsername.Text.Trim();
                        //command.ExecuteNonQuery();
                        //command.Dispose();

                        // 4. Do the redirect. 
                        String returnUrl1 = "";
                        //the login is successful
                        if (Request.QueryString["ReturnUrl"] == null || Request.QueryString["ReturnUrl"] == "/")
                        {
                            if (userrole.Equals("Employee"))
                            {
                                returnUrl1 = "/Dashboard.aspx";
                            }
                            else if (userrole.Equals("Supervisor"))
                            {
                                returnUrl1 = "/Dashboard.aspx";
                            }
                            else if (userrole.Equals("HR"))
                            {
                                returnUrl1 = "/DashboardHR.aspx";
                            }
                        }
                        //login not unsuccessful 
                        else
                        {
                            returnUrl1 = Request.QueryString["ReturnUrl"];
                        }
                        Response.Redirect(returnUrl1);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Wrong Password','Login Failed');", true);
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('User does not exist','Login Failed');", true);
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "','Login Failed');", true);
            }
            finally
            {
                reader.Close();
                connection.Dispose();
            }
        }
        private static bool MatchSHA1(byte[] p1, byte[] p2)
        {
            bool result = false;
            if (p1 != null && p2 != null)
            {
                if (p1.Length == p2.Length)
                {
                    result = true;
                    for (int i = 0; i < p1.Length; i++)
                    {
                        if (p1[i] != p2[i])
                        {
                            result = false;
                            break;
                        }
                    }
                }
            }
            return result;
        }
        /// <summary>
        /// Returns the SHA1 hash of the combined userID and password.
        /// </summary>
        /// <param name="userID"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        private static byte[] GetSHA1(string password)
        {
            SHA1CryptoServiceProvider sha = new SHA1CryptoServiceProvider();
            return sha.ComputeHash(System.Text.Encoding.ASCII.GetBytes(password));
        }
    }
}