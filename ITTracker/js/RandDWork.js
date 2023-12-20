
var tot = 0;
var days = "";
var f = 0;
var c;
var accessility = 0;
$(window).on('load', function () {
    showDetails();
   
    $("#txtModRemar").val(""); 
    $("#txtRemarks").val("");
    $("#txtModRemarks2").val("");
    teamload();
    $('#lblTeam').html("");
    $('#lblStDt').html("");
    $('#lblTarDt').html("");
    $("#tardthides").hide();
    $("#txtStartDt1").datepicker({
        dateFormat: 'dd/MM/yy',
        changeMonth: true,
        changeYear: true,
        stepMonths: true,
        todayHighlight: true,
        onSelect: function (dateText, inst) {
        }

    });
    $("#txtEndDt1").datepicker({
        dateFormat: 'dd/MM/yy',
        changeMonth: true,
        changeYear: true,
        stepMonths: true,
        todayHighlight: true,
        onSelect: function (dateText, inst) {
        }

    });
    var chk = accessibility_Check();
    if (chk == 1) {
       //usersload();
        //crfload();
        GetTechnology();//----------krish

    }
   

});
function detailsLoad() {
    var crf = $("#ddlCrf").val();
    var data = "";
    if (crf == "-1") {
        Swal.fire("Please choose CRF.!");
        return false;
    }
    else {
        $.ajax({
            type: "post",
            contentType: "application/json; charset=utf-8",
            url: "RandDDeveloperUpdate.aspx/getDetails",
            data: "{pageVal:'LOADRANDDDTLS', pageval1 :'" + crf + "',pageval2 :''}",
            dataType: "json",
            async: false,
            success: function (Result) {

                Result = Result.d;
                var crfdtl = Result;
                var cdtl = crfdtl.split('~');
                $('#lblTeam').html(cdtl[0]);
                $('#lblStDt').html(cdtl[1]);
                $('#lblTarDt').html(cdtl[2]);
            },
            error: function (Result) {

                alert(Result);
            }
        });



    }
}

function showTables() {
    var work_id = $("#ddlCrf").val();
    var data = "";
    if (work_id == "-1") {
        Swal.fire("Please choose a Work.");
        return false;
    }
    else {
    
        $("#tardthides").show();
        $.ajax({
            type: "post",
            contentType: "application/json; charset=utf-8",
            url: "RandDWorkCreate.aspx/AccessCheck",
            data: "{pageVal:'GetRADDetails', pageval1:'" + work_id + "'}",
            dataType: "json",
            async: false,
            success: function (Result) {
                Result = Result.d;
                data = Result;
                
            }
        });

        var valData, valData1;
        data = data + '¶';
        valData = data.split('¶');
        $("#tabChange2").empty();
        if ($("#tabChange2 tr").length == 0) {
            $("#tabChange2").empty();
            $('#tabChange2').append('<tr style="color:black; background-color:honeydew" class="text-left"><th class="text-left">Task ID</th><th class="text-left">Sub Task</th><th class="text-left">Tech Lead</th><th class="text-left">Developer</th><th class="text-left">Man Hours</th><th class="text-left">Start Date</th><th class="text-left">End Date</th></tr>');
        }

        for (i = 0; i < valData.length - 1; i++) {

            valData1 = valData[i].split('^');
            $('#tabChange2').append('<tbody><tr>' +
                '<td>' + valData1[0] + '</td>' +
                '<td>' + valData1[1] + '</td>' +
                '<td>' + valData1[3] + '</td>' +
                '<td>' + valData1[2] + '</td>' +
                '<td>' + valData1[4] + '</td>' +
                '<td>' + valData1[5] + '</td>' +
                '<td>' + valData1[6] + '</td></tr> </tbody>');
        }
        detailsLoading();
        
    }
}
function showDetails_wrk() {
    $("#wrksplit").show();
      
}

