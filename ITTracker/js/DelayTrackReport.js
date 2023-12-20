$(window).on('load', function () {

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
    //GetReportAccess();
});
function frmExit() {
    window.open("index.aspx", "_self");
}

function viewBugReport() {
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

    wh = $('#txtFromDate').val() + 'æ' + $('#txtToDate').val() + 'æ';

    encryptUrl(wh);

}
function onlyNos(e, t) {

    try {
        if (window.event) { //To disable other button clicks
            if (window.event.keyCode == 13) { e.preventDefault(); } var charCode = window.event.keyCode;
        } else if (e) { var charCode = e.which; } else { return true; } if (charCode > 31 && (charCode < 48 || charCode > 57)) { return false; } return true;
    } catch (err) { alert(err.Description); }
}

function encryptUrl(dtdata) {
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "DelayTrackReport.aspx/Encrypt",
        data: "{clearText:'" + dtdata + "'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            //window.open("POFormView.aspx?poid=" + Result);
            window.open("DelayReport.aspx?mnuId=" + Result + "");

        }
    });

}
