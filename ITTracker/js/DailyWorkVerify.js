var dev = 0;
var wrkId = 0;
$(window).on('load', function () {
    checkTechLead();

    $("[id*=hddraftid]").val('');
    let querystring = window.location.search.substring(1);
    let crfid = querystring.split("=")[1];


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
    //$("#datepicker1").datepicker({
    //    dateFormat: 'dd/M/yy',
    //    changeMonth: true,
    //    changeYear: true,
    //    stepMonths: true,
    //    maxDate: '0',
    //    todayHighlight: true,

    //    onSelect: function (dateText, inst) {
    //    }

    //});

});

function checkTechLead() {

    var usr = $("[id*=hdUserId]").val();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "DailyWorkVerifying.aspx/getDatas",
        data: "{pageVal:'CHECKTLORDEV', pageval1 :'" + usr + "'}",
        async: false,
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            
            if (Result != '0') {
                TeamMembers();
                checkdata();
            }
            

        }
    });
}

function TeamMembers() {
    var user = $("[id*=hdUserId]").val();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "DailyWorkVerifying.aspx/getFillData",
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


function checkdata() {

    var usr = $("[id*=hdUserId]").val();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "DailyWorkVerifying.aspx/selectdata",
        data: "{pageVal:'CHECKWORKS', pageval1 :'" + usr + "'}",
        dataType: "json",
        async:false,
        success: function (Result) {
            Result = Result.d;
            if (Result != '100~') {
                display(Result);
            }

        }
    });
}

var n = 0;
function display(data) {
    var valData = data.split('~');
    if ($("#tableData tr").length == 0) {
        $("#tableData").empty();
        $("#tableData").append('<tr style="background-color:#fdd935;color:#ed2023"><th class="text-center">Developer</th><th class="text-center">Assigned Work</th><th class="text-center">Description of Work Performed</th><th class="text-center">Detail Description</th><th class="text-center">Time</th><th class="text-center">Remarks</th><th class="text-center">Date</th><th class="text-center">Percentage</th><th class="text-center">Delete</th><tr>');
    }

    for (i = 0; i < valData.length - 1; i++) {
        valData1 = valData[i].split('^');
        
        $("#tableData").append('<tr id="row_' + (n + 1) + '">' +

            '<td class="text-center slrow_' + (n + 1) + '">' + valData1[9] + '</td>' +

            '<td class="text-center">' + valData1[1] + '</td>' +
            '<td class="text-center">' + valData1[3] + '</td>' +
            '<td class="text-center">' + valData1[4] + '</td>' +

            '<td class="text-center">' + valData1[5] + '</td>' +
            '<td class="text-center" >' + valData1[6] + '</td>' +
            '<td class="text-center" >' + valData1[7] + '</td>' +
            '<td class="text-center" >' + valData1[8] + '</td>' +
            '<td class="text-center" ><i class="fas fa-trash-alt" style="cursor:pointer" data-toggle="modal" data-target="#ModeModal" onclick="LoadModal(' + valData1[10] + ')"></i></td>' +

            //'<td class="text-center" ><i class="fas fa-trash-alt" style="cursor:pointer" data-toggle="modal" data-target="#ModeModal" onclick="LoadModal(' + valData1[0] + '^' + valData1[10] + '^' + valData1[9] + '^' + valData1[1] + '^' + valData1[6] + '^' + valData1[4] + '^' + valData1[7] +')"></i></td>' +
            //'<td class="text-center" ><i class="fas fa-trash-alt" style="cursor:pointer" data-toggle="modal" data-target="#ModeModal" onclick="FnDelete(' + valData1[0] + ',' + valData1[10] + ')"></i></td>' +
            '<td class="text-center" style="display:none">' + valData1[0] + '</td>' +

            '<td class="text-center" style="display:none">' + valData1[10] + '</td>' +
            '</tr >');

        n = n + 1;

    }

    //$("#tableData").show();

    var table = document.getElementById('tableData');

    //var rowLength = table.rows.length;
    //if (rowLength < 3) {
    //    $("#tableData").hide();
    //}

    $("#txtReason").val("");
    $("#txtRemarks").val("");
    $("#txtpercentage").val("");
    $("#datepicker").val("");
}
function frmExit() {
    window.open("index.aspx", "_self");

}
function LoadModal(datas) {
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "DailyWorkVerifying.aspx/selectdata",
        data: "{pageVal:'SelectWork', pageval1 :'" + datas + "'}",
        dataType: "json",
        async: false,
        success: function (Result) {
            Result = Result.d;
            var array = Result.split('^');
            $("#txtWorkBy").val(array[5]); 
            $("#txtAssWork").val(array[0]);
            $("#txtWorDes").val(array[1]);
            $("#txtDate").val(array[3]);
            $("#txtPercent").val(array[4]); 
            $("#txtTime").val(array[2]); 
            $("#txtComments").val("");
            dev = array[6].replace("~", "");
            wrkId = datas;
        }
    });
}

