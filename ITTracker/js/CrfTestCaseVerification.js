$(window).on('load', function () {

    Accessibility();
    CRFLoad();
    $("#Doc").hide();
    
});

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
function Accessibility() {
    debugger;
    var usr = $("[id*=hduserid]").val();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "CrfTestCaseVerification.aspx/Accessibility",
        data: "{pageVal:'testcaseupdatingaccess', pageval1:'" + usr + "'}",
        dataType: "json",
        success: function (Result) {


            Result = Result.d;


            if (Result == 222) {

                let timerInterval
                Swal.fire({
                    width: 400,
                    type: 'error',
                    title: 'You Are Not Authorized !',
                    html: "To View This Page!! ",
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
                        window.open('index.aspx', '_self');
                    }
                }).then((result) => {
                    if (
                        result.dismiss === Swal.DismissReason.timer
                    ) {
                        window.open('index.aspx', '_self');
                    }
                })

            }
        }
    });
}
function frmExit(){
    window.open('index.aspx', '_self');
}
function CRFLoad() {
    var usr = $("[id*=hduserid]").val();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "CrfTestCaseVerification.aspx/getFillData",
        data: "{pageVal:'testverificationload', pageval1 :'" + usr + "'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            $.each(Result, function (key, value) {
                $('#ddlCrf').append($("<option></option>").val(value.id).html(value.name));
            });
        }
    });

}
function fillCRFData() {
    var CRFID = $("#ddlCrf").val();
    detailsLoad(CRFID);
    if (CRFID == -1) {
        $("#CrfDetailsID").hide();
    }
    else {
        $("#CrfDetailsID").show();

    }
    CRFSearch(CRFID);
    GetRequestId(CRFID);
    filesFill(CRFID);
    
    
}
/************* To content of the CRF **************/
function detailsLoad(noteid) {
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "CrfTestCaseVerification.aspx/getRequestNote",
        data: "{pageVal:'GetRequestNotes', pageval1:'" + noteid + "',pageval2:'2'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            $('.summernoteview').summernote('code', Result);
        }
    });
}
/************* Load CRF's Details **************/
function CRFSearch(CRFID) {
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "CrfTestCaseVerification.aspx/getFillData",
        data: "{pageVal:'DraftApproveDetail', pageval1 :'" + CRFID + "'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            //alert(Result);
            $.each(Result, function (key, value) {
                var crfdtl = value.id;
                var cdtl = crfdtl.split('±');
                $('#lblTeam').html(cdtl[0]);
                //alert(cdtl[0]).val;
                $('#lblType').html(cdtl[1]);
                $('#lblReqtr').html(cdtl[2]);
                $('#lblRqstDt').html(cdtl[3]);
                $('#lblTarDt').html(cdtl[4]);
                if (cdtl[6] == 1) {
                    $('#lblErrorImpact').html("Yes");
                }
                else {
                    $('#lblErrorImpact').html("No");
                }
                if (cdtl[5] == 1) {
                    $('#lblPrior').html("High");
                    //$('#lblPrior').prop(color = red);
                } else if (cdtl[5] == 2) {
                    $('#lblPrior').html("Medium");
                    //$('#lblPrior').prop(color, red);
                } if (cdtl[5] == 3) {
                    $('#lblPrior').html("Low");
                    //$('#lblPrior').prop(color, red);
                }
            });
        },
        error: function (Result) {
            alert(Result);
        }
    });
}
/************* To show attached files table **************/
function filesFill(noteid) {
    //alert("ff");
    $("#tblFiles").empty();
    var filenm = $("[id*=hdUserId]").val() + noteid.replace(/[^a-zA-Z0-9]/g, '') + "_";
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "CrfTestCaseVerification.aspx/getFileData",
        async: false,
        data: "{pageVal:'GetAttachListTestCases', pageval1 :'" + $("[id*=hdRqstID]").val() + "', pageval2 :'" + filenm + "'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            var valData, valData1;
            var n = 0;
            valData = Result.split('Θ');
            if ($("#tblFiles tr").length == 0) {
                $('#tblFiles').append('<thead class="bg-success text-white"><tr><th scope="col">File No</th><th scope="col">File Name</th><th scope="col">File</th></tr></thead>');
            }
            for (j = 0; j < valData.length - 1; j++) {
                var contentDtl = valData[j].split('µ');
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
                var imgid = "'" + $("[id*=hdRqstID]").val() + "'";
                $('#tblFiles').append('<tbody><tr>' +
                    '<td>' + contentDtl[0] + '</td>' +
                    '<td>' + contentDtl[1] + '</td>' +
                    '<td class=""  ><input type="button" style="width:30%;margin-left: 0; background-color: #4775d1;"  value="View" class="btn btn-success" onclick="ViewAttachment(' + imgid + ');"></td>' + 
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
function GetRequestId(CRFID) {
    var usr = $("[id*=hdUserId]").val();
    usr = usr + '^' + CRFID;
    var dtl = $('#ddlCrf option:selected').text();
    var ddtl = dtl.split('~');
    $("[id*=hdRqstID]").val(ddtl[1]);
}
function ViewAttachment(imgid) {
 //   alert("viewwwwww");
    debugger;

    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "CrfTestCaseVerification.aspx/Viewattach",
        data: "{pageVal:'GetviewTestCases', pageval1 :'" + imgid + "'}",
        dataType: "json",
        success: function (Result) {

            Result = Result.d;
            var myUrl = "Images/" + Result;
            //alert(myUrl);
            //window.open(myUrl);
            OpenDialog(myUrl, 875, 650, function (termsOfServiceAccepted) {

                if (termsOfServiceAccepted) {

                    $.ajax({
                        type: "POST",
                        url: "CrfTestCaseVerification.aspx/deleteDownloadFile",
                        contentType: "application/json; charset=utf-8",
                        data: "{input: '" + Result + "'}",
                        dataType: "json",
                        success: function (Result) {


                        },
                        error: function (Result) {
                        }
                    });


                }




            });
        }
    });
}

function OpenDialog(url, width, height, callback) {
   // alert(url);
    debugger;
    var win = window.open(url, "Ambience Status", height, "menubar=0,toolbar=0", "_blank");
  
    var timer = setInterval(function () {

        if (win.closed) {
            clearInterval(timer);
            var returnValue = true;
            callback(returnValue);
        }
    }, 10);
}
function TestCaseApprove() {

    if ($("#ddlCrf").val() == -1) {
        alert("Please Choose a CRF.!");
        $("#ddlCrf").focus();
        return false;
    }
   
    if ($("#txtRemarks").val() == "" || $("#txtRemarks").val() == null) {
        alert("Please add your remark..!");
        $("#txtRemarks").focus();
        return false;
    }
    remark = $("#txtRemarks").val();
    crfid = $("#ddlCrf").val();
    var reqstid = $("[id*=hdRqstID]").val();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "CrfTestCaseVerification.aspx/TestCaseApprove",
        data: "{pageVal:'testcaseverifyconfirm', pageval1 :'" + reqstid + "',pageval2:'" + remark + "',pageval3:''}",
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
                        window.open('CrfTestCaseVerification.aspx', '_self');
                    }
                }).then((result) => {
                    if (
                        // Read more about handling dismissals
                        result.dismiss === Swal.DismissReason.timer
                    ) {
                        window.open('CrfTestCaseVerification.aspx', '_self');
                    }
                })
            }
            else {
                alert("Someting went wrong.! Please contact IT Support.!");
            }

        }
    });

}

function RejctCRF() {
    debugger;
    if ($("#ddlCrf").val() == -1) {
        alert("Please Choose a CRF.!");
        $("#ddlCrf").focus();
        return false;
    }

    if ($("#txtRemarks").val() == "" || $("#txtRemarks").val() == null) {
        alert("Please add your remark..!");
        $("#txtRemarks").focus();
        return false;
    }
    remark = $("#txtRemarks").val();
    crfid = $("#ddlCrf").val();
    var reqstid = $("[id*=hdRqstID]").val();

    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "CrfTestCaseVerification.aspx/RejctCRF",
        data: "{pageVal:'testcaseverifyreject', pageval1 :'" + reqstid + "',pageval2:'" + remark + "',pageval3:''}",
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
                    type: 'error',
                    title: 'Rejected!',
                    html: "Rejected ",
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
                        window.open('CrfTestCaseVerification.aspx', '_self');
                    }
                }).then((result) => {
                    if (
                        // Read more about handling dismissals
                        result.dismiss === Swal.DismissReason.timer
                    ) {
                        window.open('CrfTestCaseVerification.aspx', '_self');
                    }
                })
            }
            else {
                alert("Someting went wrong.! Please contact IT Support.!");
            }

        }
    });

}