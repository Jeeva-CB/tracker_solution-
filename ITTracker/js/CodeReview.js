$(window).on('load', function () {
    var usr = $("[id*=hdUserId]").val();
    checkLead(usr);
    $("[id*=hdRqstID]").val('');
    CRFLoad();
    $("#txtTarDt").datepicker({
        dateFormat: 'dd/MM/yy',
        changeMonth: true,
        changeYear: true,
        stepMonths: true,
        todayHighlight: true,
        onSelect: function (dateText, inst) {
        }

    });

    fillPerson();

});
function checkLead(user) {
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "CRF_CodeReview.aspx/UATDetail",
        data: "{pageVal:'CHECKDBALEAD', pageval1 :'" + user + "', pageval2:''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            if (Result != "0§") {
                $("#butShow").show();
            }
            else $("#butShow").hide();
        }
    });
}
function GetUatDetails(req) {
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "CRF_CodeReview.aspx/UATDetail",
        data: "{pageVal:'DbDetails', pageval1 :'" + req + "', pageval2:''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            filluatDetails(Result);
        }
    });
}
function Assgn() {
    $("#Codereviewid").show();
}
function GetRequestId(CRFID) {
    var usr = $("[id*=hdUserId]").val();
    usr = usr + '^' + CRFID;
    var dtl = $('#ddlCrf option:selected').text();
    var ddtl = dtl.split('~');
    $("[id*=hdRqstID]").val(ddtl[1]);
}

function filluatDetails(data) {
    var valData, valData1;
    valData = data.split('§');
    if (load == 0) {
        $("#tblUatDtls").empty();
        if ($("#tblUatDtls tr").length == 0) {
            $('#tblUatDtls').append('<tr style="background-color:honeydew;color:black"><th class="text-center">DBTYPE</th><th class="text-center">DBOBJECT</th><th class="text-center">DEVELOPER</th></tr>');
        }
        //var sno = $('#tableData tr').length;
        for (i = 0; i < valData.length - 1; i++) {
            valData1 = valData[i].split('^');
            $('#tblUatDtls').append('<tbody><tr class="text-center"  >' +
                '<td>' + valData1[0] + '</td>' +
                '<td>' + valData1[1] + '</td>' +
                '<td>' + valData1[2] + '</td></tr > </tbody > ');
        }
    }
    else {
        $("#tblUatDtls1").empty();
        if ($("#tblUatDtls1 tr").length == 0) {
            $('#tblUatDtls1').append('<tr style="background-color:honeydew;color:black"><th class="text-center">DBTYPE</th><th class="text-center">DBOBJECT</th><th class="text-center">DEVELOPER</th></tr>');
        }
        //var sno = $('#tableData tr').length;
        for (i = 0; i < valData.length - 1; i++) {
            valData1 = valData[i].split('^');
            $('#tblUatDtls1').append('<tbody><tr class="text-center"  >' +
                '<td>' + valData1[0] + '</td>' +
                '<td>' + valData1[1] + '</td>' +
                '<td>' + valData1[2] + '</td></tr > </tbody > ');
        }
    }
    
}

function fillPerson() {
    $('#ddlDevlp').empty();
    $('#ddlDevlp').append($("<option></option>").val("-1").html("Choose Code Reviewer"));
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "CRF_CodeReview.aspx/getFillData",
        data: "{pageVal:'CodeReviewTeams', pageval1 :'',pageval2 :''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            $.each(Result, function (key, value) {
                $('#ddlDevlp').append($("<option></option>").val(value.id).html(value.name));
            });
        }
    });

}
function CRFLoad() {
    var usr = $("[id*=hdUserId]").val();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "CRF_CodeReview.aspx/getFillData",
        data: "{pageVal:'CodeReviewerLoad', pageval1 :'" + usr + "',pageval2 :''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            $.each(Result, function (key, value) {
                $('#ddlCrf').append($("<option></option>").val(value.id).html(value.name));
            });
        }
    });
}
function UserListLoad() {
    load = 1;
    var CRFID = $("#ddlCrfList").val();
    CRFSearch();   
    if (CRFID == -1) {
        $("#CrfDetailsID1").hide();
    }
    else {
        $("#CrfDetailsID1").show();
    }
    detailsLoad(CRFID);
    var crfdata = $('#ddlCrfList option:selected').text();
    var ddtl = crfdata.split('~');
    var req = ddtl[1];
    $("#txtRemarks1").val("");
}


