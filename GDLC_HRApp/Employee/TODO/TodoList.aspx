<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="TodoList.aspx.cs" Inherits="GDLC_HRApp.Employee.TODO.TodoList" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5> Todo List </h5>
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
                                            <asp:TextBox runat="server" ID="txtSearch" Width="100%" placeholder="Task..." OnTextChanged="txtSearch_TextChanged" AutoPostBack="true"></asp:TextBox>
                                        </div>
                                        <div class="col-sm-8 pull-left">
                                            <div class="toolbar-btn-action">
                                                <asp:Button runat="server" ID="btnAddNew" CssClass="btn btn-success" Text="Add" CausesValidation="false" OnClientClick="newModal();"  /> 
                                                <a class="btn btn-warning" href="/Dashboard.aspx"> Return </a> 
                                            </div>
                                        </div>
                                    </div>
                             <telerik:RadGrid ID="todoGrid" runat="server" DataSourceID="todoSource" AutoGenerateColumns="False" GroupPanelPosition="Top" AllowPaging="False" AllowSorting="True" CellSpacing="-1" GridLines="Both" OnItemCommand="todoGrid_ItemCommand" OnItemDataBound="todoGrid_ItemDataBound">
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" ScrollHeight="400px" />
                                <Selecting AllowRowSelect="true" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />

                                 <MasterTableView DataKeyNames="Id" DataSourceID="todoSource" >
                                     <Columns>
                                         <telerik:GridButtonColumn Text="Complete" ButtonType="PushButton" CommandName="Complete" UniqueName="Complete" ConfirmText="Complete this task?" ButtonCssClass="btn-primary">
                                             <HeaderStyle Width="70px" />
                                         </telerik:GridButtonColumn>
                                         <telerik:GridBoundColumn Display="false" DataType="System.Int32" DataField="Id" SortExpression="Id" UniqueName="Id">
                                         </telerik:GridBoundColumn>
                                         <telerik:GridDateTimeColumn DataField="TaskDate" DataType="System.DateTime" FilterControlAltText="Filter TaskDate column" HeaderText="Task Date" SortExpression="TaskDate" UniqueName="TaskDate" DataFormatString="{0:dd-MMM-yyyy h:mm tt}">
                                         <HeaderStyle Width="120px" />
                                         </telerik:GridDateTimeColumn>
                                         <telerik:GridBoundColumn DataField="Task" FilterControlAltText="Filter Task column" HeaderText="Task" SortExpression="Task" UniqueName="Task">
                                         <HeaderStyle Width="200px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridCheckBoxColumn DataField="Completed" DataType="System.Boolean" FilterControlAltText="Filter Completed column" HeaderText="Completed" SortExpression="Completed" UniqueName="Completed" StringTrueValue="1" StringFalseValue="0" >
                                         <HeaderStyle Width="80px" />
                                         </telerik:GridCheckBoxColumn> 
                                         <telerik:GridButtonColumn Text="Delete" ButtonType="PushButton" CommandName="Delete" UniqueName="Delete" ButtonCssClass="btn-danger">
                                             <HeaderStyle Width="60px" />
                                         </telerik:GridButtonColumn>          
                                     </Columns>
                                 </MasterTableView>

                        </telerik:RadGrid>
                        <asp:SqlDataSource ID="todoSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT TOP (50) Id, Task, TaskDate, Completed FROM tblEmployeeTodoList WHERE (Task LIKE '%' + @SearchValue + '%') AND (EmployeeId = @EmployeeId) ORDER BY Id DESC" DeleteCommand="DELETE FROM tblEmployeeDiscipline WHERE Id = @Id">
                            <SelectParameters>
                                <asp:ControlParameter Name="SearchValue" ControlID="txtSearch" Type="String" PropertyName="Text" ConvertEmptyStringToNull="false" />
                                <asp:CookieParameter Name="EmployeeId" CookieName="UserId" Type="Int32" />
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


                 <!-- new modal -->
         <div class="modal fade" id="newmodal">
    <div class="modal-dialog" style="width:50%">
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                 <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">New Todo</h4>
                </div>
                        <div class="modal-body">
                            <div class="form-group">
                                        <label>Date</label>
                                <telerik:RadDateTimePicker ID="dpTaskDate" runat="server" Width="100%"></telerik:RadDateTimePicker>
                                   <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dpTaskDate" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>
                             </div>
                             <div class="form-group">
                                        <label>Task</label>
                                       <asp:TextBox runat="server" ID="txtTask" Width="100%" MaxLength="100"></asp:TextBox>
                                   <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtTask" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>
                             </div>
                       </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
                    <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-primary" ValidationGroup="new" OnClick="btnSave_Click" />
                </div>
            </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        </div>
         </div>

    <!-- edit modal -->
         <div class="modal fade" id="editmodal">
    <div class="modal-dialog" style="width:50%">
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                 <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">Edit Todo</h4>
                </div>
                        <div class="modal-body">

                       </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
                    <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-primary" ValidationGroup="edit"/>
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
            function editModal() {
                $('#editmodal').modal('show');
                $('#editmodal').appendTo($("form:first"));
            }
            function closeeditModal() {
                $('#editmodal').modal('hide');
            }
    </script>
</asp:Content>