function ConfirmDelete() {
    var usr = $("[id*=hdUserId]").val();
    if ($("#txtComments").val() == "") {
        Swal.fire("Please add your comments.!");
        $("#txtComments").focus();
        return false;
    }
    var datas = wrkId + "^" + $("#txtAssWork").val() + "^"+ dev + "^" + usr + "^" + $("#txtDate").val() + "^" + $("#txtTime").val() + "^" + $("#txtPercent").val() + "^" + $("#txtComments").val();
   // alert(dev);
    $.ajax({
            type: "post",
            contentType: "application/json; charset=utf-8",
            url: "DailyWorkVerifying.aspx/selectdata",
            data: "{pageVal:'INSERTDELETEDROW', pageval1 :'" + datas + "'}",
            dataType: "json",
            success: function (Result) {
                Result = Result.d;

                if (Result != null) {
                    FnDelete(wrkId);
                    
                }
            }
        });
}


function FnDelete(val1) {
    $("#row_" + n).remove();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "DailyWorkVerifying.aspx/selectdata",
        data: "{pageVal:'DELETEROW', pageval1 :'" + val1 + "'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;

            if (Result == '1~') {
                window.open('DailyWorkVerifying.aspx', '_self');
            }
        }
    });
    var table = document.getElementById('tableData');

    //var rowLength = table.rows.length;
    //if (rowLength < 3) {
    //    $("#tableData").hide();
    //}

}

function ShowData() {
    var  frm_date;
    if ($("#ddlDevlp1").val() == "" || $("#ddlDevlp1").val() == null) {
        Swal.fire("Please Choose Developer..");
        $("#ddlDevlp1").focus();
        return false;
    }
    if ($("#datepicker").val() == "" || $("#datepicker").val() == null) {
        Swal.fire("Please Choose Date..");
        $("#datepicker").focus();
        return false;
    }
    else frm_date = $("#datepicker").val();
    $("#tableData tr").remove();
    var usr = $("[id*=hdUserId]").val();
    var data = usr + "~" + frm_date + "~"+ $("#ddlDevlp1").val();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "DailyWorkVerifying.aspx/selectdata",
        data: "{pageVal:'CHECKWORKDATEWISE', pageval1 :'" + data + "'}",
        dataType: "json",
        async: false,
        success: function (Result) {
            Result = Result.d;
            if (Result != '100~') {
                display(Result);
            }

        }
    });
   
}
var ids = "";
function ConfirmNote() {
    var usr = $("[id*=hdUserId]").val();
    var table = document.getElementById('tableData');
    var rowLength = table.rows.length;
    for (var i = 1; i < rowLength - 1; i++) {
        ids = ids + table.rows[i + 1].cells[10].innerHTML + ",";
    }
    ids = ids.substring(0, ids.length - 1);
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "DailyWorkVerifying.aspx/InsertData",
        data: "{pageVal:'CONFIRMEDWORKS', pageval1 :'" + ids + "', pageval2 :'" + usr + "'}",
        dataType: "json",
        async: false,
        success: function (Result) {
            Result = Result.d;
            if (Result == "123") {
               // Swal.fire("Successfully Updated..!");
                Swal.fire({
                    width: 400,
                    type: 'success',
                    title: 'Success!',
                    html: "Work Verified!! ",
                    allowOutsideClick: false,
                    timer: 10000,
                    onBeforeOpen: () => {
                        timerInterval = setInterval(() => {
                            Swal.getContent().querySelector('strong')
                                .textContent = Swal.getTimerLeft()
                        }, 100)
                    },
                    onClose: () => {
                        clearInterval(timerInterval)
                        window.open('DailyWorkVerifying.aspx?crfid=1', '_self');
                    }
                }).then((result) => {
                    if (
                        result.dismiss === Swal.DismissReason.timer
                    ) {
                        window.open('DailyWorkVerifying.aspx?crfid=1', '_self');
                    }
                })
            }

        }
    });
 
}
