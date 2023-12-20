<%@ Page Title="" Language="C#" MasterPageFile="~/PWA_Master.Master" AutoEventWireup="true" CodeBehind="crbrequest.aspx.cs" Inherits="ITTracker.crbrequest" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="js/crbrqst.js" + "new Date().getTime()"></script>
    <style>
        tr:nth-child(even) {
            background-color: #dddddd;
        }



        @media only screen and (max-width: 760px), (min-device-width: 768px) and (max-device-width: 1024px) {

            /* Force table to not be like tables anymore */
            table, thead, tbody, th, td, tr {
                display: block;
            }

                /* Hide table headers (but not display: none;, for accessibility) */
                thead tr {
                    position: absolute;
                    top: -9999px;
                    left: -9999px;
                }

            tr {
                margin: 0 0 1rem 0;
            }

                tr:nth-child(odd) {
                    background: #ccc;
                }

            td {
                /* Behave  like a "row" */
                border: none;
                border-bottom: 1px solid #eee;
                position: relative;
                padding-left: 50%;
            }

                td:before {
                    /* Now like a table header */
                    position: absolute;
                    /* Top/left values mimic padding */
                    top: 0;
                    left: 6px;
                    width: 45%;
                    padding-right: 10px;
                    white-space: nowrap;
                }
        }
       
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="card card-5 rightmarg">
        <form class="form-inline" runat="server" method="post" enctype="multipart/form-data">
            <div class="card-body">

                <div class="row">
                    <div id="div1" class="form-group col-md-12  padding-bottom-10px" style="color: black;">

                        <div class="table-responsive" style="overflow-x:auto;">
                                    <table class="table1 table-hover table-responsive-md" id="tableData">
                                    </table>
                                </div>

                       
                        <%--table--%>
                    </div>
                </div>

                <div class="row" id="showSubmitBtn">
                    <div class="col-md-2 col-sm-2 col-xs-4">
                        <a href="#" class="btn btn-sm animated-button thar-one btn-primary" 
                            onclick="return confirmdata();" id="btnSubmit"><i class="fa fa-thumbs-up"></i>Confirm</a>
                    </div>
                    <div class="col-md-2 col-sm-2 col-xs-4">
                        <a href="#" class="btn btn-sm animated-button thar-one btn-red" 
                            onclick="return Exit();"><i class="fa fa-sign-out-alt"></i>Exit</a>
                    </div>

                </div>
            </div>
        </form>
    </div>

    <input id="hdPag" type="hidden" runat="server" />
    <input id="hdData" type="hidden" runat="server" />
    <input id="hdDtl" type="hidden" runat="server" />
    <input id="HdVend" type="hidden" runat="server" />
    <input id="hdUserId" type="hidden" runat="server" />
    <input id="hdBchId" type="hidden" runat="server" />
    <input id="hdAct" type="hidden" runat="server" />
    <input id="hdEmpCode" type="hidden" runat="server" />
</asp:Content>
