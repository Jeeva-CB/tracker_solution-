<%@ Page Title="" Language="C#" MasterPageFile="~/PWA_Master.Master" AutoEventWireup="true" CodeBehind="NoteSearchReport.aspx.cs" Inherits="ITTacker.NoteSearchReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%--<link href="css/dataTables.bootstrap.css" rel="stylesheet" />--%>
     <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.23/css/jquery.dataTables.css">
    <script src="js/datatable.js"></script>

<style>
    .select2-container--default .select2-selection--multiple .select2-selection__choice {
    background-color: #2962ff !important;
    padding: 0px 12px !important;
    color:#ffffff !important;
}

        .select2-container .select2-selection--multiple {
    box-sizing: border-box;
    cursor: pointer;
    display: table !important;
    min-height: auto;
    user-select: none;
    -webkit-user-select: none;
    min-width: 100% !important;
}
</style>

<script>
    $(window).on('load', function () {
    ModalLoad();
    let querystring = window.location.search.substring(1);
    //alert(querystring.split("=")[1])
    //alert(Decrypt(querystring.split("=")[1]))
    let searchKey = Decrypt(querystring.split("=")[1]);
    //alert(searchKey);
     $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "NoteSearchReport.aspx/GetReportDtls",
        data: "{pageVal:'GetSearchReport', pageval1 :'" + searchKey +"', pageval2 :'" + $("[id*=hdUserId]").val() +"'}",
        dataType: "json",
         success: function (Result) {
            if (Result.d == '') {
                $('#rptReportDiv').hide();
                $('#rptEmptyDiv').show();
            }
            else {
                $('#rptReportDiv').show();
                $('#rptEmptyDiv').hide();
                Result = Result.d;  
                fillTable(Result);
            }           
        }
    });

    });

    function Getstatus() {
    
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "NoteSearchReport.aspx/getFillData",
        data: "{pageVal:'GetStatusFill', pageval1 :'', pageval2 :''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            $('#ddlStatus').append($("<option></option>").val("-1").html("Choose Status"));
            $.each(Result, function (key, value) {
                $('#ddlStatus').append($("<option></option>").val(value.id).html(value.name));
            });
        }
    });
}
function GetTechnology() {

    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "NoteSearchReport.aspx/getFillData",
        data: "{pageVal:'GetTechnology', pageval1 :'', pageval2 :''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            $('#ddlTech').append($("<option></option>").val("-1").html("Choose Technology"));
            $.each(Result, function (key, value) {
                $('#ddlTech').append($("<option></option>").val(value.id).html(value.name));
            });
        }
    });
}
function GetTechLead() {

    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "NoteSearchReport.aspx/getFillData",
        data: "{pageVal:'GetTechLead', pageval1 :'', pageval2 :''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            $('#ddlTLead').append($("<option></option>").val("-1").html("Choose TechLead"));
            $.each(Result, function (key, value) {
                $('#ddlTLead').append($("<option></option>").val(value.id).html(value.name));
            });
        }
    });
}
function GetDeveloper() {

    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "NoteSearchReport.aspx/getFillData",
        data: "{pageVal:'GetDeveloper', pageval1 :'', pageval2 :''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            $('#ddlDevlp').append($("<option></option>").val("-1").html("Choose Developer"));
            $.each(Result, function (key, value) {
                $('#ddlDevlp').append($("<option></option>").val(value.id).html(value.name));
            });
        }
    });
}

    function getDepartment() {

    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "NoteSearchReport.aspx/getFillData",
        data: "{pageVal:'getDepartment', pageval1 :'', pageval2 :''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            $('#ddlDept').append($("<option></option>").val("-1").html("Choose Department"));
            $.each(Result, function (key, value) {
                $('#ddlDept').append($("<option></option>").val(value.id).html(value.name));
            });
        }
    });
    }
    function getUser() {

    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "NoteSearchReport.aspx/getFillData",
        data: "{pageVal:'getUser', pageval1 :'', pageval2 :''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            $('#ddlUser').append($("<option></option>").val("-1").html("Choose User"));
            $.each(Result, function (key, value) {
                $('#ddlUser').append($("<option></option>").val(value.id).html(value.name));
            });
        }
    });
    }
    function ModalLoad() {
    //$('#tblSearchRpt').DataTable();
    Getstatus();
    GetTechnology();
    GetTechLead();
    GetDeveloper();
    getDepartment();
    getUser();
     $("#txtfrmDate").datepicker({
        dateFormat: 'dd/MM/yy',
        changeMonth: true,
        changeYear: true,
        stepMonths: true,
        todayHighlight: true,
        onSelect: function (dateText, inst) {
        }

    });
    $("#txttoDate").datepicker({
        dateFormat: 'dd/MM/yy',
        changeMonth: true,
        changeYear: true,
        stepMonths: true,
        todayHighlight: true,
        onSelect: function (dateText, inst) {
        }

    });
    }