function isNumber(evt, val1, isDec) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (isDec == 0 && charCode == 46) {
        return false;
    } else if (isDec == 1 && charCode == 46) {
        var dec = val1.split('.');
        if (dec.length > 1 && charCode == 46) {
            return false;
        }
    }
    if (charCode == 37 || charCode == 39 || charCode == 46) {
        return true;
    }
    if ((charCode > 31 && charCode < 48) || charCode > 57) {
        return false;
    }
    return true;
}

function targetdatetaking() {
  
    var data = 0;
    var dtls = "";
    var user = $("#ddldevelpr").val();
    if ($("#TNoc").val() == "") {
        Swal.fire("Please add man hours");
        data = 1;
        return false;
    }
    if ($("#txtStartDt1").val() == "") {
        Swal.fire("Please choose start date");
        data = 1;
        return false;
    }
    if (user == "-1") {
        Swal.fire("Please select a developer.!");
        data = 1;
        return false;
    }

    if (data == 0) {
        
        dtls = $("#TNoc").val() + '~' + $("#txtStartDt1").val() + '~' + user;
       
        $.ajax({
            type: "post",
            contentType: "application/json; charset=utf-8",
            url: "RandDWorkCreate.aspx/AccessCheck",
            data: "{pageVal:'GetEndDate', pageval1:'" + dtls + "'}",
            dataType: "json",
            async: false,
            success: function (Result) {
                Result = Result.d;
                $("#tardthide").show();
                $("#txtEndDt1").val(Result);
                document.getElementById("txtEndDt1").disabled = true;
            }
        });
    }
}





function teamload() {
    $('#ddlTeam').empty();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "RandDWorkCreate.aspx/getFillData",
        data: "{pageVal:'RANDDTEAM', pageval1 :''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            $('#ddlTeam').append($("<option></option>").val("-1").html("Choose team.."));
            $.each(Result, function (key, value) {
                $('#ddlTeam').append($("<option></option>").val(value.id).html(value.name));
            });
        }
    });
}

function frmExit() {
    window.open("index.aspx", "_self");
}
//////////////C krishnan////////////////// ---------------------
function GetTechnology() {
    var usr = $("[id*=hdUserId]").val();
    $('#ddlTechno').empty();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "RandDWorkCreate.aspx/getFillData",
        data: "{pageVal:'RANDDTECHNOLOGY', pageval1 :'', pageval2 :''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            $('#ddlTechno').append($("<option></option>").val("-1").html("Choose Technology"));
            $.each(Result, function (key, value) {
                $('#ddlTechno').append($("<option></option>").val(value.id).html(value.name));
            });
        }
    });
}
function crfload() {
    var usr = $("[id*=hdUserId]").val();
    var techid = $("#ddlTechno").val();
    var data = usr + '~' + techid;
    //alert(data);
    //alert(techid);
    $('#ddlCrf').empty();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "RandDWorkCreate.aspx/getFillData",
        data: "{pageVal:'RDWORKTOCANCELORCLOSE', pageval1 :'" + data + "'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            $('#ddlCrf').append($("<option></option>").val("-1").html("Choose CRF"));
            $.each(Result, function (key, value) {
                $('#ddlCrf').append($("<option></option>").val(value.id).html(value.name));
            });
        }
    });
}

