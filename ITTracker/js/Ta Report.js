$(window).on('load', function () {
   
    userchk();
   // userchk1()
    var usr = $("[id*=hdUserId]").val();

    $("#txt_TASrtDate").datepicker({
        dateFormat: 'dd/MM/yy',
        changeMonth: true,
        changeYear: true,
        stepMonths: true,
        todayHighlight: true,
        onSelect: function (dateText, inst) {
        }

    });
    $("#txt_TarDate").datepicker({
        dateFormat: 'dd/MM/yy',
        changeMonth: true,
        changeYear: true,
        stepMonths: true,
        todayHighlight: true,
        onSelect: function (dateText, inst) {
        }

    });


});

function viewReport() {

    debugger;

    var Taselect = $('#taselect').val();
    var txt_TASrtDate = $('#txt_TASrtDate').val();
    var txt_TarDate = $('#txt_TarDate').val();

    if (Taselect == "-1") {

        alert("Please Select Report Type");
        return false;
    }
    if (txt_TASrtDate == "" || txt_TarDate=="") {

        alert("Please Select Date");
        return false;
    }
    if (txt_TASrtDate != "" && txt_TarDate != "") {


        var TASDateCom = $("#txt_TASrtDate").val();
        var TAEDateCom = $("#txt_TarDate").val();
        var newFrmDate = Date.parse(TASDateCom);
        var NewToDate = Date.parse(TAEDateCom);
        var dateDifference = NewToDate - newFrmDate;
        if (dateDifference < 0) {
            alert("Choose To Date greater than From Date");
            $("#txt_TASrtDate").val("");
            $("#txt_TarDate").focus();
            return false;
        }
    }

    var data = Taselect + 'æ' + txt_TASrtDate + 'æ' + txt_TarDate;
    //alert(wh);
    encryptUrl(data);
   
}

function userchk() {

    var usr = $("[id*=hdUserId]").val();

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "TaReport.aspx/user_chk",
        data: "{flag:'Qatareportaccess',user :'" + usr + "'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            if (Result == 222) {

                alert("You Are Not Authorized to View This page");
                window.open('ams/Index.aspx', '_self');
            }
        },
        error: function (Result) {

        }
    });
}

function encryptUrl(dtdata) {
   
    debugger;
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "TaReport.aspx/Encrypt",
        data: "{clearText:'" + dtdata + "'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
           // window.open("POFormView.aspx?poid=");
          //  alert(Result);
            window.open("TaRptDetails.aspx?mnuId="+ Result);

        }
    });

}