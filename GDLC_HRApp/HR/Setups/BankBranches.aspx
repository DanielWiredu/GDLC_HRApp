<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="BankBranches.aspx.cs" Inherits="GDLC_HRApp.HR.Setups.BankBranches" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Bank Branches</h5>
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
                                                <asp:Button runat="server" ID="btnAddNew" CssClass="btn btn-success" Text="Add BankBranch" CausesValidation="false" OnClientClick="newModal()" />  
                                            </div>
                                        </div>
                                    </div>

                             <telerik:RadGrid ID="bankBranchGrid" runat="server" AutoGenerateColumns="False" GroupPanelPosition="Top" ShowGroupPanel="true" AllowFilteringByColumn="True" AllowPaging="True" AllowSorting="True" CellSpacing="-1" GridLines="Both" DataSourceID="bankBranchSource" OnItemCommand="bankBranchGrid_ItemCommand" OnItemDeleted="bankBranchGrid_ItemDeleted">
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" ScrollHeight="400px" />
                                <Selecting AllowRowSelect="true" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" ShowUnGroupButton="true" />
                                 <ExportSettings IgnorePaging="true" ExportOnlyData="true" OpenInNewWindow="true" FileName="bankBranch_list" HideStructureColumns="true"  >
                                        <Pdf AllowPrinting="true" AllowCopy="true" PaperSize="Letter" PageTitle="Bank Branch List" PageWidth="500"></Pdf>
                                    </ExportSettings>

                                 <MasterTableView DataKeyNames="BranchId" DataSourceID="bankBranchSource" AllowAutomaticDeletes="true" PageSize="50">
                                     <GroupByExpressions>
                                           <telerik:GridGroupByExpression>
                                               <SelectFields>
                                                   <telerik:GridGroupByField FieldAlias="" FieldName="BankName"></telerik:GridGroupByField>
                                               </SelectFields>
                                               <GroupByFields>
                                                   <telerik:GridGroupByField FieldName="BankName" SortOrder="Ascending"></telerik:GridGroupByField>
                                               </GroupByFields>
                                           </telerik:GridGroupByExpression>
                                       </GroupByExpressions>
                                     <Columns>
                                         <telerik:GridBoundColumn Display="false" DataField="BranchId" DataType="System.Int32" FilterControlAltText="Filter BranchId column" HeaderText="BranchId" ReadOnly="True" SortExpression="BranchId" UniqueName="BranchId">
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="BranchName" FilterControlAltText="Filter BranchName column" HeaderText="Branch Name" SortExpression="BranchName" UniqueName="BranchName" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="250px">
                                         <HeaderStyle Width="300px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn Display="false" DataField="BankId" DataType="System.Int32" FilterControlAltText="Filter BankId column" HeaderText="BankId" SortExpression="BankId" UniqueName="BankId">
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="SortCode" HeaderText="SortCode" SortExpression="SortCode" UniqueName="SortCode" EmptyDataText="" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="70px">
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
                        <asp:SqlDataSource ID="bankBranchSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [vwBankBranches]" DeleteCommand="DELETE FROM [tblBankBranches] WHERE [BranchId] = @BranchId">
                            <DeleteParameters>
                                <asp:Parameter Name="BranchId" Type="Int32" />
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
                    <h4 class="modal-title">New Bank Branch</h4>
                </div>
                        <div class="modal-body">
                             <div class="form-group">
                                        <label> Name</label>
                                       <asp:TextBox runat="server" ID="txtBankBranch" Width="100%" MaxLength="50"></asp:TextBox>
                                   <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtBankBranch" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>
                             </div>
                            <div class="form-group">
                                <label>Bank</label>
                                <telerik:RadComboBox ID="dlBank" runat="server" Width="100%" DataSourceID="bankSource" DataTextField="BankName" DataValueField="BankId" Filter="Contains" MarkFirstMatch="true" MaxHeight="300"></telerik:RadComboBox>
                                 <asp:SqlDataSource ID="bankSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>"  SelectCommand="SELECT BankId,BankName FROM tblBanks"></asp:SqlDataSource>  
                            </div>
                            <div class="form-group">
                                <label>Sort Code</label>
                                <asp:TextBox runat="server" ID="txtSortCode" Width="100%" MaxLength="6"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtSortCode" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator runat="server" ErrorMessage="Numbers only up to 6 characters" ControlToValidate="txtSortCode" ValidationExpression="^[0-9]{6,6}$" Display="Dynamic" SetFocusOnError="true" ForeColor="Red" ValidationGroup="new" />
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
                    <h4 class="modal-title">Edit Bank Branch</h4>
                </div>
                        <div class="modal-body">
                             <div class="form-group">
                                        <label>Branch Name</label>
                                       <asp:TextBox runat="server" ID="txtBankBranch1" Width="100%" MaxLength="50"></asp:TextBox>
                                   <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtBankBranch1" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="edit"></asp:RequiredFieldValidator>
                             </div>
                            <div class="form-group">
                                <label>Bank</label>
                                <telerik:RadComboBox ID="dlBank1" runat="server" Width="100%" DataSourceID="bankSource" DataTextField="BankName" DataValueField="BankId" Filter="Contains" MarkFirstMatch="true" MaxHeight="300"></telerik:RadComboBox>
                            </div>
                            <div class="form-group">
                                <label>Sort Code</label>
                                <asp:TextBox runat="server" ID="txtSortCode1" Width="100%" MaxLength="6"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtSortCode1" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="edit"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator runat="server" ErrorMessage="Numbers only up to 6 characters" ControlToValidate="txtSortCode1" ValidationExpression="^[0-9]{6,6}$" Display="Dynamic" SetFocusOnError="true" ForeColor="Red" ValidationGroup="edit" />
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