function showDetails() {
    $("#crwork").show();
    $("#to_tech").hide();//-----
    $("#tardthides").hide();
    $("#showSubmitBtn").show();
    $("#to_cancell").hide();
    $("#showCloseBtn").hide();
    $("#showCncelBtn").hide();
    $("#closecanceldata").hide();
    $('#lblTeam').html("");
    $('#lblStDt').html("");
    $('#lblTarDt').html("");
}
function closeSection() { 
    $("#tardthides").hide();
    $("#wrksplit").hide();
    $("#showSubmitBtn").hide();
    $("#to_tech").show();//-----
    $("#to_cancell").show();
    $("#showCloseBtn").show();
    $("#showCncelBtn").hide();
    $("#crwork").hide();
    $("#txtModRemar").val("");
    $("#closecanceldata").show();
    $('#lblTeam').html("");
    $('#lblStDt').html("");
    $('#lblTarDt').html("");
    GetTechnology();//---
    //crfload();
}
function cancelSection() {
    $("#tardthides").hide();
    $("#wrksplit").hide();
    $("#showSubmitBtn").hide();
    $("#to_tech").show();//------------
    $("#to_cancell").show(); 
    $("#showCncelBtn").show();
    $("#showCloseBtn").hide();
    $("#crwork").hide();
    $("#txtModRemar").val("");
    $("#closecanceldata").show();
    $('#lblTeam').html("");
    $('#lblStDt').html("");
    $('#lblTarDt').html("");
    GetTechnology();//---
    //crfload();
}


function DevLoad() {

    var tm = $("#ddlTeam").val();
    $('#ddldevelpr').empty();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "RandDWorkCreate.aspx/getFillData",
        data: "{pageVal:'DevelopersLoadRD', pageval1 :'"+tm+"'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            $('#ddldevelpr').append($("<option></option>").val("-1").html("Choose a developer.."));
            $.each(Result, function (key, value) {
                $('#ddldevelpr').append($("<option></option>").val(value.id).html(value.name));
            });
        }
    });
}


function AddTableDatas() {
    var data = "";
    if ($("#subid").val() == "") {
        Swal.fire("Please Add Subject.!");
        $("#subid").focus();
        return false;
    }
    if ($("#bususer").val() == "") {
        Swal.fire("Please Add Business User.!");
        $("#bususer").focus();
        return false;
    }
    if ($("#subtaskname").val() == "") {
        Swal.fire("Sub task field can not be empty.!");
        $("#subtaskname").focus();
        return false;
    }
    if ($("#usecase").val() == "") {
        Swal.fire("Use case field can not be empty.!");
        $("#usecase").focus();
        return false;
    }
    if ($("#ddldevelpr").val() == "-1") {
        Swal.fire("Please assign the task to a person.!");
        $("#ddldevelpr").focus();
        return false;
    }
    if ($("#txtStartDt1").val() != "") {
        var frmDateCom = $("#txtStartDt1").val();
        var newFrmDate = Date.parse(frmDateCom);
    }
    else {
        Swal.fire("Starting date can not be empty.!")
        $("#txtStartDt1").focus();
        return false;
    }
    if ($("#txtEndDt1").val() != "") {
        var ToDateCom = $("#txtEndDt1").val();
        var NewToDate = Date.parse(ToDateCom);
    }
    else {
        Swal.fire("Please Add an expected target date.!")
        $("#txtEndDt1").focus();
        return false;
    }
    //var dateDifference = NewToDate - newFrmDate;
    //if (dateDifference < 0) {
    //    Swal.fire("Choose End Date greater than Start Date.!");
    //    $("#txtEndDt1").val("");
    //    $("#txtEndDt1").focus();
    //    return false;
    //} 
    if ($("#txtModRemarks2").val() == "") {
        Swal.fire("Please Add short description.!");
        $("#txtModRemarks2").focus();
        return false;
    }
    if ($("#TNoc").val() == "") {
        Swal.fire("Please add Man hours.!");
        $("#TNoc").focus();
        return false;
    }
    if ($("#ddlTeam").val() == "-1") {
        Swal.fire("Please choose team.!");
        $("#ddlTeam").focus();
        return false;
    }
    //-----------------1-------
    data = $("#subtaskname").val() + "^" + $("#usecase").val() + "^" + $("#ddldevelpr option:selected").text() + "^" + $("#txtStartDt1").val() + "^" + $("#txtEndDt1").val() + "^" + $("#txtModRemarks2").val() + "^" + $("#ddldevelpr").val() + "^" + $("#TNoc").val() + "^" + $("#ddlTeam").val() +"¶"; 
    tableFill(data);
    $("#txtModRemarks2").val("");
    $("#TNoc").val("");
    $("#txtStartDt1").val("");
    $("#txtEndDt1").val("");
    $("#tardthide").hide();
}
function tableFill(data) {
    var valData, valData1;
    valData = data.split('¶');
    if ($("#tabChange1 tr").length == 0) {
        $("#tabChange1").empty();
        $('#tabChange1').append('<tr style="color:black; background-color:honeydew" class="text-left"><th class="text-left">Sub Task</th><th class="text-left">Use Cases</th><th class="text-left">Assign To</th><th class="text-left">Start Date</th><th class="text-left">End Date</th><th class="text-left">Man Hours</th><th class="text-left">Description</th>><th class="text-left">Delete</th></tr>');
    }
    for (i = 0; i < valData.length - 1; i++) {
        valData1 = valData[i].split('^');
        $('#tabChange1').append('<tbody><tr>' +
            '<td>' + valData1[0] + '</td>' +
            '<td>' + valData1[1] + '</td>' +
            '<td>' + valData1[2] + '</td>' +
            '<td>' + valData1[3] + '</td>' +
            '<td>' + valData1[4] + '</td>' +
            '<td>' + valData1[7] + '</td>' +
            '<td>' + valData1[5] + '</td>' +
            '<td style="display:none">' + valData1[6] + '</td>' +
            '<td style="display:none">' + valData1[8] + '</td>' +
            '<td><a href="javascript:void(0);" class="remove"  id="remrow"><span class="glyphicon glyphicon-trash">Remove</span></a></td></tr > </tbody > ');
    }
    
}
$(document).on('click', '.remove', function () {

    $(this).closest('tr').remove();
    dirRemovefromHidden();
    return false;
});

