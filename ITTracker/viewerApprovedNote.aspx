<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="viewerApprovedNote.aspx.cs" Inherits="ITTacker.viewerApprovedNote" %>

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
    headerLoad(noteid);
    detailsLoad(noteid);
    approversLoad(noteid);
    FooterLoad(noteid);
    imgLoad(noteid);
    var d = new Date();
    document.getElementById("lblDateTime").innerHTML = d;
    document.getElementById("lblUser").innerHTML = $("[id*=hdUserName]").val();
   

    //window.print();
    //window.close();
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
             $('.noteview').append(Result);
            //$('.summernoteview').summernote('code', Result);
}
});
    }
function headerLoad(noteid) {
$.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "Approve2.aspx/getTableData",
        data: "{pageVal:'GetApprovedRDLCheader', pageval1:'" + noteid + "',pageval2:''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            var contentDtl = Result.split('µ');
            
            document.getElementById("lblSubject").innerHTML = contentDtl[1];
            document.getElementById("lblInitiator").innerHTML = contentDtl[2];
            document.getElementById("lblDepartment").innerHTML = contentDtl[4];
            document.getElementById("lblPriority").innerHTML = contentDtl[5];
            document.getElementById("lblCreatedOn").innerHTML = contentDtl[3];
            
}
});
    }

function approversLoad(noteid) {
$.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "Approve2.aspx/getTableData",
        data: "{pageVal:'GetApprovedRDLC', pageval1:'" + noteid + "',pageval2:''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            var valData, valData1;
                    var n = 0;
                    valData = Result.split('Θ');
                    if ($("#tblApprovers tr").length == 0) {
                        $('#tblApprovers').append('<thead style="color: #000;"><tr><th scope="col">Reviewer Name</th><th scope="col">Designation </th><th scope="col">Department</th><th scope="col">Status</th><th scope="col">Updated Date</th><th scope="col">Remarks</th></tr></thead>');
                    }
                    for (j = 0; j < valData.length - 1; j++) {
                        
                        var contentDtl = valData[j].split('µ');
                        $('#tblApprovers').append('<tbody style="color: #000; font-size: 12px;"><tr>' +
                            '<td>' + contentDtl[2] + '</td>' +
                            '<td>' + contentDtl[5] + '</td>' +
                            '<td>' + contentDtl[6] + '</td>' +
                            '<td>' + contentDtl[1] + '</td>' +
                            '<td>' + contentDtl[3] + '</td>' +
                            '<td>' + contentDtl[4] + '</td>' +
                            '</tr> </tbody>');
                    }
}
});
    }

function FooterLoad(noteid) {
$.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "Approve2.aspx/getTableData",
        data: "{pageVal:'GetApprovedRDLCfooter', pageval1:'" + noteid + "',pageval2:''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            var contentDtl = Result.split('µ');
            document.getElementById("lblFinalAppName").innerHTML = contentDtl[2];
            document.getElementById("lblFinalAppDesgn").innerHTML = contentDtl[5];
            document.getElementById("lblFAUpdateDate").innerHTML = contentDtl[3];
           
            document.getElementById("lblFARemarks").innerHTML = "Remarks : " +contentDtl[4];
            document.getElementById("lblStatus").innerHTML = contentDtl[1];
            }
});
    }
function imgLoad(noteid) {
$.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "Approve2.aspx/getTableData",
        data: "{pageVal:'GetNoteStatus', pageval1:'" + noteid + "',pageval2:''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            var contentDtl = Result.split('µ');
            if (contentDtl[0] == 9) {
                $("#imgAppr").attr('src', 'files/img/redrejectedstamp.jpg');
                selectspan = document.getElementById("lblFARemarks");
                selectspan.style.color = "Red";
            }
             if (contentDtl[0] == 0) {                 
                 $("#imgAppr").attr('src', 'files/img/Approved-stamp-png.png');
                  selectspan = document.getElementById("lblFARemarks");
                  selectspan.style.color = "Green";
            }
             if (contentDtl[0] == 7) {                 
                 $("#imgAppr").attr('src', 'files/img/notedlogo.png');
                  selectspan = document.getElementById("lblFARemarks");
                  selectspan.style.color = "Green";
            }
            
}
});
    }