function fillTable(data) {
    var valData, valData1, valPriorityId, valPriority, valNatureId, valNature,barStatus,valPrintCopy,valAttach;
    var n = 0;
    valData = data.split('Θ');
    if (valData.length > 0) {
        
         $('#rptReportDiv').show();
         $('#rptEmptyDiv').hide();
         $("#example").empty();
        if ($("#example tr").length == 0) {
            //$("#example").append('<thead class="bg-success text-white">< tr ><th scope="col">NoteId</th><th scope="col">Firm</th><th scope="col">Department</th><th scope="col">NoteType</th><th scope="col">Subject</th><th scope="col">Nature</th><th scope="col">Priority</th><th scope="col">Circular</th><th scope="col">Status</th><th scope="col">WorkFlow</th><th scope="col">CreatedBy</th><th scope="col">CreatedDate</th><th scope="col">Content</th><th scope="col">Attachements</th><th scope="col">Approval/Rejected Copy</th></tr ></thead><tbody>'
            //$("#example").append('<thead class="bg-success text-white">< tr ><th scope="col" stlye="display:none">Note</th><th scope="col">NoteId</th><th scope="col">Firm</th><th scope="col">Department</th><th scope="col">NoteType</th><th scope="col">Subject</th><th scope="col">Priority</th><th scope="col">Status</th><th scope="col">WorkFlow</th><th scope="col">Content</th><th scope="col">Attachements</th><th scope="col">CreatedBy</th><th scope="col">CreatedDate</th></tr ></thead><tbody>'
            $("#example").append('<thead class="bg-success text-white">< tr ><th scope="col">NoteId</th><th scope="col">Department</th><th scope="col">Subject</th><th scope="col">Priority</th><th scope="col">Status</th><th scope="col">WorkFlow</th><th scope="col">Content</th><th scope="col">Attachements</th><th scope="col">CreatedBy</th><th scope="col">CreatedDate</th></tr ></thead><tbody>'

            );
        }
        for (i = 0; i < valData.length - 1; i++) {
            var valStatusData;
            valData1 = valData[i].split('µ');
            valNatureId = valData1[5];
            valPriorityId = valData1[6];
            if (valNatureId == 1) { valNature = "<i class='fa fa-circle' style='color:#FF0000; font-size: 10px; padding-right: 2px;'></i>" }
            else { valNature = "<i class='fa fa-circle' style='color:#fdee30; font-size: 10px; padding-right: 2px;'></i>" }

            if (valPriorityId == 1) { valPriority = "<i class='fa fa-circle' style='color:#FF0000; font-size: 10px; padding-right: 2px;'></i>" }
            else if (valPriorityId == 2) { valPriority = "<i class='fa fa-circle' style='color:#fb8c00; font-size: 10px; padding-right: 2px;'></i>" }
            else if (valPriorityId == 3) { valPriority = "<i class='fa fa-circle' style='color:#fdee30; font-size: 10px; padding-right: 2px;'></i>" }
            valStatusData = valData1[11].split('¥');
            if (valStatusData.length > 0) {
                barStatus = "";
                for (k = 0; k < valStatusData.length; k++) {
                    var valStatus;                    
                    valStatus = valStatusData[k].split('±');
                    if (valStatus[2] == 0) {
                        barStatus = barStatus + "<i class='fa fa-square' style='color:#A0D468; font-size: 13px; padding-right: 2px;' data-toggle='tooltip' title='created by " + valStatus[1] + "'></i>"
                     
                       }
                    else if (valStatus[2] == 1) {
                            barStatus = barStatus + "<i class='fa fa-square' style='color:#7460ee; font-size: 13px; padding-right: 2px;' data-toggle='tooltip' title='Recommended by "+ valStatus[1] +"'></i>"
                        }
                    else if (valStatus[2] == 2) {
                            barStatus = barStatus + "<i class='fa fa-square' style='color:#EC87C0; font-size: 13px; padding-right: 2px;' data-toggle='tooltip' title='PMO Verified by "+ valStatus[1] +"'></i>"
                        }
                    else if (valStatus[2] == 3) {
                            barStatus = barStatus + "<i class='fa fa-square' style='color:#FF0000; font-size: 13px; padding-right: 2px;' data-toggle='tooltip' title='TA completed by "+ valStatus[1] +"'></i>"
                    }
                    else if (valStatus[2] == 4) {
                            barStatus = barStatus + "<i class='fa fa-square' style='color:#00bfff; font-size: 13px; padding-right: 2px;' data-toggle='tooltip' title='Developed by "+ valStatus[1] +"'></i>"
                    }
                    else if (valStatus[2] == 5) {
                            barStatus = barStatus + "<i class='fa fa-square' style='color:#00bfff; font-size: 13px; padding-right: 2px;' data-toggle='tooltip' title='Developed by "+ valStatus[1] +"'></i>"
                    }
                    else if (valStatus[2] == 6) {
                            barStatus = barStatus + "<i class='fa fa-square' style='color:#0c5b61; font-size: 13px; padding-right: 2px;' data-toggle='tooltip' title='Test Assigned by "+ valStatus[1] +"'></i>"
                    }
                    else if (valStatus[2] == 7) {
                            barStatus = barStatus + "<i class='fa fa-square' style='color:#FFA500; font-size: 13px; padding-right: 2px;' data-toggle='tooltip' title='Tested by "+ valStatus[1] +"'></i>"
                    }
                    else if (valStatus[2] == 8) {
                            barStatus = barStatus + "<i class='fa fa-square' style='color:#1a3300; font-size: 13px; padding-right: 2px;' data-toggle='tooltip' title='Test Reuslt by "+ valStatus[1] +"'></i>"
                    }
                    else if (valStatus[2] == 9) {
                            barStatus = barStatus + "<i class='fa fa-square' style='color:#0d00ff; font-size: 13px; padding-right: 2px;' data-toggle='tooltip' title='PRE UAT BY "+ valStatus[1] +"'></i>"
                    }
                    else if (valStatus[2] == 10) {
                            barStatus = barStatus + "<i class='fa fa-square' style='color:#7d0045; font-size: 13px; padding-right: 2px;' data-toggle='tooltip' title='CRB Request BY "+ valStatus[1] +"'></i>"
                    }
                    else if (valStatus[2] == 11) {
                            barStatus = barStatus + "<i class='fa fa-square' style='color:#800801; font-size: 13px; padding-right: 2px;' data-toggle='tooltip' title='CRB Approved BY "+ valStatus[1] +"'></i>"
                    }
                    else if (valStatus[2] == 12) {
                            barStatus = barStatus + "<i class='fa fa-square' style='color:#03543d; font-size: 13px; padding-right: 2px;' data-toggle='tooltip' title='User Feedback BY "+ valStatus[1] +"'></i>"
                    }
                }
            }
            if (valData1[8]== "Approved") {
                valPrintCopy = '<a href="#" onclick="openApproval(\'' + valData1[0] + '\'); return false"><i class="fa fa-download"></i></a>'
            }
            else if (valData1[8] == "Rejected") {
                valPrintCopy = '<a href="#" onclick="openApproval(\'' + valData1[0] + '\'); return false"><i class="fa fa-download"></i></a>'
            }
            else if (valData1[8] == "Noted") {
                valPrintCopy = '<a href="#" onclick="openApproval(\'' + valData1[0] + '\'); return false"><i class="fa fa-download"></i></a>'
            }
            else {
                valPrintCopy=""
            }
            if (valData1[12] == "0") {
                valAttach=""                
            }
            else {
               valAttach = '<a href="#" onclick="openAttach(\'' + valData1[0] + '\'); return false"><i class="fa fa-paperclip"></i></a>'
            }
            $('#example').append('<tr style="cursor:pointer;">' +                
                '<td style="text-align: center;font-weight: 700;font-size: 1.3rem; padding-left: 0px;padding-right: 0px;padding-top: 5px;padding-bottom: 0px;display:none;">' + valPrintCopy + '</td>' +
                '<td><a href="#" onclick="openDetails(\'' + valData1[0] + '\'); return false">' + valData1[0] + '</a></td>' +
                '<td>' + valData1[2] + '</td>' +
                '<td>' + valData1[4] + '</td>' +
                '<td>' + valPriority + '</td>' +
                '<td>' + valData1[8] + '</td>' +                
                '<td style="white-space: nowrap;">' + barStatus + '</td>' +               
                '<td style="text-align: center;font-weight: 700;font-size: 1.3rem; padding-left: 0px;padding-right: 0px;padding-top: 5px;padding-bottom: 0px;"><a href="#" onclick="openContent(\'' + valData1[0] + '\'); return false" ><i class="fa fa-file-alt"></i></a></td>' +
                '<td style="text-align: center;font-weight: 700;font-size: 1.3rem; padding-left: 0px;padding-right: 0px;padding-top: 5px;padding-bottom: 0px;">' + valAttach + '</td>' +
                '<td>' + valData1[9] + '</td>' +
                '<td>' + valData1[10] + '</td>' +
                '</tr>');
        }
        $('#example').append('</tbody>');
    }
    else {
         $('#rptReportDiv').hide();
         $('#rptEmptyDiv').show();
    }
    }
    function BtnSearch() {
   

        var FromDate = "";
        var ToDate = "";
        var Dept = "";
        var User = "";
        var Techld = "";
        var Dev = "";
        var Technlgy = "";
        var Status = ""; ;

        FromDate = $('#txtfrmDate').val();
        ToDate = $('#txttoDate').val();
        Dept = $('.dept').val();
        User = $('.user').val();
        Techld = $('.tlead').val();
        Dev = $('.devlp').val();
        Technlgy = $('.tech').val();
        Status =$('.status').val();

 
        var data = FromDate + 'æ' + ToDate + 'æ' + Dept + 'æ' + User + 'æ' + Techld + 'æ' + Dev + 'æ' + Technlgy + 'æ' + Status;
 
        $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "NoteSearchReport.aspx/GetSearchReportDtls",       
        data: "{pageVal:'GetAdvSearchReport', pageval1 :'" + data + "', pageval2 :'" + $("[id*=hdUserId]").val() +"'}",
        dataType: "json",
         success: function (Result) {
            if (Result.d == '') {
                $('#ReportDiv').hide();
                $('#EmptyDiv').show();
            }
            else {
                $('#ReportDiv').show();
                $('#EmptyDiv').hide();
                Result = Result.d;                
                fillTableT(Result);
            }           
        }
        });
        }
    function ClearGrid() {       
        $("#tblSearchRpt").empty();
        $('#ReportDiv').hide();
        $('#EmptyDiv').show();
        $("#txtfrmDate").val("");
        $("#txttoDate").val("");
        $("#ddlDept").empty();
        $("#ddlTLead").empty();
        $("#ddlDevlp").empty();
        $("#ddlTech").empty();
        $("#ddlStatus").empty();  
        $("#ddlUser").empty()
        ModalLoad();
    }
  function fillTableT(data) {
    var valData, valData1, valPriorityId, valPriority, valNatureId, valNature,barStatus,valPrintCopy,valAttach;
    var n = 0;
      valData = data.split('Θ');
    
    if (valData.length > 0) {
        
         $('#ReportDiv').show();
         $('#EmptyDiv').hide();
         $("#tblSearchRpt").empty();
        if ($("#tblSearchRpt tr").length == 0) {
            $("#tblSearchRpt").append('<thead class="bg-success text-white">< tr ><th scope="col">NoteId</th><th scope="col">Department</th><th scope="col">TechLead</th><th scope="col">Subject</th><th scope="col">Priority</th><th scope="col">Status</th><th scope="col">CreatedBy</th><th scope="col">CreatedDate</th></tr ></thead><tbody>'

            );
        }
        for (i = 0; i < valData.length - 1; i++) {
            var valStatusData;
            valData1 = valData[i].split('µ');
            valNatureId = valData1[5];
            valPriorityId = valData1[4];
            if (valNatureId == 1) { valNature = "<i class='fa fa-circle' style='color:#FF0000; font-size: 10px; padding-right: 2px;'></i>" }
            else { valNature = "<i class='fa fa-circle' style='color:#fdee30; font-size: 10px; padding-right: 2px;'></i>" }

            if (valPriorityId == 1) { valPriority = "<i class='fa fa-circle' style='color:#FF0000; font-size: 10px; padding-right: 2px;'></i>" }
            else if (valPriorityId == 2) { valPriority = "<i class='fa fa-circle' style='color:#fb8c00; font-size: 10px; padding-right: 2px;'></i>" }
            else if (valPriorityId == 3) { valPriority = "<i class='fa fa-circle' style='color:#fdee30; font-size: 10px; padding-right: 2px;'></i>" }
       
         
            $('#tblSearchRpt').append('<tr style="cursor:pointer;">' +                
                '<td style="text-align: center;font-weight: 700;font-size: 1.3rem; padding-left: 0px;padding-right: 0px;padding-top: 5px;padding-bottom: 0px;display:none;">' + valPrintCopy + '</td>' +
                '<td><a href="#" onclick="openDetails(\'' + valData1[0] + '\'); return false">' + valData1[0] + '</a></td>' +
                //'<td>' + valData1[1] + '</td>' +
                '<td>' + valData1[1] + '</td>' +
                //'<td>' + valData1[3] + '</td>' +
                '<td>' + valData1[2] + '</td>' +
                '<td>' + valData1[3] + '</td>' +
                //'<td>' + valNature + '</td>' +
                '<td>' + valPriority + '</td>' +
                //'<td>' + valData1[7] + '</td>' +
                '<td>' + valData1[5] + '</td>' +
                '<td>' + valData1[6] + '</td>' +
                '<td>' + valData1[7] + '</td>' +
                '</tr>');
            //'</tr> </tbody>');   
        }
        $('#tblSearchRpt').append('</tbody>');
        $('#tblSearchRpt').DataTable();
    }
    else {
     
         $('#ReportDiv').hide();
         $('#EmptyDiv').show();
    }
}
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
    var win = NULL;
