<%@ Page Title="" Language="C#" MasterPageFile="~/PWA_Master.Master" AutoEventWireup="true" CodeBehind="ApprovalDetails.aspx.cs" Inherits="ITTacker.ApprovalDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <script src="js/ApprovalDetails.js"></script>
    <script>

    /************************************/
    //inline-editor
    /************************************/
    $('.inline-editor').summernote({
        airMode: true
    });  

    /************************************/
    //airmode editor
    /************************************/
    $('.airmode-summer').summernote({
        airMode: true
        });

    
    </script>
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

<div class="summernoteview">
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
