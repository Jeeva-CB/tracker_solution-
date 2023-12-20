<%@ Page Title="" Language="C#" MasterPageFile="~/PWA_Master.Master" AutoEventWireup="true" CodeBehind="FileDownloader.aspx.cs" Inherits="ITTacker.FileDownloader" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

<style>
  * {
  font-family: arial;
}

#doc {
  width: 300px;
  height: 400px;
}

.file-list {
  /*color: BLACK;
  text-decoration: NONE;*/
   color: BLUE;
  text-decoration: UNDERLINE;
  font-size: 20px;
  font-family: times;
}

.file-list:hover {
  color: BLUE;
  text-decoration: UNDERLINE;
  font-size: 25px;
  font-family: times;
}


</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<%--<input type="file" id="fileinput" />
<p>
  <a id="download" class="file-list"></a>
</p>--%>
<div class="table-responsive">
<table class="table1 table-hover" id="tblFiles" > 
</table> 
</div>
     <!-- partial -->
    <script src="js/downloadscript.js"></script>
</asp:Content>
