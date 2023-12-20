<%@ Page Language="C#" enableEventValidation ="false" AutoEventWireup="true" CodeBehind="ApprovedNote.aspx.cs" Inherits="ITTacker.ApprovedNote" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <!-- Tell the browser to be responsive to screen width -->
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0" />
    
<title>Approval Note</title>
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
    let querystring = window.location.search.substring(1);
    let searchKey = Decrypt(querystring.split("=")[1]); 
    let noteid = searchKey;
    document.getElementById("lblNoteId").innerHTML = noteid;
    detailsLoad(noteid);
});
function Decrypt(value)
{
  var result="";
  var array = value.split("-");
  for(i=0;i<array.length;i++)
  {
    result+=String.fromCharCode(array[i]-10);
  }
  return result;
} 

 $(document).ready(function () {  
     $('.summernoteview').summernote({
        airMode: true,
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
    function printing() {
        var x = document.getElementById("myDIV");
         x.style.display = "none";
        window.print();
        //printDiv()
         x.style.display = "block";
        
    }
</script>

<style>

.page-header, .page-header-space {
  height: 21mm;
}

.page-footer, .page-footer-space {
  height: 13mm;

}

.page-footer {
  position: fixed;
  bottom: 0;
  width: 100%;
  border-top: 1px solid black; /* for demo */
  /*background: yellow;*/ /* for demo */
}

.page-header {
  position: fixed;
  top: 0mm;
  width: 100%;
  border-bottom: 1px solid black; /* for demo */
  /*background: yellow;*/ /* for demo */
}

/*@page {
  margin: 20mm
}*/

@media print {
       @page {
      size: A4; /* DIN A4 standard, Europe */
      margin:0;
    }
   thead {display: table-header-group;} 
   tfoot {display: table-footer-group;}
   
   button {display: none;}
   body { 
	background: white; 
} 

   html, body {
        width: 210mm;
        /* height: 297mm; */
        height: 282mm;
        font-size: 11px;
        background: #FFF;
        overflow:visible;
    }
    /*body {
        padding-top:15mm;
    }*/
   body {margin: 0;page-break-after: always;}
}
 @page 
    {
        size: auto;   /* auto is the initial value */
        /*margin: 0mm;*/  /* this affects the margin in the printer settings */
        size: 210mm 297mm; 
  /* Chrome sets own margins, we change these printer settings */
  margin: 0mm 16mm 0mm 16mm; 
    }

</style>
</head>
<body>

    <form id="form1" runat="server">
        <div class="Section1">
     <div class="page-header" style="text-align: center">
     <div class="row h-25 pt-4">
  <div class="col-md-2 text-center"><img src="files/img/manappuram_logo.png" alt="homepage" class="dark-logo" /></div>
  <div class="col-md-6 text-center">
    <button type="button" onClick="window.print()" style="background: pink">
      PRINT ME!
    </button></div>
  <div class="col-md-4 text-left"><span id="lblNoteId" class ="head4 text-primary"></span></div>
</div> 
   
  </div>

  <div style="position: relative; top: 21mm; bottom :13mm">
     <div class="summernoteview" >
</div>

</div>
  <div class="page-footer">
    I'm The Footer
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