function detailsLoading() {
    var crf = $("#ddlCrf").val();
    var data = "";
    if (crf == "-1") {
        Swal.fire("Please choose CRF.!");
        return false;
    }
    else {
        $.ajax({
            type: "post",
            contentType: "application/json; charset=utf-8",
            url: "RandDDeveloperUpdate.aspx/getDetails",
            data: "{pageVal:'LOADRANDDDTLS', pageval1 :'" + crf + "',pageval2 :''}",
            dataType: "json",
            async: false,
            success: function (Result) {

                Result = Result.d;
                var crfdtl = Result;
                var cdtl = crfdtl.split('~');
                $('#lblTeam').html(cdtl[0]);
                $('#lblStDt').html(cdtl[1]);
                $('#lblTarDt').html(cdtl[2]);
            },
            error: function (Result) {

                alert(Result);
            }
        });
        $.ajax({
            type: "post",
            contentType: "application/json; charset=utf-8",
            url: "RandDDeveloperUpdate.aspx/getDetails",
            data: "{pageVal:'LoaDRANDDRmrk', pageval1 :'" + crf + "',pageval2 :''}",
            dataType: "json",
            async: false,
            success: function (Result) {

                Result = Result.d;
                var crfdtl = Result;
                var cdtl = crfdtl.split('~');
                $('#lblrmk').html(cdtl[0]);
                $('#lblSts').html(cdtl[1]);
            },
            error: function (Result) {

                alert(Result);
            }
        });

        filesFill(crf);



    }
}



