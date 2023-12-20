var tid = "";
var thead = "";
$(window).on('load', function () {

    $("#Doc").hide();
    $("[id*=hddraftid]").val('');
    $("#txtRemarks").val("");


    //if (crfid == 1) {
        $("#div1").show();
        $("#div2").hide();
        CRFLoad();
    //}
    //else {
    //    $("#div1").hide();
    //    $("#div2").show();
    //    crfid = Decrypt(crfid);
    //    $("[id*=hddraftid]").val(crfid);
    //    CRFIDLBL(crfid);
    //    CRFSearch(crfid);
    //    $("#snote").show();
    //    detailsLoad(crfid);
    //    filesFill(crfid);
    //}
    $('#divtblPrincpleIntDtl').show();
    $('#tblticket').show();

});
function CRFLoad() {

    var usr = $("[id*=hdUserId]").val();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "User_BugDtl.aspx/getFillData",
        data: "{pageVal:'GetIncidentCRF', pageval1 :'" + usr + "'}",
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

function ClearPopUp() {
    $('#ddlCrf').empty();
    $('#ddlCrfList').empty();
    $('#ddlToUser').empty();
    CRFLoad();
    $('#txtCurrUser').val("");
    $('#txtModRemarks').val("");

}

function UserListLoad() {
   
    GetCRFUser(draftNo);
}

function fillCRFData() {
    var CRFID = $("#ddlCrf").val();
    $("[id*=hddraftid]").val(CRFID);
    CRFSearch(CRFID);
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
    $("[id*=hdRqstID]").val(req);
    BugTview(req);
    $("#txtRemarks").val("");
}
function CRFSearch(CRFID) {

    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "User_BugDtl.aspx/getFillData",
        data: "{pageVal:'DraftApproveDetail', pageval1 :'" + CRFID + "'}",
        dataType: "json",
        success: function (Result) {
            //alert(Result.d);
            Result = Result.d;
            $.each(Result, function (key, value) {
                var crfdtl = value.id;

                var cdtl = crfdtl.split('±');
                $('#lblTeam').html(cdtl[0]);
                $('#lblType').html(cdtl[1]);
                $('#lblReqtr').html(cdtl[2]);
                $('#lblRqstDt').html(cdtl[3]);
                $('#lblTarDt').html(cdtl[4]);
                if (cdtl[6] == 1) {
                    $('#lblErrorImpact').html("Yes");
                    //$('#lblErrorImpact').prop(color, red);
                }
                else {
                    $('#lblErrorImpact').html("No");
                    //$('#lblErrorImpact').prop(color, red);
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

            });
        },
        error: function (Result) {

            alert(Result);
        }
    });

}
function GetCRFUser(CRFID) {

    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "User_BugDtl.aspx/getFillData",
        data: "{pageVal:'DraftApproveDetail', pageval1 :'" + CRFID + "'}",
        dataType: "json",
        success: function (Result) {
            //alert(Result.d);
            Result = Result.d;
            $.each(Result, function (key, value) {
                var crfdtl = value.id;
                var cdtl = crfdtl.split('±');
                //$('#lblTeam').html(cdtl[0]);
                //$('#lblType').html(cdtl[1]);;
                $('#txtCurrUser').val(cdtl[2]);
                $('#txtUserId').val(cdtl[7]);
                //$('#lblRqstDt').html(cdtl[3]);
                //$('#lblTarDt').html(cdtl[4]);
                //if (cdtl[6] == 1) {
                //    $('#lblErrorImpact').html("Yes");
                //    //$('#lblErrorImpact').prop(color, red);
                //}
                //else {
                //    $('#lblErrorImpact').html("No");
                //    //$('#lblErrorImpact').prop(color, red);
                //}
                //if (cdtl[5] == 1) {
                //    $('#lblPrior').html("High");
                //    $('#lblPrior').prop(color = red);
                //} else if (cdtl[5] == 2) {
                //    $('#lblPrior').html("Medium");
                //    $('#lblPrior').prop(color, red);
                //} if (cdtl[5] == 3) {
                //    $('#lblPrior').html("Low");
                //    $('#lblPrior').prop(color, red);

                //}

            });
        },
        error: function (Result) {
            alert(Result);
        }
    });

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


function detailsLoad(noteid) {

    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "User_BugDtl.aspx/getRequestNote",
        data: "{pageVal:'GetRequestNotes', pageval1:'" + noteid + "',pageval2:'2'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            $('.summernoteview').summernote('code', Result);
        }
    });
}
function CRFIDLBL(noteid) {

    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "User_BugDtl.aspx/getRequestNote",
        data: "{pageVal:'CRFSUBJECT', pageval1:'" + noteid + "',pageval2:'2'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            $('#lblCRFID').html(Result);
        }
    });
}
function filesFill(noteid) {

    $("#tblFiles").empty();
    var filenm = $("[id*=hdUserId]").val() + noteid.replace(/[^a-zA-Z0-9]/g, '') + "_";
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "User_BugDtl.aspx/getFileData",
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
    if ($("#tblFiles tr").length > 1) {
        $("#Doc").show();
    }
}

