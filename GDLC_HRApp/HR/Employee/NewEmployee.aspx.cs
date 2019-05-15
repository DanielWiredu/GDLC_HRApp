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
using System.IO;
using System.Security.Cryptography;

namespace GDLC_HRApp.HR.Employee
{
    public partial class NewEmployee : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                dpRegdate.SelectedDate = DateTime.UtcNow;
            }
        }
        protected void dlBankBranch_ItemDataBound(object sender, RadComboBoxItemEventArgs e)
        {
            e.Item.Text = ((DataRowView)e.Item.DataItem)["BranchName"].ToString() + " - " + ((DataRowView)e.Item.DataItem)["SortCode"].ToString();
            e.Item.Value = ((DataRowView)e.Item.DataItem)["BranchId"].ToString();
        }

        protected void dlBankBranch_DataBound(object sender, EventArgs e)
        {
            //set the initial footer label
            ((Literal)dlBankBranch.Footer.FindControl("branchCount")).Text = Convert.ToString(dlBankBranch.Items.Count);
        }

        protected void dlBankBranch_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            String sql = "SELECT top (30) BranchId, BranchName, SortCode FROM [tblBankBranches] WHERE BankId = '" + dlBank.SelectedValue + "' AND (BranchName LIKE '%" + e.Text.ToUpper() + "%' OR SortCode LIKE '%" + e.Text.ToUpper() + "%')";
            bankBranchSource.SelectCommand = sql;
            dlBankBranch.DataBind();
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.Url.AbsoluteUri);
        }
        protected void btnPrint_Click(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(txtStaffNo.Text))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Reports/vwWorkerDetails.aspx?workerid=" + txtStaffNo.Text + "');", true);
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            //int bankId = 0;
            //if (!String.IsNullOrEmpty(dlBank.SelectedValue))
            //    bankId = Convert.ToInt32(dlBank.SelectedValue);
            //int bankBranchId = 0;
            //if (!String.IsNullOrEmpty(dlBankBranch.SelectedValue))
            //    bankBranchId = Convert.ToInt32(dlBankBranch.SelectedValue);
            if (String.IsNullOrEmpty(avatarUpload.PostedFile.FileName))
            {
                lblMsg.InnerText = "Image Required";
                lblMsg.Attributes["class"] = "alert alert-danger";
                return;
            }

            int unitId = 0;
            if (!String.IsNullOrEmpty(dlUnit.SelectedValue))
                unitId = Convert.ToInt32(dlUnit.SelectedValue);

            int contentLength = avatarUpload.PostedFile.ContentLength;
            string contentType = String.Empty;
            contentType = avatarUpload.PostedFile.ContentType;
            string fileName = avatarUpload.PostedFile.FileName;
            if (fileName != "" && (contentLength / 1024) > 512) //greater than 512KB
            {
                lblMsg.InnerText = "Picture size should not exceed 512KB...Please resize and try again";
                lblMsg.Attributes["class"] = "alert alert-danger";
                return;
            }
            string ext = Path.GetExtension(fileName);
            switch (ext)
            {
                case ".jpg":
                    contentType = "image/jpg";
                    break;
                case ".png":
                    contentType = "image/png";
                    break;
                case ".gif":
                    contentType = "image/gif";
                    break;
                default:
                    contentType = String.Empty;
                    break;
            }
            if (fileName != "" && contentType == String.Empty)
            {
                lblMsg.InnerText = "Invalid File Selected...Only Images Allowed";
                lblMsg.Attributes["class"] = "alert alert-danger";
                return;
            }

            string username = txtFirstname.Text.Trim() + "." + txtLastname.Text.Trim();
            string password = System.Web.Security.Membership.GeneratePassword(8, 1);
            byte[] hashedPassword = GetSHA1(password);

            string path = "";
            if (fileName != "" && contentType != String.Empty)
                path = "/Content/Uploads/Profiles/" + username + ext;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("spAddEmployee", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("@FirstName", SqlDbType.VarChar).Value = txtFirstname.Text;
                    command.Parameters.Add("@MiddleName", SqlDbType.VarChar).Value = txtMiddleName.Text;
                    command.Parameters.Add("@LastName", SqlDbType.VarChar).Value = txtLastname.Text;
                    command.Parameters.Add("@Username", SqlDbType.VarChar).Value = username;
                    command.Parameters.Add("@UserPassword", SqlDbType.VarBinary).Value = hashedPassword; //
                    command.Parameters.Add("@UserRoles", SqlDbType.VarChar).Value = "Employee";
                    command.Parameters.Add("@DateOfBirth", SqlDbType.DateTime).Value = dpDOB.SelectedDate;
                    command.Parameters.Add("@Gender", SqlDbType.VarChar).Value = dlGender.SelectedText;
                    command.Parameters.Add("@ContactNo", SqlDbType.VarChar).Value = txtPhoneNumber.Text;
                    command.Parameters.Add("@Email", SqlDbType.VarChar).Value = txtEmailAddress.Text;
                    command.Parameters.Add("@MaritalStatus", SqlDbType.VarChar).Value = dlMaritalStatus.SelectedText;
                    command.Parameters.Add("@PostalAddress", SqlDbType.VarChar).Value = txtPostalAddress.Text;
                    command.Parameters.Add("@ResidentialAddress", SqlDbType.VarChar).Value = txtResidentialAddress.Text;
                    command.Parameters.Add("@ProfilePath", SqlDbType.VarChar).Value = path;
                    command.Parameters.Add("@EmergencyContact", SqlDbType.VarChar).Value = txtContactPerson.Text;
                    command.Parameters.Add("@EmergencyContactNo", SqlDbType.VarChar).Value = txtContactPhoneNo.Text;
                    command.Parameters.Add("@BankId", SqlDbType.Int).Value = dlBank.SelectedValue;
                    command.Parameters.Add("@BankBranchId", SqlDbType.Int).Value = dlBankBranch.SelectedValue;
                    command.Parameters.Add("@BankAccNo", SqlDbType.VarChar).Value = txtBankNo.Text;
                    command.Parameters.Add("@SSNITNo", SqlDbType.VarChar).Value = txtSSFNo.Text;
                    command.Parameters.Add("@DateEmployed", SqlDbType.DateTime).Value = dpDateEmployed.SelectedDate;
                    command.Parameters.Add("@CompanyId", SqlDbType.Int).Value = dlCompany.SelectedValue;
                    command.Parameters.Add("@BranchId", SqlDbType.Int).Value = dlBranch.SelectedValue;
                    command.Parameters.Add("@RegionId", SqlDbType.Int).Value = dlRegion.SelectedValue;
                    command.Parameters.Add("@DepartmentId", SqlDbType.Int).Value = dlDepartment.SelectedValue;
                    command.Parameters.Add("@UnitId", SqlDbType.Int).Value = unitId;
                    command.Parameters.Add("@RankId", SqlDbType.Int).Value = dlRank.SelectedValue;
                    command.Parameters.Add("@PositionId", SqlDbType.Int).Value = dlPosition.SelectedValue;
                    command.Parameters.Add("@StaffNo", SqlDbType.VarChar).Value = txtStaffNo.Text;
                    command.Parameters.Add("@EmploymentStatus", SqlDbType.VarChar).Value = dlEmploymentStatus.SelectedText;
                    command.Parameters.Add("@EmploymentType", SqlDbType.VarChar).Value = dlEmploymentType.SelectedText;
                    command.Parameters.Add("@Resigned", SqlDbType.Bit).Value = chkResigned.Checked;
                    command.Parameters.Add("@DateResigned", SqlDbType.DateTime).Value = dpDateResigned.SelectedDate;
                    command.Parameters.Add("@CreatedBy", SqlDbType.VarChar).Value = User.Identity.Name;
                    command.Parameters.Add("@UserId", SqlDbType.Int).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@return_value", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
                    try
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                        int retVal = Convert.ToInt16(command.Parameters["@return_value"].Value);
                        long autoID = Convert.ToInt64(command.Parameters["@EmployeeId"].Value);
                        if (retVal == 0)
                        {
                            lblMsg.InnerText = "Employee Saved Successfully";
                            lblMsg.Attributes["class"] = "alert alert-success";
                            txtEmployeeId.Text = autoID.ToString();
                            txtUsername.Text = username;
                            txtStaffNo.ReadOnly = true;
                            btnSave.Enabled = false;
                            btnPrint.Enabled = true;
                            if (path != "")
                            {
                                avatarUpload.PostedFile.SaveAs(Server.MapPath(path));
                                Image1.ImageUrl = "~" + path + "?" + DateTime.Now.Ticks.ToString();
                            }
                                
                            RadTabStrip1.Tabs[2].Enabled = true;
                            RadTabStrip1.Tabs[3].Enabled = true;
                            RadTabStrip1.Tabs[4].Enabled = true;
                            RadTabStrip1.Tabs[5].Enabled = true;
                            //RadTabStrip1.SelectedIndex = 1;
                            //RadMultiPage1.SelectedIndex = 1;
                        }
                    }
                    catch (Exception ex)
                    {
                        //ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                        lblMsg.InnerText = ex.Message.Replace("'", "").Replace("\r\n", "");
                        lblMsg.Attributes["class"] = "alert alert-danger";
                    }
                }
            }
        }

        protected void dlDepartment_ItemSelected(object sender, DropDownListEventArgs e)
        {
            dlUnit.ClearSelection();
        }
        private static byte[] GetSHA1(string password)
        {
            SHA1CryptoServiceProvider sha = new SHA1CryptoServiceProvider();
            return sha.ComputeHash(System.Text.Encoding.ASCII.GetBytes(password));
        }
        protected void showDialog(string message)
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append("<script type = 'text/javascript'>");
            sb.Append("window.onload=function(){");
            sb.Append("alert('");
            sb.Append(message);
            sb.Append("')};");
            sb.Append("</script>");

            ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", sb.ToString());
        }

        protected void dependentGrid_ItemInserted(object sender, GridInsertedEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + e.Exception.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Saved Successfully', 'Success');", true);
            }
        }

        protected void dependentGrid_ItemUpdated(object sender, GridUpdatedEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + e.Exception.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Updated Successfully', 'Success');", true);
            }
        }

        protected void dependentGrid_ItemDeleted(object sender, GridDeletedEventArgs e)
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

        protected void dependentGrid_ItemCreated(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridEditableItem && e.Item.IsInEditMode)
            {
                GridEditableItem item = e.Item as GridEditableItem;
                GridEditManager manager = item.EditManager;
                GridTextBoxColumnEditor dpName = manager.GetColumnEditor("DependentName") as GridTextBoxColumnEditor;
                dpName.TextBoxControl.Width = 300;
                //if (!(e.Item is GridDataInsertItem))  //(!(e.Item is GridEditFormInsertItem ))
                //{
                    
                //}

            }
        }

        protected void nextofkinGrid_ItemInserted(object sender, GridInsertedEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + e.Exception.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Saved Successfully', 'Success');", true);
            }
        }

        protected void nextofkinGrid_ItemUpdated(object sender, GridUpdatedEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + e.Exception.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Updated Successfully', 'Success');", true);
            }
        }

        protected void nextofkinGrid_ItemDeleted(object sender, GridDeletedEventArgs e)
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

        protected void nextofkinGrid_ItemCreated(object sender, GridItemEventArgs e)
        {

        }

        protected void experienceGrid_ItemInserted(object sender, GridInsertedEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + e.Exception.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Saved Successfully', 'Success');", true);
            }
        }

        protected void experienceGrid_ItemUpdated(object sender, GridUpdatedEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + e.Exception.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Updated Successfully', 'Success');", true);
            }
        }

        protected void experienceGrid_ItemDeleted(object sender, GridDeletedEventArgs e)
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

        protected void experienceGrid_ItemCreated(object sender, GridItemEventArgs e)
        {

        }

        protected void trainingGrid_ItemInserted(object sender, GridInsertedEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + e.Exception.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Saved Successfully', 'Success');", true);
            }
        }

        protected void trainingGrid_ItemUpdated(object sender, GridUpdatedEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + e.Exception.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Updated Successfully', 'Success');", true);
            }
        }

        protected void trainingGrid_ItemDeleted(object sender, GridDeletedEventArgs e)
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

        protected void trainingGrid_ItemCreated(object sender, GridItemEventArgs e)
        {

        }
    }
}