<%@ Page Title="" Language="C#" MasterPageFile="~/PWA_Master.Master" AutoEventWireup="true" CodeBehind="CRBApproval.aspx.cs" Inherits="ITTracker.CRBApproval" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="js/CRBApproval.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="card card-5 rightmarg">
        <form class="form-inline" runat="server" method="post" enctype="multipart/form-data">
            <div class="card-body">

                <div class="row">
                    <div id="div1" class="form-group col-md-12  padding-bottom-10px" style="color: black;">

                        <div class="table-responsive" style="overflow-x: auto;">
                            <table class="table1 table-hover table-responsive-md" id="tableData">
                            </table>
                        </div>


                        <%--table--%>
                    </div>
                </div>
                <div class="row" id="showSubmitBtn">
                    <div class="col-md-2 col-sm-2 col-xs-4" id="recommend1">
                        <a href="#" class="btn btn-sm animated-button thar-one btn-primary" style="width: 100%; margin: 5px; display: none;"
                            onclick="return Recommend();" id="recommend"><i class="fa fa-thumbs-up"></i>RECOMMEND</a>
                    </div>
                    <div class="col-md-2 col-sm-2 col-xs-4" id="approve1">
                        <a href="#" class="btn btn-sm animated-button thar-one btn-primary" style="width: 100%; margin: 5px;"
                            onclick="return Approve();" id="approve"><i class="fa fa-thumbs-up"></i>APPROVE</a>
                    </div>
                    <div class="col-md-2 col-sm-2 col-xs-4">
                        <a href="#" class="btn btn-sm animated-button thar-one btn-red" style="width: 100%; margin: 5px;"
                            onclick="return frmExit();"><i class="fa fa-sign-out-alt"></i>Exit</a>
                    </div>

                </div>
            </div>
        </form>
    </div>
    <input id="hdUserId" type="hidden" runat="server" />
    <input id="hdBranchId" type="hidden" runat="server" />
    <input id="hdFirmId" type="hidden" runat="server" />
    <input id="hdAct" type="hidden" runat="server" />
    <input id="hdData" type="hidden" runat="server" />
    <input id="hdnSystemIP" type="hidden" runat="server" />
    <input id="hdSesssion" type="hidden" runat="server" />
    
</asp:Content>