onerror = stopError;
function stopError(){
    return true;
}
function openContent(noteid) {
       // settings = "width=840, height=580, top=20, left=20";
    var str = Encrypt(noteid);
    settings = "width=840, height=580, top=20, left=20, scrollbars=yes, location=no, directories=no, status=no, menubar=no, toolbar=no, resizable=no, dependent=no";
    win = window.open('ViewerNoteContent.aspx?noteid='+str, '', settings);
    win.focus();
}
function openAttach(noteid) {
       // settings = "width=840, height=580, top=20, left=20";
    var str = Encrypt(noteid);
    settings = "width=840, height=580, top=20, left=20, scrollbars=yes, location=no, directories=no, status=no, menubar=no, toolbar=no, resizable=no, dependent=no";
    win = window.open('ViewerNoteAttachements.aspx?noteid='+str, '', settings);
    win.focus();
    }

function openDetails(noteid) {
    var note = Encrypt(noteid);
    window.location = "ViewerNoteDetails.aspx?noteid=" + note;
    //settings = "width=840, height=580, top=20, left=20, scrollbars=yes, location=no, directories=no, status=no, menubar=no, toolbar=no, resizable=no, dependent=no";
    //win = window.open('ViewerNoteAttachements.aspx?noteid='+str, '', settings);
    //win.focus();
    }
