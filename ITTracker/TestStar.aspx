<%@ Page Title="" Language="C#" MasterPageFile="~/PWA_Master.Master" AutoEventWireup="true" CodeBehind="TestStar.aspx.cs" Inherits="ITTracker.TestStar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
       
    <link href="css/teststar.css" rel="stylesheet" />
    <script src="js/teststar.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  

<div class="rating left">Rate
  <div class="stars right">
    <a class="star"></a>    <a class="star"></a>    <a class="star"></a>    <a class="star"></a>    <a class="star"></a>
  </div>
</div>
</asp:Content>