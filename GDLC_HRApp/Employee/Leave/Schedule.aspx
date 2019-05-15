<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="Schedule.aspx.cs" Inherits="GDLC_HRApp.Employee.Leave.Schedule" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Content/css/updateProgress.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5> Leave Schedule </h5>
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
                        <asp:UpdateProgress ID="UpdateProgress2" runat="server" AssociatedUpdatePanelID="upMain">
                           <ProgressTemplate>
                            <div class="divWaiting">            
	                            <asp:Label ID="lblWait" runat="server" Text="Processing... " />
	                              <asp:Image ID="imgWait" runat="server" ImageAlign="Top" ImageUrl="/Content/img/loader.gif" />
                                </div>
                             </ProgressTemplate>
                       </asp:UpdateProgress>
                         <asp:UpdatePanel runat="server" ID="upMain" >
                    <ContentTemplate>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-3">
                                    <label>Transaction Date</label>
                                    <telerik:RadDatePicker ID="dpTransactionDate" runat="server" Width="100%" Enabled="false"></telerik:RadDatePicker>
                                </div>
                                <div class="col-md-3">
                                    <label>Staff No</label>
                                    <asp:TextBox runat="server" ID="txtStaffNo" Width="100%" Enabled="false"></asp:TextBox>
                                </div>
                                <div class="col-md-3">
                                    <label>Employee Name</label>
                                    <asp:TextBox runat="server" ID="txtEmployeeName" Width="100%" Enabled="false"></asp:TextBox>
                                </div>
                                <div class="col-md-3">
                                    <label>Rank</label>
                                    <asp:TextBox runat="server" ID="txtRank" Width="100%" Enabled="false"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                       
                        <div class="alert alert-info">
                                    Select Leave Type, Select Start Date & Enter Number of Days You Wish To Apply For.
                                </div>

                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-3">
                                    <label>Leave Type</label>
                                    <telerik:RadComboBox ID="dlLeaveType" runat="server" Width="100%" DataSourceID="leaveTypeSource" DataTextField="LeaveType" DataValueField="Id" Filter="Contains" MarkFirstMatch="true" MaxHeight="150" EmptyMessage="Select Leave Type"></telerik:RadComboBox>
                                    <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dlLeaveType" Display="Dynamic" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    <asp:SqlDataSource ID="leaveTypeSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>"  SelectCommand="SELECT Id,LeaveType FROM tblLeaveType"></asp:SqlDataSource>  
                                </div>
                                <div class="col-md-3">
                                    <label>Start Date</label>
                                    <telerik:RadDatePicker ID="dpStartDate" runat="server" Width="100%" OnSelectedDateChanged="dpStartDate_SelectedDateChanged" AutoPostBack="true"></telerik:RadDatePicker>
                                    <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dpStartDate" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="getEndDate"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-md-3">
                                    <label>Days Requested</label>
                                    <telerik:RadNumericTextBox ID="txtDaysRequested" runat="server" Width="100%" OnTextChanged="txtDaysRequested_TextChanged" AutoPostBack="true" NumberFormat-DecimalDigits="0" ShowSpinButtons="true" MinValue="1" CausesValidation="true"></telerik:RadNumericTextBox>
                                    <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtDaysRequested" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="getEndDate"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-md-3">
                                    <label>End Date</label>
                                    <telerik:RadDatePicker ID="dpEndDate" runat="server" Width="100%" Enabled="false"></telerik:RadDatePicker>
                                    <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dpEndDate" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="apply"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <asp:Button runat="server" ID="btnClear" Text="Clear" CssClass="btn btn-warning" CausesValidation="false" style="margin-bottom:0px" OnClick="btnClear_Click" />
                            <asp:Button runat="server" ID="btnSave" Text="Save" CssClass="btn btn-primary" OnClick="btnSave_Click" ValidationGroup="apply" OnClientClick="if (Page_IsValid) {this.value='Processing...';this.disabled=true; }" UseSubmitBehavior="false" />
                        </div>  

                        <hr />

                        <telerik:RadGrid ID="leaveGrid" runat="server" DataSourceID="leaveSource" AutoGenerateColumns="False" GroupPanelPosition="Top" AllowPaging="False" AllowSorting="True" CellSpacing="-1" GridLines="Both" OnItemDeleted="leaveGrid_ItemDeleted">
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" ScrollHeight="250px" />
                                <Selecting AllowRowSelect="true" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />

                                 <MasterTableView DataKeyNames="Id" DataSourceID="leaveSource" AllowAutomaticDeletes="true">
                                     <Columns>
                                         <telerik:GridBoundColumn Display="false" DataType="System.Int32" DataField="Id" SortExpression="Id" UniqueName="Id">
                                         </telerik:GridBoundColumn>
                                         <telerik:GridDateTimeColumn DataField="CreatedDate" DataType="System.DateTime" FilterControlAltText="Filter CreatedDate column" HeaderText="Date" SortExpression="CreatedDate" UniqueName="CreatedDate" DataFormatString="{0:dd-MMM-yyyy}">
                                         <HeaderStyle Width="120px" />
                                         </telerik:GridDateTimeColumn>
                                         <telerik:GridBoundColumn DataField="StaffNo" FilterControlAltText="Filter StaffNo column" HeaderText="StaffNo" SortExpression="StaffNo" UniqueName="StaffNo">
                                         <HeaderStyle Width="80px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="EmployeeName" FilterControlAltText="Filter EmployeeName column" HeaderText="EmployeeName" ReadOnly="True" SortExpression="EmployeeName" UniqueName="EmployeeName">
                                         <HeaderStyle Width="150px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="LeaveType" FilterControlAltText="Filter LeaveType column" HeaderText="LeaveType" SortExpression="LeaveType" UniqueName="LeaveType">
                                         <HeaderStyle Width="120px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridDateTimeColumn DataField="Startdate" DataType="System.DateTime" FilterControlAltText="Filter Startdate column" HeaderText="Startdate" SortExpression="Startdate" UniqueName="Startdate" DataFormatString="{0:dd-MMM-yyyy}">
                                         <HeaderStyle Width="120px" />
                                         </telerik:GridDateTimeColumn>
                                         <telerik:GridDateTimeColumn DataField="Enddate" DataType="System.DateTime" FilterControlAltText="Filter Enddate column" HeaderText="Enddate" SortExpression="Enddate" UniqueName="Enddate" DataFormatString="{0:dd-MMM-yyyy}">
                                         <HeaderStyle Width="120px" />
                                         </telerik:GridDateTimeColumn>
                                         <telerik:GridBoundColumn DataField="DaysRequested" FilterControlAltText="Filter DaysRequested column" HeaderText="DaysRequested" SortExpression="DaysRequested" UniqueName="DaysRequested">
                                         <HeaderStyle Width="100px" />
                                         </telerik:GridBoundColumn>
                                         <%--<telerik:GridButtonColumn ButtonType="PushButton" CommandName="Edit" ButtonCssClass="btn-info" Text="Edit" Exportable="false">
                                        <HeaderStyle Width="50px" />
                                        </telerik:GridButtonColumn>--%>
                                        <telerik:GridButtonColumn Text="Delete" CommandName="Delete" UniqueName="Delete" ConfirmText="Delete Record?" ButtonType="PushButton" ButtonCssClass="btn-danger" Exportable="false">
                                        <HeaderStyle Width="50px" />
                                        </telerik:GridButtonColumn>
                                     </Columns>
                                 </MasterTableView>

                        </telerik:RadGrid>
                        <asp:SqlDataSource ID="leaveSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT Id,CreatedDate,StaffNo,EmployeeName,LeaveType,Startdate,Enddate,DaysRequested from vwLeaveSchedule WHERE EmployeeId=@EmployeeId ORDER BY Id DESC" DeleteCommand="DELETE FROM tblLeaveSchedule WHERE Id = @Id">
                            <SelectParameters>
                                <asp:CookieParameter Name="EmployeeId" CookieName="UserId" Type="Int32" DefaultValue="0" />
                            </SelectParameters>
                            <DeleteParameters>
                                <asp:Parameter Name="Id" Type="Int32" />
                            </DeleteParameters>
                        </asp:SqlDataSource>

                    </ContentTemplate>
                </asp:UpdatePanel>
                    </div>
                </div>
        </div>
</asp:Content>
