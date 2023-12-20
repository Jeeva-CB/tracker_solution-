$(window).on('load', function () {
    var usr = $("[id*=hdUserId]").val();
    checkLead(usr);

    $("#txt_TstStsDate").datepicker({
        dateFormat: 'dd/MM/yy',
        changeMonth: true,
        changeYear: true,
        stepMonths: true,
        todayHighlight: true,
        onSelect: function (dateText, inst) {
        }

    });
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

    GetTester();
    GetTestLead();

});

function frmExit() {
    window.open("index.aspx", "_self");
}



function viewBugReport() {
    // alert("js hit");

   
    var tester = "";
    var v_tester = "";

    txt_TstStsDate = $('#txt_TstStsDate').val();
    txt_TASrtDate = $('#txt_TASrtDate').val();
    txt_TarDate = $('#txt_TarDate').val();


    v_tester = $("#ddlTester").find("option:selected").val();

    if (v_tester != "-1") {
        tester = $("#ddlTester").find("option:selected").val();
    }
    // alert(Testlead);
    // var test = $("#ddlTLead").find("option:selected").text();
    //alert(test);
    //var e = document.getElementById("ddlTester");
    //var text = e.options[e.selectedIndex].text;
    //alert(text);

    var wh = tester + 'æ';
    //alert(wh);
    encryptUrl(wh);


}
function onlyNos(e, t) {

    try {
        if (window.event) { //To disable other button clicks
            if (window.event.keyCode == 13) { e.preventDefault(); } var charCode = window.event.keyCode;
        } else if (e) { var charCode = e.which; } else { return true; } if (charCode > 31 && (charCode < 48 || charCode > 57)) { return false; } return true;
    } catch (err) { alert(err.Description); }
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

        }
    });
}

function checkLead(user) {
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "BugStatusReport.aspx/UATDetail",
        data: "{pageVal:'CHECKTESTLEAD', pageval1 :'" + user + "', pageval2:''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            if (Result == "0§") {
                alert("YOU ARE NOT AUTHORIZE");
                window.open("index.aspx", "_self");
            }

        }
    });
}

function encryptUrl(dtdata) {
    //alert("hii");
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "BugStatusReport.aspx/Encrypt",
        data: "{clearText:'" + dtdata + "'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
           // alert(Result);
            //window.open("POFormView.aspx?poid=" + Result);
            window.open("QA_Team_Availability_monthRpt.aspx?mnuId=" + Result + "");

        }
    });

}
