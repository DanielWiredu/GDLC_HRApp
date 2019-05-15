<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="InfoView.aspx.cs" Inherits="GDLC_HRApp.Employee.InfoView" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
table {
    border-collapse: collapse;
    width: 100%;
}

th {
    padding: 8px;
    text-align: left;
    border-bottom: 3px solid #000000;
    font-size:larger;
}
h3 {
    text-align: left;
    border-bottom: 2px solid #000000;
    font-weight:bold;
}
td {
    padding: 5px;
    text-align: left;
    border-bottom: 1px solid #ddd;
}
.tdempInfo {
    padding: 5px;
    text-align: left;
    border-bottom:none !important;
}
.tdlabel {
    padding: 5px;
    text-align: left;
    border-bottom:none !important;
    font-weight:bold;
}
.tdlabelh {
    padding: 5px;
    text-align: right;
    /*border-bottom: 1px solid #ddd;*/
    font-weight:bold;
}
.tdlabelg {
    padding: 5px;
    text-align: left;
    border-bottom: 1px solid #ddd;
    font-weight:bold;
}
tr:hover{background-color:#f5f5f5}
/*tr:nth-child(odd) {background-color: #f2f2f2}*/
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper wrapper-content animated fadeInRight">
            <div class="row">
            <div class="col-lg-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-content">
                       <%--<p>Employee Information</p>--%>

                        <div class="row">
                             <asp:Panel ID="ListViewPanel2" runat="server">
            <telerik:RadListView ID="lvEmployee" RenderMode="Lightweight" Width="97%" AllowPaging="True" runat="server"
                ItemPlaceholderID="EmployeeHolder" DataKeyNames="ID">
                <LayoutTemplate>
                    <fieldset class="layoutFieldset" id="FieldSet2">
                        <asp:Panel ID="EmployeeHolder" runat="server">
                        </asp:Panel>
                    </fieldset>
                </LayoutTemplate>
                <ItemTemplate>
                    <div class="itemWrapper">
                        <h3>Personal Details</h3>
                         <div class="row">
                            <div class="col-md-8">
                                <table id="Table2" border="0" class="module">
                                        <tr>
                                            <td class="tdlabelh">Staff No:
                                            </td>
                                            <td>
                                                <%# Eval("staffno") %>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tdlabelh">Fullname:
                                            </td>
                                            <td>
                                                <%# Eval("fullname") %>
                                            </td>
                                        </tr>
                                         <tr>
                                            <td class="tdlabelh">Gender:
                                            </td>
                                            <td>
                                               <%# Eval("gender") %>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tdlabelh">Contact No:
                                            </td>
                                            <td>
                                                <%# Eval("contactno") %>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tdlabelh">Email Address:
                                            </td>
                                            <td>
                                                <%# Eval("email") %>
                                            </td>
                                        </tr>
                                    </table>
                            </div>
                            <div class="col-md-4">
                                <table id="Table4" border="0" class="module">
                             
                                        <tr>
                                            <td style="text-align:left">
                                                <asp:Image ID="imgProfile" Width="140px" Height="135px" runat="server" ImageUrl='<%# Eval("profilepath") %>' />
                                            </td>
                                        </tr>
                                    </table>
                            </div>
                        </div>
                        <%--<hr />--%>
                        <div class="row">
                            <div class="col-md-6">
                                <table id="Table3" border="0" class="module">
                                    <tr>
                                            <td class="tdlabel">Employee ID:
                                            </td>
                                            <td class="tdempInfo">
                                                <%# Eval("id") %>
                                            </td>
                                        </tr>
                                    <tr>
                                            <td class="tdlabel">Username:
                                            </td>
                                            <td class="tdempInfo">
                                                <%# Eval("username") %>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tdlabel">Date of Birth:
                                            </td>
                                            <td class="tdempInfo">
                                                <%# DataBinder.Eval(Container.DataItem, "dateofbirth", "{0:dd-MMM-yyyy}") %>
                                            </td>
                                        </tr>
                                        
                                         <tr>
                                            <td class="tdlabel">Department:
                                            </td>
                                            <td class="tdempInfo">
                                               <%# Eval("departmentname") %>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tdlabel">Position:
                                            </td>
                                            <td class="tdempInfo">
                                                <%# Eval("position") %>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tdlabel">Bank:
                                            </td>
                                            <td class="tdempInfo">
                                                <%# Eval("bankname") %>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tdlabel">Bank Branch:
                                            </td>
                                            <td class="tdempInfo">
                                                <%# Eval("bankbranch") %>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tdlabel">Account No:
                                            </td>
                                            <td class="tdempInfo">
                                                <%# Eval("bankaccno") %>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tdlabel">SSNIT No:
                                            </td>
                                            <td class="tdempInfo">
                                                <%# Eval("SSNITNo") %>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tdlabel">Date Employed:
                                            </td>
                                            <td class="tdempInfo">
                                                <%# DataBinder.Eval(Container.DataItem, "dateemployed", "{0:dd-MMM-yyyy}") %>
                                            </td>
                                        </tr>
                                        
                                    </table>
                            </div>
                            <div class="col-md-6">
                                <table id="Table1" border="0" class="module">
                                        <tr>
                                            <td class="tdlabel">Company:
                                            </td>
                                            <td class="tdempInfo">
                                               <%# Eval("company") %>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tdlabel">Company Branch:
                                            </td>
                                            <td class="tdempInfo">
                                                <%# Eval("branchname") %>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tdlabel">Rank:
                                            </td>
                                            <td class="tdempInfo">
                                                <%# Eval("rank") %>
                                            </td>
                                        </tr>
                                         <tr>
                                            <td class="tdlabel">Unit:
                                            </td>
                                            <td class="tdempInfo">
                                               <%# Eval("unit") %>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tdlabel">Region:
                                            </td>
                                            <td class="tdempInfo">
                                                <%# Eval("region") %>
                                            </td>
                                        </tr>
                                        
                                    <tr>
                                            <td class="tdlabel">Marital Status:
                                            </td>
                                            <td class="tdempInfo">
                                                <%# Eval("maritalstatus") %>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tdlabel">Postal Address:
                                            </td>
                                            <td class="tdempInfo">
                                                <%# Eval("postaladdress") %>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tdlabel">Residential Address:
                                            </td>
                                            <td class="tdempInfo">
                                                <%# Eval("residentialaddress") %>
                                            </td>
                                        </tr>       
                                        <tr>
                                            <td class="tdlabel">Employment Status:
                                            </td>
                                            <td class="tdempInfo">
                                                <%# Eval("employmentstatus") %>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tdlabel">Employment Type:
                                            </td>
                                            <td class="tdempInfo">
                                                <%# Eval("employmenttype") %>
                                            </td>
                                        </tr>
                                    </table>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </telerik:RadListView>
        </asp:Panel>
                        </div>
                        <hr />
                        <div class="row">
                            <asp:Panel ID="Panel1" runat="server">
            <telerik:RadListView ID="lvDependents" RenderMode="Lightweight" Width="97%" AllowPaging="True" runat="server"
                ItemPlaceholderID="DependentsHolder" DataKeyNames="id">
                <LayoutTemplate>
                    
                     <h3>Dependents</h3>
                                <table>
                                    <tr>
                                        <td class="tdlabelg" style="width:40%">Name
                                            </td>
                                        <td class="tdlabelg" style="width:30%">Date of Birth
                                            </td>
                                        <td class="tdlabelg" style="width:30%">Relation
                                            </td>
                                    </tr>
                                    </table>                    
                    <fieldset class="layoutFieldset" id="FieldSet2">
                        <asp:Panel ID="DependentsHolder" runat="server">
                        </asp:Panel>
                    </fieldset>
                </LayoutTemplate>
                <ItemTemplate>

                                <table>
                                        <tr> 
                                            <td style="width:40%">
                                                <%# Eval("DependentName") %>
                                            </td>
                                            
                                            <td style="width:30%">
                                                <%# DataBinder.Eval(Container.DataItem, "DateOfBirth", "{0:dd-MMM-yyyy}") %>
                                            </td>
                                            <td style="width:30%">
                                               <%# Eval("Relation") %>
                                            </td>
                                        </tr>
                                    </table>
                </ItemTemplate>
            </telerik:RadListView>
        </asp:Panel>
                        </div>

                    </div>
                </div>
            </div>

                </div>
        </div>
</asp:Content>
