$(window).on('load', function () {
    var usr = $("[id*=hdUserId]").val();
    checkLead(usr);

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
    //GetFirmList();
    //GetDocTypeList();
    //GetDepartment();
    GetStatus();
    GetTester();
    GetTestLead();
    //GetReportAccess();
});
function frmExit() {
    window.open("index.aspx", "_self");
}



function viewBugReport() {
    debugger;
    var flag = 0;
    flag = $("input:radio[name=Rpt]:checked").val();

    var FromDate = "";
    var ToDate = "";
    var Test = "";
    var Status = "";
    var Crfid = "";
    var Reqid = "";
    var Testlead = "";

    FromDate = $('#txtFromDate').val();
    ToDate = $('#txtToDate').val();
    Test = $("#ddlTester").val();
    Status = $('#ddlStatus').val();
    Reqid = $("#txtRequestId").val();
    Crfid = $("#txtCrdId").val();
    Testlead = $("#ddlTLead").val();




    var frmDateCom = $("#txtFromDate").val();
    var ToDateCom = $("#txtToDate").val();
    var newFrmDate = Date.parse(frmDateCom);
    var NewToDate = Date.parse(ToDateCom);
    var dateDifference = NewToDate - newFrmDate;
    if (dateDifference < 0) {
        alert("Choose To Date greater than From Date");
        $("#txtFromDate").val("");
        $("#txtToDate").focus();
        return;
    }

    if (flag == 0) {

        //if ($('#txtCrdId').val() == "") {
        //    alert("Please enter CRFID ");
        //    $('#txtCrdId').focus();
        //    return false;
        //}



        var wh = FromDate + 'æ' + ToDate + 'æ' + Status + 'æ' + Crfid + 'æ' + Reqid + 'æ' + Test + 'æ' + flag + 'æ' + Testlead + 'æ';
        // alert(wh);
        //  wh = $('#txtCrdId').val() + 'æ' + fromdate + 'æ' + todate + 'æ' + $('#ddlStatus').val()  + 'æ' + $('#txtRequestId').val() + 'æ' + $('#ddlTester').val() + 'æ';
        encryptUrl(wh);
    }

    else if (flag == 1) {
        //if (fromdate == "") fromdate = "-1";
        //if (todate == "") todate = "-1";
        //var teamList = $("#ddlDevlp1").val();
        // if (teamList == "") {
        //     alert("Choose Developers:");
        //     return false;
        // }     


        var wh = FromDate + 'æ' + ToDate + 'æ' + Status + 'æ' + Crfid + 'æ' + Reqid + 'æ' + Test + 'æ' + flag + 'æ' + Testlead + 'æ';

        //  wh = $('#txtCrdId').val() + 'æ' + fromdate + 'æ' + todate + 'æ' + $('#ddlStatus').val()  + 'æ' + $('#txtRequestId').val() + 'æ' + $('#ddlTester').val() + 'æ';
        encryptUrl(wh);

    }

    else if (flag == 2) {
        //if (fromdate == "") fromdate = "-1";
        //if (todate == "") todate = "-1";
        //var teamList = $("#ddlDevlp1").val();
        // if (teamList == "") {
        //     alert("Choose Developers:");
        //     return false;
        // }


        var wh = FromDate + 'æ' + ToDate + 'æ' + Status + 'æ' + Crfid + 'æ' + Reqid + 'æ' + Test + 'æ' + flag + 'æ' + Testlead + 'æ';

        //  wh = $('#txtCrdId').val() + 'æ' + fromdate + 'æ' + todate + 'æ' + $('#ddlStatus').val()  + 'æ' + $('#txtRequestId').val() + 'æ' + $('#ddlTester').val() + 'æ';
        encryptUrl(wh);
    }
    else if (flag == 3 || flag == 4) {
        //if (fromdate == "") fromdate = "-1";
        //if (todate == "") todate = "-1";
        //var teamList = $("#ddlDevlp1").val();
        // if (teamList == "") {
        //     alert("Choose Developers:");
        //     return false;
        // }


        var wh = FromDate + 'æ' + ToDate + 'æ' + Status + 'æ' + Crfid + 'æ' + Reqid + 'æ' + Test + 'æ' + flag + 'æ' + Testlead + 'æ';

        //  wh = $('#txtCrdId').val() + 'æ' + fromdate + 'æ' + todate + 'æ' + $('#ddlStatus').val()  + 'æ' + $('#txtRequestId').val() + 'æ' + $('#ddlTester').val() + 'æ';
        encryptUrl(wh);
        // wh =//encryptUrl(wh);

    }
    else if (flag == 5) {

        var wh = FromDate + 'æ' + ToDate + 'æ' + Status + 'æ' + Crfid + 'æ' + Reqid + 'æ' + Test + 'æ' + flag + 'æ';
        encryptUrl(wh);
    }



}
function onlyNos(e, t) {

    try {
        if (window.event) { //To disable other button clicks
            if (window.event.keyCode == 13) { e.preventDefault(); } var charCode = window.event.keyCode;
        } else if (e) { var charCode = e.which; } else { return true; } if (charCode > 31 && (charCode < 48 || charCode > 57)) { return false; } return true;
    } catch (err) { alert(err.Description); }
}


//function GetTestLead() {
//    $('#ddlTLead').empty();

//    $.ajax({
//        type: "post",
//        contentType: "application/json; charset=utf-8",
//        url: "BugStatusReport.aspx/getFillData",
//        data: "{pageVal:'GetTestLead', pageval1 :'', pageval2 :''}",
//        dataType: "json",
//        success: function (Result) {
//            Result = Result.d;
//            $('#ddlTLead').append($("<option></option>").val("-1").html("Choose TechLead"));
//            $.each(Result, function (key, value) {
//                $('#ddlTLead').append($("<option></option>").val(value.id).html(value.name));
//            });
//        }
//    });
//}