function WorkCreateConfirm() {
    var table = document.getElementById('tabChange1');
    var rowLength = table.rows.length;
    if (rowLength < 2) {
        Swal.fire("Please Create work Properly.!");
        return false;
    }
    if ($("#txtModRemar").val() == "") {
        $("#txtModRemar").val("Nil");
    }
    var data = "";
    for (var i = 1; i < rowLength; i += 1) {
        var row = table.rows[i];
        var cellLength = row.cells.length;
        for (var y = 0; y < cellLength - 1; y += 1) {
            var cell = row.cells[y];
            data = data + cell.innerText + '^';
        }
        data = data + '¶';
        
    }
    
  
    var usr = $("[id*=hdUserId]").val();
    var details = $("[id*=hdUserId]").val() + '^' + $("#bususer").val()+ '^' + $("#subid").val() + '^' + $("#txtModRemar").val(); 
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "RandDWorkCreate.aspx/RequestNoteConfirm",
        data: "{pageVal:'RDWORKCONFIRM', pageval1:'WORKCREATE',pageval2:'" + details + "',pageval3:'" + data+"'}",
        dataType: "json",
        async: false,
        success: function (Result) {
            Result = Result.d;
            if (Result != '') {
                let timerInterval
                Swal.fire({
                    width: 400,
                    type: 'success',
                    title: 'Success!',
                    html: "Work has been Created.",
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
                        window.open('RandDWorkCreate.aspx?crfid=1', '_self');
                    }
                }).then((result) => {
                    if (
                        result.dismiss === Swal.DismissReason.timer
                    ) {
                        window.open('RandDWorkCreate.aspx?crfid=1', '_self');
                    }
                })
            }
            else {
                alert("Something went wrong.!Please contact IT Support");
            }
                
        }
    });
   
}
function WorkCancelConfirm() {
    if ($("#ddlTechno").val() == '-1') {
        Swal.fire("Please choose a Technology.!");
        return false;
    }
    if ($("#ddlCrf").val() == '-1') {
        Swal.fire("Please choose a CRF.!");
        return false;
    }
    if ($("#txtModRemar").val() == "") {
        $("#txtModRemar").val("Nil");
    }
    var usr = $("[id*=hdUserId]").val();
    var details = $("[id*=hdUserId]").val() + '^' + $("#ddlCrf").val() + '^' +$("#txtModRemar").val();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "RandDWorkCreate.aspx/RequestNoteConfirm",
        data: "{pageVal:'RDWORKCONFIRM', pageval1:'WORKCANCEL',pageval2:'" + details + "',pageval3:'Cancel'}",
        dataType: "json",
        async: false,
        success: function (Result) {
            Result = Result.d;
           
            if (Result != '0') {
                let timerInterval
                Swal.fire({
                    width: 400,
                    type: 'success',
                    title: 'Success!',
                    html: "Work has been Cancelled.",
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
                        window.open('RandDWorkCreate.aspx?crfid=1', '_self');
                    }
                }).then((result) => {
                    if (
                        result.dismiss === Swal.DismissReason.timer
                    ) {
                        window.open('RandDWorkCreate.aspx?crfid=1', '_self');
                    }
                })
            }
            else {
                alert("Something went wrong.!Please contact IT Support");
            }
        }
    });

}
function WorkReturnConfirm() {
    if ($("#ddlTechno").val() == '-1') {
        Swal.fire("Please choose a Technology.!");
        return false;
    }
    if ($("#ddlCrf").val() == '-1') {
        Swal.fire("Please choose a CRF.!");
        return false;
    }
    if ($("#txtModRemar").val() == "") {
        $("#txtModRemar").val("Nil");
    }
    var usr = $("[id*=hdUserId]").val();
    var details = $("[id*=hdUserId]").val() + '^' + $("#ddlCrf").val() + '^' + $("#txtModRemar").val();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "RandDWorkCreate.aspx/RequestNoteConfirm",
        data: "{pageVal:'RDWORKCONFIRM', pageval1:'WORKRETURN',pageval2:'" + details + "',pageval3:'Return'}",
        dataType: "json",
        async: false,
        success: function (Result) {
            Result = Result.d;
            if (Result != '0') {
                let timerInterval
                Swal.fire({
                    width: 400,
                    type: 'success',
                    title: 'Success!',
                    html: "Work has been Returned to Developer.",
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
                        window.open('RandDWorkCreate.aspx?crfid=1', '_self');
                    }
                }).then((result) => {
                    if (
                        result.dismiss === Swal.DismissReason.timer
                    ) {
                        window.open('RandDWorkCreate.aspx?crfid=1', '_self');
                    }
                })
            }
            else {
                alert("Something went wrong.!Please contact IT Support");
            }
        }
    });
}
function WorkCloseConfirm() {
    if ($("#ddlTechno").val() == '-1') {
        Swal.fire("Please choose a Technology.!");
        return false;
    }
    if ($("#ddlCrf").val() == '-1') {
        Swal.fire("Please choose a CRF.!");
        return false;
    }
    if ($("#txtModRemar").val() == "") {
        $("#txtModRemar").val("Nil");
    }
    var usr = $("[id*=hdUserId]").val();
    var details = $("[id*=hdUserId]").val() + '^' + $("#ddlCrf").val() + '^' + $("#txtModRemar").val();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "RandDWorkCreate.aspx/RequestNoteConfirm",
        data: "{pageVal:'RDWORKCONFIRM', pageval1:'WORKCLOSE',pageval2:'" + details + "',pageval3:'Close'}",
        dataType: "json",
        async: false,
        success: function (Result) {
            Result = Result.d;
            if (Result != '0') {
                let timerInterval
                Swal.fire({
                    width: 400,
                    type: 'success',
                    title: 'Success!',
                    html: "Work has been Closed.",
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
                        window.open('RandDWorkCreate.aspx?crfid=1', '_self');
                    }
                }).then((result) => {
                    if (
                        result.dismiss === Swal.DismissReason.timer
                    ) {
                        window.open('RandDWorkCreate.aspx?crfid=1', '_self');
                    }
                })
            }
            else {
                alert("Something went wrong.!Please contact IT Support");
            }
        }
    });
}


