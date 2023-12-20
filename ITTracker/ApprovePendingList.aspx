<%@ Page Title="" Language="C#" MasterPageFile="~/PWA_Master.Master" AutoEventWireup="true" CodeBehind="ApprovePendingList.aspx.cs" Inherits="ITTacker.ApprovePendingList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="js/approvependinglist.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="row">
<div class="col-12">
<div class="card card-5 rightmarg"> 
<form class="form-horizontal" runat="server">    
<div class="card-body">
<div class="row">
<div class="col-md-12">
<div class="form-group">
<div class="table-responsive">
<table class="table table-hover table-success" id="tblPendingList" > 
<thead class="bg-success text-white">
<tr >                                 
</tr> 
</thead> 
<tbody class="border border-dark"></tbody>
</table> 
</div>
</div>
</div>
</div>
</div>
</form>      
</div>
</div>
</div>

<input id="hdUserId" type="hidden" runat="server"/>
        <input id="hdBranchId" type="hidden" runat="server"/>
        <input id="hdFirmId" type="hidden" runat="server"/>
</asp:Content>