function GetTestLead() {
    $('#ddlTLead').empty();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "BugStatusReport.aspx/getFillData",
        data: "{pageVal:'GetTestLead', pageval1 :'', pageval2 :''}",
        dataType: "json",
        success: function (Result) {
            // alert(Result);
            Result = Result.d;
            $('#ddlTLead').append($("<option ></option>").val("-1").html("All TechLead "));
            $.each(Result, function (key, value) {
                $('#ddlTLead').append($("<option></option>").val(value.id).html(value.name));
            });
            //$('#ddlStatus').append($("<option ></option>").val("111").html("My Recommended"));
        }
    });
}

function GetStatus() {
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "BugStatusReport.aspx/getFillData",
        data: "{pageVal:'GetStatusFilltest', pageval1 :'', pageval2 :''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            $('#ddlStatus').append($("<option ></option>").val("-1").html("All Status"));
            $.each(Result, function (key, value) {
                $('#ddlStatus').append($("<option></option>").val(value.id).html(value.name));
            });
            //$('#ddlStatus').append($("<option ></option>").val("111").html("My Recommended"));
        }
    });
}
//------------- Get tester............//


function GetTester() {
    $('#ddlTester').empty();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "BugStatusReport.aspx/getFillData",
        data: "{pageVal:'GetTester', pageval1 :'', pageval2 :''}",
        dataType: "json",
        success: function (Result) {
            //alert(Result);
            Result = Result.d;
            $('#ddlTester').append($("<option ></option>").val("-1").html("All Tester"));
            $.each(Result, function (key, value) {
                $('#ddlTester').append($("<option></option>").val(value.id).html(value.name));
            });
            //$('#ddlStatus').append($("<option ></option>").val("111").html("My Recommended"));
        }
    });
}
//---------- check techlead---------//
function checkLead(user) {
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "BugStatusReport.aspx/UATDetail",
        data: "{pageVal:'CHECKTESTLEAD', pageval1 :'" + user + "', pageval2:''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            if (Result != "0§") {
                $("#butdelay").show();
            }
            else $("#butdelay").hide();
        }
    });
}

//-----------select firm -------------------//

function GetFirmList() {
    var QueryString = "GetFirmList";
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "StatusReport.aspx/getFillData",
        data: "{pageVal:'GetFirmList', pageval1 :'', pageval2 :''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            $('#ddlFirm').append($("<option ></option>").val("-1").html("All Firm"));
            $.each(Result, function (key, value) {
                $('#ddlFirm').append($("<option></option>").val(value.id).html(value.name));
            });
        }
    });
}
//----------- Choose Tester--------------//

function GetAssignedWork() {
    // alert('d');
    var seldevpr = $("#ddlDevlp").val();
    if (seldevpr == 0) {
        $("#AssgnedWrks").hide();
        $("#AssgnedWrks1").hide();
    }
    else {
        $("#AssgnedWrks").show();
        $("#AssgnedWrks1").show();
    }
    // $('#ddlWorks').empty();
    //alert(seldevpr);
    debugger;
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "DailyTrackReport.aspx/GetAssgnedWrk",
        data: "{pageVal:'GetTesters', pageval1 :'" + seldevpr + "'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            // $('#ddlDevlp').append($("<option></option>").val("-1").html("Choose Developer"));
            $.each(Result, function (key, value) {
                $('#ddlWorks').append($("<option></option>").val(value.id).html(value.name));
            });
        }
    });
}

function TeamMembers() {

    var user = $("[id*=hdUserId]").val();

    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "DailyTrackReport.aspx/getFillData",
        data: "{pageVal:'TEAMMz', pageval1 :'" + user + "', pageval2 :''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            $('#ddlDevlp1').append($("<option></option>").val("-1").html("Choose Developer"));
            $.each(Result, function (key, value) {
                $('#ddlDevlp1').append($("<option></option>").val(value.id).html(value.name));
            });
        }
    });
}


//-----------select Department-------------------//

function GetDepartment() {
    var QueryString = "GetDepartment";
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "StatusReport.aspx/getFillData",
        data: "{pageVal:'getDepartment', pageval1 :'', pageval2 :''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            $('#ddlDept').append($("<option ></option>").val("-1").html("All Department"));
            $.each(Result, function (key, value) {
                $('#ddlDept').append($("<option></option>").val(value.id).html(value.name));
            });
        }
    });
}
//-----------select Document type-------------------//

function GetDocTypeList() {
    var QueryString = "GetDocTypeList";
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "BugStatusReport.aspx/getFillData",
        data: "{pageVal:'GetDocTypeList', pageval1 :'', pageval2 :''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            $('#ddlDocType').append($("<option ></option>").val("-1").html("All Document Type"));
            $.each(Result, function (key, value) {
                $('#ddlDocType').append($("<option></option>").val(value.id).html(value.name));
            });
        }
    });
}
function encryptUrl(dtdata) {
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "BugStatusReport.aspx/Encrypt",
        data: "{clearText:'" + dtdata + "'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            //window.open("POFormView.aspx?poid=" + Result);
            window.open("BugReport.aspx?mnuId=" + Result + "");

        }
    });

}

function showtstDlyRpt() {
    var dly = 0
    dly = $("input:radio[name=Rpt]:checked").val();

    if (dly == 5) {

        $("#status").hide();
        $("#techlead").hide();
    }
    else {
        $("#status").show();
        $("#techlead").show();
    }

    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "BugStatusReport.aspx/Encrypt",
        data: "{clearText:'" + dtdata + "'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            //window.open("POFormView.aspx?poid=" + Result);
            window.open("BugReport.aspx?mnuId=" + Result + "");

        }
    });
}
