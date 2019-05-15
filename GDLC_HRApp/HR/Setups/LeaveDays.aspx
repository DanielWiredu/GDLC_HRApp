<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="LeaveDays.aspx.cs" Inherits="GDLC_HRApp.HR.Setups.LeaveDays" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Leave Days</h5>
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
                                        <div class="col-sm-4 pull-right" style="width:inherit">
                                           <asp:Button runat="server" ID="btnExcelExport" CssClass="btn btn-primary" Text="Excel" CausesValidation="false" OnClick="btnExcelExport_Click"/>
                                            <asp:Button runat="server" ID="btnPDFExport" CssClass="btn btn-warning" Text="PDF" CausesValidation="false" OnClick="btnPDFExport_Click"/>
                                        </div>
                                        <div class="col-sm-8 pull-left">
                                            <div class="toolbar-btn-action">
                                                <asp:Button runat="server" ID="btnAddNew" CssClass="btn btn-success" Text="Add New" CausesValidation="false" OnClientClick="newModal()" />  
                                            </div>
                                        </div>
                                    </div>

                             <telerik:RadGrid ID="leaveDayGrid" runat="server" AutoGenerateColumns="False" GroupPanelPosition="Top" ShowGroupPanel="true" AllowFilteringByColumn="True" AllowPaging="True" AllowSorting="True" CellSpacing="-1" GridLines="Both" DataSourceID="leaveDaySource" OnItemCommand="leaveDayGrid_ItemCommand" OnItemDeleted="leaveDayGrid_ItemDeleted">
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" ScrollHeight="400px" />
                                <Selecting AllowRowSelect="true" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" ShowUnGroupButton="true" />
                                 <ExportSettings IgnorePaging="true" ExportOnlyData="true" OpenInNewWindow="true" FileName="leaveDay_list" HideStructureColumns="true"  >
                                        <Pdf AllowPrinting="true" AllowCopy="true" PaperSize="Letter" PageTitle="Leave Day List" PageWidth="450"></Pdf>
                                    </ExportSettings>

                                 <MasterTableView DataKeyNames="Id" DataSourceID="leaveDaySource" AllowAutomaticDeletes="true" PageSize="50">
                                     <GroupByExpressions>
                                           <telerik:GridGroupByExpression>
                                               <SelectFields>
                                                   <telerik:GridGroupByField FieldAlias="" FieldName="LeaveType"></telerik:GridGroupByField>
                                               </SelectFields>
                                               <GroupByFields>
                                                   <telerik:GridGroupByField FieldName="LeaveType" SortOrder="Ascending"></telerik:GridGroupByField>
                                               </GroupByFields>
                                           </telerik:GridGroupByExpression>
                                       </GroupByExpressions>
                                     <Columns>
                                         <telerik:GridBoundColumn Display="false" DataField="Id" DataType="System.Int32" FilterControlAltText="Filter Id column" HeaderText="Id" ReadOnly="True" SortExpression="Id" UniqueName="Id">
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn Display="false" DataField="LeaveTypeId" DataType="System.Int32" FilterControlAltText="Filter LeaveTypeId column" HeaderText="LeaveTypeId" ReadOnly="True" SortExpression="LeaveTypeId" UniqueName="LeaveTypeId">
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn Display="false" DataField="RankId" DataType="System.Int32" FilterControlAltText="Filter RankId column" HeaderText="RankId" ReadOnly="True" SortExpression="RankId" UniqueName="RankId">
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="Rank" FilterControlAltText="Filter Rank column" HeaderText="Rank" SortExpression="Rank" UniqueName="Rank" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="250px">
                                         <HeaderStyle Width="250px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="LeaveDays" DataType="System.Int32" FilterControlAltText="Filter LeaveDays column" HeaderText="LeaveDays" SortExpression="LeaveDays" UniqueName="LeaveDays" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="80px">
                                         <HeaderStyle Width="100px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="DaysBefore" DataType="System.Int32" FilterControlAltText="Filter DaysBefore column" HeaderText="DaysBefore" SortExpression="DaysBefore" UniqueName="DaysBefore" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="80px">
                                         <HeaderStyle Width="100px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridButtonColumn ButtonType="PushButton" CommandName="Edit" ButtonCssClass="btn-info" Text="Edit" Exportable="false">
                                        <HeaderStyle Width="50px" />
                                        </telerik:GridButtonColumn>
                                        <telerik:GridButtonColumn Text="Delete" CommandName="Delete" UniqueName="Delete" ConfirmText="Delete Record?" ButtonType="PushButton" ButtonCssClass="btn-danger" Exportable="false">
                                        <HeaderStyle Width="60px" />
                                        </telerik:GridButtonColumn>
                                     </Columns>
                                 </MasterTableView>

                        </telerik:RadGrid>
                        <asp:SqlDataSource ID="leaveDaySource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [vwLeaveDays]" DeleteCommand="DELETE FROM [tblLeaveDays] WHERE [Id] = @Id">
                            <DeleteParameters>
                                <asp:Parameter Name="Id" Type="Int32" />
                            </DeleteParameters>
                        </asp:SqlDataSource>
                    </ContentTemplate>
                             <Triggers>
                                  <asp:PostBackTrigger ControlID="btnExcelExport" />
                                  <asp:PostBackTrigger ControlID="btnPDFExport" />
                              </Triggers>
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
                    <h4 class="modal-title">New Leave Days</h4>
                </div>
                        <div class="modal-body">                          
                            <div class="form-group">
                                <label>Leave Type</label>
                                <telerik:RadComboBox ID="dlLeaveType" runat="server" Width="100%" DataSourceID="leaveTypeSource" DataTextField="LeaveType" DataValueField="Id" Filter="Contains" MarkFirstMatch="true" MaxHeight="150"></telerik:RadComboBox>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dlLeaveType" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>
                                 <asp:SqlDataSource ID="leaveTypeSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>"  SelectCommand="SELECT Id,LeaveType FROM tblLeaveType"></asp:SqlDataSource>  
                            </div>
                            <div class="form-group">
                                <label>Rank</label>
                                <telerik:RadComboBox ID="dlRank" runat="server" Width="100%" DataSourceID="rankSource" DataTextField="Rank" DataValueField="Id" Filter="Contains" MarkFirstMatch="true" MaxHeight="200"></telerik:RadComboBox>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dlRank" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>
                                 <asp:SqlDataSource ID="rankSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>"  SelectCommand="SELECT Id,Rank FROM tblRanks"></asp:SqlDataSource>  
                            </div>
                            <div class="form-group">
                                        <label> Leave Days</label>
                                       <telerik:RadNumericTextBox runat="server" ID="txtLeaveDays" NumberFormat-DecimalDigits="0" MinValue="0" Width="100%" Value="0"></telerik:RadNumericTextBox>
                                   <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtLeaveDays" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>
                             </div>
                            <div class="form-group">
                                        <label> Days Before</label>
                                       <telerik:RadNumericTextBox runat="server" ID="txtDaysBefore" NumberFormat-DecimalDigits="0" MinValue="0" Width="100%" Value="0"></telerik:RadNumericTextBox>
                                   <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtDaysBefore" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>
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
                    <h4 class="modal-title">Edit Leave Days</h4>
                </div>
                        <div class="modal-body">                          
                            <div class="form-group">
                                <label>Leave Type</label>
                                <telerik:RadComboBox ID="dlLeaveType1" runat="server" Width="100%" DataSourceID="leaveTypeSource" DataTextField="LeaveType" DataValueField="Id" Filter="Contains" MarkFirstMatch="true" MaxHeight="150"></telerik:RadComboBox>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dlLeaveType1" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="edit"></asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group">
                                <label>Rank</label>
                                <telerik:RadComboBox ID="dlRank1" runat="server" Width="100%" DataSourceID="rankSource" DataTextField="Rank" DataValueField="Id" Filter="Contains" MarkFirstMatch="true" MaxHeight="200"></telerik:RadComboBox>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dlRank1" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="edit"></asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group">
                                        <label> Leave Days</label>
                                       <telerik:RadNumericTextBox runat="server" ID="txtLeaveDays1" NumberFormat-DecimalDigits="0" MinValue="0" Width="100%" Value="0"></telerik:RadNumericTextBox>
                                   <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtLeaveDays1" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="edit"></asp:RequiredFieldValidator>
                             </div>
                            <div class="form-group">
                                        <label> Days Before</label>
                                       <telerik:RadNumericTextBox runat="server" ID="txtDaysBefore1" NumberFormat-DecimalDigits="0" MinValue="0" Width="100%" Value="0"></telerik:RadNumericTextBox>
                                   <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtDaysBefore1" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="edit"></asp:RequiredFieldValidator>
                             </div>
                       </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
                    <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-primary" ValidationGroup="edit" OnClick="btnUpdate_Click" />
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
