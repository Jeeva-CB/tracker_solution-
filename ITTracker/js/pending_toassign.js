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
   
});

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
    //Dept = $('.dept').val();
    //User = $('.user').val();
    //Techld = $('.tlead').val();
    //Dev = $('.devlp').val();
    //Technlgy = $('.tech').val();
    //Status = $('.status').val();
    //Priority = $("#ddlPriority").val();

    var newFrmDate = Date.parse(FromDate);
    var NewToDate = Date.parse(ToDate);
    var dateDifference = NewToDate - newFrmDate;
    if (dateDifference < 0) {
        alert("Choose To Date greater than From Date");
        $("#txtFromDate").val("");
        $("#txtToDate").focus();
        return false;
    }
    var data = FromDate + 'æ' + ToDate;

    encryptUrl(data);
}
function encryptUrl(dtdata) {
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "Pending_toAssign_DateSelctn.aspx/Encrypt",
        data: "{clearText:'" + dtdata + "'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            //window.open("POFormView.aspx?poid=" + Result);
            window.open("Pending_toAssign_rpt.aspx?mnuId=" + Result + "");

        }
    });

}