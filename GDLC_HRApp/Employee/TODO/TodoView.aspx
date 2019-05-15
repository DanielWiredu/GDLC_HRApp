<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="TodoView.aspx.cs" Inherits="GDLC_HRApp.Employee.TODO.TodoView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <style type="text/css">
        .titles{
            padding-bottom: 2px;
            padding-left: 5px; 
            text-align: left;
            /*border-bottom:2px;*/
            font-weight:bold;
        }
        .dbValues{
            padding-left: 10px;
            text-align: left;
            /*border-bottom:2px;*/
            /*font-weight:bold;*/
        }
    </style>
    <div class="wrapper wrapper-content animated fadeInRight">
            <div class="row">
            <div class="col-lg-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-content">
                       <%--<p>Job Vacancy View</p>--%>                             
                        
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                                 <div class="row">
                            <a href="/Dashboard.aspx" class="btn btn-warning pull-right"> Return</a>
                            <asp:Button runat="server" ID="btnComplete" Text="Complete" CssClass="btn btn-primary" OnClick="btnComplete_Click"></asp:Button>
                        </div>

                        <hr />

                                <div class="row">
                           
                            <p class="titles">Task Date : </p>
                            <div runat="server" id="dvTaskDate" class="dbValues">

                            </div>
                            <hr />
                            
                            <p class="titles">Task : </p>
                            <div runat="server" id="dvTask" class="dbValues">

                            </div>
                            <hr />
                            
                            <p class="titles">Status : </p>
                            <div runat="server" id="dvStatus" class="dbValues">

                            </div>
                            <hr />

                        </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>                 
                        
                    </div>
                </div>
            </div>

                </div>
        </div>
</asp:Content>
