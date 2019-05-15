<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="Supervisor_Subordinates.aspx.cs" Inherits="GDLC_HRApp.HR.Manage.Supervisor_Subordinates" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <link href="/Content/css/telerikCombo.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Supervisor / Subordinates</h5>
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
                                        <div class="col-sm-4 pull-right">
                                           
                                        </div>
                                        <div class="col-sm-8 pull-left">
                                            <div class="toolbar-btn-action">
                                                <asp:Button runat="server" ID="btnAddNew" CssClass="btn btn-success" Text="Add Subordinate" CausesValidation="false" OnClick="btnAddNew_Click" />  
                                                <asp:Button runat="server" ID="btnViewSubs" CssClass="btn btn-warning" Text="View Subordinates" OnClick="btnViewSubs_Click" /> 
                                            </div>
                                        </div>
                                    </div>

                        <hr />

                        <div class="row">
                    <div class="col-sm-4">
                        <!-- START panel-->
                        <div class="panel panel-default">
                            <div class="panel-heading">Supervisors</div>
                            <div class="panel-body">
                                <div class="form-group">
                                       <telerik:RadComboBox ID="dlSupervisor" runat="server" Width="100%" DataSourceID="supervisorSource" MaxHeight="200" EmptyMessage="Select Supervisor" Filter="Contains"
                                           OnItemDataBound="dlSupervisor_ItemDataBound" OnDataBound="dlSupervisor_DataBound" OnItemsRequested="dlSupervisor_ItemsRequested" EnableLoadOnDemand="true"
                                            OnClientItemsRequested="UpdateSupervisorItemCountField" HighlightTemplatedItems="true" MarkFirstMatch="true"  >
                                            <HeaderTemplate>
                <ul>
                    <li class="ncolfull">SUPERVISOR</li>
                </ul>
            </HeaderTemplate>
            <ItemTemplate>
                <ul>
                    <li class="ncolfull">
                        <%# DataBinder.Eval(Container.DataItem, "SupervisorName")%></li>
                </ul>
            </ItemTemplate>
            <FooterTemplate>
                A total of
                <asp:Literal runat="server" ID="supervisorCount" />
                items
            </FooterTemplate>
                                        </telerik:RadComboBox>
                                        <asp:SqlDataSource ID="supervisorSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT top (30) SupervisorID,SupervisorName FROM [vwSupervisors]"></asp:SqlDataSource>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="dlSupervisor" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                             </div>
                            </div>
                        </div>
                        <!-- END panel-->
                    </div>
                    <div class="col-sm-8">
                        <!-- START panel-->
                        <div class="panel panel-default">
                            <div class="panel-heading">Subordinates</div>
                            <div class="panel-body">
                                <telerik:RadGrid ID="subordinateGrid" runat="server" AutoGenerateColumns="False" GroupPanelPosition="Top" AllowFilteringByColumn="False" AllowPaging="True" AllowSorting="True" OnItemDeleted="subordinateGrid_ItemDeleted" CellSpacing="-1" DataSourceID="subordinateSource" GridLines="Both">
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                                <Selecting AllowRowSelect="true" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />
                                 <MasterTableView DataKeyNames="Id" DataSourceID="subordinateSource" AllowAutomaticDeletes="true">
                                     <Columns>
                                         <telerik:GridBoundColumn Display="false" DataField="Id" DataType="System.Int32" HeaderText="SupervisorId" ReadOnly="True" SortExpression="Id" UniqueName="Id">
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="SubordinateName" HeaderText="SubordinateName" SortExpression="SubordinateName" UniqueName="SubordinateName">
                                         <HeaderStyle Width="300px" />
                                         </telerik:GridBoundColumn>
                                    <telerik:GridButtonColumn Text="Delete" CommandName="Delete" UniqueName="Delete" ConfirmText="Delete Record?" ButtonType="PushButton" ButtonCssClass="btn-danger" Exportable="false">
                                        <HeaderStyle Width="50px" />
                                    </telerik:GridButtonColumn>
                                     </Columns>
                                 </MasterTableView>
                        </telerik:RadGrid>
                        <asp:SqlDataSource ID="subordinateSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [tblSupervisorSubordinates] WHERE [Id] = @Id" SelectCommand="SELECT * FROM [vwSupervisorSubordinates] WHERE SupervisorId = @SupervisorId">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="dlSupervisor" Name="SupervisorId" PropertyName="SelectedValue" ConvertEmptyStringToNull="false" DefaultValue="0" />
                            </SelectParameters>
                            <DeleteParameters>
                                <asp:Parameter Name="Id" Type="Int32" />
                            </DeleteParameters>
                        </asp:SqlDataSource>
                            </div>
                        </div>
                        <!-- END panel-->
                    </div>
                </div>

                    </ContentTemplate>
                </asp:UpdatePanel>
                    </div>
                </div>
        </div>

    
    <!-- new modal -->
         <div class="modal fade" id="newmodal">
    <div class="modal-dialog" style="width:50%">
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                 <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">New Subordinate</h4>
                </div>
                        <div class="modal-body">
                             <div class="form-group">
                                        <label>Name</label>
                                       <telerik:RadComboBox ID="dlEmployee" runat="server" Width="100%" DataSourceID="employeeSource" MaxHeight="200" EmptyMessage="Select Employee" Filter="Contains"
                                           OnItemDataBound="dlEmployee_ItemDataBound" OnDataBound="dlEmployee_DataBound" OnItemsRequested="dlEmployee_ItemsRequested" EnableLoadOnDemand="true"
                                            OnClientItemsRequested="UpdateEmployeeItemCountField" HighlightTemplatedItems="true" MarkFirstMatch="true"  >
                                            <HeaderTemplate>
                <ul>
                    <li class="ncolfull">EMPLOYEE NAME</li>
                </ul>
            </HeaderTemplate>
            <ItemTemplate>
                <ul>
                    <li class="ncolfull">
                        <%# DataBinder.Eval(Container.DataItem, "FullName")%></li>
                </ul>
            </ItemTemplate>
            <FooterTemplate>
                A total of
                <asp:Literal runat="server" ID="employeeCount" />
                items
            </FooterTemplate>
                                        </telerik:RadComboBox>
                                        <asp:SqlDataSource ID="employeeSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT top (30) ID,FullName FROM [vwEmployee] WHERE Active = 1"></asp:SqlDataSource>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="dlEmployee" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                             </div>
                       </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
                    <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-primary" OnClick="btnSave_Click" />
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
    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <script type="text/javascript">
            function UpdateSupervisorItemCountField(sender, args) {
                //Set the footer text.
                sender.get_dropDownElement().lastChild.innerHTML = "A total of " + sender.get_items().get_count() + " items";
            }
            function UpdateEmployeeItemCountField(sender, args) {
                //Set the footer text.
                sender.get_dropDownElement().lastChild.innerHTML = "A total of " + sender.get_items().get_count() + " items";
            }
        </script>
    </telerik:RadScriptBlock>
</asp:Content>
