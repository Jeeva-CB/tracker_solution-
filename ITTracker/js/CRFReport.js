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
    CheckMdTech(usr);
    Getstatus();
    GetTechnology();
    GetTechLead();
    GetDeveloper();
    getDepartment();
    getPriority();
    getUser();
});
function frmExit() {
    window.open("index.aspx", "_self");
}
function getPriority(){
   // $('#ddlPriority').append($("<option selected disabled></option>").val("-1").html("Choose Priority"));
    $('#ddlPriority').append($("<option></option>").val("3").html("Low"));
    $('#ddlPriority').append($("<option></option>").val("2").html("Medium"));
    $('#ddlPriority').append($("<option></option>").val("1").html("High"));
}
function CheckMdTech(user) {
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "CRFStatusReport.aspx/UserDeptCheck",
        data: "{pageVal:'CheckMdTech', pageval1 :'"+user+"'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            if (Result == "666") {
                $("#MdTech").show();
            }
            else $("#MdTech").hide();
        }
    });
}



function viewReport() {

    var flag = 0;

    //flag = $("input:radio[name=Rpt]:checked").val();

    //wh = frmDateCom + 'æ' + ToDateCom+ 'æ' + $('#ddlStatus').val() + 'æ' + $('#ddlTech').val() + 'æ' + $('#ddlTLead').val() + 'æ' + $('#ddlDevlp').val() + 'æ' + $('#ddlDept').val() + 'æ' + $('#ddlUser').val() + 'æ' + flag + 'æ'; 
    flag = $("input:radio[name=Rpt]:checked").val();
    var FromDate = "";
    var ToDate = "";
    var Dept = "";
    var User = "";
    var Techld = "";
    var Dev = "";
    var Technlgy = "";
    var Status = "";
    var Priority = "";
  
    FromDate = $('#txtFromDate').val();
    ToDate = $('#txtToDate').val();
    Dept = $('.dept').val();
    User = $('.user').val();
    Techld = $('.tlead').val();
    Dev = $('.devlp').val();
    Technlgy = $('.tech').val();
    Status = $('.status').val();  
    Priority = $("#ddlPriority").val();  

    var newFrmDate = Date.parse(FromDate);
    var NewToDate = Date.parse(ToDate);
    var dateDifference = NewToDate - newFrmDate;
    if (dateDifference < 0) {
        alert("Choose To Date greater than From Date");
        $("#txtFromDate").val("");
        $("#txtToDate").focus();
        return false;
    }
    var data = FromDate + 'æ' + ToDate + 'æ' + Dept + 'æ' + User + 'æ' + Techld + 'æ' + Dev + 'æ' + Technlgy + 'æ' + Status + 'æ' + flag + 'æ' + Priority  + 'æ';

    encryptUrl(data);
}
function Getstatus() {
    
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "CRFStatusReport.aspx/getFillData",
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
        url: "CRFStatusReport.aspx/getFillData",
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
        url: "CRFStatusReport.aspx/getFillData",
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
        url: "CRFStatusReport.aspx/getFillData",
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
        url: "CRFStatusReport.aspx/getFillData",
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
        url: "CRFStatusReport.aspx/getFillData",
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
function encryptUrl(dtdata) {
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "CRFStatusReport.aspx/Encrypt",
        data: "{clearText:'" + dtdata + "'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            //window.open("POFormView.aspx?poid=" + Result);
            window.open("CrfReport.aspx?mnuId=" + Result + "");

        }
    });

}