</script>

<style>
#tblFinal td[rowspan] {
            position: relative;
        }

 #tblFinal td[rowspan]:before {
            position: absolute;
            content: "";
            top: -1px;
            left: -1px;
            background-color: transparent;
            border: solid #000 1px;
            width: 100%;
            height: 100%;
        }
/*table{
  table-layout:fixed;
}*/
    @media screen {
        .page-header, .page-header-space {
            height: 21mm;
        }

        .page-header {
            /*display:table;*/
            position: fixed;
            top: 0;
            width: 100%;
            /*border-bottom: 1px solid black;*/ /* for demo */
            background: #fdd935; /* for demo */
        }

        .page-footer, .page-footer-space {
            height: 13mm;
        }

        .page-footer {
            position: fixed;
            bottom: 0;
            width: 100%;
            padding-top: 2mm;
            /*border-top: 1px solid black;*/ /* for demo */
            background: #fdd935; /* for demo */
        }

        a {
            text-decoration: none;
            color: #000 !important;
        }
    }
</style>
<style type="text/css">

@media screen {
/*thead { display: none; }
tfoot { display: none; }*/
@page { margin: 2cm }
.page-body {
  /*display:table;*/
  position: relative;
  top: 21mm;
   left:2cm;
  right:2cm;
  width: 100%;
  page-break-after: always;
  background: #fff !important;
 color: #000 !important;
 font: 13pt Helvetica, "Times New Roman", Times, serif;
}
html, body {
    width: 210mm;
    height: 297mm;
  }
body { 
background: #fff !important;
color: #000 !important;
font: 13pt Helvetica, "Times New Roman", Times, serif;
} 
table tr.page-break{
  page-break-after:always
} 
table.page-break{
  page-break-after:always
}
.table1 {
     border: 1px solid #000 !important
}
}
@page 
    {
        size: auto;   /* auto is the initial value */
        /*margin: 0mm;*/  /* this affects the margin in the printer settings */
        size: 210mm 297mm; 
  /* Chrome sets own margins, we change these printer settings */
  margin: 0mm 16mm 0mm 16mm; 
    }


@media print {
button {display: none;}



 .page-header, .page-header-space {
            height: 21mm;
        }

        .page-header {
          
            top: 0;
            width: 100%;
            /*border-bottom: 1px solid black;*/ /* for demo */
            background: #fdd935; /* for demo */
        }

        .page-footer, .page-footer-space {
            height: 13mm;
        }

        .page-footer {
           
            bottom: 0;
            width: 100%;
            padding-top: 2mm;
            /*border-top: 1px solid black;*/ /* for demo */
            background: #fdd935; /* for demo */
        }

        a {
            text-decoration: none;
            color: #000 !important;
        }


.page-footer {
font-size: 10px;
}


.page-body {
 
  width: 100%;
 font: 13pt Helvetica, "Times New Roman", Times, serif;
 background: #fff !important;
color: #000 !important; 
 page-break-after: always;
}
 @page {
      size: A4;  /*DIN A4 standard, Europe*/      
    }



 
#header-widgets, nav, aside.mashsb-container, 
.sidebar, .mashshare-top, .mashshare-bottom, 
.content-ads, .make-comment, .author-bio, 
.heading, .related-posts, #decomments-form-add-comment, 
#breadcrumbs, #footer, .post-byline, .meta-single, 
.site-title img, .post-tags, .readability 
{
display: none;
}


}
</style>

<style>
button.print-button {
  width: 100px;
  height: 100px;
}
span.print-icon, span.print-icon::before, span.print-icon::after, button.print-button:hover .print-icon::after {
  border: solid 4px #333;
}
span.print-icon::after {
  border-width: 2px;
}

button.print-button {
  position: relative;
  padding: 0;
  border: 0;
  
  border: none;
  background: transparent;
}

span.print-icon, span.print-icon::before, span.print-icon::after, button.print-button:hover .print-icon::after {
  box-sizing: border-box;
  background-color: #fff;
}