function fillCRFData() {
    var CRFID = $("#ddlCrf").val();
    CRFSearch();
    $("#snote").show();
    if (CRFID == -1) {
        $("#CrfDetailsID").hide();
    }
    else {
        $("#CrfDetailsID").show();
    }
    detailsLoad(CRFID);
    filesFill(CRFID);
    var crfdata = $('#ddlCrf option:selected').text();
    var ddtl = crfdata.split('~');
    var req = ddtl[1];
    $("#txtRemarks").val("");
}
function CRFSearch() {
    var crfval, reqid, CRFID;
    if (load == 1) {
         crfval = $("#ddlCrfList option:selected").text();
         reqid = crfval.split('~');
         CRFID = $("#ddlCrfList").val();
        if (CRFID == "") {
            alert("Please Choose CRF!!!");
        }

    }
    else {
         crfval = $("#ddlCrf option:selected").text();
         reqid = crfval.split('~');
         CRFID = $("#ddlCrf").val();
        if (CRFID == "") {
            alert("Please Choose CRF!!!");
        }
    }
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "CRF_CodeReview.aspx/getFillData",
        data: "{pageVal:'DataLoadDocUpload', pageval1 :'" + CRFID + "',pageval2 :'" + reqid[0] + "'}",
        dataType: "json",
        success: function (Result) {

            Result = Result.d;
            $.each(Result, function (key, value) {
                var crfdtl = value.id;

                var cdtl = crfdtl.split('±');
                if (load == 0) {
                    $('#lblTeam').html(cdtl[0]);
                    $('#lblType').html(cdtl[1]);
                    $('#lblReqtr').html(cdtl[2]);
                    $('#lblRqstDt').html(cdtl[3]);
                    $('#lblDvCom').html(cdtl[6]);
                    $('#lblTarDt').html(cdtl[8]);
                    $('#lblUserExpectDate').html(cdtl[4]);
                    if (cdtl[7] == 1) {
                        $('#lblErrorImpact').html("Yes");
                    }
                    else {
                        $('#lblErrorImpact').html("No");
                    }
                    if (cdtl[5] == 1) {
                        $('#lblPrior').html("High");
                        $('#lblPrior').prop(color = red);
                    } else if (cdtl[5] == 2) {
                        $('#lblPrior').html("Medium");
                        $('#lblPrior').prop(color, red);
                    } if (cdtl[5] == 3) {
                        $('#lblPrior').html("Low");
                        $('#lblPrior').prop(color, red);

                    }
                }
                else {
                    $('#lblTeam1').html(cdtl[0]);
                    $('#lblType1').html(cdtl[1]);;
                    $('#lblReqtr1').html(cdtl[2]);
                    $('#lblRqstDt1').html(cdtl[3]);
                    $('#lblDvCom1').html(cdtl[6]);
                    $('#lblTarDt1').html(cdtl[8]);
                    $('#lblUserExpectDate1').html(cdtl[4]);
                    if (cdtl[7] == 1) {
                        $('#lblErrorImpact1').html("Yes");
                    }
                    else {
                        $('#lblErrorImpact1').html("No");
                    }
                    if (cdtl[5] == 1) {
                        $('#lblPrior1').html("High");
                        $('#lblPrior1').prop(color = red);
                    } else if (cdtl[5] == 2) {
                        $('#lblPrior1').html("Medium");
                        $('#lblPrior1').prop(color, red);
                    } if (cdtl[5] == 3) {
                        $('#lblPrior1').html("Low");
                        $('#lblPrior1').prop(color, red);

                    }
                }
                
            });
        },
        error: function (Result) {

            alert(Result);
        }
    });
    GetUatDetails(reqid[0]);

}
$(document).ready(function () {
    $('.summernoteview').summernote({
        height: 200, // set editor height
        minHeight: null, // set minimum height of editor
        maxHeight: null, // set maximum height of editor
        focus: false, // set focus to editable area after initializing summernote
        toolbar: [
        ]
    });
    $(".summernoteview").summernote("disable");
    $("#summernoteview").summernote("fullscreen.toggle");
});
function Decrypt(value) {
    var result = "";
    var array = value.split("-");

    for (i = 0; i < array.length; i++) {
        result += String.fromCharCode(array[i] - 10);
    }
    return result;
}