function openApproval(noteid) {
   
$.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "Approve2.aspx/getTableData",
        data: "{pageVal:'GetTableImageStatus', pageval1:'" + noteid + "',pageval2:''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            var contentDtl = Result.split('µ');
            var printRdlc = contentDtl[0];
             
            
            if (printRdlc > 0) {
                  var note = Encrypt(noteid);
                   //window.location = "NoteApprovedView.aspx?noteid=" + noteid;
                  settings = "width="+ screen.width +", height="+ screen.height +", top=20, left=20, scrollbars=yes,fullscreen=yes, location=no, directories=no, status=no, menubar=no, toolbar=no, resizable=no, dependent=no";

                 win = window.open('viewerApprovedNote.aspx?noteid=' + note, '', settings);
                //win = window.open('DeleteApprovePrint.aspx?noteid=' + note, '', settings);

                  win.focus();
            }
            else {
                 //settings = "width="+ screen.width +", height="+ screen.height +", top=20, left=20, scrollbars=yes,fullscreen=yes, location=no, directories=no, status=no, menubar=no, toolbar=no, resizable=no, dependent=no";

                 // win = window.open('NoteApprovedView.aspx?noteid=' + noteid, '', settings);

                 // win.focus();
                window.open('NoteApprovedView.aspx?noteid=' + noteid, '_blank');
            }            
            }
});

  
}
function Encrypt(value) 
{
  var result="";
  for(i=0;i<value.length;i++)
  {
    if(i<value.length-1)
    {
        result+=value.charCodeAt(i)+10;
        result+="-";
    }
    else
    {
        result+=value.charCodeAt(i)+10;
    }
  }
  return result;
}
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="card card-5 rightmarg"> 
<form class="form-horizontal" >    
<div class="card-body">
<div class="row">
<div class="col-md-12">
<div class="form-group"  style="display: none;" id="rptReportDiv">
<div class="row" style="height:40px">
<div class="col-md-12 text-right">
<button style="width: 20%;" type="button" class="btn btn-primary" data-toggle="modal" onclick="return ModalLoad();" data-target="#ModeModal" >Advanced Search &nbsp; &nbsp;&nbsp; <i class="fa fa-search font-18" style="color: #fff;"></i></button>
</div>
</div>

