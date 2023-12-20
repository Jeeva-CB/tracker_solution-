var st = 0;
$(window).on('load', function () {
    pendingWork();

    checkdata();
    $("[id*=hddraftid]").val('');

    $("[id*=hdrqst]").val('');
    // alert($("[id*=hdrqst]").val(''));
    let querystring = window.location.search.substring(1);
    let crfid = querystring.split("=")[1];
    AssignedProjectLoad();

    if ($("[id*=hdEmpCheck]").val() == 0) {
        
        $('#iblgitbranch').show();
        $('#gitbranch').show();
        $('#iblgitrespose').show();
        $('#gitres').show();
      

    } else {
        
        $('#iblgitbranch').hide();
        $('#gitbranch').hide();
        $('#iblgitrespose').hide();
        $('#gitres').hide();

    }

    $("#datepicker").datepicker({
        dateFormat: 'dd/M/yy',
        changeMonth: true,
        changeYear: true,
        stepMonths: true,
        maxDate: '0',
        todayHighlight: true,

        onSelect: function (dateText, inst) {
        }

    });

});

function pendingWork() {
    var usr = $("[id*=hdUserId]").val();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "DailyTracking.aspx/selectdata",
        data: "{pageVal:'CHECKPENDINGWORK', pageval1 :'" + usr + "'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;

            if (Result != "") {
                // alert(Result);
                var valData = Result.split('^');
                // alert(valData[4]);
                Swal.fire({
                    title: 'You need to update work again for the date ' + valData[1] + ' for ' + valData[4].split('~')[0] + ' Hours',
                    text: 'Comment by TL : ' + valData[0],
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes!'
                }).then((result) => {
                    //if (result.value == true) {
                    //    Swal.fire("Okay!!");
                    //}
                })
            }

        }
    });

}


function checkdata() {

    var usr = $("[id*=hdUserId]").val();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "DailyTracking.aspx/selectdata",
        data: "{pageVal:'CHECKDETAILS', pageval1 :'" + usr + "'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            // alert(Result);
            if (Result != '100~') {
                display(Result);
            }

        }
    });
}

function FillAssignedProjects(CRFID) {
    var CRFID = $("#ddlCrf").val();
    $("[id*=hddraftid]").val(CRFID);
    CRFSearch(CRFID);
    $("#snote").show();
    detailsLoad(CRFID);
    filesFill(CRFID);
    selectmodule();



}

function AssignedProjectLoad() {
    var usr = $("[id*=hdUserId]").val();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "DailyTracking.aspx/getFillData",
        data: "{pageVal:'GetAssignedPrjt', pageval1 :'" + usr + "'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            $.each(Result, function (key, value) {
                $('#ddlWorks').append($("<option></option>").val(value.id).html(value.name));
            });
        }
    });

}

/***************wbs loasd */
function WbsLoad() {
    //alert("in wbsload");
    $("#rddata").hide();
    $("#wbsdata").show();
    
   $("#ddlwbs").empty();
    var usr = $("[id*=hdUserId]").val();
    // $("[id*=hdrqst]").val(reqst);
    // alert($("[id*=hdrqst]").val());

    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "DailyTracking.aspx/getFillDatas",
        data: "{pageVal:'Getwbsload', pageval1 :'" + usr + "', pageval2 :'" + $("[id*=hdrqst]").val() + "'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            $('#ddlwbs').append($("<option></option>").val("-1").html("Choose WBS Details"));
            $.each(Result, function (key, value) {
                $('#ddlwbs').append($("<option></option>").val(value.id).html(value.name));
            })
            $('#ddlwbs').append($("<option></option>").val("0").html("Other work"));
        }
    });
}







/*Selected assigned project*/
function SelectAssignedProjects() {
    var projectid = $("#ddlWorks").val();
    var randd = "";
    var assgnedwork = "";
    assgnedwork = $("#ddlWorks option:selected").text();
    var reqst = "";
    // alert("haai");
    reqst = assgnedwork.split('-')[1];
    randd = assgnedwork.split('-')[0];
    $("[id*=hdrqst]").val(reqst);

    // alert(reqst);
    WorkDescLoad();
    if (randd == 'R') {
        RandDWorkLoad(reqst);
        st = 1;
    }
    else {
        WbsLoad();
        st = 0;
    }

}

function RandDWorkLoad(reqst) {
    var usr = $("[id*=hdUserId]").val();
    $("#rddata").show();
    $("#wbsdata").hide();
    $('#ddlrd').empty();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "DailyTracking.aspx/getDescOfWork",
        data: "{pageVal:'GetSubRDWork', pageval1 :'" + reqst + "',user :'" + usr + "'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;

            $('#ddlrd').append($("<option selected disabled></option>").val("-1").html("Choose Sub-Work.."));
            $.each(Result, function (key, value) {
                $('#ddlrd').append($("<option></option>").val(value.id).html(value.name));
            });

        }
    });
}


