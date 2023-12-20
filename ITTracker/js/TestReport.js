$(window).on('load', function () {
    var usr = $("[id*=hdUserId]").val();
    //checkLead(usr);

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

    var txt_TstStsDate = "";
    var txt_TASrtDate = "";
    var txt_TarDate = "";
    var Testlead = "";
    var tester = "";
    var v_tester = "";
    var v_testlead = "";

    txt_TstStsDate = $('#txt_TstStsDate').val();
    txt_TASrtDate = $('#txt_TASrtDate').val();
    txt_TarDate = $('#txt_TarDate').val();
    

     v_tester = $("#ddlTester").find("option:selected").val();
     v_testlead = $("#ddlTLead").find("option:selected").val();

    if (v_tester != "-1") {
        tester = $("#ddlTester").find("option:selected").text();
    }

    if (v_testlead != "-1") {
        Testlead = $("#ddlTLead").find("option:selected").text();
    }
   // alert(Testlead);
   // var test = $("#ddlTLead").find("option:selected").text();
    //alert(test);
    //var e = document.getElementById("ddlTester");
    //var text = e.options[e.selectedIndex].text;
    //alert(text);

    if (txt_TstStsDate == "" && txt_TASrtDate == "" && txt_TarDate == "" && v_tester == "-1" && v_testlead == "-1") {
            alert("Please choose any condition..!");
            $('#txtCrdId').focus();
            return false;

    }


    if (txt_TstStsDate != "" && txt_TASrtDate !="") {

   
    var TASDateCom = $("#txt_TASrtDate").val();
    var TAEDateCom = $("#txt_TarDate").val();
    var newFrmDate = Date.parse(TASDateCom);
    var NewToDate = Date.parse(TAEDateCom);
    var dateDifference = NewToDate - newFrmDate;
     if (dateDifference < 0) {
        alert("Choose To Date greater than From Date");
        $("#txt_TASrtDate").val("");
        $("#txt_TarDate").focus();
        return;
     }
    }
   

       


    var wh = txt_TstStsDate + 'æ' + txt_TASrtDate + 'æ' + txt_TarDate + 'æ' + tester + 'æ' + Testlead + 'æ';
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
            window.open("TestReport.aspx?mnuId=" + Result + "");

        }
    });

}
