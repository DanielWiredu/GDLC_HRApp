﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="Denied.aspx.cs" Inherits="GDLC_HRApp.Employee.Leave.Denied" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Denied Leave</h5>
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
                                            <%--<asp:TextBox runat="server" ID="txtSearch" Width="100%" placeholder="Year..." OnTextChanged="txtSearch_TextChanged" AutoPostBack="true"></asp:TextBox>--%>
                                        </div>
                                        <div class="col-sm-8 pull-left">
                                            <div class="toolbar-btn-action">

                                            </div>
                                        </div>
                                    </div>
                        <hr />
                             <telerik:RadGrid ID="leaveGrid" runat="server" DataSourceID="leaveSource" AutoGenerateColumns="False" GroupPanelPosition="Top" AllowPaging="False" AllowSorting="True" CellSpacing="-1" GridLines="Both">
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
                                         <HeaderStyle Width="100px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="DeniedBy" FilterControlAltText="Filter DeniedBy column" HeaderText="DeniedBy" SortExpression="DeniedBy" UniqueName="DeniedBy">
                                         <HeaderStyle Width="150px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridDateTimeColumn DataField="DeniedDate" DataType="System.DateTime" FilterControlAltText="Filter DeniedDate column" HeaderText="DeniedDate" SortExpression="DeniedDate" UniqueName="DeniedDate">
                                         <HeaderStyle Width="120px" />
                                         </telerik:GridDateTimeColumn>
                                         <telerik:GridBoundColumn DataField="DeniedReason" FilterControlAltText="Filter DeniedReason column" HeaderText="DeniedReason" SortExpression="DeniedReason" UniqueName="DeniedReason">
                                         <HeaderStyle Width="200px" />
                                         </telerik:GridBoundColumn>
                                     </Columns>
                                 </MasterTableView>

                        </telerik:RadGrid>
                        <asp:SqlDataSource ID="leaveSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT Id,CreatedDate,StaffNo,EmployeeName,LeaveType,Startdate,Enddate,DaysRequested,ApprovedStatus from vwLeave WHERE EmployeeId=@EmployeeId AND ApprovedStatus = 2 ORDER BY Id DESC">
                            <SelectParameters>
                                <asp:CookieParameter Name="EmployeeId" CookieName="UserId" Type="Int32" DefaultValue="0" />
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
</asp:Content>