<div class="row">
<div class="col-md-4">
Priority Status: <i class='fa fa-circle' style='color:#FF0000; font-size: 10px; padding-right: 2px;'></i> - High  <i class='fa fa-circle' style='color:#fb8c00; font-size: 10px; padding-right: 2px;'></i> - Medium <i class='fa fa-circle' style='color:#fdee30; font-size: 10px; padding-right: 2px;'></i> - Low
<br/>
<%--Nature Status: <i class='fa fa-circle' style='color:#FF0000; font-size: 10px; padding-right: 2px;'></i> - Confidential  <i class='fa fa-circle' style='color:#fdee30; font-size: 10px; padding-right: 2px;'></i> - Non-Confidential
<br/>--%>
</div>
<div class="col-md-8 text-right">
Workflow Status:<i class='fa fa-square' style='color:#A0D468; font-size: 13px; padding-right: 2px;'></i> - Created   <i class='fa fa-square' style='color:#EC87C0; font-size: 13px; padding-right: 2px;'></i> - PMO Verified  <i class='fa fa-square' style='color:#7460ee; font-size: 13px; padding-right: 2px;'></i> - Recommended  <i class='fa fa-square' style='color:#FFA500; font-size: 13px; padding-right: 2px;'></i> - Tested  <i class='fa fa-square' style='color:#FF0000; font-size: 13px; padding-right: 2px;'></i> - TA completed   <i class='fa fa-square' style='color:#0d00ff; font-size: 13px; padding-right: 2px;'></i> - PRE UAT
</div>
</div>
       <div class="col-md-12 well align-center">
               <div class="col-md-12 align-right">               
                   <asp:Button ID="btn_Excel" runat="server" BackColor="LightSteelBlue" BorderStyle="Ridge"
                 EnableTheming="True" Font-Bold="True" Font-Names="Book Antiqua" Font-Size="10pt"
                 ForeColor="Black" Height="30%" Style="border-right: thin ridge; border-top: thin ridge;
                 border-left: thin ridge; cursor: hand; border-bottom: thin ridge" Text="EXPORT TO EXCEL"
                 Width="168px" OnClick="btn_Excel_Click"/>
                   <input id="btnPrint" onclick="return btnPrint_onclick()" style="font-weight: bold;
                width: 73pt; cursor: hand; font-family: 'Book Antiqua'; background-color: lightsteelblue"
                type="button" value="PRINT" />
               </div>
               <div class="col-md-12 align-center">
                   <asp:Label ID="lbldate" runat="server" Font-Bold="True" ForeColor="Navy" Width="25%"></asp:Label><br />
                   <asp:Label ID="lblTime" runat="server" Font-Bold="True" ForeColor="Navy" Width="258px"></asp:Label><br />
               </div>
               <div class="col-md-12 align-center">
                   <asp:Panel ID="Panel1" runat="server" Height="16%" Style="z-index: 100; left: 11px; top: 7px" Width="100%">
                        <div style="margin-left: auto; margin-right: auto; text-align: center">
                             <asp:Label ID="Label2" runat="server" BackColor="Transparent" Font-Bold="True" Font-Size="X-Large"
                                 ForeColor="Green" Height="28px" Text="MANAPPURAM FINANCE LIMITED" Width="100%"></asp:Label>
                            <asp:Label ID="lblTitle" runat="server" BackColor="Transparent" Font-Bold="True" Font-Size="Large"
                                 ForeColor="Purple" Height="21px" Width="100%">CRF STATUS REPORT</asp:Label><br />
                        </div>
                        <div id="demo" class="scroll">
                            <div id="MyTable" runat="server" style="margin-left: auto; margin-right: auto; text-align: center">
                            </div>
                        </div>
                   </asp:Panel>
               </div>
        
        
    
    </div>
