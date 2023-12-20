<%@ Page Language="C#" AutoEventWireup="true" enableEventValidation ="false" CodeBehind="ViewerNoteContent.aspx.cs" Inherits="ITTacker.ViewerNoteContent" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<!-- Tell the browser to be responsive to screen width -->
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0" />
  
<title>Note Content Viewer</title>
<style type="text/css" media="print">
    @page 
    {
        size: auto;   /* auto is the initial value */
        margin: 0mm;  /* this affects the margin in the printer settings */
    }
     
</style>
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
    <script src="js/compare.js"></script>
<script>
$(window).on('load', function () {
    let querystring = window.location.search.substring(1);
    let searchKey = Decrypt(querystring.split("=")[1]); 
    let noteid = searchKey.split("~")[0];    
     let editOption = searchKey.split("~")[1];     
  
    $("#btn_Save").hide();
   
    if (editOption == "0" || searchKey.split("~").length <= 1) {         
         $("#btn_Edit").hide();        
    }
    else
    {
        $("#btn_Edit").show();
    }

    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "Approve2.aspx/getEditedContent",
        data: "{noteid:'" + noteid + "'}",
        dataType: "json",
        async:false,
        success: function (Result) {
            Result = Result.d;            
            $("#hdEditedContent").val(Result.toString());           
            }
    });

      detailLoad(noteid, $("#hdEditedContent").val());
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
        height: 350, // set editor height
        minHeight: null, // set minimum height of editor
        maxHeight: null, // set maximum height of editor
        focus: false, // set focus to editable area after initializing summernote
        toolbar: [  ]
     });
       $(".summernoteview").summernote("disable");
     $("#summernoteview").summernote("fullscreen.toggle");




       $(".note-editable").on("keypress", function () {

       
    });
    });

    
   

    function detailLoad(noteid, notecontent) {       
        $("#hdNoteId").val(noteid);  
         $('.summernoteview').summernote({
        airMode: true,
        height: 350, // set editor height
        minHeight: null, // set minimum height of editor
        maxHeight: null, // set maximum height of editor
        focus: false, // set focus to editable area after initializing summernote
        toolbar: [  ]
     });
        $(".summernoteview").summernote("disable");       
      $("#summernoteview").summernote("fullscreen.toggle");      

            $.ajax({
                type: "post",
                contentType: "application/json; charset=utf-8",
                url: "NoteContentViewer.aspx/getRequestNote",
                data: "{pageVal:'GetRequestNotes', pageval1:'" + noteid + "',pageval2:''}",
                dataType: "json",
                async:false,
                success: function (Result) {
                    //alert(Result.d);
                    Result = Result.d;
                    $("#hdOldContent").val(Result);
                }
        });
        if (notecontent == 'NODATA' || notecontent == '') {
             $('.summernoteview').summernote('code', $("#hdOldContent").val());
        }
        else {
            $('.summernoteview').summernote('code', $("#hdEditedContent").val());
    
        }
    }

    
    function EditContent() {     
        $("#btn_Save").show(); 
      
        $(".summernoteview").summernote("enable");      
    
        $("#summernoteview").summernote("fullscreen.toggle");
        // $('.note-editable').css('font-weight','800');
        $('#summernote').summernote('underline');

      
    }

  

    function SaveContent() {
        var markup = $('.summernoteview').summernote('code').toString();  
       
        var y = $("#hdOldContent").val();
         
        var markup = htmldiff(y, markup); 
           
        markup = markup.replace(/\\/g, '\\\\').replace(/[“”‘’']/g, '\\\'');

        $("#hdEditedContent").val($("#hdNoteId").val()+"~"+ markup);
      
        $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "Approve2.aspx/setEditedContent",
        data: "{content:'" + $("#hdEditedContent").val() + "'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d; 
}
        });
       
        window.close();
    }
    function printing() {
        var x = document.getElementById("myDIV");
         x.style.display = "none";
        window.print();
        //printDiv()
         x.style.display = "block";
        
    }
function printDiv() {
  let mywindow = window.open('', 'PRINT', 'height=650,width=900,top=100,left=150');
      
  mywindow.document.write(document.getElementById("print").innerHTML);

  mywindow.document.close(); // necessary for IE >= 10
  mywindow.focus(); // necessary for IE >= 10*/

  mywindow.print();
  mywindow.close();

  return true;
}
</script>
</head>
<body>
  <%--  <div id="myDIV"><button onclick="printing()">Print</button></div>--%>
     
    <form id="form1" runat="server">
<div style="margin: 30px;">
     <div class="summernoteview" >
</div>
    <div>
      <button id="btn_Edit" type="button" class="btn btn-outline-primary btn-rounded font-10" onclick="EditContent();" ><i class="fa fa-file-alt"></i> Edit Content</button>
        <button type="button" id="btn_Save" class="btn btn-outline-primary btn-rounded font-10" onclick="SaveContent();" ><i class="fa fa-file-alt"></i> Confirm</button>
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
<input id="hdEditedContent" type="hidden" runat="server"/>
    <input id="hdOldContent" type="hidden" runat="server"/>
    <input id="hdNoteId" type="hidden" runat="server"/>
</body>
</html>