function frmExit() {
    window.open("index.aspx", "_self");
}
function NoteRecommendConfirm() {

    var crfid = $("#ddlCrf").val();
    if (crfid == -1) {
        alert("Please select CRF..");
        $("#ddlCrf").focus();
        return false;
    }

    if ($("#tblticket tr").length < 2) {
        alert("Please select bug..");
        $("#ddlCrf").focus();
        return false;
    }

     if ($('#usrBUG').prop('checked')) {
         var bugsts = 0;
         
    }
    else {
         var bugsts = 1;
         alert("Please select Issue status..");
         $("#ddlCrf").focus();
         return false;
    }

    $("#butShow").hide();

    var crfid = $("#ddlCrf").val() + "§" + $("[id*=hdRqstID]").val() + "§" + $("[id*=hdUserId]").val() + "§" + $("#txtRemarks").val() + "§" + bugsts;
    //Data = $("#txtRemarks").val() + 'µ' + $("[id*=hddraftid]").val() + 'µ' + $("[id*=hdUserId]").val() + 'µ1';

    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "User_BugDtl.aspx/ConfirmRecommendNote",
        data: "{pageVal:'ReturnCRFToFEEDBACK', pageval1 :'" + crfid + "',pageval2:'',pageval3:''}",
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
                        window.open('User_BugDtl.aspx?crfid=1', '_self');
                    }
                }).then((result) => {
                    if (
                        // Read more about handling dismissals
                        result.dismiss === Swal.DismissReason.timer
                    ) {
                        window.open('User_BugDtl.aspx?crfid=1', '_self');
                    }
                })
            }
            else {
                alert("Something went wrong.! Please contact IT support..")
            }

        }
    });
}

function Decrypt(value) {
    var result = "";
    var array = value.split("-");

    for (i = 0; i < array.length; i++) {
        result += String.fromCharCode(array[i] - 10);
    }
    return result;
}
function gr() {

    $('#tblticket').find('tr').click(function () {
        var row = $(this).find('td:eq(1)').text();

        shdetails(row);
        //WorkLogView(row);
        //UserApprvTview(row);
        //global_tickno = row;
        $('#tblticket').removeEventListener();
    });
}
function shdetails(tn) {

    var SoI;
    var input = tn;
    var QueryString = "GetTview";

    SoI = tn.substring(0, 2);
    $("#ticket_show").text(tn);

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        async: false,
        url: "User_BugDtl.aspx/FillBugDetails",
        data: "{pageVal:'FillIncidentDetails', pageval1 :'" + input + "', pageval2:''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d.split("^");

            $('#txtSubject').val(Result[0]);
            $('#txtDescription').val(Result[1]);
            $('#txtFromDate').val(Result[2]);
            $('#ddlEnvironment').val(Result[3]);
            $('#ddlPriority').val(Result[4]);

            if ($("[id*=hdEmpCheck]").val() == 0) {
                $('#ddlBugstatus').val("5");
            } else {
                $('#ddlBugstatus').val("2");
            }
            $("[id*=hdBugId]").val(Result[6]);

            $("#txtBugRemarks").val(Result[7]);

            $("#ddlPriority").prop("disabled", true);
            $("#ddlEnvironment").prop("disabled", true);
            $("#txtDescription").prop("disabled", true);
            $("#txtSubject").prop("disabled", true);
            $("#txtFromDate").prop("disabled", true);

            $("#btnSubmitD").show();

            $("#DivBug").show();


        },
        error: function (Result) {
            alert(Result);
        }
    });


}

function BugTview(req) {

    $('#divtblPrincpleIntDtl').show();
    $('#tblticket').show();

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "User_BugDtl.aspx/GetBugTble",
        async: false,
        //data: "{QueryStr : '" + Querystring + "',input :'" + InputString + "'}",
        data: "{pageVal:'GetIncidenttable', pageval1 :'" + req + "', pageval2:''}",
        dataType: "json",
        success: function (Result) {
            if (Result.d.length > 0) {
                $('#tblticket').empty();
                $('#tblticket').append('<thead < tr style="color:black; background-color:honeydew" class="text-left" ><td scope="col">NO</td><td scope="col">Incident ID</td><td scope="col">Subject</td><td scope="col">Request ID</td> <td scope="col">Status</td> <td scope="col">Date</td> </tr></thead><tbody>');
                for (var i = 0; i < Result.d.length; i++) {
                    k = i + 1;
                    $('#tblticket').append('<tr><td>' + k + '</td>' +
                        '<td>' + Result.d[i].IncidentID + '</td>' +
                        '<td>' + Result.d[i].Subject + '</td>' +
                        '<td>' + Result.d[i].RequestID + '</td>' +
                        '<td>' + Result.d[i].Status + '</td>' +
                        '<td>' + Result.d[i].Date + '</td>' + '</tr>');
                }
                $('#tblticket').append(
                    '</tbody>');
                $('#DivBug').show();

            } else {

                $('#tblticket').empty();
                $('#tblticket').hide();
                $('#DivBug').hide();

            }

        },
        error: function (Result) {
            alert(Result);
        }
    });
}
function userB() {

    if ($('#ddlCrf').val() == -1) {
        alert("Please Select a CRF..");
        $('#usrBUG').prop('checked', false);
        return false;
    }
    //if ($('#usrBUG').prop('checked')) {
    //    $("#rdlabel").show();
    //}
    //else {
    //    $("#rdlabel").hide();
    //}
    if ($("#tblticket tr").length < 2) {
        alert("Please select bug..");
        $("#ddlCrf").focus();
        return false;
    }
}