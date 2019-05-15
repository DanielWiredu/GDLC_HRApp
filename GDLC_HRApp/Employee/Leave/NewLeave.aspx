<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="NewLeave.aspx.cs" Inherits="GDLC_HRApp.Employee.Leave.NewLeave" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Content/css/updateProgress.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>New Leave</h5>
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
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-3">
                                    <label>Leave Days</label>
                                    <asp:TextBox runat="server" ID="txtLeaveDays" Width="100%" Enabled="false"></asp:TextBox>
                                </div>
                                <div class="col-md-3">
                                    <label>Remaining Days</label>
                                    <asp:TextBox runat="server" ID="txtRemainingDays" Width="100%" Enabled="false"></asp:TextBox>
                                    <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtRemainingDays" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="apply"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-md-3">
                                    <label>Supervisor</label>
                                    <asp:TextBox runat="server" ID="txtSupervisor" Width="100%" Enabled="false"></asp:TextBox>
                                </div>
                                <div class="col-md-3">
                                    <label>Supervisor Email</label>
                                    <asp:TextBox runat="server" ID="txtSupervisorEmail" Width="100%" Enabled="false"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <asp:HiddenField runat="server" ID="hfDaysBefore" />
                        <div class="alert alert-info">
                                    Select Leave Type, Select Start Date & Enter Number of Days You Wish To Apply For.
                                </div>

                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-3">
                                    <label>Leave Type</label>
                                    <telerik:RadComboBox ID="dlLeaveType" runat="server" Width="100%" DataSourceID="leaveTypeSource" DataTextField="LeaveType" DataValueField="Id" Filter="Contains" MarkFirstMatch="true" MaxHeight="150" EmptyMessage="Select Leave Type" OnSelectedIndexChanged="dlLeaveType_SelectedIndexChanged" AutoPostBack="true"></telerik:RadComboBox>
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
                            <asp:Button runat="server" ID="btnClear" Text="Clear" CssClass="btn btn-danger" CausesValidation="false" style="margin-bottom:0px" OnClick="btnClear_Click" />
                            <asp:Button runat="server" ID="btnReturn" Text="Return" CssClass="btn btn-warning" CausesValidation="false" PostBackUrl="~/Employee/Leave/Leave.aspx" />
                            <asp:Button runat="server" ID="btnSave" Text="Apply" CssClass="btn btn-primary" OnClick="btnSave_Click" ValidationGroup="apply" OnClientClick="if (Page_IsValid) {this.value='Processing...';this.disabled=true; }" UseSubmitBehavior="false" />
                        </div>  
                    </ContentTemplate>
                </asp:UpdatePanel>
                    </div>
                </div>
        </div>
</asp:Content>