/*Description of work performed*/
function WorkDescLoad() {
    $('#ddlDesc').empty();
    var usr = $("[id*=hdUserId]").val();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "DailyTracking.aspx/getDescOfWork",
        data: "{pageVal:'GetDescOfWork', pageval1 :'" + usr + "',user :'no using this flag'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;

            $('#ddlDesc').append($("<option selected disabled></option>").val("-1").html("Choose Description.."));
            $.each(Result, function (key, value) {
                $('#ddlDesc').append($("<option></option>").val(value.id).html(value.name));
            });

        }
    });

}
function ShowDesc() {
    $("#select_date_frm").show();
    $("#txtsection").show();
    $("#timesectn").show();

}
/*Add butn function*/
function AddNote() {
    debugger;
    var AssgnedWork = "", AssignedWorkDetail = "", DescWork = "", DescWorkText = "", DetailDesc = "", Remarks = "", Time = "", Hr = "", Min = "", percent = "", wbs = "", wbspercent = "";

    var dat = $("#datepicker").val();
    wbs = $("#ddlwbs option:selected").text();

    //alert(wbs);
    AssgnedWork = $("#ddlWorks").val();
    //AssgnedWork = AssgnedWork.replace(/\\/g, '\\\\').replace(/[“”‘’']/g, '\\\'');
    AssignedWorkDetail = $("#ddlWorks option:selected").text();
    AssignedWorkDetail = AssignedWorkDetail.replace(/\\/g, '\\\\').replace(/[“”‘’']/g, '\\\'');
    DescWork = $("#ddlDesc").val();
    DescWorkText = $("#ddlDesc option:selected").text();
    DetailDesc = $("#txtReason").val();
    Remarks = $("#txtRemarks").val();
    percent = $("#txtpercentage").val();
    //wbs = $("#ddlwbs").val();
    wbspercent = $("#txtwbspercent").val();
    if (percent > 100) { alert("Percentage of completion should not exceed 100%"); return false; }
    ///*#<%=*/recipient.ClientID %>
    // Hr = document.getElementById("<%=ddlHours.ClientID %>").val();
    Hr = $("#ContentPlaceHolder1_ddlHours").val();
    // Hr = $("#<%=ddlHours.ClientID %>").val();
    //alert(Hr);
    Min = $("#ContentPlaceHolder1_ddlMinutes").val();
    // Min = $("#ddlMinutes").val();
    Time = Hr + ":" + Min;
    //Time = $("#ttime").val();
    //alert(Time);
    //||  DescWork == -1 
    //if (AssgnedWork == -1 || DescWork == -1 || DetailDesc == "" || Remarks == "" || Time == "0:00" || dat == "" || percent == "" || wbs == -1 ||  wbspercent =="") {
    gitbranch = $("#gitbranch").val();
    gitrespo = $("#gitres").val();

    if (AssgnedWork == -1) {
        alert('Select assigned work');
        return false;
    }
    else if (DescWork == -1) {
        alert('Select description of work performed');
        return false;
    }



    else if (DetailDesc == "") {
        alert('Enter reason in detail description');
        return false;
    }
    else if (Remarks == "") {
        alert('Please enter your remarks');
        return false;
    }
    
    else if (Time == "0:00") {
        alert('Please enter time taken for your discussion');
        return false;

    }

    else if (dat == "") {
        alert('Please Select date');
        return false;

    }

    else if (percent == "") {
        alert('Please enter the percentage of completion');
        return false;
    }
    else if (wbspercent > 100) { alert("Percentage of completion should not exceed 100%"); return false; }
    else if (st == 1) {
        if ($("#ddlrd").val() == '-1') {
            alert('Select R&D Sub Task.!');
            return false;
        }
        else {
            wbs = $("#ddlrd").val() + 'µ' + $("#ddlrd option:selected").text();
        }
        if ($("#txtrdpercent").val() == "") {
            alert('Please enter the wbs percentage');
            return false;
        }
        else {
            wbspercent = $("#txtrdpercent").val();
        }
    }

    else if (st == 0) {
        if ($("#ddlwbs").val() == '-1') {
            alert('Select WBS work');
            return false;
        }
        else {
            $("#ddlwbs option:selected").text();
        }
        if ($("#txtwbspercent").val() == "") {
            alert('Please enter the wbs percentage');
            return false;
        }
        else {
            wbspercent = $("#txtwbspercent").val();
        }

    }
    else if ($("[id*=hdEmpCheck]").val() == 0) {
        if (gitbranch == "") {
            alert('Please enter GitHub BRANCH Name');
            return false;
        }

        else if (gitrespo == "") {
            alert('Please enter GitHub Repository Name');
            return false;
        }
    }
    // }
    //else {

   
    //1                 2                        3                 4                      5               6             7             8              9             10            11
    data = AssgnedWork + "^" + AssignedWorkDetail + "^" + DescWork + "^" + DescWorkText + "^" + DetailDesc + "^" + Time + "^" + Remarks + "^" + dat + "^" + percent + "^" + wbs + "^" + wbspercent + "^" + gitbranch + "^" + gitrespo + "~";
   // alert(data);
    display(data);
    // }
}
var n = 0;
function display(data) {

    debugger;
    var valData = data.split('~');
    //alert(valData);
    //alert("Length:"+valData.length);
    if ($("#tableData tr").length == 0) {
        $("#tableData").empty();
        if (st == 1) {
            $("#tableData").append('<tr style="background-color:#fdd935;color:#ed2023"><th class="text-center">SLNo.</th><th class="text-center">Assigned Work</th><th class="text-center">Description of Work Performed</th><th class="text-center">R&D Work</th><th class="text-center">R&D Work Percentage</th><th class="text-center">Detail Description</th><th class="text-center">Time</th><th class="text-center">Remarks</th><th class="text-center">Date</th><th class="text-center">Percentage</th><th class="text-center">GitHub Branch</th><th class="text-center">GitHub Repository</th><th class="text-center">Delete</th><tr>');

        }
        else {
            $("#tableData").append('<tr style="background-color:#fdd935;color:#ed2023"><th class="text-center">SLNo.</th><th class="text-center">Assigned Work</th><th class="text-center">Description of Work Performed</th><th class="text-center">WBS</th><th class="text-center">WBS Percentage</th><th class="text-center">Detail Description</th><th class="text-center">Time</th><th class="text-center">Remarks</th><th class="text-center">Date</th><th class="text-center">Percentage</th><th class="text-center">GitHub Branch</th><th class="text-center">GitHub Repository</th><th class="text-center">Delete</th><tr>');

        }
    }

    for (i = 0; i < valData.length - 1; i++) {
        //alert('ww');
        valData1 = valData[i].split('^');
        //alert(valData1[0]);
        //1     2       3       4                            5        6       7           8       9  10  11    
        //0^Other Works^9^Testing template creation^jiiiii jiiiiiii^8:00^kiiiikkiiii^01/Oct/2021^34^-1^100
        $("#tableData").append('<tr id="row_' + (n + 1) + '">' +

            '<td class="text-center slrow_' + (n + 1) + '">' + parseInt(n + 1) + '</td>' +
            
            '<td class="text-center">' + valData1[1] + '</td>' +
            '<td class="text-center">' + valData1[3] + '</td>' +
            '<td class="text-center">' + valData1[9] + '</td>' +
            '<td class="text-center">' + valData1[10] + '</td>' +
            '<td class="text-center">' + valData1[4] + '</td>' +

            '<td class="text-center">' + valData1[5] + '</td>' +
            '<td class="text-center" >' + valData1[6] + '</td>' +
            '<td class="text-center" >' + valData1[7] + '</td>' +
            '<td class="text-center" >' + valData1[8] + '</td>' +
            '<td class="text-center" >' + valData1[11] + '</td>' +
            '<td class="text-center" >' + valData1[12] + '</td>' +

            '<td class="text-center" ><i class="fas fa-trash-alt" style="cursor:pointer" onclick="FnDelete(' + (n + 1) + ',' + valData1[0] + ')"></i></td>' +
            //'<td class="text-center" style="display:none"><input type="hidden" id="workrow_' + (n + 1) + '" value="' + valData1[0] + '"></td>' +
            
            '<td class="text-center" style="display:none">' + valData1[0] + '</td>' +

            //'<td class="text-center" style="display:none"><input type="hidden" id="descrow_' + (n + 1) + '" value="' + valData1[2] + '"></td>'+
            '<td class="text-center" style="display:none">' + valData1[2] + '</td>' +
            
            '</tr >');

        n = n + 1;

    }

    $("#tableData").show();

    $("#txtReason").val("");
    $("#txtRemarks").val("");
    $("#txtpercentage").val("");
    $("#datepicker").val("");
    $("#gitbranch").val("");
    $("#gitres").val("");
    // $("#ddlwbs").val();
    $("#txtwbspercent").val("");
    $("#showSubmitBtn").show();
}
function frmExit() {
    window.open("index.aspx", "_self");

}
/*insert data into tabel */
function ConfirmNote() {
    debugger;
    var ItemDtls = "";
    var usr = $("[id*=hdUserId]").val();

    //if ($("#tableData tr").length == 0 || $("#tableData tr").length == 1) {
    if ($("#tableData tr").length == 0) {
        alert("Add Any Item....!!!!");
        return false;
    }
    else {
        var table = document.getElementById('tableData');
        
        var rowLength = table.rows.length;


        for (var i = 1; i < rowLength - 1; i++) {
           

            var DescId = table.rows[i + 1].cells[14].innerHTML;
            //alert(DescId);
            debugger;
            // var DraftDtl = data.split('-');
            // alert("rowleng:"+rowLength);
            var workId = table.rows[i + 1].cells[13].innerHTML;
            //alert(workId);
            //ItemDtls = ItemDtls + table.rows[i].cells[1].innerHTML + '^' + table.rows[i].cells[2].innerHTML + '^' + table.rows[i].cells[3].innerHTML + '^' + table.rows[i].cells[4].innerHTML + '^' + table.rows[i].cells[5].innerHTML + '$';
            ItemDtls = ItemDtls + workId + '^' + DescId + '^' + table.rows[i + 1].cells[5].innerHTML + '^' + table.rows[i + 1].cells[6].innerHTML + '^' + table.rows[i + 1].cells[7].innerHTML + '^' + usr + '^' + table.rows[i + 1].cells[8].innerHTML + '^' + table.rows[i + 1].cells[9].innerHTML + '^' + table.rows[i + 1].cells[3].innerHTML + '^' + table.rows[i + 1].cells[4].innerHTML + '^' + table.rows[i + 1].cells[1].innerHTML + '^' + table.rows[i + 1].cells[10].innerHTML + '^' + table.rows[i + 1].cells[11].innerHTML + '$';
            //alert(table.rows[i + 1].cells[1].innerHTML);
            //alert(ItemDtls);
        }
        //alert(ItemDtls);
        debugger;
        //0^Other Works^6^Development of web services^  developmetn ^5:00^completed^05/Oct/2021^56^-1^4~

        $.ajax({
            type: "post",
            contentType: "application/json; charset=utf-8",

            url: "DailyTracking.aspx/InsertData",
            data: "{pageVal:'DailyTrack', pageval1 :'" + ItemDtls + "',pageval2:'" + usr + "'}",
            dataType: "json",
            success: function (result) {

                result = result.d;

                let timerInterval
                Swal.fire({
                    width: 400,
                    type: 'success',
                    title: 'Success!',
                    html: "Your work has been Saved. ",
                    //showConfirmButton: false,
                    allowOutsideClick: false,
                    timer: 10000,
                    onBeforeOpen: () => {
                        //Swal.showLoading()
                        timerInterval = setInterval(() => {
                            Swal.getContent().querySelector('strong')
                                .textContent = Swal.getTimerLeft()
                        }, 100)
                    },
                    onClose: () => {
                        clearInterval(timerInterval)
                        window.open('dailytracking.aspx?crfid=1', '_self');
                    }
                }).then((result) => {
                    if (
                        // Read more about handling dismissals
                        result.dismiss === Swal.DismissReason.timer
                    ) {
                        window.open('dailytracking.aspx?crfid=1', '_self');
                    }
                })
                
            },
            error: function (result) {
                // alert('Failed');
                // window.location = "../VMSReports/vms_maintenance.aspx";
            }
        });


    }

}
function FnDelete(val, val1) {


    $("#row_" + val).remove();

    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "DailyTracking.aspx/selectdata",
        data: "{pageVal:'DELETEROW', pageval1 :'" + val1 + "'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;

            if (Result == '1~') {
                alert("Deleted");
            }


        }
    });
    var table = document.getElementById('tableData');

    var rowLength = table.rows.length;

    if (rowLength < 3) {
        $("#tableData").hide();
    }

}
function GetEmpStatus() {

    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "DailyTracking.aspx/CheckEmployeeDepartment",
        async: false,
        data: "{pageVal:'CheckEmployeeDepartment', pageval1 :'" + $("[id*=hdUserId]").val() + "', pageval2 :''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;

            if (Result == "0") {
                $("[id*=hdEmpCheck]").val(Result); //developer

            }
            else {
                $("[id*=hdEmpCheck]").val("1"); //tester
            }
        }
    });
}

function onlyNos(e, t) {

    try {
        if (window.event) { //To disable other button clicks
            if (window.event.keyCode == 13) { e.preventDefault(); } var charCode = window.event.keyCode;
        } else if (e) { var charCode = e.which; } else { return true; } if (charCode > 31 && (charCode < 48 || charCode > 57)) { return false; } return true;
    } catch (err) { alert(err.Description); }
}

