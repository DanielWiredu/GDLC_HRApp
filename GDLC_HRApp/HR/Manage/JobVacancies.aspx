<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="JobVacancies.aspx.cs" Inherits="GDLC_HRApp.HR.Manage.JobVacancies" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
 
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Job Vacancies</h5>
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
                                            <asp:TextBox runat="server" ID="txtSearch" Width="100%" placeholder="Job Title / Position..." OnTextChanged="txtSearch_TextChanged" AutoPostBack="true"></asp:TextBox>
                                           
                                           <%--<asp:Button runat="server" ID="btnExcelExport" CssClass="btn btn-primary" Text="Excel" CausesValidation="false" OnClick="btnExcelExport_Click"/>--%>
                                            <%--<asp:Button runat="server" ID="btnPDFExport" CssClass="btn btn-warning" Text="PDF" CausesValidation="false" OnClick="btnPDFExport_Click"/>--%>
                                        </div>
                                        <div class="col-sm-8 pull-left">
                                            <div class="toolbar-btn-action">
                                                <%--<asp:Button runat="server" ID="btnAddNew" CssClass="btn btn-success" Text="Add" CausesValidation="false" OnClientClick="newModal();"  />--%> 
                                                <a class="btn btn-success" onclick="newModal();"> Add</a> 
                                            </div>
                                        </div>
                                    </div>
                             <telerik:RadGrid ID="vacancyGrid" runat="server" DataSourceID="vacancySource" AutoGenerateColumns="False" GroupPanelPosition="Top" AllowPaging="False" AllowSorting="True" CellSpacing="-1" GridLines="Both" OnItemCommand="vacancyGrid_ItemCommand" OnItemDeleted="vacancyGrid_ItemDeleted">
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" ScrollHeight="400px" />
                                <Selecting AllowRowSelect="true" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />

                                 <MasterTableView DataKeyNames="Id" DataSourceID="vacancySource" AllowAutomaticDeletes="true">
                                     <Columns>
                                         <telerik:GridBoundColumn Display="false" DataType="System.Int32" DataField="Id" SortExpression="Id" UniqueName="Id">
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="JobTitle" FilterControlAltText="Filter JobTitle column" HeaderText="Job Title" SortExpression="JobTitle" UniqueName="JobTitle">
                                         <HeaderStyle Width="150px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridDateTimeColumn DataField="ClosingDate" DataType="System.DateTime" FilterControlAltText="Filter ClosingDate column" HeaderText="Closing Date" SortExpression="ClosingDate" UniqueName="ClosingDate" DataFormatString="{0:dd-MMM-yyyy}">
                                         <HeaderStyle Width="120px" />
                                         </telerik:GridDateTimeColumn>
                                         <telerik:GridBoundColumn DataField="Position" FilterControlAltText="Filter Position column" HeaderText="Position" SortExpression="Position" UniqueName="Position">
                                         <HeaderStyle Width="150px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn DataField="JobQualification" FilterControlAltText="Filter JobQualification column" HeaderText="JobQualification" SortExpression="JobQualification" UniqueName="JobQualification">
                                         <HeaderStyle Width="250px" />
                                         </telerik:GridBoundColumn>
                                         <telerik:GridDateTimeColumn DataField="CreatedDate" DataType="System.DateTime" FilterControlAltText="Filter CreatedDate column" HeaderText="Created Date" SortExpression="CreatedDate" UniqueName="CreatedDate" DataFormatString="{0:dd-MMM-yyyy}">
                                         <HeaderStyle Width="120px" />
                                         </telerik:GridDateTimeColumn>
                                         <telerik:GridButtonColumn Display="false" ButtonType="PushButton" CommandName="Edit" ButtonCssClass="btn-info" Text="Edit" Exportable="false">
                                        <HeaderStyle Width="50px" />
                                        </telerik:GridButtonColumn>
                                        <telerik:GridButtonColumn Text="Delete" CommandName="Delete" UniqueName="Delete" ConfirmText="Delete Record?" ButtonType="PushButton" ButtonCssClass="btn-danger" Exportable="false">
                                        <HeaderStyle Width="50px" />
                                        </telerik:GridButtonColumn>
                                     </Columns>
                                 </MasterTableView>

                        </telerik:RadGrid>
                        <asp:SqlDataSource ID="vacancySource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT TOP (50) Id, JobTitle, ClosingDate, Position, JobQualification, CreatedDate FROM vwJobVacancy WHERE (Position LIKE '%' + @SearchValue + '%') OR (JobTitle LIKE '%' + @SearchValue + '%') ORDER BY Id DESC" DeleteCommand="DELETE FROM tblEmployeeDiscipline WHERE Id = @Id">
                            <SelectParameters>
                                <asp:ControlParameter Name="SearchValue" ControlID="txtSearch" Type="String" PropertyName="Text" ConvertEmptyStringToNull="false" />
                            </SelectParameters>
                            <DeleteParameters>
                                <asp:Parameter Name="Id" Type="Int32" />
                            </DeleteParameters>
                        </asp:SqlDataSource>
                        <%--<hr />
                        <div class="row">
                            <telerik:RadEditor runat="server" ID="txtRad" Width="100%" EditModes="Design" BackColor="White">
                                
                            </telerik:RadEditor>
                        </div>--%>

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
    <div class="modal-dialog" style="width:60%">
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                 <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">New Vacancy</h4>
                </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label>Job Title</label>
                                <asp:TextBox runat="server" ID="txtJobTitle" Width="100%" MaxLength="100"></asp:TextBox>
                                 <asp:RequiredFieldValidator runat="server" ControlToValidate="txtJobTitle" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red" ValidationGroup="new"></asp:RequiredFieldValidator>
                               </div>
                            <div class="form-group">
                                    <label>Closing Date</label>
                                     <telerik:RadDatePicker runat="server" ID="dpClosingDate" Width="100%" DateInput-ReadOnly="false" MinDate="1/1/1850"></telerik:RadDatePicker>
                                     <asp:RequiredFieldValidator runat="server" ControlToValidate="dpClosingDate" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red" ValidationGroup="new"></asp:RequiredFieldValidator>
                                </div>
                            <div class="form-group">
                                <label>Position</label>
                                        <telerik:RadDropDownList ID="dlPosition" runat="server" Width="100%" DataSourceID="positionSource" DataTextField="Position" DataValueField="Id" DropDownHeight="200px" CausesValidation="false"></telerik:RadDropDownList>
                                        <asp:SqlDataSource ID="positionSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT Id,Position FROM [tblPositions]"></asp:SqlDataSource>
                                    </div>
                            <div class="form-group">
                         <label>Job Qualification</label>
                         <telerik:RadComboBox ID="dlJobQualification" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" runat="server" Width="100%" DataSourceID="jobQualificationSource" DataTextField="Qualification" DataValueField="Qualification" Filter="None" MarkFirstMatch="false" Text="Select Offences"></telerik:RadComboBox>
                          <asp:SqlDataSource ID="jobQualificationSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT Qualification from tblJobQualification"></asp:SqlDataSource>  
                          <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dlJobQualification" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>
                     </div>
                             <%--<div class="form-group" hidden="hidden">
                                        <label>Job Description</label>
                                       <asp:TextBox runat="server" ID="txtJobDescription111" TextMode="MultiLine"></asp:TextBox>
                             </div>--%>
                            <div class="form-group">
                                <label>Job Description</label>
                               <telerik:RadEditor RenderMode="Lightweight" Height="400px" Width="100%" EmptyMessage="Click to enter job description" ToolsWidth="300px" EditModes="Preview,Design" ID="txtJobDescription" runat="server" ToolbarMode="Default" ToolsFile="/Content/BasicTools.xml">
                                   <CssFiles>
                                       <telerik:EditorCssFile Value="/Content/EditorContentArea.css" />
                                   </CssFiles>
                        </telerik:RadEditor>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtJobDescription" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>
                            </div>
                            <%--<div class="form-group">
                                <label>job</label>
                                <telerik:RadEditor RenderMode="Lightweight" runat="server" ID="RadEditor1" Height="250px" Width="100%">
                <Tools>
                    <telerik:EditorToolGroup>
                        <telerik:EditorTool Name="Cut"></telerik:EditorTool>
                        <telerik:EditorTool Name="Copy"></telerik:EditorTool>
                        <telerik:EditorTool Name="Paste"></telerik:EditorTool>
                    </telerik:EditorToolGroup>
                </Tools>
            </telerik:RadEditor>
                            </div>--%>
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
    <div class="modal-dialog" style="width:60%">
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                 <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">Edit Vacancy</h4>
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

     <%--<script type="text/javascript" src="https://cdn.tinymce.com/4/tinymce.min.js"></script>--%>

    <script type="text/javascript" src="https://tinymce.cachefly.net/4.0/tinymce.min.js"></script>

    <%--<script src="https://cloud.tinymce.com/stable/tinymce.min.js"></script>--%>
        <script type="text/javascript">
            tinymce.init({ selector: 'textarea', width: 700 });
        </script>
</asp:Content>
