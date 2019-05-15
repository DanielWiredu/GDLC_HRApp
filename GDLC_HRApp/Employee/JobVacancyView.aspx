<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="JobVacancyView.aspx.cs" Inherits="GDLC_HRApp.Employee.JobVacancyView" %>

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
                        
                                         
                        <div class="row">
                           <p style="text-align:right"><a href="/Dashboard.aspx" class="btn btn-warning"> Return</a></p> 

                            <p class="titles">Job Tile : </p>
                            <div runat="server" id="dvJobTitle" class="dbValues">

                            </div>
                            <hr />

                            <p class="titles">Closing Date : </p>
                            <div runat="server" id="dvClosingDate" class="dbValues">

                            </div>
                            <hr />
                            
                            <p class="titles">Position : </p>
                            <div runat="server" id="dvPosition" class="dbValues">

                            </div>
                            <hr />
                            
                            <p class="titles">Job Qualification : </p>
                            <div runat="server" id="dvJobQualification" class="dbValues">

                            </div>
                            <hr />

                            <p class="titles">Job Description : </p>
                            <div runat="server" id="dvJobDescription" class="dbValues">

                            </div>
                            <hr />

                        </div>
                    </div>
                </div>
            </div>

                </div>
        </div>
</asp:Content>
