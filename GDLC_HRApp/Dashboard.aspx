<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="GDLC_HRApp.Dashboard" %>

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
    height: 35px;
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
                       <p>Dashboard</p>
                       
                        <div class="row">
                            
                        </div>

                        <div class="row">
                <div class="col-lg-6">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Job Vacancy</h5>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-up"></i>
                            </a>
                            <%--<a class="dropdown-toggle" data-toggle="dropdown" href="#">
                                <i class="fa fa-wrench"></i>
                            </a>--%>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <asp:Panel runat="server">
            <telerik:RadListView ID="lvJobs" RenderMode="Lightweight" Width="97%" runat="server" OnSelectedIndexChanged="lvJobs_SelectedIndexChanged"
                ItemPlaceholderID="jobsHolder" DataKeyNames="id">
                
                <LayoutTemplate>
                                <%--<table>
                                    <tr>
                                        <td class="tdlabelg" style="width:70%">Job Title
                                            </td>
                                        <td class="tdlabelg" style="width:30%">Closing Date
                                            </td>
                                    </tr>
                                    </table>  --%>                  
                    <fieldset class="layoutFieldset" >
                        <asp:Panel ID="jobsHolder" runat="server">
                        </asp:Panel>
                    </fieldset>
                </LayoutTemplate>
                <ItemTemplate>
                                <table>
                                        <%--<tr runat="server" id="jobRow" onclick="jobClick()"> 
                                            <td style="width:70%">
                                                <%# Eval("JobTitle") %>
                                            </td>
                                            <td style="width:30%">
                                                <%# DataBinder.Eval(Container.DataItem, "ClosingDate", "{0:dd-MMM-yyyy}") %>
                                            </td>
                                        </tr>--%>
                                    <tr > 
                                            <td style="width:70%">
                                               <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Select">
                                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("JobTitle") %>'></asp:Label>
                                            </asp:LinkButton>
                                            </td>
                                            <td style="width:30%; text-align:right; color:green; font-size:smaller; padding-bottom:15px;">
                                                <%# DataBinder.Eval(Container.DataItem, "ClosingDate", "{0:dd-MMM-yyyy}") %>
                                            </td>
                                        </tr>
                                    </table>
                </ItemTemplate>
            </telerik:RadListView>
        </asp:Panel>
                    </div>
                    <div class="sidebar-title">
                        <h5>
                            <i class="fa fa-minus-square-o"></i>
                            <a href="/Employee/JobVacancyList.aspx">
                                more
                            </a>
                        </h5>
                    </div>

                </div>
            </div>
            <div class="col-lg-6">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Todo List </h5>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-up"></i>
                            </a>
                            <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                                <i class="fa fa-wrench"></i>
                            </a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <asp:Panel runat="server">
            <telerik:RadListView ID="lvTodo" RenderMode="Lightweight" Width="97%" runat="server" OnSelectedIndexChanged="lvTodo_SelectedIndexChanged"
                ItemPlaceholderID="taskHolder" DataKeyNames="id">
                
                <LayoutTemplate>
                                <%--<table>
                                    <tr>
                                        <td class="tdlabelg" style="width:70%">Job Title
                                            </td>
                                        <td class="tdlabelg" style="width:30%">Closing Date
                                            </td>
                                    </tr>
                                    </table>  --%>                  
                    <fieldset class="layoutFieldset" >
                        <asp:Panel ID="taskHolder" runat="server">
                        </asp:Panel>
                    </fieldset>
                </LayoutTemplate>
                <ItemTemplate>
                                <table>
                                    <tr > 
                                            <td style="width:70%">
                                               <asp:LinkButton ID="lkTask" runat="server" CommandName="Select">
                                                <asp:Label ID="lblTask" runat="server" Text='<%# Bind("Task") %>'></asp:Label>
                                            </asp:LinkButton>
                                            </td>
                                            <td style="width:30%; text-align:right; color:green; font-size:smaller; padding-bottom:15px;">
                                                <%# DataBinder.Eval(Container.DataItem, "TaskDate", "{0:dd-MMM-yyyy h:mm tt}") %>
                                            </td>
                                        </tr>
                                    </table>
                </ItemTemplate>
            </telerik:RadListView>
        </asp:Panel>
                    </div>
                    <div class="sidebar-title">
                        <h5>
                            <i class="fa fa-minus-square-o"></i>
                            <a href="/Employee/TODO/TodoList.aspx">
                                more
                            </a>
                        </h5>
                    </div>
                    <telerik:RadNotification RenderMode="Lightweight" ID="ntTodo" runat="server" Text="Task(s) date due, Kindly check schedule" Position="Center"
                                                    Animation="Slide" AutoCloseDelay="0" Width="400" Height="150" Title="Due Task(s)" EnableRoundedCorners="true">
                                </telerik:RadNotification>
                    <%--<telerik:RadNotification RenderMode="Lightweight" ID="ntTodo" runat="server" Text="Task(s) date due, Kindly check schedule" Position="Center"
                                                    Animation="Slide"  AutoCloseDelay="2000" Width="400" Height="150" Title="Due Task(s)" EnableRoundedCorners="true"
                        ShowInterval="10000" LoadContentOn="EveryShow" OnCallbackUpdate="ntTodo_CallbackUpdate" >
                                </telerik:RadNotification>--%>
                </div>
            </div>
            </div>

                    </div>
                </div>
            </div>

                </div>
        </div>

    <script type="text/javascript">

        function jobClick()
        {
            __doPostBack('jobClicked', '');
        }

</script> 
</asp:Content>
