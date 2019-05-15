<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="Users.aspx.cs" Inherits="GDLC_HRApp.HR.Security.Users" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Users</h5>
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
                                                <div class="row">
                                        <div class="col-sm-4 pull-right">
                                           
                                        </div>
                                        <div class="col-sm-8 pull-left">
                                            <div class="toolbar-btn-action">

                                            </div>
                                        </div>
                                    </div>
                         <asp:UpdatePanel runat="server" >
                    <ContentTemplate>

                            <telerik:RadGrid ID="userGrid" runat="server" AllowFilteringByColumn="True" AllowSorting="True" DataSourceID="userSource" GroupPanelPosition="Top" OnItemDataBound="userGrid_ItemDataBound" OnItemCommand="userGrid_ItemCommand">
                                   <GroupingSettings CaseSensitive="False" />
                                   <ClientSettings>
                                       <Selecting AllowRowSelect="True" />
                                       <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="400px" />
                                   </ClientSettings>
                                   <GroupingSettings CaseSensitive="false" />
                                   <MasterTableView AutoGenerateColumns="False" CommandItemDisplay="None" DataKeyNames="ID" DataSourceID="userSource">
                                       <CommandItemSettings ShowAddNewRecordButton="false" />
                                       <RowIndicatorColumn Visible="False">
                                       </RowIndicatorColumn>
                                       <Columns>
                                           <telerik:GridBoundColumn  DataField="ID" FilterControlAltText="Filter ID column"  SortExpression="ID" UniqueName="ID" Display="false">
                                           </telerik:GridBoundColumn>
                                           <telerik:GridBoundColumn AutoPostBackOnFilter="True" CurrentFilterFunction="Contains" DataField="USERNAME" EmptyDataText="" FilterControlAltText="Filter USERNAME column" FilterDelay="1000" HeaderText="Username"  SortExpression="USERNAME" UniqueName="USERNAME" ShowFilterIcon="false" FilterControlWidth="120px">
                                           <HeaderStyle Width="150px" />
                                           </telerik:GridBoundColumn>
                                           <telerik:GridBoundColumn AutoPostBackOnFilter="True" CurrentFilterFunction="Contains" DataField="FULLNAME" FilterControlAltText="Filter FULLNAME column" FilterDelay="1000" HeaderText="Full Name" SortExpression="FULLNAME" UniqueName="FULLNAME" ShowFilterIcon="false" FilterControlWidth="170px">
                                           <HeaderStyle Width="200px" />
                                           </telerik:GridBoundColumn>
                                           <telerik:GridBoundColumn DataField="USERROLES" FilterControlAltText="Filter USERROLES column" HeaderText="USERROLES" SortExpression="USERROLES" UniqueName="USERROLES" ShowFilterIcon="false" FilterControlWidth="170px">
                                           <HeaderStyle Width="200px" />
                                           </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="ACTIVE" FilterControlAltText="Filter ACTIVE column" HeaderText="ACTIVE" SortExpression="ACTIVE" UniqueName="ACTIVE" Display="false" >
                                           <HeaderStyle Width="120px" />
                                            </telerik:GridBoundColumn>
                                           <telerik:GridButtonColumn CommandName="Edit" Text="Edit" UniqueName="Edit" ButtonType="PushButton" ButtonCssClass="btn-info">
                                           <HeaderStyle Width="50px" />
                                           </telerik:GridButtonColumn>
                                           <telerik:GridButtonColumn CommandName="ToggleActive" Text="Toggle Active" ButtonType="PushButton" ButtonCssClass="btn-warning" UniqueName="ToggleActive" ConfirmText="Toggle User's active status?">
                                           <HeaderStyle Width="100px" />
                                           </telerik:GridButtonColumn>
                                       </Columns>
                                   </MasterTableView>
                               </telerik:RadGrid>
                               <asp:SqlDataSource ID="userSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT ID, USERNAME, LastName + ' ' + ISNULL(MiddleName, '') + ' ' + Firstname as FULLNAME, USERROLES, ACTIVE FROM TBLEMPLOYEES ORDER BY FULLNAME">
                                   <DeleteParameters>
                                       <asp:Parameter Name="ID" Type="Int32" />
                                   </DeleteParameters>
                               </asp:SqlDataSource>
                    </ContentTemplate>
                </asp:UpdatePanel>
                    </div>
                </div>
        </div>

    <div class="modal animated bounceInLeft" id="usermodal">
    <div class="modal-dialog" style="width:40%">
         <asp:UpdatePanel ID="upUser" runat="server" >
             <ContentTemplate>
                          <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">User Account</h4>
                </div>
                        <div class="modal-body">
                            <div class="form-group">
                             <label>Username</label>
                             <asp:TextBox runat="server" ID="txtUsername" Width="100%" Enabled="false"></asp:TextBox>
                         </div>
                         <div class="form-group">
                             <label>Password</label>
                             <asp:TextBox runat="server" ID="txtPassword" Width="100%" TextMode="Password"></asp:TextBox>
                         </div>
                            <div class="form-group">
                             <label>Role</label>
                             <telerik:RadDropDownList ID="dlRole" runat="server" Width="100%">
                             <Items>
                                 <telerik:DropDownListItem Text="Employee" />
                                 <telerik:DropDownListItem Text="Supervisor" />
                                 <telerik:DropDownListItem Text="HR" />
                             </Items>
                         </telerik:RadDropDownList>
                         </div>
                            <div class="form-group">
                             <label>Active</label>
                             <asp:CheckBox runat="server" ID="chkActive" Width="100%" />
                         </div>
                       </div>
                <div class="modal-footer">
                     <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
                    <asp:Button runat="server" ID="btnUpdate" CssClass="btn btn-primary" Text="Update" OnClick="btnUpdate_Click" ValidationGroup="user"/>
                </div>
            </div>
             </ContentTemplate>
         </asp:UpdatePanel>
        </div>
    </div>

    <script type="text/javascript">
        function showusermodal() {
            $('#usermodal').modal('show');
            $('#usermodal').appendTo($("form:first"));
        }
        function closeusermodal() {
            $('#usermodal').modal('hide');
        }
    </script>
</asp:Content>
