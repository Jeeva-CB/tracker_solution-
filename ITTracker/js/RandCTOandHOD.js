
var tot = 0;
var days = "";
var f = 0;
var c;
var accessility = 0;
$(window).on('load', function () {

    $("#txtModRemar").val("");
    $("#ctoReject").hide();
    $("#lblHDrmrk").hide();

    var chk = accessibility_Check();



    crfload(chk);



});

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
        detailsLoad();
    }
}

function WorkReturnConfirm() {
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
        data: "{pageVal:'RDWORKCONFIRM', pageval1:'WORKRETURN',pageval2:'" + details + "',pageval3:'CTOHODRETURN'}",
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
                        window.open('RandDCTOorHeadApprove.aspx?crfid=1', '_self');
                    }
                }).then((result) => {
                    if (
                        result.dismiss === Swal.DismissReason.timer
                    ) {
                        window.open('RandDCTOorHeadApprove.aspx?crfid=1', '_self');
                    }
                })
            }
            else {
                alert("Something went wrong.!Please contact IT Support");
            }
        }
    });
}

// function to reject by cto , re assigned to techlead

function Workrejectconfirm() {
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
        data: "{pageVal:'RDWORKCONFIRM', pageval1:'WORKREJECT',pageval2:'" + details + "',pageval3:'CTOHODRETURN'}",
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
                    html: "Work has been Returned to Techlead.",
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
                        window.open('RandDCTOorHeadApprove.aspx?crfid=1', '_self');
                    }
                }).then((result) => {
                    if (
                        result.dismiss === Swal.DismissReason.timer
                    ) {
                        window.open('RandDCTOorHeadApprove.aspx?crfid=1', '_self');
                    }
                })
            }
            else {
                alert("Something went wrong.!Please contact IT Support");
            }
        }
    });
}

function crfload(sts) {
    var usr = $("[id*=hdUserId]").val();
    $('#ddlCrf').empty();

    if (sts == 5) { //Head
        $.ajax({
            type: "post",
            contentType: "application/json; charset=utf-8",
            url: "RandDWorkCreate.aspx/getFillData",
            data: "{pageVal:'RDWORKHOD', pageval1 :'" + usr + "'}",
            dataType: "json",
            success: function (Result) {
                Result = Result.d;

                $('#ddlCrf').append($("<option></option>").val("-1").html("Choose Work"));
                $.each(Result, function (key, value) {
                    $('#ddlCrf').append($("<option></option>").val(value.id).html(value.name));
                });
            }
        });
    }
    else if (sts == 1) {
        $.ajax({
            type: "post",
            contentType: "application/json; charset=utf-8",
            url: "RandDWorkCreate.aspx/getFillData",
            data: "{pageVal:'RDWORKCTO', pageval1 :'" + usr + "'}",
            dataType: "json",
            success: function (Result) {
                Result = Result.d;

                $('#ddlCrf').append($("<option></option>").val("-1").html("Choose Work"));
                $.each(Result, function (key, value) {
                    $('#ddlCrf').append($("<option></option>").val(value.id).html(value.name));
                });
            }
        });
    }


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



function WorkApproveConfirm() {
    if ($("#ddlCrf").val() == '-1') {
        Swal.fire("Please choose a CRF.!");
        return false;
    }
    if ($("#txtModRemar").val() == "") {
        $("#txtModRemar").val("Nil");
    }
    var usr = $("[id*=hdUserId]").val();
    var details = usr + '^' + $("#ddlCrf").val() + '^' + $("#txtModRemar").val();
    if (accessility == 5) { // for HOD Approve
        var pageval3 = "CTOHODAPPROVE$$";
        $.ajax({
            type: "post",
            contentType: "application/json; charset=utf-8",
            url: "RandDWorkCreate.aspx/RequestNoteConfirm",
            data: "{pageVal:'RDWORKCONFIRM', pageval1:'WORKHODAPPROVE',pageval2:'" + details + "',pageval3:'" + pageval3 + "'}",
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
                        html: "Work has been Approved.",
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
                            window.open('RandDCTOorHeadApprove.aspx?crfid=1', '_self');
                        }
                    }).then((result) => {
                        if (
                            result.dismiss === Swal.DismissReason.timer
                        ) {
                            window.open('RandDCTOorHeadApprove.aspx?crfid=1', '_self');
                        }
                    })
                }
                else {
                    alert("Something went wrong.!Please contact IT Support");
                }
            }
        });
    }
    else if (accessility == 1) {// CTO
        var pageval3 = "CTOHODAPPROVE@@";
        $.ajax({
            type: "post",
            contentType: "application/json; charset=utf-8",
            url: "RandDWorkCreate.aspx/RequestNoteConfirm",
            data: "{pageVal:'RDWORKCONFIRM', pageval1:'WORKCTOAPPROVE',pageval2:'" + details + "',pageval3:'" + pageval3 + "'}",
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
                        html: "Work has been Approved.",
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
                            window.open('RandDCTOorHeadApprove.aspx?crfid=1', '_self');
                        }
                    }).then((result) => {
                        if (
                            result.dismiss === Swal.DismissReason.timer
                        ) {
                            window.open('RandDCTOorHeadApprove.aspx?crfid=1', '_self');
                        }
                    })
                }
                else {
                    alert("Something went wrong.!Please contact IT Support");
                }
            }
        });
    }
    else {
        Swal.fire("You are not authorized to see this page.!");
        window.open('Index.aspx?crfid=1', '_self');
        return false;
    }


}
function frmExit() {
    window.open("index.aspx", "_self");
}
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
                $('#lblTLrmk').html(cdtl[3]);
                $('#lblHDrmk').html(cdtl[4]);
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
                $('#lblDvrmk').html(cdtl[0]);
                $('#lblsts').html(cdtl[1]);

            },
            error: function (Result) {

                alert(Result);
            }
        });

        filesFill(crf);

    }
}


function accessibility_Check() {

    var usr = $("[id*=hdUserId]").val();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "RandDWorkCreate.aspx/AccessCheck",
        data: "{pageVal:'CheckCTOorHOD', pageval1:'" + usr + "'}",
        dataType: "json",
        async: false,
        success: function (Result) {
            Result = Result.d;

            if (Result == '1') {
                accessility = 1;
                $("#ctoReject").show();
                $("#lblHDrmrk").show();
            } //cto
            else if (Result == '2') {
                accessility = 5;
                $("#ctoReject").show();
                $("#lblHDrmrk").hide();
                $("#btnSubmit").empty();
                $("#btnSubmit").append('<i class="fa fa-thumbs-up"></i>&nbsp;Approve');
            } //hod sanu madam

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

