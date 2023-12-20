<%@ Page Title="" Language="C#" MasterPageFile="~/PWA_Master.Master" AutoEventWireup="true" CodeBehind="AddRequest.aspx.cs" Inherits="ITTracker.Request.AddRequest" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <div class="row">
<div class="col-12">
<div class="card card-5 rightmarg"> 
<form class="form-horizontal" runat="server" method="post" enctype="multipart/form-data">    
<div class="card-body">
<div class="row">
<div class="col-md-2">
<div class="form-group">
<label for="ddlFirm">Firm : <span class="text-danger">*</span></label>
<%--<select class="custom-select form-control" id="ddlFirm" onchange="FillFirm()" name="Firm">
</select> --%> 
<div class="div-select-dark">
  <select class="select-dark" name="Firm" id="ddlFirm">
    <%--<option selected disabled> Choose Firm</option>--%>
  </select>
</div>
</div>
</div></div>
</div></form></div>
</div></div>

</asp:Content>
