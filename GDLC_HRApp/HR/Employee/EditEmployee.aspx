<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="EditEmployee.aspx.cs" Inherits="GDLC_HRApp.HR.Employee.EditEmployee" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <link href="/Content/css/telerikCombo.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        div.upload {
    width: 120px;
    height: 43px;
    background: url(/Content/img/upload.png);
    overflow: hidden;
}

div.upload input {
    display: block !important;
    width: 120px !important;
    height: 43px !important;
    opacity: 0 !important;
    overflow: hidden !important;
}
    </style>
    <script type="text/javascript">
          function previewFile() {
              var preview = document.querySelector('#<%=Image1.ClientID %>');
            var file = document.querySelector('#<%=avatarUpload.ClientID %>').files[0];
            var reader = new FileReader();

            reader.onloadend = function () {
                preview.src = reader.result;
            }

            if (file) {
                reader.readAsDataURL(file);
            } else {
                preview.src = "";
            }
          }
    </script>
    <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Edit Employee</h5>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-up"></i>
                            </a>
                            <a class="close-link">
                                <i class="fa fa-times"></i>
                            </a>
                        </div>
                    </div>
                    <div class="ibox-content">
                         <asp:UpdatePanel runat="server" UpdateMode="Conditional" >
                    <ContentTemplate>
                        <div runat="server" id="lblMsg"></div>
                        <div class="row">
                            <div class="col-md-5">
                                <div class="form-horizontal">
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">Registration Date</label>
                                    <div class="col-sm-8">
                                        <telerik:RadDatePicker runat="server" ID="dpRegdate" Width="100%" DateInput-ReadOnly="true" MinDate="1/1/1850"></telerik:RadDatePicker>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="dpRegdate" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">Employee Id</label>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="txtEmployeeId" runat="server" Width="100%" Enabled="false"></asp:TextBox>
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">Staff No</label>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="txtStaffNo" runat="server" Width="100%"></asp:TextBox>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtStaffNo" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </div>
                                </div>

                                </div>
                            </div>
                            <div class="col-md-5">
                                <div class="form-horizontal">
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">Gender</label>
                                    <div class="col-sm-8">
                                        <telerik:RadDropDownList ID="dlGender" runat="server" Width="100%" >
                                            <Items>
                                                <telerik:DropDownListItem Text="Male" />
                                                <telerik:DropDownListItem Text="Female" />
                                            </Items>
                                        </telerik:RadDropDownList>
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">Date of Birth</label>
                                    <div class="col-sm-8">
                                        <telerik:RadDatePicker ID="dpDOB" runat="server" Width="100%" DateInput-ReadOnly="false" MinDate="1/1/1850"></telerik:RadDatePicker>
                           <asp:RequiredFieldValidator runat="server" ControlToValidate="dpDOB" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">Username</label>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="txtUsername" runat="server" Width="100%" Enabled="false" ClientIDMode="Static" ></asp:TextBox>
                                    </div>
                                </div>
                                </div>
                            </div>
                                        <div class="col-md-2">
                                <div class="form-horizontal">
                                    <div class="form-group">
                                    <%--<label class="col-sm-4 control-label">Comments</label>--%>
                                    <div class="col-sm-12">
                                        <asp:Image ID="Image1" runat="server" Width="140px" Height="130px" BackColor="#cccccc" ImageUrl="~/Content/img/photo.png"  />
                            <input class="upload" id="avatarUpload" type="file" accept="image/*"  name="file" onchange="previewFile()"  runat="server" />
                                       
                                    </div>
                                </div>
                                </div>
                            </div>
                        </div>


                            <telerik:RadTabStrip ID="RadTabStrip1" runat="server" MultiPageID="RadMultiPage1" SelectedIndex="0" AutoPostBack="false" CausesValidation="false" >
                <Tabs>
                    <telerik:RadTab runat="server" Text="Personal" >
                    </telerik:RadTab>
                    <telerik:RadTab runat="server" Text="Employment" Enabled="true">
                    </telerik:RadTab>
                    <telerik:RadTab runat="server" Text="Dependents" Enabled="true">
                    </telerik:RadTab>
                    <telerik:RadTab runat="server" Text="Next of Kin" Enabled="true">
                    </telerik:RadTab>
                    <telerik:RadTab runat="server" Text="Experience" Enabled="true">
                    </telerik:RadTab>
                    <telerik:RadTab runat="server" Text="Training" Enabled="true">
                    </telerik:RadTab>
                </Tabs>
            </telerik:RadTabStrip>
                            <telerik:RadMultiPage ID="RadMultiPage1" runat="server" SelectedIndex="0" RenderSelectedPageOnly="false" >
                                <telerik:RadPageView ID="pvPersonal" runat="server" Height="100%">
                                    <div class="row">
                            <div class="col-md-6">
                                <hr />
                                <div class="form-horizontal">
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">First Name</label>
                                    <div class="col-sm-8">
                                       <asp:TextBox ID="txtFirstname" runat="server" Width="100%" ClientIDMode="Static" ></asp:TextBox>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtFirstname" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">Last Name</label>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="txtLastname" runat="server" Width="100%" ClientIDMode="Static"></asp:TextBox>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtLastname" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                    
                                     <div class="form-group">
                                    <label class="col-sm-4 control-label">Middle Name</label>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="txtMiddleName" runat="server" Width="100%"></asp:TextBox>
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">Marital Status</label>
                                    <div class="col-sm-8">
                                        <telerik:RadDropDownList ID="dlMaritalStatus" runat="server" Width="100%" >
                                            <Items>
                                                <telerik:DropDownListItem Text="Single" />
                                                <telerik:DropDownListItem Text="Married" />
                                                <telerik:DropDownListItem Text="Divorced" />
                                                <telerik:DropDownListItem Text="Widowed" />
                                            </Items>
                                        </telerik:RadDropDownList>
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">Phone Number</label>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="txtPhoneNumber" runat="server" Width="100%"></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ErrorMessage="Numbers only up to 10 characters" ControlToValidate="txtPhoneNumber" ValidationExpression="^[0-9]{10,10}$" Display="Dynamic" SetFocusOnError="true" ForeColor="Red" />
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">Email Address</label>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="txtEmailAddress" runat="server" Width="100%" TextMode="Email"></asp:TextBox>
                                    </div>
                                </div>
                                     <div class="form-group">
                                    <label class="col-sm-4 control-label">Postal Address</label>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="txtPostalAddress" runat="server" Width="100%" TextMode="MultiLine" Rows="2"></asp:TextBox>
                                    </div>
                                </div>
                                   
                                     
                                </div>
                            </div>
                            <div class="col-md-6">
                                <hr />
                                <div class="form-horizontal">
                                     <div class="form-group">
                                    <label class="col-sm-4 control-label">Contact Person</label>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="txtContactPerson" runat="server" Width="100%"></asp:TextBox>
                                    </div>
                                </div>
                                     <div class="form-group">
                                    <label class="col-sm-4 control-label">Contact Phone No</label>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="txtContactPhoneNo" runat="server" Width="100%"></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Numbers only up to 10 characters" ControlToValidate="txtContactPhoneNo" ValidationExpression="^[0-9]{10,10}$" Display="Dynamic" SetFocusOnError="true" ForeColor="Red" />
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">Bank</label>
                                    <div class="col-sm-8">
                                        <telerik:RadDropDownList ID="dlBank" runat="server" Width="100%" DefaultMessage="Select Bank" DataSourceID="bankSource" DataTextField="BankName" DataValueField="BankId" DropDownHeight="200px" AutoPostBack="true" CausesValidation="false"></telerik:RadDropDownList>
                                        <asp:SqlDataSource ID="bankSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT BankId,BankName FROM [tblBanks]"></asp:SqlDataSource>
                                        <asp:RequiredFieldValidator Enabled="false" runat="server" ControlToValidate="dlBank" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">Bank Branch</label>
                                    <div class="col-sm-8">
                                        <telerik:RadComboBox ID="dlBankBranch" runat="server" Width="100%" DataSourceID="bankBranchSource" MaxHeight="300" EmptyMessage="Select Branch" Filter="Contains"
                                           OnItemDataBound="dlBankBranch_ItemDataBound" OnDataBound="dlBankBranch_DataBound" OnItemsRequested="dlBankBranch_ItemsRequested" EnableLoadOnDemand="true"
                                            OnClientItemsRequested="UpdateBankBranchItemCountField" HighlightTemplatedItems="true" MarkFirstMatch="true"  >
                                            <HeaderTemplate>
                <ul>
                    <li class="ncol2">Branch Name</li>
                    <li class="ncol1">Sort Code</li>
                </ul>
            </HeaderTemplate>
            <ItemTemplate>
                <ul>
                    <li class="ncol2">
                        <%# DataBinder.Eval(Container.DataItem, "BranchName")%></li>
                    <li class="ncol1">
                        <%# DataBinder.Eval(Container.DataItem, "SortCode")%></li>
                </ul>
            </ItemTemplate>
            <FooterTemplate>
                A total of
                <asp:Literal runat="server" ID="branchCount" />
                items
            </FooterTemplate>
                                        </telerik:RadComboBox>
                                        <asp:SqlDataSource ID="bankBranchSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT top (30) BranchId, BranchName, SortCode FROM [tblBankBranches] WHERE BankId = @BankId">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="dlBank" Name="BankId" PropertyName="SelectedValue" Type="Int32" DefaultValue="0" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="dlBankBranch" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                    <%--<div class="form-group">
                                    <label class="col-sm-4 control-label">Bank Branch</label>
                                    <div class="col-sm-8">
                                        <asp:TextBox runat="server" ID="txtBankBranch" Width="100%"></asp:TextBox>
                                    </div>
                                </div>--%>
                                    
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">Account Number</label>
                                    <div class="col-sm-8">
                                        <asp:TextBox runat="server" ID="txtBankNo" Width="100%"></asp:TextBox>
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">SSF No</label>
                                    <div class="col-sm-8">
                                        <asp:TextBox runat="server" ID="txtSSFNo" Width="100%" ></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="RegExp1" runat="server" ErrorMessage="Alphanumeric between 8 to 15 characters" ControlToValidate="txtSSFNo" ValidationExpression="^[a-zA-Z0-9\s]{8,15}$" Display="Dynamic" SetFocusOnError="true" ForeColor="Red" />
                                        <asp:RequiredFieldValidator Enabled="true" runat="server" ControlToValidate="txtSSFNo" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                     <div class="form-group">
                                    <label class="col-sm-4 control-label">Residential Address</label>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="txtResidentialAddress" runat="server" Width="100%" TextMode="MultiLine" Rows="2"></asp:TextBox>
                                    </div>
                                </div>
                                </div>
                            </div>
                        </div>
                                </telerik:RadPageView>
                                <telerik:RadPageView ID="pvEmployment" runat="server" Height="100%" >
                                    <div class="row">
                            <div class="col-md-6">
                                <hr />
                                <div class="form-horizontal">
                                    <%--<div class="form-group">
                                    <label class="col-sm-4 control-label"></label>
                                    <div class="col-sm-8">
                                        <asp:Label runat="server" ID="lblStatus" ForeColor="Red" Font-Bold="true" Visible="true"></asp:Label>
                                    </div>
                                </div>--%>
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">Date Employed</label>
                                    <div class="col-sm-8">
                                        <telerik:RadDatePicker runat="server" ID="dpDateEmployed" Width="100%" DateInput-ReadOnly="true" MinDate="1/1/1850"></telerik:RadDatePicker>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="dpDateEmployed" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">Company</label>
                                    <div class="col-sm-8">
                                        <telerik:RadDropDownList ID="dlCompany" runat="server" Width="100%" DataSourceID="companySource" DataTextField="Company" DataValueField="Id" DropDownHeight="200px" CausesValidation="false"></telerik:RadDropDownList>
                                        <asp:SqlDataSource ID="companySource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT Id,Company FROM [tblCompany]"></asp:SqlDataSource>
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">Branch</label>
                                    <div class="col-sm-8">
                                        <telerik:RadDropDownList ID="dlBranch" runat="server" Width="100%" DataSourceID="branchSource" DataTextField="BranchName" DataValueField="Id" DropDownHeight="200px" CausesValidation="false"></telerik:RadDropDownList>
                                        <asp:SqlDataSource ID="branchSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT Id,BranchName FROM [tblBranches]"></asp:SqlDataSource>
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">Region</label>
                                    <div class="col-sm-8">
                                        <telerik:RadDropDownList ID="dlRegion" runat="server" Width="100%" DataSourceID="regionSource" DataTextField="Region" DataValueField="Id" DropDownHeight="200px" CausesValidation="false"></telerik:RadDropDownList>
                                        <asp:SqlDataSource ID="regionSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT Id,Region FROM [tblRegions]"></asp:SqlDataSource>
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">Department</label>
                                    <div class="col-sm-8">
                                        <telerik:RadDropDownList ID="dlDepartment" runat="server" Width="100%" DataSourceID="departmentSource" DataTextField="DepartmentName" DataValueField="Id" DefaultMessage="Select Department" DropDownHeight="200px" AutoPostBack="true" CausesValidation="false" OnItemSelected="dlDepartment_ItemSelected"></telerik:RadDropDownList>
                                        <asp:SqlDataSource ID="departmentSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT Id,DepartmentName FROM [tblDepartments]"></asp:SqlDataSource>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="dlDepartment" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">Unit</label>
                                    <div class="col-sm-8">
                                        <telerik:RadDropDownList ID="dlUnit" runat="server" Width="100%" DataSourceID="unitSource" DataTextField="Unit" DataValueField="Id" DefaultMessage="Select Unit" DropDownHeight="200px"></telerik:RadDropDownList>
                                        <asp:SqlDataSource ID="unitSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT Id,Unit FROM [tblUnits] WHERE DepartmentId=@DepartmentId">
                                            <SelectParameters>
                                                <asp:ControlParameter Name="DepartmentId" ControlID="dlDepartment" Type="Int32" PropertyName="SelectedValue" DefaultValue="0" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </div>
                                </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <hr />
                                <div class="form-horizontal">
                                    <%--<div class="form-group">
                                    <label class="col-sm-4 control-label"></label>
                                    <div class="col-sm-8">
                                        <asp:Label runat="server" ID="lblAge" ForeColor="Red" Font-Bold="true" Width="100%" Visible="true"></asp:Label>
                                    </div>
                                </div>--%>
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">Rank</label>
                                    <div class="col-sm-8">
                                        <telerik:RadDropDownList ID="dlRank" runat="server" Width="100%" DataSourceID="rankSource" DataTextField="Rank" DataValueField="Id" DropDownHeight="200px" CausesValidation="false"></telerik:RadDropDownList>
                                        <asp:SqlDataSource ID="rankSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT Id,Rank FROM [tblRanks]"></asp:SqlDataSource>
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">Position</label>
                                    <div class="col-sm-8">
                                        <telerik:RadDropDownList ID="dlPosition" runat="server" Width="100%" DataSourceID="positionSource" DataTextField="Position" DataValueField="Id" DropDownHeight="200px" CausesValidation="false"></telerik:RadDropDownList>
                                        <asp:SqlDataSource ID="positionSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT Id,Position FROM [tblPositions]"></asp:SqlDataSource>
                                    </div>
                                </div>
                                   <div class="form-group">
                                    <label class="col-sm-4 control-label">Employment Status</label>
                                    <div class="col-sm-8">
                                        <telerik:RadDropDownList ID="dlEmploymentStatus" runat="server" Width="100%" >
                                            <Items>
                                                <telerik:DropDownListItem Text="Probation" />
                                                <telerik:DropDownListItem Text="Confirmed" />
                                            </Items>
                                        </telerik:RadDropDownList>
                                    </div>
                                </div> 
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">Employment Type</label>
                                    <div class="col-sm-8">
                                        <telerik:RadDropDownList ID="dlEmploymentType" runat="server" Width="100%" >
                                            <Items>
                                                <telerik:DropDownListItem Text="Full Time" />
                                                <telerik:DropDownListItem Text="Part Time" />
                                                <telerik:DropDownListItem Text="Contract" />
                                                <telerik:DropDownListItem Text="National Service" />
                                                <telerik:DropDownListItem Text="Internship" />
                                            </Items>
                                        </telerik:RadDropDownList>
                                    </div>
                                </div> 
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">Resigned</label>
                                    <div class="col-sm-8">
                                        <asp:CheckBox runat="server" ID="chkResigned" />
                                    </div>
                                </div>
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">Date Resigned</label>
                                    <div class="col-sm-8">
                                        <telerik:RadDatePicker runat="server" ID="dpDateResigned" Width="100%" DateInput-ReadOnly="true" MinDate="1/1/1850"></telerik:RadDatePicker>
                                        <%--<asp:RequiredFieldValidator runat="server" ControlToValidate="dpDateResigned" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                                    </div>
                                </div>
                                </div>
                            </div>
                        </div>
                                </telerik:RadPageView>
                                <telerik:RadPageView ID="pvDependents" runat="server" Height="100%">
                                    <hr />
                                    <asp:UpdatePanel runat="server" UpdateMode="Conditional" >
                    <ContentTemplate>
                        <telerik:RadGrid ID="dependentGrid" DataSourceID="dependentSource" runat="server" AutoGenerateColumns="False" GroupPanelPosition="Top" AllowFilteringByColumn="False" AllowPaging="True" AllowSorting="True" CellSpacing="-1" GridLines="Both" OnItemInserted="dependentGrid_ItemInserted" OnItemUpdated="dependentGrid_ItemUpdated" OnItemDeleted="dependentGrid_ItemDeleted" OnItemCreated="dependentGrid_ItemCreated">
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" ScrollHeight="200px"/>
                                <Selecting AllowRowSelect="true" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />
                            <MasterTableView DataKeyNames="Id" DataSourceID="dependentSource" CommandItemDisplay="Top" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" AllowAutomaticUpdates="True" EditMode="InPlace">
                                    <RowIndicatorColumn Visible="false"></RowIndicatorColumn>
                                    <ExpandCollapseColumn Created="True"></ExpandCollapseColumn>
                                    <Columns>
                                        <telerik:GridBoundColumn DataField="DependentName" FilterControlAltText="Filter DependentName column" HeaderText="DependentName" SortExpression="DependentName" UniqueName="DependentName">
                                         <ColumnValidationSettings EnableRequiredFieldValidation="true">
                                            <RequiredFieldValidator Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></RequiredFieldValidator>
                                        </ColumnValidationSettings>
                                            <HeaderStyle Width="200px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridDateTimeColumn DataField="DateOfBirth" DataType="System.DateTime" FilterControlAltText="Filter DateOfBirth column" HeaderText="DateOfBirth" SortExpression="DateOfBirth" UniqueName="DateOfBirth" DataFormatString="{0:dd-MMM-yyyy}">
                                         <ColumnValidationSettings EnableRequiredFieldValidation="true">
                                            <RequiredFieldValidator Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></RequiredFieldValidator>
                                        </ColumnValidationSettings>
                                             <HeaderStyle Width="120px" />
                                         </telerik:GridDateTimeColumn>
                                        <telerik:GridTemplateColumn FilterControlAltText="Filter Relation column" UniqueName="Relation" DataField="Relation" HeaderText="Relation" SortExpression="Relation">
                                                <ItemTemplate>
                                                     <asp:Label ID="lblDpRelation" runat="server" Text='<%# Bind("Relation")%>'></asp:Label>
                                                    </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:DropDownList ID="dlDpRelation" runat="server" SelectedValue='<%# Bind("Relation") %>'
                                                        DataSource='<%# (new String[] {"Parent", "Child", "Spouse", "Sibling", "Extended Family", "Other"})%>'
                                                             AppendDataBoundItems="True">
                                                            <asp:ListItem Selected="True" Text="Select" Value=""> </asp:ListItem>
                                                        </asp:DropDownList>
                                            </EditItemTemplate>
                                            <HeaderStyle Width="100px" />
                                        </telerik:GridTemplateColumn>
                                        <%--<telerik:GridNumericColumn DataField="UPPERLIM" DataType="System.Decimal" FilterControlAltText="Filter UPPERLIM column" HeaderText="UPPER LIMIT" SortExpression="UPPERLIM" UniqueName="UPPERLIM" DecimalDigits="2" DefaultInsertValue="0.00" EmptyDataText="0.00" DataFormatString="{0:0.00}">
                                        <ColumnValidationSettings EnableRequiredFieldValidation="true">
                                            <RequiredFieldValidator Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></RequiredFieldValidator>
                                        </ColumnValidationSettings>
                                        </telerik:GridNumericColumn>
                                         <telerik:GridNumericColumn DataField="EXPRATE" DataType="System.Decimal" FilterControlAltText="Filter EXPRATE column" HeaderText="EXPENSE RATE" SortExpression="EXPRATE" UniqueName="EXPRATE" DecimalDigits="2" DefaultInsertValue="0.00" EmptyDataText="0.00" DataFormatString="{0:0.00}" NumericType="Percent">
                                        </telerik:GridNumericColumn>--%>
                                         <telerik:GridTemplateColumn AllowFiltering="false"> 
                                         <ItemTemplate>
                                            <asp:Button ID="btnEdit" runat="server" CommandName="Edit" Text="Edit" CssClass="btn-info" /> 
                                          </ItemTemplate> 
                                        <EditItemTemplate > 
                                            <asp:Button ID="btnUpdate" runat="server" CommandName='<%# (Container is GridDataInsertItem) ? "PerformInsert" : "Update" %>' Text='<%# (Container is GridDataInsertItem) ? "Save" : "Update" %>' CssClass="btn-primary" /> 
                                            <asp:Button ID="btnCancel" runat="server" CommandName="Cancel" Text="Cancel" CausesValidation="false" CssClass="btn-warning" /> 
                                        </EditItemTemplate>
                                            <HeaderStyle Width="80px" />
                                        </telerik:GridTemplateColumn> 
                                    <telerik:GridButtonColumn Text="Delete" CommandName="Delete" UniqueName="Delete" ConfirmText="Delete Record?" ButtonType="PushButton" ButtonCssClass="btn-danger">
                                        <HeaderStyle Width="70px" />
                                    </telerik:GridButtonColumn>
                                    </Columns>
                                </MasterTableView>
                        </telerik:RadGrid>
                        <asp:SqlDataSource ID="dependentSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM tblEmployeeDependents WHERE (Id = @Id)" InsertCommand="INSERT INTO tblEmployeeDependents(EmployeeId, DependentName, DateOfBirth, Relation, CreatedBy) VALUES(@EmployeeId, @DependentName, @DateOfBirth, @Relation, @CreatedBy)" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT Id, DependentName, DateOfBirth, Relation from tblEmployeeDependents WHERE (EmployeeId = @EmployeeId)" UpdateCommand="UPDATE tblEmployeeDependents SET DependentName = @DependentName, DateOfBirth = @DateOfBirth, Relation = @Relation WHERE (Id = @Id)">
                                <DeleteParameters>
                                    <asp:Parameter Name="Id" Type="Int32" />
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:ControlParameter Name="EmployeeId" Type="Int32" ControlID="txtEmployeeId" PropertyName="Text" DefaultValue="0" />
                                    <asp:Parameter Name="DependentName" Type="String" />
                                    <asp:Parameter Name="DateOfBirth" Type="DateTime" />
                                    <asp:Parameter Name="Relation" Type="String" />
                                    <asp:CookieParameter Name="CreatedBy" CookieName="LoginUser" Type="String" />
                                </InsertParameters>
                                <SelectParameters>
                                    <asp:ControlParameter Name="EmployeeId" Type="Int32" ControlID="txtEmployeeId" PropertyName="Text" DefaultValue="0" />
                                </SelectParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="DependentName" Type="String" />
                                    <asp:Parameter Name="DateOfBirth" Type="DateTime" />
                                    <asp:Parameter Name="Relation" Type="String" />
                                    <asp:Parameter Name="Id" Type="Int32" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                    </ContentTemplate>
                </asp:UpdatePanel>
                                </telerik:RadPageView>
                                <telerik:RadPageView ID="pvNextOfKin" runat="server" Height="100%">
                                    <hr />
                                    <asp:UpdatePanel runat="server" UpdateMode="Conditional" >
                    <ContentTemplate>
                        <telerik:RadGrid ID="nextofkinGrid" DataSourceID="nextofKinSource" runat="server" AutoGenerateColumns="False" GroupPanelPosition="Top" AllowFilteringByColumn="False" AllowPaging="True" AllowSorting="True" CellSpacing="-1" GridLines="Both" OnItemInserted="nextofkinGrid_ItemInserted" OnItemUpdated="nextofkinGrid_ItemUpdated" OnItemDeleted="nextofkinGrid_ItemDeleted" OnItemCreated="nextofkinGrid_ItemCreated">
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" ScrollHeight="200px"/>
                                <Selecting AllowRowSelect="true" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />
                            <MasterTableView DataKeyNames="Id" DataSourceID="nextofKinSource" CommandItemDisplay="Top" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" AllowAutomaticUpdates="True" EditMode="InPlace">
                                    <RowIndicatorColumn Visible="false"></RowIndicatorColumn>
                                    <ExpandCollapseColumn Created="True"></ExpandCollapseColumn>
                                    <Columns>
                                        <telerik:GridBoundColumn DataField="FullName" FilterControlAltText="Filter FullName column" HeaderText="FullName" SortExpression="FullName" UniqueName="FullName">
                                         <ColumnValidationSettings EnableRequiredFieldValidation="true">
                                            <RequiredFieldValidator Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></RequiredFieldValidator>
                                        </ColumnValidationSettings>
                                            <HeaderStyle Width="200px" />
                                         </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Email" FilterControlAltText="Filter Email column" HeaderText="Email Address" SortExpression="Email" UniqueName="Email">
                                         <ColumnValidationSettings EnableRequiredFieldValidation="true">
                                            <RequiredFieldValidator Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></RequiredFieldValidator>
                                        </ColumnValidationSettings>
                                            <HeaderStyle Width="150px" />
                                         </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="PhoneNo" FilterControlAltText="Filter PhoneNo column" HeaderText="Phone Number" SortExpression="PhoneNo" UniqueName="PhoneNo">
                                         <ColumnValidationSettings EnableRequiredFieldValidation="true">
                                            <RequiredFieldValidator Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></RequiredFieldValidator>
                                        </ColumnValidationSettings>
                                            <HeaderStyle Width="100px" />
                                         </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn FilterControlAltText="Filter Relation column" UniqueName="Relation" DataField="Relation" HeaderText="Relation" SortExpression="Relation">
                                                <ItemTemplate>
                                                     <asp:Label ID="lblDpRelation" runat="server" Text='<%# Bind("Relation")%>'></asp:Label>
                                                    </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:DropDownList ID="dlDpRelation" runat="server" SelectedValue='<%# Bind("Relation") %>'
                                                        DataSource='<%# (new String[] {"Parent", "Child", "Spouse", "Sibling", "Extended Family", "Other"})%>'
                                                             AppendDataBoundItems="True">
                                                            <asp:ListItem Selected="True" Text="Select" Value=""> </asp:ListItem>
                                                        </asp:DropDownList>
                                            </EditItemTemplate>
                                            <HeaderStyle Width="100px" />
                                        </telerik:GridTemplateColumn>
                                         <telerik:GridTemplateColumn AllowFiltering="false"> 
                                         <ItemTemplate>
                                            <asp:Button ID="btnEdit" runat="server" CommandName="Edit" Text="Edit" CssClass="btn-info" /> 
                                          </ItemTemplate> 
                                        <EditItemTemplate > 
                                            <asp:Button ID="btnUpdate" runat="server" CommandName='<%# (Container is GridDataInsertItem) ? "PerformInsert" : "Update" %>' Text='<%# (Container is GridDataInsertItem) ? "Save" : "Update" %>' CssClass="btn-primary" /> 
                                            <asp:Button ID="btnCancel" runat="server" CommandName="Cancel" Text="Cancel" CausesValidation="false" CssClass="btn-warning" /> 
                                        </EditItemTemplate>
                                            <HeaderStyle Width="80px" />
                                        </telerik:GridTemplateColumn> 
                                    <telerik:GridButtonColumn Text="Delete" CommandName="Delete" UniqueName="Delete" ConfirmText="Delete Record?" ButtonType="PushButton" ButtonCssClass="btn-danger">
                                        <HeaderStyle Width="70px" />
                                    </telerik:GridButtonColumn>
                                    </Columns>
                                </MasterTableView>
                        </telerik:RadGrid>
                        <asp:SqlDataSource ID="nextofKinSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM tblEmployeeNextOfKin WHERE (Id = @Id)" InsertCommand="INSERT INTO tblEmployeeNextOfKin(EmployeeId, FullName, Email, PhoneNo, Relation, CreatedBy) VALUES(@EmployeeId, @FullName, @Email, @PhoneNo, @Relation, @CreatedBy)" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT Id, FullName, Email, PhoneNo, Relation from tblEmployeeNextOfKin WHERE (EmployeeId = @EmployeeId)" UpdateCommand="UPDATE tblEmployeeNextOfKin SET FullName = @FullName, Email = @Email, PhoneNo = @PhoneNo, Relation = @Relation WHERE (Id = @Id)">
                                <DeleteParameters>
                                    <asp:Parameter Name="Id" Type="Int32" />
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:ControlParameter Name="EmployeeId" Type="Int32" ControlID="txtEmployeeId" PropertyName="Text" DefaultValue="0" />
                                    <asp:Parameter Name="FullName" Type="String" />
                                    <asp:Parameter Name="Email" Type="String" />
                                    <asp:Parameter Name="PhoneNo" Type="String" />
                                    <asp:Parameter Name="Relation" Type="String" />
                                    <asp:CookieParameter Name="CreatedBy" CookieName="LoginUser" Type="String" />
                                </InsertParameters>
                                <SelectParameters>
                                    <asp:ControlParameter Name="EmployeeId" Type="Int32" ControlID="txtEmployeeId" PropertyName="Text" DefaultValue="0" />
                                </SelectParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="FullName" Type="String" />
                                    <asp:Parameter Name="Email" Type="String" />
                                    <asp:Parameter Name="PhoneNo" Type="String" />
                                    <asp:Parameter Name="Relation" Type="String" />
                                    <asp:Parameter Name="Id" Type="Int32" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                    </ContentTemplate>
                </asp:UpdatePanel>
                                </telerik:RadPageView>
                                <telerik:RadPageView ID="pvExperience" runat="server" Height="100%">
                                    <hr />
                                    <asp:UpdatePanel runat="server" UpdateMode="Conditional" >
                    <ContentTemplate>
                        <telerik:RadGrid ID="experienceGrid" DataSourceID="experienceSource" runat="server" AutoGenerateColumns="False" GroupPanelPosition="Top" AllowFilteringByColumn="False" AllowPaging="True" AllowSorting="True" CellSpacing="-1" GridLines="Both" OnItemInserted="experienceGrid_ItemInserted" OnItemUpdated="experienceGrid_ItemUpdated" OnItemDeleted="experienceGrid_ItemDeleted" OnItemCreated="experienceGrid_ItemCreated">
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" ScrollHeight="200px"/>
                                <Selecting AllowRowSelect="true" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />
                            <MasterTableView DataKeyNames="Id" DataSourceID="experienceSource" CommandItemDisplay="Top" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" AllowAutomaticUpdates="True" EditMode="InPlace">
                                    <RowIndicatorColumn Visible="false"></RowIndicatorColumn>
                                    <ExpandCollapseColumn Created="True"></ExpandCollapseColumn>
                                    <Columns>
                                        <telerik:GridBoundColumn DataField="PlaceOfWork" FilterControlAltText="Filter PlaceOfWork column" HeaderText="PlaceOfWork" SortExpression="PlaceOfWork" UniqueName="PlaceOfWork">
                                         <ColumnValidationSettings EnableRequiredFieldValidation="true">
                                            <RequiredFieldValidator Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></RequiredFieldValidator>
                                        </ColumnValidationSettings>
                                            <HeaderStyle Width="200px" />
                                         </telerik:GridBoundColumn>
                                        <telerik:GridDateTimeColumn DataField="StartDate" DataType="System.DateTime" FilterControlAltText="Filter StartDate column" HeaderText="StartDate" SortExpression="StartDate" UniqueName="StartDate" DataFormatString="{0:dd-MMM-yyyy}">
                                         <ColumnValidationSettings EnableRequiredFieldValidation="true">
                                            <RequiredFieldValidator Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></RequiredFieldValidator>
                                        </ColumnValidationSettings>
                                             <HeaderStyle Width="120px" />
                                         </telerik:GridDateTimeColumn>
                                        <telerik:GridDateTimeColumn DataField="EndDate" DataType="System.DateTime" FilterControlAltText="Filter EndDate column" HeaderText="EndDate" SortExpression="EndDate" UniqueName="EndDate" DataFormatString="{0:dd-MMM-yyyy}">
                                         <ColumnValidationSettings EnableRequiredFieldValidation="true">
                                            <RequiredFieldValidator Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></RequiredFieldValidator>
                                        </ColumnValidationSettings>
                                             <HeaderStyle Width="120px" />
                                         </telerik:GridDateTimeColumn>
                                        <telerik:GridBoundColumn DataField="Experience" FilterControlAltText="Filter Experience column" HeaderText="Experience" SortExpression="Experience" UniqueName="Experience">
                                         <ColumnValidationSettings EnableRequiredFieldValidation="true">
                                            <RequiredFieldValidator Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></RequiredFieldValidator>
                                        </ColumnValidationSettings>
                                            <HeaderStyle Width="200px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridTemplateColumn AllowFiltering="false"> 
                                         <ItemTemplate>
                                            <asp:Button ID="btnEdit" runat="server" CommandName="Edit" Text="Edit" CssClass="btn-info" /> 
                                          </ItemTemplate> 
                                        <EditItemTemplate > 
                                            <asp:Button ID="btnUpdate" runat="server" CommandName='<%# (Container is GridDataInsertItem) ? "PerformInsert" : "Update" %>' Text='<%# (Container is GridDataInsertItem) ? "Save" : "Update" %>' CssClass="btn-primary" /> 
                                            <asp:Button ID="btnCancel" runat="server" CommandName="Cancel" Text="Cancel" CausesValidation="false" CssClass="btn-warning" /> 
                                        </EditItemTemplate>
                                            <HeaderStyle Width="80px" />
                                        </telerik:GridTemplateColumn> 
                                    <telerik:GridButtonColumn Text="Delete" CommandName="Delete" UniqueName="Delete" ConfirmText="Delete Record?" ButtonType="PushButton" ButtonCssClass="btn-danger">
                                        <HeaderStyle Width="70px" />
                                    </telerik:GridButtonColumn>
                                    </Columns>
                                </MasterTableView>
                        </telerik:RadGrid>
                        <asp:SqlDataSource ID="experienceSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM tblEmployeeExperience WHERE (Id = @Id)" InsertCommand="INSERT INTO tblEmployeeExperience(EmployeeId, PlaceOfWork, StartDate, EndDate, Experience, CreatedBy) VALUES(@EmployeeId, @PlaceOfWork, @StartDate, @EndDate, @Experience, @CreatedBy)" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT Id, PlaceOfWork, StartDate, EndDate, Experience from tblEmployeeExperience WHERE (EmployeeId = @EmployeeId)" UpdateCommand="UPDATE tblEmployeeExperience SET PlaceOfWork = @PlaceOfWork, StartDate = @StartDate, EndDate = @EndDate, Experience = @Experience WHERE (Id = @Id)">
                                <DeleteParameters>
                                    <asp:Parameter Name="Id" Type="Int32" />
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:ControlParameter Name="EmployeeId" Type="Int32" ControlID="txtEmployeeId" PropertyName="Text" DefaultValue="0" />
                                    <asp:Parameter Name="PlaceOfWork" Type="String" />
                                    <asp:Parameter Name="StartDate" Type="DateTime" />
                                    <asp:Parameter Name="EndDate" Type="DateTime" />
                                    <asp:Parameter Name="Experience" Type="String" />
                                    <asp:CookieParameter Name="CreatedBy" CookieName="LoginUser" Type="String" />
                                </InsertParameters>
                                <SelectParameters>
                                    <asp:ControlParameter Name="EmployeeId" Type="Int32" ControlID="txtEmployeeId" PropertyName="Text" DefaultValue="0" />
                                </SelectParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="PlaceOfWork" Type="String" />
                                    <asp:Parameter Name="StartDate" Type="DateTime" />
                                    <asp:Parameter Name="EndDate" Type="DateTime" />
                                    <asp:Parameter Name="Experience" Type="String" />
                                    <asp:Parameter Name="Id" Type="Int32" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                    </ContentTemplate>
                </asp:UpdatePanel>
                                </telerik:RadPageView>
                                <telerik:RadPageView ID="pvTraining" runat="server" Height="100%">
                                    <hr />
                                    <asp:UpdatePanel runat="server" UpdateMode="Conditional" >
                    <ContentTemplate>
                        <telerik:RadGrid ID="trainingGrid" DataSourceID="trainingSource" runat="server" AutoGenerateColumns="False" GroupPanelPosition="Top" AllowFilteringByColumn="False" AllowPaging="True" AllowSorting="True" CellSpacing="-1" GridLines="Both" OnItemInserted="trainingGrid_ItemInserted" OnItemUpdated="trainingGrid_ItemUpdated" OnItemDeleted="trainingGrid_ItemDeleted" OnItemCreated="trainingGrid_ItemCreated">
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" ScrollHeight="200px"/>
                                <Selecting AllowRowSelect="true" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />
                            <MasterTableView DataKeyNames="Id" DataSourceID="trainingSource" CommandItemDisplay="Top" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" AllowAutomaticUpdates="True" EditMode="InPlace">
                                    <RowIndicatorColumn Visible="false"></RowIndicatorColumn>
                                    <ExpandCollapseColumn Created="True"></ExpandCollapseColumn>
                                    <Columns>
                                        <telerik:GridBoundColumn DataField="Training" FilterControlAltText="Filter Training column" HeaderText="Training" SortExpression="Training" UniqueName="Training">
                                         <ColumnValidationSettings EnableRequiredFieldValidation="true">
                                            <RequiredFieldValidator Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></RequiredFieldValidator>
                                        </ColumnValidationSettings>
                                            <HeaderStyle Width="200px" />
                                         </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Provider" FilterControlAltText="Filter Provider column" HeaderText="Provider" SortExpression="Provider" UniqueName="Provider">
                                         <ColumnValidationSettings EnableRequiredFieldValidation="true">
                                            <RequiredFieldValidator Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></RequiredFieldValidator>
                                        </ColumnValidationSettings>
                                            <HeaderStyle Width="200px" />
                                         </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Location" FilterControlAltText="Filter Location column" HeaderText="Location" SortExpression="Location" UniqueName="Location">
                                         <ColumnValidationSettings EnableRequiredFieldValidation="true">
                                            <RequiredFieldValidator Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></RequiredFieldValidator>
                                        </ColumnValidationSettings>
                                            <HeaderStyle Width="160px" />
                                         </telerik:GridBoundColumn>
                                        <telerik:GridDateTimeColumn DataField="StartDate" DataType="System.DateTime" FilterControlAltText="Filter StartDate column" HeaderText="StartDate" SortExpression="StartDate" UniqueName="StartDate" DataFormatString="{0:dd-MMM-yyyy}">
                                         <ColumnValidationSettings EnableRequiredFieldValidation="true">
                                            <RequiredFieldValidator Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></RequiredFieldValidator>
                                        </ColumnValidationSettings>
                                             <HeaderStyle Width="120px" />
                                         </telerik:GridDateTimeColumn>
                                        <telerik:GridDateTimeColumn DataField="EndDate" DataType="System.DateTime" FilterControlAltText="Filter EndDate column" HeaderText="EndDate" SortExpression="EndDate" UniqueName="EndDate" DataFormatString="{0:dd-MMM-yyyy}">
                                         <ColumnValidationSettings EnableRequiredFieldValidation="true">
                                            <RequiredFieldValidator Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></RequiredFieldValidator>
                                        </ColumnValidationSettings>
                                             <HeaderStyle Width="120px" />
                                         </telerik:GridDateTimeColumn>
                                         <telerik:GridTemplateColumn AllowFiltering="false"> 
                                         <ItemTemplate>
                                            <asp:Button ID="btnEdit" runat="server" CommandName="Edit" Text="Edit" CssClass="btn-info" /> 
                                          </ItemTemplate> 
                                        <EditItemTemplate > 
                                            <asp:Button ID="btnUpdate" runat="server" CommandName='<%# (Container is GridDataInsertItem) ? "PerformInsert" : "Update" %>' Text='<%# (Container is GridDataInsertItem) ? "Save" : "Update" %>' CssClass="btn-primary" /> 
                                            <asp:Button ID="btnCancel" runat="server" CommandName="Cancel" Text="Cancel" CausesValidation="false" CssClass="btn-warning" /> 
                                        </EditItemTemplate>
                                            <HeaderStyle Width="80px" />
                                        </telerik:GridTemplateColumn> 
                                    <telerik:GridButtonColumn Text="Delete" CommandName="Delete" UniqueName="Delete" ConfirmText="Delete Record?" ButtonType="PushButton" ButtonCssClass="btn-danger">
                                        <HeaderStyle Width="70px" />
                                    </telerik:GridButtonColumn>
                                    </Columns>
                                </MasterTableView>
                        </telerik:RadGrid>
                        <asp:SqlDataSource ID="trainingSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM tblEmployeeTraining WHERE (Id = @Id)" InsertCommand="INSERT INTO tblEmployeeTraining(EmployeeId, Training, Provider, Location, StartDate, EndDate, CreatedBy) VALUES(@EmployeeId, @Training, @Provider, @Location, @StartDate, @EndDate, @CreatedBy)" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT Id, Training, Provider, Location, StartDate, EndDate from tblEmployeeTraining WHERE (EmployeeId = @EmployeeId)" UpdateCommand="UPDATE tblEmployeeTraining SET Training = @Training, Provider = @Provider, Location = @Location, StartDate = @StartDate, EndDate = @EndDate WHERE (Id = @Id)">
                                <DeleteParameters>
                                    <asp:Parameter Name="Id" Type="Int32" />
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:ControlParameter Name="EmployeeId" Type="Int32" ControlID="txtEmployeeId" PropertyName="Text" DefaultValue="0" />
                                    <asp:Parameter Name="Training" Type="String" />
                                    <asp:Parameter Name="Provider" Type="String" />
                                    <asp:Parameter Name="Location" Type="String" />
                                    <asp:Parameter Name="StartDate" Type="DateTime" />
                                    <asp:Parameter Name="EndDate" Type="DateTime" />
                                    <asp:CookieParameter Name="CreatedBy" CookieName="LoginUser" Type="String" />
                                </InsertParameters>
                                <SelectParameters>
                                    <asp:ControlParameter Name="EmployeeId" Type="Int32" ControlID="txtEmployeeId" PropertyName="Text" DefaultValue="0" />
                                </SelectParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="Training" Type="String" />
                                    <asp:Parameter Name="Provider" Type="String" />
                                    <asp:Parameter Name="Location" Type="String" />
                                    <asp:Parameter Name="StartDate" Type="DateTime" />
                                    <asp:Parameter Name="EndDate" Type="DateTime" />
                                    <asp:Parameter Name="Id" Type="Int32" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                    </ContentTemplate>
                </asp:UpdatePanel>
                                </telerik:RadPageView>
                            </telerik:RadMultiPage>

                        <div class="modal-footer">
                            <asp:Button runat="server" ID="btnReturn" Text="Return" CssClass="btn btn-warning" CausesValidation="false" PostBackUrl="~/HR/Employee/Employees.aspx" style="margin-bottom:0px" />
                            <asp:Button runat="server" ID="btnPrint" Text="Print" CssClass="btn btn-info" OnClick="btnPrint_Click" CausesValidation="false" Enabled="false" />
                            <%--<asp:Button runat="server" ID="btnFind" Text="Find" CssClass="btn btn-success" OnClientClick="newModal()" CausesValidation="false" UseSubmitBehavior="false" />--%>
                            <a class="btn btn-success" onclick="newModal()">Find</a>
                            <asp:Button runat="server" ID="btnUpdate" Text="Update" CssClass="btn btn-primary" OnClick="btnUpdate_Click" />
                        </div>   
                    </ContentTemplate>
                             <Triggers>
                                 <asp:PostBackTrigger ControlID="btnUpdate" />
                                 <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                             </Triggers>
                </asp:UpdatePanel>
                    </div>
                </div>
        </div>


    
    <!-- new modal -->
         <div class="modal fade" id="newmodal">
    <div class="modal-dialog" style="width:40%">
        <asp:Panel runat="server" DefaultButton="btnSearch">
            <asp:UpdatePanel runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                 <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">Find Employee</h4>
                </div>
                        <div class="modal-body">
                             <div class="form-group">
                                        <label>Enter Staff No</label>
                                       <asp:TextBox runat="server" ID="txtSearchEmployee" ClientIDMode="Static" Width="100%" MaxLength="50" ></asp:TextBox>
                                   <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtSearchEmployee" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="search"></asp:RequiredFieldValidator>
                             </div>
                            <div>
                            </div>
                       </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
                    <asp:Button ID="btnSearch" runat="server" Text="Find" CssClass="btn btn-primary"  OnClick="btnSearch_Click" ValidationGroup="search" />
                </div>
            </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        </asp:Panel>
        </div>
         </div>

    <script type="text/javascript">
        function getUsername() {
            var username = $('#txtFirstname').val() + "." + $('#txtLastname').val();
            $('#txtUsername').val(username);
        }
        function newModal() {
            $('#newmodal').modal('show');
            $('#newmodal').appendTo($("form:first"));
        }

        $('#newmodal').on('shown.bs.modal', function () {
            // jQuery code is in here
            $('#txtSearchEmployee').focus();
        });

        function closenewModal() {
            $('#newmodal').modal('hide');
        }
    </script>

    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <script type="text/javascript">
            function UpdateBankBranchItemCountField(sender, args) {
                //Set the footer text.
                sender.get_dropDownElement().lastChild.innerHTML = "A total of " + sender.get_items().get_count() + " branches";
            }
        </script>
    </telerik:RadScriptBlock>
</asp:Content>