span.print-icon {
  position: relative;
  display: inline-block;  
  padding: 0;
  margin-top: 20%;

  width: 60%;
  height: 35%;
  background: #fff;
  border-radius: 20% 20% 0 0;
}

span.print-icon::before {
  content: " ";
  position: absolute;
  bottom: 100%;
  left: 12%;
  right: 12%;
  height: 110%;

  transition: height .2s .15s;
}

span.print-icon::after {
  content: " ";
  position: absolute;
  top: 55%;
  left: 12%;
  right: 12%;
  height: 0%;
  background: #fff;
  background-repeat: no-repeat;
  background-size: 70% 90%;
  background-position: center;
  background-image: linear-gradient(
    to top,
    #fff 0, #fff 14%,
    #333 14%, #333 28%,
    #fff 28%, #fff 42%,
    #333 42%, #333 56%,
    #fff 56%, #fff 70%,
    #333 70%, #333 84%,
    #fff 84%, #fff 100%
  );

  transition: height .2s, border-width 0s .2s, width 0s .2s;
}

button.print-button:hover {
  cursor: pointer;
}

button.print-button:hover .print-icon::before {
  height:0px;
  transition: height .2s;
}
button.print-button:hover .print-icon::after {
  height:120%;
  transition: height .2s .15s, border-width 0s .16s;
}
</style>
</head>
<body >
<form id="form1" runat="server">
<div>
<table>
<thead class="page-header"> 
<tr>
<td ><img src="files/img/manappuram_logo.png" alt="homepage" class="dark-logo" /></td>
<td ><button class="print-button" onClick="window.print()"><span class="print-icon"></span></button></td>
<td ><span id="lblNoteId" class ="head5 text-primary"></span></td>
</tr>
</thead>
<tbody class="page-body">
    
<tr>
<td colspan="3" style="text-align:justify; margin-left:20px;">   
<div class="container">
<div class="row">
<div class="col-md-2" style="text-align:center; border: 1px solid #000;">
 
<div class="form-group"> <br />
<span >Subject</span>
</div>
</div>
<div class="col-md-10" style="border-style: solid;border-color: #000; border-width: 1px 1px 1px 0;">
<div class="form-group"> 
<span id="lblSubject"  class ="head6"></span>
</div>
</div>
</div>
<div class="row">
<div class="col-md-2" style="text-align:center; border-style: solid;border-color: #000; border-width: 0 1px 1px 1px;">
<div class="form-group">Initiator 
</div>
</div>
<div class="col-md-4" style="border-style: solid;border-color: #000; border-width: 0 1px 1px 0;">
<div class="form-group"> 
<span id="lblInitiator" style="font-size: 14px;"></span>
</div>
</div>
<div class="col-md-2" style="text-align:center; border-style: solid;border-color: #000; border-width: 0 1px 1px 0;">
<div class="form-group">Department 
</div>
</div>
<div class="col-md-4" style="border-style: solid;border-color: #000; border-width: 0 1px 1px 0;">
<div class="form-group"> 
<span id="lblDepartment"style="font-size: 14px;"></span>
</div>
</div>
</div>
<div class="row">
<div class="col-md-2" style="text-align:center; border-style: solid;border-color: #000; border-width: 0 1px 1px 1px;">
<div class="form-group">Priority 
</div>
</div>
<div class="col-md-4" style="border-style: solid;border-color: #000; border-width: 0 1px 1px 0;">
<div class="form-group"> 
<span id="lblPriority"style="font-size: 14px;"></span>
</div>
</div>
<div class="col-md-2" style="text-align:center; border-style: solid;border-color: #000; border-width: 0 1px 1px 0;">
<div class="form-group">Created On 
</div>
</div>
<div class="col-md-4" style="border-style: solid;border-color: #000; border-width: 0 1px 1px 0;">
<div class="form-group"> 
<span id="lblCreatedOn"style="font-size: 14px;"></span>
</div>
</div>
</div>
</div>
<div class="noteview" >
</div>
</td>
</tr>
    <tr>
        <td colspan="3">
            <br />
        </td>
    </tr>
