<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="Leave.aspx.cs" Inherits="GDLC_HRApp.Supervisor.Leave.Leave" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Leave</h5>
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
                         <asp:UpdatePanel runat="server" >
                    <ContentTemplate>
                        <div class="row">
                                        <div class="col-sm-4 pull-right" >
                                            <asp:TextBox runat="server" ID="txtSearch" Width="100%" placeholder="Employee Name / Leave Type..." OnTextChanged="txtSearch_TextChanged" AutoPostBack="true"></asp:TextBox>
                                        </div>
                                        <div class="col-sm-8 pull-left">
                                            <div class="toolbar-btn-action">
                                                
                                            </div>
                                        </div>
                                    </div>
                        <hr />
                             <telerik:RadGrid ID="leaveGrid" runat="server" DataSourceID="leaveSource" AutoGenerateColumns="False" GroupPanelPosition="Top" AllowPaging="False" AllowSorting="True" CellSpacing="-1" GridLines="Both" OnItemCommand="leaveGrid_ItemCommand" OnItemDataBound="leaveGrid_ItemDataBound">
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" ScrollHeight="400px" />
                                <Selecting AllowRowSelect="true" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />

                                 <MasterTableView DataKeyNames="Id" DataSourceID="leaveSource">
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
                                         <HeaderStyle Width="80px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn Display="false" DataType="System.Int32" DataField="ApprovedStatus" UniqueName="ApprovedStatus">
                                         </telerik:GridBoundColumn>
                                         <%--<telerik:GridButtonColumn ButtonType="PushButton" CommandName="Edit" ButtonCssClass="btn-info" Text="Edit" Exportable="false">
                                        <HeaderStyle Width="50px" />
                                        </telerik:GridButtonColumn>--%>
                                        <telerik:GridButtonColumn Text="View" CommandName="View" UniqueName="View" ButtonType="PushButton" ButtonCssClass="btn-info" Exportable="false">
                                        <HeaderStyle Width="50px" />
                                        </telerik:GridButtonColumn>
                                     </Columns>
                                 </MasterTableView>

                        </telerik:RadGrid>
                        <asp:SqlDataSource ID="leaveSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT Id,CreatedDate,StaffNo,EmployeeName,LeaveType,Startdate,Enddate,DaysRequested,ApprovedStatus from vwLeave WHERE SupervisorId=@SupervisorId AND (EmployeeName LIKE '%' + @SearchValue + '%' OR LeaveType LIKE '%' + @SearchValue + '%') ORDER BY Id DESC">
                            <SelectParameters>
                                <asp:CookieParameter Name="SupervisorId" CookieName="UserId" Type="Int32" DefaultValue="0" />
                                <asp:ControlParameter Name="SearchValue" ControlID="txtSearch" Type="String" PropertyName="Text" ConvertEmptyStringToNull="false" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ContentTemplate>
                             <%--<Triggers>
                                  <asp:PostBackTrigger ControlID="btnSearch" />
                              </Triggers>--%>
                </asp:UpdatePanel>
                    </div>
                </div>
        </div>

     <!-- new modal -->
         <div class="modal fade" id="newmodal">
    <div class="modal-dialog" style="width:80%">
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                 <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">Leave Details</h4>
                </div>
                        <div class="modal-body">
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
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-3">
                                    <label>Leave Type</label>
                                    <telerik:RadComboBox ID="dlLeaveType" runat="server" Width="100%" DataSourceID="leaveTypeSource" DataTextField="LeaveType" DataValueField="Id" Filter="Contains" MarkFirstMatch="true" MaxHeight="150" EmptyMessage="Select Leave Type" Enabled="false"></telerik:RadComboBox>
                                    <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dlLeaveType" Display="Dynamic" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    <asp:SqlDataSource ID="leaveTypeSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>"  SelectCommand="SELECT Id,LeaveType FROM tblLeaveType"></asp:SqlDataSource>  
                                </div>
                                <div class="col-md-3">
                                    <label>Start Date</label>
                                    <telerik:RadDatePicker ID="dpStartDate" runat="server" Width="100%" Enabled="false"></telerik:RadDatePicker>
                                    <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dpStartDate" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="getEndDate"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-md-3">
                                    <label>Days Requested</label>
                                    <telerik:RadNumericTextBox ID="txtDaysRequested" runat="server" Width="100%" NumberFormat-DecimalDigits="0" ShowSpinButtons="true" MinValue="1" CausesValidation="true" Enabled="false"></telerik:RadNumericTextBox>
                                    <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtDaysRequested" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="getEndDate"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-md-3">
                                    <label>End Date</label>
                                    <telerik:RadDatePicker ID="dpEndDate" runat="server" Width="100%" Enabled="false"></telerik:RadDatePicker>
                                    <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dpEndDate" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="apply"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                            <div class="form-group">
                                <label>Rejection Comment</label>
                                <asp:TextBox runat="server" ID="txtDenialReason" placeholder="Reason for denying leave request" TextMode="MultiLine" Rows="3" Width="100%"></asp:TextBox>
                            </div>
                       </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
                </div>
            </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        </div>
         </div>

    <script type="text/javascript">
            function newModal() {
                $('#newmodal').modal('show');
                $('#newmodal').appendTo($("form:first"));
            }
            function closenewModal() {
                $('#newmodal').modal('hide');
            }
    </script>
</asp:Content>
