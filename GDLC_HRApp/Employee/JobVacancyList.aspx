<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="JobVacancyList.aspx.cs" Inherits="GDLC_HRApp.Employee.JobVacancyList" %>

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
                                                <a class="btn btn-warning" href="/Dashboard.aspx"> Return </a> 
                                            </div>
                                        </div>
                                    </div>
                             <telerik:RadGrid ID="vacancyGrid" runat="server" DataSourceID="vacancySource" AutoGenerateColumns="False" GroupPanelPosition="Top" AllowPaging="False" AllowSorting="True" CellSpacing="-1" GridLines="Both" OnSelectedIndexChanged="vacancyGrid_SelectedIndexChanged">
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" ScrollHeight="400px" />
                                <Selecting AllowRowSelect="true" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />

                                 <MasterTableView DataKeyNames="Id" DataSourceID="vacancySource" >
                                     <Columns>
                                         <telerik:GridBoundColumn Display="false" DataType="System.Int32" DataField="Id" SortExpression="Id" UniqueName="Id">
                                         </telerik:GridBoundColumn>
                                         <%--<telerik:GridHyperLinkColumn DataTextField="JobTitle" DataNavigateUrlFields="Id" DataNavigateUrlFormatString="/Employee/JobVacancyView.aspx?jobId={0}" UniqueName="JobTitle" >
                                             <HeaderStyle Width="150px" />
                                         </telerik:GridHyperLinkColumn>--%>
                                         <telerik:GridButtonColumn DataTextField="JobTitle" ButtonType="LinkButton" CommandName="Select" HeaderText="Job Title">
                                             <HeaderStyle Width="200px" />
                                             <ItemStyle ForeColor="SteelBlue" Font-Underline="true" />
                                         </telerik:GridButtonColumn>
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
</asp:Content>
