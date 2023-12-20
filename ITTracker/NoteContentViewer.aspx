<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NoteContentViewer.aspx.cs" Inherits="ITTacker.NoteContentViewer" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <!-- Tell the browser to be responsive to screen width -->
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0" />
    
<title>Note Content Viewer</title>
<link href="css/style.min.css" rel="stylesheet"/>
    <link href="css/c3.min.css" rel="stylesheet"/>
    <link href="css/jquery-jvectormap-2.0.2.css" rel="stylesheet" />
    <link href="css/jquery-ui.css" rel="stylesheet" />
    <link href="css/morris.css" rel="stylesheet"/>
<link rel="stylesheet" type="text/css" href="css/summernote-bs4.css"/>
 <script src="js/angular.min.js"></script>
     <script src ="js/jquery-latest.js"></script> 
    <script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="js/jquery-ui-1.10.2.custom.min.js"></script>  
    <script src="js/jquery.min.js"></script> 
    <script src="js/jquery-ui.js"></script>  
     <script src="js/xlsx.core.min.js"></script>
    <script src="js/xls.core.min.js"></script>
    <script src="js/raphael.min.js"></script>
    <script src="js/morris.min.js"></script>
<script src="js/summernote-bs4.min.js"></script>
<script>
$(window).on('load', function () {
    var noteid = getUrlParameter('noteid');
    detailsLoad(noteid);
});

 $(document).ready(function () {  
        $('.summernoteview').summernote({
       // height: 350, // set editor height
        minHeight: null, // set minimum height of editor
        maxHeight: null, // set maximum height of editor
        focus: false, // set focus to editable area after initializing summernote
        toolbar: [
        ]
    });
    $(".summernoteview").summernote("disable");
    $("#summernoteview").summernote("fullscreen.toggle");
});

function getUrlParameter(name) {
    name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
    var regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
    var results = regex.exec(location.search);
    return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
    };

function detailsLoad(noteid) {
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "NoteContentViewer.aspx/getRequestNote",
        data: "{pageVal:'GetRequestNotes', pageval1:'" + noteid + "',pageval2:''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            $('.summernoteview').summernote('code', Result);
        }
    });
}
</script>
</head>
<body>
    <form id="form1" runat="server">
<div>
<div class="summernoteview">
</div>
</div>
        
    </form>
 <!-- Bootstrap tether Core JavaScript -->
     <script src="js/popper.min.js"></script> 
     <script src="js/bootstrap.min.js"></script> 
    <!-- apps -->
     <script src="js/app.min.js"></script> 
     <script src="js/app.init.light-sidebar.js"></script> 
    <!-- Theme settings -->
     <script src="js/app-style-switcher.js"></script> 
    <!-- slimscrollbar scrollbar JavaScript -->
     <script src="js/perfect-scrollbar.jquery.min.js"></script> 
     <script src="js/sparkline.js"></script> 
    <!--Wave Effects -->
     <script src="js/waves.js"></script> 
    <!--Menu sidebar -->
     <script src="js/sidebarmenu.js"></script> 
    <!--Custom JavaScript -->
     <script src="js/custom.min.js"></script> 
    <!--This page JavaScript -->
     <script src="js/d3.min.js"></script> 
     <script src="js/c3.min.js"></script> 
     <script src="js/Chart.min.js"></script> 
     <script src="js/gauge.min.js"></script> 
     <script src="js/excanvas.min.js"></script> 
     <script src="js/jquery.flot.js"></script> 
     <script src="js/jquery.flot.tooltip.min.js"></script> 
     <script src="js/jquery-jvectormap-2.0.2.min.js"></script> 
     <script src="js/jquery-jvectormap-world-mill-en.js"></script> 
     <script src="js/dashboard2.js"></script> 
    <script src="js/echarts/echarts-en.min.js"></script>
       <script src="js/select2.full.min.js"></script>
    <script src="js/select2.min.js"></script>
    <script src="js/select2.init.js"></script>
</body>
</html>