<tr  class="page-break">
<td colspan="3">
<div class="row">
<div class="col-md-12" style="text-align: center;">
<div class="form-group"><span style=" text-decoration: underline;" class ="head5">Review Details</span>
</div>
</div>
</div>

<table class="table1 table-bordered" id="tblApprovers" style="border-color: #000 !important;"> 
</table>
</td></tr>
 <tr>
      <td colspan="3">
            <br />
        </td>
    </tr>
<tr class="page-break">
<td colspan="3">

<div class="row">
<div class="col-md-12" style="text-align: center;">
<div class="form-group">
</div>
</div>
</div>

<table id="tblFinal" align="center" style="width: 80%;margin-bottom: 1rem; border-collapse: collapse;">

  <tr>
    <td style="padding: .5rem;vertical-align: middle; border-style: solid;border-color: #000 !important; border-width: 1px 1px 1px 1px; "><span class ="head5">Final Status</span> -  <span id="lblStatus"  class ="head5"></span></td>
    <td colspan="2" style="padding: .5rem;vertical-align: middle; border-style: solid;border-color: #000 !important; border-width: 1px 1px 1px 1px;font-size: 18px; font-weight: bold; font-style:italic;"><span id="lblFARemarks"></span></td>

  </tr>
  <tr>
    <td style="padding: .5rem;vertical-align: middle; border-style: solid;border-color: #000 !important; border-width: 1px 0 1px 1px;">Name</td>
    <td style="padding: .5rem;vertical-align: middle; border-style: solid;border-color: #000 !important; border-width: 1px 0 1px 1px;"><span id="lblFinalAppName" class ="head6"></span></td>
   <td rowspan="3" ><img src="files/img/Approved-stamp-png.png" id="imgAppr"  width="150" height="150"/></td>
  </tr>
  <tr >
    <td style="padding: .5rem;vertical-align: middle; border-style: solid;border-color: #000 !important; border-width: 0 1px 1px 1px;">Designation</td>
    <td style="padding: .5rem;vertical-align: middle; border-style: solid;border-color: #000 !important; border-width: 0 0 1px 0; font-size: 14px;"><span id="lblFinalAppDesgn"></span></td>    
  </tr>
<%--<tr >
    <td style="padding: .5rem;vertical-align: middle; border-style: solid;border-color: #000 !important; border-width: 1px 1px 1px 1px; ">Remarks</td>
    <td style="padding: .5rem;vertical-align: middle; border-style: solid;border-color: #000 !important; border-width: 1px 0 1px 1px;font-size: 18px; font-weight: bold; font-style:italic;"><span id="lblFARemarks"></span></td>
  </tr>--%>
  <tr >
    <td style="padding: .5rem;vertical-align: middle; border-style: solid;border-color: #000 !important; border-width: 1px 1px 1px 1px;">Date</td>
    <td style="padding: .5rem;vertical-align: middle; font-size: 14px;border-style: solid;border-color: #000 !important; border-width: 1px 1px 1px 0;"><span id="lblFAUpdateDate"></span></td>
  </tr>
    <tr >
    <td style="padding: .5rem;vertical-align: middle; border-style: solid;border-color: #000 !important; border-width: 0 0 0 0; color:white;">.</td>
    <td style="padding: .5rem;vertical-align: middle; font-size: 14px; color:white;">.</td>
  </tr>
     <tr >
    <td style="padding: .5rem;vertical-align: middle; border-style: solid;border-color: #000 !important; border-width: 0 0 0 0; color:white;">.</td>
    <td style="padding: .5rem;vertical-align: middle; font-size: 14px; color:white;">.</td>
  </tr>
</table>


</td>
</tr>
</tbody>
<tfoot class="page-footer">
<tr>
<td colspan="3">Confidential Information- Do not distribute<br />Generated By <span id="lblUser" class ="font-normal"></span> on <span id="lblDateTime"></span>
</td>
</tr>
</tfoot>
</table>
</div>
 <input id="hdUserName" type="hidden" runat="server"/> </form>
    
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
