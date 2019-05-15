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

namespace GDLC_HRApp.HR.Employee
{
    public partial class EditEmployee : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loadEmployeeDetails(Request.QueryString["staffno"].ToString());
            }
        }
        protected bool loadEmployeeDetails(string staffNo)
        {
            bool employeeFound = false;
            string query = "select * from tblEmployees where StaffNo = @StaffNo";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@StaffNo", SqlDbType.VarChar).Value = staffNo;
                    try
                    {
                        connection.Open();
                        SqlDataReader reader = command.ExecuteReader();
                        if (reader.Read())
                        {
                            dpRegdate.SelectedDate = Convert.ToDateTime(reader["CreatedDate"]);
                            txtEmployeeId.Text = reader["Id"].ToString();
                            txtStaffNo.Text = reader["StaffNo"].ToString();
                            dlGender.SelectedText = reader["Gender"].ToString();
                            dpDOB.SelectedDate = Convert.ToDateTime(reader["DateOfBirth"]);
                            txtUsername.Text = reader["Username"].ToString();
                            txtFirstname.Text = reader["Firstname"].ToString();
                            txtLastname.Text = reader["LastName"].ToString();
                            txtMiddleName.Text = reader["MiddleName"].ToString();
                            dlMaritalStatus.SelectedText = reader["MaritalStatus"].ToString();
                            txtPhoneNumber.Text = reader["ContactNo"].ToString();
                            txtEmailAddress.Text = reader["Email"].ToString();
                            txtPostalAddress.Text = reader["PostalAddress"].ToString();
                            txtContactPerson.Text = reader["EmergencyContact"].ToString();
                            txtContactPhoneNo.Text = reader["EmergencyContactNo"].ToString();
                            dlBank.SelectedValue = reader["BankId"].ToString();
                            string bankBranchId = reader["BankBranchId"].ToString();
                            query = "SELECT BranchId, BranchName, SortCode FROM [tblBankBranches] WHERE BranchId = '" + bankBranchId + "'";
                            bankBranchSource.SelectCommand = query;
                            dlBankBranch.DataBind();
                            dlBankBranch.SelectedValue = bankBranchId;
                            txtBankNo.Text = reader["BankAccNo"].ToString();
                            txtSSFNo.Text = reader["SSNITNo"].ToString();
                            txtResidentialAddress.Text = reader["ResidentialAddress"].ToString();
                            dpDateEmployed.SelectedDate = Convert.ToDateTime(reader["DateEmployed"]);
                            dlCompany.SelectedValue = reader["CompanyId"].ToString();
                            dlBranch.SelectedValue = reader["BranchId"].ToString();
                            dlRegion.SelectedValue = reader["RegionId"].ToString();
                            dlDepartment.SelectedValue = reader["DepartmentId"].ToString();
                            dlUnit.SelectedValue = reader["UnitId"].ToString();
                            dlRank.SelectedValue = reader["RankId"].ToString();
                            dlPosition.SelectedValue = reader["PositionId"].ToString();
                            dlEmploymentStatus.SelectedText = reader["EmploymentStatus"].ToString();
                            dlEmploymentType.SelectedText = reader["EmploymentType"].ToString();
                            chkResigned.Checked = Convert.ToBoolean(reader["Resigned"]);
                            if (!Convert.IsDBNull(reader["DateResigned"]))
                                dpDateResigned.SelectedDate = Convert.ToDateTime(reader["DateResigned"]);
                            else
                                dpDateResigned.Clear();
                            //image
                            ViewState["imagepath"] = reader["ProfilePath"].ToString();
                            if (!String.IsNullOrEmpty(ViewState["imagepath"].ToString()))
                                Image1.ImageUrl = "~" + ViewState["imagepath"].ToString() + "?" + DateTime.Now.Ticks.ToString();
                            //else
                            //    Image1.ImageUrl = "/Content/img/photo.png";

                            employeeFound = true;
                        }
                        reader.Close();
                    }
                    catch (Exception ex)
                    {
                        lblMsg.InnerText = ex.Message.Replace("'", "").Replace("\r\n", "");
                        lblMsg.Attributes["class"] = "alert alert-danger";
                    }
                }
            }
            return employeeFound;
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

        protected void dlDepartment_ItemSelected(object sender, DropDownListEventArgs e)
        {
            dlUnit.ClearSelection();
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

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
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

            string path = ViewState["imagepath"].ToString();
            if (fileName != "" && contentType != String.Empty)
                path = "/Content/Uploads/Profiles/" + txtUsername.Text + ext;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("spUpdateEmployee", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("@FirstName", SqlDbType.VarChar).Value = txtFirstname.Text;
                    command.Parameters.Add("@MiddleName", SqlDbType.VarChar).Value = txtMiddleName.Text;
                    command.Parameters.Add("@LastName", SqlDbType.VarChar).Value = txtLastname.Text;
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
                            lblMsg.InnerText = "Employee Updated Successfully";
                            lblMsg.Attributes["class"] = "alert alert-success";

                            if (path != "" && fileName != "") //you selected an image
                            {
                                avatarUpload.PostedFile.SaveAs(Server.MapPath(path));
                                ViewState["imagepath"] = path;
                            }
                                
                            if (!String.IsNullOrEmpty(ViewState["imagepath"].ToString()))
                                Image1.ImageUrl = "~" + path + "?" + DateTime.Now.Ticks.ToString();
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
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            dlBankBranch.ClearSelection();
            bool employeeFound = loadEmployeeDetails(txtSearchEmployee.Text.Trim());
            if (employeeFound)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "closenewModal();", true);
                txtSearchEmployee.Text = "";
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Employee not found', 'Error');", true);
                txtSearchEmployee.Focus();
            }

        }
    }
}