function TestCaseFileLoad(request_id) {

    var count = 0;
    $("#tblFilesTestCase").empty();
    var filenm = "TestCases_" + $("[id*=hdUserId]").val() + "_" + request_id.replace(/[^a-zA-Z0-9]/g, '') + "_";
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "DeveloperUpdation.aspx/getFileData",
        async: false,
        data: "{pageVal:'GetAttachListTestCases', pageval1 :'" + request_id + "', pageval2 :'" + filenm + "'}",
        dataType: "json",
        success: function (Result) {

            Result = Result.d;


            var valData, valData1;
            var n = 0;
            valData = Result.split('Θ');
            if ($("#tblFilesTestCase tr").length == 0) {
                $('#tblFilesTestCase').append('<thead class="bg-success text-white"><tr><th scope="col">File No</th><th scope="col">File Name</th></tr></thead>');
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

                $('#tblFilesTestCase').append('<tbody><tr>' +
                    '<td>' + contentDtl[0] + '</td>' +
                    '<td><a href="' + myUrl + '" download="' + filename + '" class="file-list1">' + contentDtl[1] + '</a></td>' +
                    '</tr> </tbody>');
            }


        },
        error: function (Result) {

        }
    });
    if ($("#tblFilesTestCase tr").length > 1 && count == 0) {
        //alert("You have already attached the Test Case file..Do you need to attach again?.");
        var proceed = confirm("You have already attached the Test Case file..Do you need to attach again?. Click OK for attach new test case OR Click REMOVE button for delete from your Queue.");
        if (proceed) {
            count = 1;
        }
        else {
            return false;
        }
    }
}


function detailsLoad(noteid) {
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "CRFTestCaseUpdation.aspx/getRequestNote",
        data: "{pageVal:'GetRequestNotes', pageval1:'" + noteid + "',pageval2:'2'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            $('.summernoteview').summernote('code', Result);
        }
    });
}

function NoNeedTestCase() {
    if ($("#txtRemarks").val() == "") {
        alert("Kindly add Remarks..!");
        return false;
    }
    var data = $("#ddlCrf").val() + '^' + $("#txtRemarks").val() + '^' + $("[id*=hdRqstID]").val() + '^' + $("[id*=hdUserId]").val() + '^' + '0';
    ConfirmTestcase(data);
}



function filesFill(noteid) {

    $("#tblFiles").empty();
    var filenm = $("[id*=hdUserId]").val() + noteid.replace(/[^a-zA-Z0-9]/g, '') + "_";
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "CRFTestCaseUpdation.aspx/getFileData",
        async: false,
        data: "{pageVal:'GetAttachList', pageval1 :'" + noteid + "', pageval2 :'" + filenm + "'}",
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
}

function frmExit() {
    window.open("index.aspx", "_self");
}

function GetStatus(crfid) {
    usr = $("[id*=hdUserId]").val();
    var data = crfid + '~' + usr;
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "CRFTestCaseUpdation.aspx/getFillData",
        data: "{pageVal:'workstatus', pageval1 :'" + data + "'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            // $('#ddlCrf').append($("<option selected disabled></option>").val("-1").html("Choose CRF"));
            $.each(Result, function (key, value) {
                $('#ddlStatus').append($("<option></option>").val(value.id).html(value.name));
            });
        }
    });
}
function GetUatDetail(req) {
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "CRFTestCaseUpdation.aspx/UATDetail",
        data: "{pageVal:'uatdtl', pageval1 :'" + req + "', pageval2:''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            filluat(Result);
        }
    });
}

function GetcodeView(crfIdStatus) {

    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "ViewerNoteDetails.aspx/CheckEmpAccessNew",
        async: false,
        data: "{pageVal:'CheckEmpAccessForEnquiry', pageval1 :'" + $("[id*=hdUserId]").val() + "', pageval2 :'" + crfIdStatus + "'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            EmpStatus = Result;
            if (EmpStatus == "1") {
                $("#btnEnQuiry").show();
            }
        }
    });
}

function filluat(data) {
    var valData, valData1;
    valData = data.split('§');

    if ($("#tblUatDtls tr").length == 0) {
        $("#tblUatDtls").empty();
        $('#tblUatDtls').append('<tr style="background-color:rosybrown;color:black"><th class="text-center">UATLINK</th><th class="text-center">UATPATH</th><th class="text-center">DBTYE</th><th class="text-center">DBOBJECT</th><th class="text-center">DEVELOPER</th></tr>');
    }
    //var sno = $('#tableData tr').length;
    for (i = 0; i < valData.length - 1; i++) {
        valData1 = valData[i].split('^');

        $('#tblUatDtls').append('<tbody><tr class="text-center" style="background-color:linen" >' +


            '<td>' + valData1[0] + '</td>' +
            '<td>' + valData1[4] + '</td>' +
            '<td>' + valData1[1] + '</td>' +
            '<td>' + valData1[2] + '</td>' +
            '<td>' + valData1[3] + '</td></tr > </tbody > ');


    }

}