function accessibility_Check() {
     //alert("sfghfjgkhl");
    var usr = $("[id*=hdUserId]").val();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "RandDWorkCreate.aspx/AccessCheck",
        data: "{pageVal:'CheckUserID', pageval1:'" + usr + "'}",
        dataType: "json",
        async: false,
        success: function (Result) {
            Result = Result.d;
            if (Result == '1') { accessility = 1; }
            else { accessility = 0; }
                    
        }
    });
    return accessility;
}

function filesFill(noteid) {

    $("#tblFiles").empty();
    var filenm = $("[id*=hdUserId]").val() + noteid.replace(/[^a-zA-Z0-9]/g, '') + "_";
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "RandDCTOorHeadApprove.aspx/getFileData",
        async: false,
        data: "{pageVal:'RandDAttach', pageval1 :'" + noteid + "', pageval2 :'" + filenm + "'}",
        dataType: "json",
        success: function (Result) {

            Result = Result.d;


            var valData, valData1;
            var n = 0;
            valData = Result.split('Θ');
            if ($("#tblFiles tr").length == 0) {
                $('#tblFiles').append('<thead class="bg-success text-white"><tr><th scope="col">File No</th><th scope="col">File Name</th></tr></thead>');
            }

            for (j = 0; j < valData.length - 1; j++) {

                var contentDtl = valData[j].split('µ');
                //alert(contentDtl[3]);
                var binaryString = contentDtl[3];
                var filename = filenm + contentDtl[1];
                var extension = contentDtl[2];
                var _location = document.location.toString();
                var applicationNameIndex = _location.indexOf('/', _location.indexOf('://') + 3);
                var applicationName = _location.substring(0, applicationNameIndex) + '/';
                var myUrl;
                if (document.location.hostname === "localhost") {
                    myUrl = applicationName + "Images/" + filename;
                }
                else {
                    myUrl = applicationName + "ams/Images/" + filename;
                }

                $('#tblFiles').append('<tbody><tr>' +
                    '<td>' + contentDtl[0] + '</td>' +
                    '<td><a href="' + myUrl + '" download="' + filename + '" class="file-list1">' + contentDtl[1] + '</a></td>' +
                    '</tr> </tbody>');
            }


        },
        error: function (Result) {

        }
    });
    if ($("#tblFiles tr").length > 1) {
        $("#Doc").show();
    }
}