<div class="table-responsive">
<table class="table table-hover table-success" id="example" > 
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

<div class="row">
<div class="col-md-12">
<div class="form-group" style="display: none;" id="rptEmptyDiv">
<div class="col-md-12 text-right">
<button style="width: 20%;" type="button" class="btn btn-primary" data-toggle="modal" data-target="#ModeModal">Advanced Search &nbsp; &nbsp;&nbsp; <i class="fa fa-search font-18" style="color: #fff;"></i></button>
</div>
<div style="font-size: 18px; text-align: center;"><i class="fa fa-filter fa-5x" aria-hidden="true" style="opacity: 0.5;"></i></div>
<div style="font-size: 18px; text-align: center;">    <h5>We didn't find anything...</h5></div>
    <div style="font-size: 12px; text-align: center;">    Try a different keyword...</div>
</div>
</div>
</div>
</div>
                  <!-- Modal -->
        <div id="ModeModal" class="modal fade" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" onclick="ClearGrid();" style="text-align:left;" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Advanced Search Here.!</h4>
                    </div>
                    <div class="modal-body">
                  
                             <!-- Main content -->
            <section class="content">
                <%--<div class="container-fluid">--%>
                    <%--<div class="row">
                        <div class="col-md-12">--%>
                            <!-- Default box -->
                            <div class="card">
                                <div class="card-body">
                                    <form role="form">
                                        <div class="row col-sm-12">
                                            <div class="form-group col-sm-3" style="padding-left: 0;">
                                                <label>From Date <span class="required text-danger">*</span> </label>
                                                <input type="text" id="txtfrmDate" class="form-control" style="width: 100%" readonly="readonly" onmousedown="getDate();" />
                                            </div>
                                            <div class="form-group col-sm-3" style="padding-left: 0;">
                                                <label>To Date <span class="required text-danger">*</span> </label>
                                                <input type="text" id="txttoDate" class="form-control" style="width: 100%" readonly="readonly" onmousedown="getDate();" />
                                            </div>
                                               <div class="form-group col-md-3" style="padding-left:0;">
                                                <label>Departments</label>
                                                <select class="form-control dept select2" multiple="multiple" id="ddlDept" >
                                                </select>
                                            </div>
                                            <div class="form-group col-md-3" style="padding-left: 0; padding-right: 0;">
                                                <label>User</label>
                                                <select class="form-control user select2" multiple="multiple" id="ddlUser">
                                                </select>
                                            </div>

                                        </div>                             
                                
                                        <div class="row col-md-12">
                                            <div class="form-group col-md-3" style="padding-left: 0;">
                                                <label>Tech lead</label>
                                                <select class="form-control tlead select2" multiple="multiple" onchange="" id="ddlTLead">
                                                </select>
                                            </div>
                                            <div class="form-group col-md-3" style="padding-left: 0; ">
                                                <label>Developer  </label>
                                                <select class="form-control devlp select2" multiple="multiple"  id="ddlDevlp">
                                                </select>
                                            </div>
                                            <div class="form-group col-md-3" style="padding-left: 0;">
                                                <label>Technology </label>
                                                <select class="form-control tech select2" multiple="multiple" id="ddlTech">
                                                </select>
                                            </div>
                                            <div class="form-group col-md-3" style="padding-left: 0; padding-right: 0;">
                                                <label>Status </label>
                                                <select class="form-control select2 status" multiple="multiple" onchange="" id="ddlStatus">
                                                </select>
                                            </div>
                                        </div>
                                        <div class="row p-2">
                                            <div class="col-sm-12">
                                                <div>
                                                    <button style="width: 15%;" type="button" class="btn btn-primary" onclick="return BtnSearch();">Submit</button>
                                                    <button style="width: 15%;" type="button"  class="btn btn-danger" data-dismiss="modal" onclick="return ClearGrid();">Exit</button>

                                                </div>
                                            </div>
                                        </div>
                               </form>
                           </div>
                           </div>

                     <div class="background-card" style="display:none;" id="ReportDiv">
                            <%--<div class="container-fluid">--%>
                                <div class="row mb-2">
                                    <div class="col-sm-6">
                                        <h4>Search Result</h4>
                                    </div>
                                    <div class="col-sm-6">
                                    </div>
                                </div>
                            <%--</div>--%>
                         <div class="row">
                             <div class="col-md-4">
                                 Priority Status: <i class='fa fa-circle' style='color: #FF0000; font-size: 10px; padding-right: 2px;'></i>- High  <i class='fa fa-circle' style='color: #fb8c00; font-size: 10px; padding-right: 2px;'></i>- Medium <i class='fa fa-circle' style='color: #fdee30; font-size: 10px; padding-right: 2px;'></i>- Low
                                 <br />
                             </div>                    
                         </div>
                         <div class="datatable-section" >
                         <div class="table-responsive">
                             <table class="table table-hover table-success sortable" id="tblSearchRpt">
                                 <thead class="bg-success text-white">
                                     <tr>
                                     </tr>
                                 </thead>
                                 <tbody class="border border-dark"></tbody>
                             </table>
                         </div>
                             </div>
                        </div>
                <div class="form-group" style="display: none;" id="EmptyDiv">
          
                    <div style="font-size: 18px; text-align: center;"><i class="fa fa-filter fa-5x" aria-hidden="true" style="opacity: 0.5;"></i></div>
                    <div style="font-size: 18px; text-align: center;">
                        <h5>We didn't find anything...</h5>
                    </div>
                    <div style="font-size: 12px; text-align: center;">Try a different keyword...</div>
                </div>
                            <!-- /.card-body -->

                        <%--</div>--%>
                        <!-- /.card -->

                   <%-- </div>--%>
                <%--</div>--%>

                </section>
                    </div>
            <%--        <div class="modal-footer">
                        <button type="button" class="btn btn-primary" onclick="ClickReportHere(1);" >Task Status Report</button>
                        <button type="button" class="btn btn-primary" onclick="ClickReportHere(3);" >Meeting Status Report</button>
                        <button type="button" class="btn btn-success" onclick="ClickReportHere(2);">Daily Work Report</button>
                        <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="ClearData();">Cancel</button>
                    </div>--%>
                </div>

            </div>
        </div>
</form>      
</div>

    <input id="hdUserId" type="hidden" runat="server"/>
        <input id="hdBranchId" type="hidden" runat="server"/>
        <input id="hdFirmId" type="hidden" runat="server"/>
</asp:Content>