function ConfirmCodereview() {
    var flag = 0;
    var dtl = $('#ddlCrfList option:selected').text();
    var ddtl = dtl.split('~');

    $("[id*=hdRqstID]").val(ddtl[0]);
    var frmDateCom = $("#txtTarDt").val();
    var assign = $("#ddlDevlp").val();
    var crfid = $("#ddlCrfList").val();
    if (crfid == "-1") {
        alert("Please select CRF..");
        $("#ddlCrfList").focus();
        return false;
    }
    if (assign == "-1") {
        alert("Please Choose CodeReviewer ..");
        return false;
    }      

    if (frmDateCom == "") {
        alert("Enter Target  Date!!!");

        $("#txtTarDt").focus();
        return false;
        flag = 0;
    }
    if ($("#txtModRemarks1").val() == "") {
        alert("Please Enter Remark...!!!");
        $("#txtModRemarks1").focus();
        return false;
    }

    Data = $("#txtModRemarks1").val() + 'µ' + $("#ddlCrfList").val() + 'µ' + $("[id*=hdRqstID]").val() + 'µ' + $("[id*=hdUserId]").val() + 'µ' + assign + 'µ' + $("#txtTarDt").val() ;
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "CRF_CodeReview.aspx/CodereviewConfirm",
        data: "{pageVal:'CodeReviewConfirm', pageval1 :'" + Data + "',pageval2:'',pageval3:''}",
        dataType: "json",
        async: false,
        success: function (Result) {
            $('.block-ui').addClass('clear');
            Result = Result.d;
            var noteid = Result;
            if (noteid.includes("µ")) {
                var msg = noteid.split("µ");
                var stat = msg[0];
                var content = msg[1];
                if (stat == "9") {
                    dangerAlert(content, 5000);
                    return false;
                }
            }


            if (noteid != "0") {
                let timerInterval
                Swal.fire({
                    width: 400,
                    type: 'success',
                    title: 'Success!',
                    html: "Success ",
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
                        window.open('CRF_CodeReview.aspx?crfid=1', '_self');
                    }
                }).then((result) => {
                    if (
                        // Read more about handling dismissals
                        result.dismiss === Swal.DismissReason.timer
                    ) {
                        window.open('CRF_CodeReview.aspx?crfid=1', '_self');
                    }
                })
            }
            else {
                alert("Something went wrong.! Please contact IT support..")
            }

        }
    });
}
var load = 0;
function LoadModalData() {
    load = 1;
    
    CRFSearch();
}


function loadModal() {
    usr = $("[id*=hdUserId]").val();
    $('#ddlCrfList').empty();
    $('#ddlCrfList').append($("<option></option>").val(-1).html("Choose CRF.."));
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "CRF_CodeReview.aspx/getFillData",
        data: "{pageVal:'CodeReviewLoad', pageval1 :'" + usr + "',pageval2 :''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            $.each(Result, function (key, value) {
                $('#ddlCrfList').append($("<option></option>").val(value.id).html(value.name));
            });
        }
    });
    $("#txtModRemarks1").val("");
}


function Codereview() {
    var flag = 0;
    var dtl = $('#ddlCrf option:selected').text();
    var ddtl = dtl.split('~');
    $("[id*=hdRqstID]").val(ddtl[0]);
    var crfid = $("#ddlCrf").val();
    if (crfid =="-1") {
        alert("Please select CRF..");
        $("#ddlCrf").focus();
        return false;
    }

   
    if ($("#txtRemarks").val() == "") {
        alert("Please Enter Remark...!!!");
        $("#txtRemarks").focus();
        return false;
    }

    Datas= $("#txtRemarks").val() + 'µ' + $("#ddlCrf").val() + 'µ' +  $("[id*=hdRqstID]").val()  + 'µ' + $("[id*=hdUserId]").val() + 'µ';

    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "CRF_CodeReview.aspx/CodereviewConfirm",
        data: "{pageVal:'CodeReviewerConfirm', pageval1 :'" + Datas + "',pageval2:'',pageval3:''}",
        dataType: "json",
        async: false,
        success: function (Result) {
            $('.block-ui').addClass('clear');
            Result = Result.d;
            var noteid = Result;
            if (noteid.includes("µ")) {
                var msg = noteid.split("µ");
                var stat = msg[0];
                var content = msg[1];
                if (stat == "9") {
                    dangerAlert(content, 5000);
                    return false;
                }
            }


            if (noteid != "0") {
                let timerInterval
                Swal.fire({
                    width: 400,
                    type: 'success',
                    title: 'Success!',
                    html: "Success ",
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
                        window.open('CRF_CodeReview.aspx', '_self');
                    }
                }).then((result) => {
                    if (
                        // Read more about handling dismissals
                        result.dismiss === Swal.DismissReason.timer
                    ) {
                        window.open('CRF_CodeReview.aspx', '_self');
                    }
                })
            }
            else {
                alert("Something went wrong.! Please contact IT support..")
            }

        }
    });
}


function ApplicableHide() {

    if ($('#applicableOption').prop('checked')) {
        $("#sensInfotxt").show();
        sesInfo = 1;
    }
    else {
        $("#sensInfotxt").hide();
        sesInfo = 0;
    }

}


