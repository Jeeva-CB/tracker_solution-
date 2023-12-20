$(window).on('load', function () {
    var usr = $("[id*=hdUserId]").val();
    $("#txtFromDate").datepicker({
        dateFormat: 'dd/MM/yy',
        changeMonth: true,
        changeYear: true,
        stepMonths: true,
        todayHighlight: true,
        onSelect: function (dateText, inst) {   
        }

    });
    $("#txtToDate").datepicker({
        dateFormat: 'dd/MM/yy',
        changeMonth: true,
        changeYear: true,
        stepMonths: true,
        todayHighlight: true,
        onSelect: function (dateText, inst) {
        }

    });

    Getstatus();
    GetTechLead();
    GetDeveloper();
    GetTechnology();

});
function frmExit() {
    window.open("index.aspx", "_self");
}

function viewReport() {

    var flag = 0;
    flag = $("input:radio[name=Rpt]:checked").val();
    var FromDate = "";
    var ToDate = "";
  
    var Techld = "";
    var Dev = "";
    var Technlgy = "";
    var Status = "";
    var Priority = "";

    FromDate = $('#txtFromDate').val();
    ToDate = $('#txtToDate').val();
    Techld = $('.tlead').val();
    Dev = $('.devlp').val();
    Technlgy = $('.tech').val();
    Status = $('.status').val();
  

    var newFrmDate = Date.parse(FromDate);
    var NewToDate = Date.parse(ToDate);
    var dateDifference = NewToDate - newFrmDate;
    if (dateDifference < 0) {
        alert("Choose To Date greater than From Date");
        $("#txtFromDate").val("");
        $("#txtToDate").focus();
        return false;
    }
    var data = FromDate + 'æ' + ToDate + 'æ'  + Techld + 'æ' + Dev + 'æ' + Technlgy + 'æ' + Status + 'æ';
    
    encryptUrl(data);
}
function Getstatus() {

    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "CRFStatusReport.aspx/getFillData",
        data: "{pageVal:'RANDDSTATUS', pageval1 :'', pageval2 :''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            
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
        url: "CRFStatusReport.aspx/getFillData",
        data: "{pageVal:'RANDDTECHNOLOGY', pageval1 :'', pageval2 :''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            
           
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
        url: "CRFStatusReport.aspx/getFillData",
        data: "{pageVal:'RANDDREPORTTL', pageval1 :'', pageval2 :''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
           
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
        url: "CRFStatusReport.aspx/getFillData",
        data: "{pageVal:'RANDDREPORTDEV', pageval1 :'', pageval2 :''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            
            $.each(Result, function (key, value) {
                $('#ddlDevlp').append($("<option></option>").val(value.id).html(value.name));
            });
        }
    });
}

function encryptUrl(dtdata) {
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "CRFStatusReport.aspx/Encrypt",
        data: "{clearText:'" + dtdata + "'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            window.open("RDReportShow.aspx?mnuId=" + Result + "");

        }
    });

}
