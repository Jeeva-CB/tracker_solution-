$(window).on('load', function () {
    
    Formacess(); 
    Headverification();
    GetReqTypeList();
    $("#snote").show();
   
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

    $('#rbnPriority a').on('click', function () {
        
        var sel = $(this).data('title');
        
        var tog = $(this).data('toggle');
        $('#' + tog).prop('value', sel);

       $('a[data-toggle="' + tog + '"]').not('[data-title="' + sel + '"]').removeClass('active').addClass('notActive');
        $('a[data-toggle="' + tog + '"][data-title="' + sel + '"]').removeClass('notActive').addClass('active');
        if (sel == 1) {
            $('a[data-toggle="' + tog + '"]').not('[data-title="' + sel + '"]').removeClass('btn-red').addClass('btn-dark');
            $('a[data-toggle="' + tog + '"][data-title="' + sel + '"]').removeClass('btn-dark').addClass('btn-red');
        }
        if (sel == 2) {
            $('a[data-toggle="' + tog + '"]').not('[data-title="' + sel + '"]').removeClass('btn-orange').addClass('btn-dark');
            $('a[data-toggle="' + tog + '"][data-title="' + sel + '"]').removeClass('btn-dark').addClass('btn-orange');
        }
        if (sel == 3) {
            $('a[data-toggle="' + tog + '"]').not('[data-title="' + sel + '"]').removeClass('btn-yellow').addClass('btn-dark');
            $('a[data-toggle="' + tog + '"][data-title="' + sel + '"]').removeClass('btn-dark').addClass('btn-yellow');
        }


    })
});

function Formacess() {
    debugger;
    
    var usr = $("[id*=hdUserId]").val();
   
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "RequestTypeUpdation.aspx/Formacess",
        data: "{pageVal:'Formacess', pageval1 :'" + usr + "'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
           
            debugger;
                
            $("[id*=hdcount]").val(Result);
            var acesscount = $("[id*=hdcount]").val();
            
            if (acesscount == 0) {

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
function Headverification() {
   
    var dep = $("[id*=hddepid]").val();
   
    if (dep == "160") {
        
        debugger;
        $.ajax({
            type: "post",
            contentType: "application/json; charset=utf-8",
            url: "RequestTypeUpdation.aspx/Headverification",
            data: "{pageVal:'HeadVerification', pageval1 :'" + dep + "'}",
            dataType: "json",
            success: function (Result) {
                Result = Result.d;
                //alert(Result);
                $.ajax({
                    type: "post",
                    contentType: "application/json; charset=utf-8",
                    url: "RequestTypeUpdation.aspx/getFillData",
                    data: "{pageVal:'CRFload', pageval1 :'" + Result + "'}",
                    dataType: "json",
                    success: function (Result) {
                        Result = Result.d;
                        //alert(Result);
                        //$('#ddlCrf').empty();
                        $('#ddlCrf').empty();
                        $('#ddlCrf').append($("<option selected disabled></option>").val("-1").html("Choose CRF"));

                        $.each(Result, function (key, value) {
                            
                            $("[id*=hdteamid]").val(Result);
                            
                            $('#ddlCrf').append($("<option></option>").val(value.id).html(value.name));
                        });
                    }
                });
            }
        });
    }

    else if (dep == "645") {
        
        debugger;
        $.ajax({
            type: "post",
            contentType: "application/json; charset=utf-8",
            url: "RequestTypeUpdation.aspx/Headverification",
            data: "{pageVal:'HeadVerification', pageval1 :'" + dep + "'}",
            dataType: "json",
            success: function (Result) {
                Result = Result.d;
                
                $.ajax({
                    type: "post",
                    contentType: "application/json; charset=utf-8",
                    url: "RequestTypeUpdation.aspx/getFillData",
                    data: "{pageVal:'CRFload', pageval1 :'" + Result + "'}",
                    dataType: "json",
                    success: function (Result) {
                        Result = Result.d;
                        $('#ddlCrf').empty();
                       // $('#ddlCrf').append($("<option selected disabled></option>").val("-1").html("Choose CRF...!"));
                        $.each(Result, function (key, value) {
                            
                            $("[id*=hdteamid]").val(Result);
                           
                            $('#ddlCrf').append($("<option></option>").val(value.id).html(value.name));
                        });
                    }
                });
            }
        });
    }
    else if (dep == "649") {
       
        debugger;
        $.ajax({
            type: "post",
            contentType: "application/json; charset=utf-8",
            url: "RequestTypeUpdation.aspx/Headverification",
            data: "{pageVal:'HeadVerification', pageval1 :'" + dep + "'}",
            dataType: "json",
            success: function (Result) {
                Result = Result.d;
                
                $.ajax({
                    type: "post",
                    contentType: "application/json; charset=utf-8",
                    url: "RequestTypeUpdation.aspx/getFillData",
                    data: "{pageVal:'CRFload', pageval1 :'" + Result + "'}",
                    dataType: "json",
                    success: function (Result) {
                        Result = Result.d;
                        $('#ddlCrf').empty();
                       // $('#ddlCrf').append($("<option selected disabled></option>").val("-1").html("Choose CRF...!"));
                        $.each(Result, function (key, value) {
                           
                            $("[id*=hdteamid]").val(Result);
                           
                            $('#ddlCrf').append($("<option></option>").val(value.id).html(value.name));
                        });
                    }
                });
            }
        });
    }
    else if (dep == "656") {
       
        debugger;
        $.ajax({
            type: "post",
            contentType: "application/json; charset=utf-8",
            url: "RequestTypeUpdation.aspx/Headverification",
            data: "{pageVal:'HeadVerification', pageval1 :'" + dep + "'}",
            dataType: "json",
            success: function (Result) {
                Result = Result.d;
               
                $.ajax({
                    type: "post",
                    contentType: "application/json; charset=utf-8",
                    url: "RequestTypeUpdation.aspx/getFillData",
                    data: "{pageVal:'CRFload', pageval1 :'" + Result + "'}",
                    dataType: "json",
                    success: function (Result) {
                        Result = Result.d;
                        $('#ddlCrf').empty();
                        //$('#ddlCrf').append($("<option selected disabled></option>").val("-1").html("Choose CRF...!"));
                        $.each(Result, function (key, value) {
                            
                            $("[id*=hdteamid]").val(Result);
                           
                          
                            $('#ddlCrf').append($("<option></option>").val(value.id).html(value.name));
                        });
                    }
                });
            }
        });
    }

    
    
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
    filesFill(CRFID)
    GetRequestId(CRFID);
    $("#txtRemarks").val("");
    ModHdFdback(CRFID);
    check_techlead(CRFID);
    already_tech_dep(CRFID);


}
function detailsLoad(noteid) {
    
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "RequestTypeUpdation.aspx/getRequestNote",
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
        url: "RequestTypeUpdation.aspx/getFillData",
        data: "{pageVal:'DraftApproveDetail', pageval1 :'" + CRFID + "'}",
        dataType: "json",
        success: function (Result) {
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
            });
        },
        error: function (Result) {
            alert(Result);
        }
    });
}

/************* To show attached files table **************/
function filesFill(noteid) {
    
    $("#tblFiles").empty();
    var filenm = $("[id*=hdUserId]").val() + noteid.replace(/[^a-zA-Z0-9]/g, '') + "_";
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "RequestTypeUpdation.aspx/getFileData",
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
function GetRequestId(CRFID) {
    
    var usr = $("[id*=hdUserId]").val();
    usr = usr + '^' + CRFID;
    var dtl = $('#ddlCrf option:selected').text();
    var ddtl = dtl.split('~');
    $("[id*=hdRqstID]").val(ddtl[1]);
}
/*************To get feedbacks from HODs **************/
function ModHdFdback(crfid) {
    
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "RequestTypeUpdation.aspx/ModHdFeedback",
        data: "{pageVal:'ModHdFdback', pageval1 :'" + crfid + "'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            
            if (Result != "NA") {
                $("#ModHeadFdbk").show();
                ModHdFdbackFill(Result);
            }
            else $("#ModHeadFdbk").hide();

        }
    });
}
/*********for filling  the feedback table --HODs ************/
function ModHdFdbackFill(data) {
    
    var valData, valData1, risk;
    $("#tblHdFdbk").empty();
    valData = data.split('¶');
    if ($("#tblHdFdbk tr").length == 0) {
        $("#tblHdFdbk").empty();
        $('#tblHdFdbk').append('<tr style="color:black; background-color:honeydew" class="text-left"><th class="text-left">Module Name</th><th class="text-left">Head</th><th class="text-left">Sensitive Information</th><th class="text-left">Risk</th></tr>');
    }
    for (i = 0; i < valData.length - 1; i++) {
        valData1 = valData[i].split('^');
        if (valData1[3] == '3') risk = "Low";
        else if (valData1[3] == '2') risk = "Medium";
        else if (valData1[3] == '1') risk = "High";
        $('#tblHdFdbk').append('<tbody><tr>' +
            '<td>' + valData1[0] + '</td>' +
            '<td>' + valData1[1] + '</td>' +
            '<td>' + valData1[2] + '</td>' +
            '<td>' + risk + '</td> </tbody > ');
    }

}
/************* for the dependency of tech leads **************/
function check_techlead(CRFID) {
   
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "RequestTypeUpdation.aspx/ModHdFeedback",
        data: "{pageVal:'TechCount', pageval1 :'" + CRFID + "'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            if (Result == '1') sts = 1;
            else sts = 0;
        }
    });

}


function GetReqTypeList() {

    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "RequestTypeUpdation.aspx/getFillData",
        data: "{pageVal:'TYPE', pageval1 :''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            
            $('#ddlReqType').empty();
            $('#ddlReqType').append($("<option selected disabled></option>").val("-1").html("Choose Request Type"));
            $.each(Result, function (key, value) {
                $('#ddlReqType').append($("<option></option>").val(value.id).html(value.name));
            });
             
        }
    });
  
}

/* For loading modules as per selected team  */
function selectmodule() {
    
    var name = $("#ddlReqType option:selected").text();
    
    var rqst = $("[id*=hdRqstID]").val();
    
    $("#exmodule").empty();
    if (name == "Modification Module") {
        $.ajax({
            type: "post",
            contentType: "application/json; charset=utf-8",
            url: "RequestTypeUpdation.aspx/getFillData",
            data: "{pageVal:'Getheadchangemodule',pageval1:'" + rqst + "'}",
            dataType: "json",
            async: false,
            success: function (Result) {
                Result = Result.d;
                
                $("#exmodule").empty();
                $("#exmodule").append($("<option></option>").val("-1").html("Choose Module"));
                $.each(Result, function (key, value) {
                    $("#exmodule").append($("<option></option>").val(value.id).html(value.name));
                });

            }

        });
        $("#newmode").show();
    }
    else {
        $("#newmode").hide();
    }
}

function Headcorrection() {
  
    var pre_typ = $("#lblType").text();
    var CRFID = $("#ddlCrf").val();
    var rqst = $("[id*=hdRqstID]").val();
    var usr = $("[id*=hdUserId]").val();
    
    var reqstType = $("#ddlReqType option:selected").val();
    var reqstType1 = $("#ddlReqType option:selected").text();
    CRFID = $("#ddlCrf").val();
    var rmk = $("#txtRemarks").val();

    if (CRFID == '-1') {
        alert("Please Choose CRF..");
        return false;
    }
    if (reqstType == '-1') {
        alert("Please select Request Type!");
        $("#exmodule").focus();
        return false;
    }
   

    if (pre_typ == reqstType1) {
        alert("ALREADY IN SAME REQUEST TYPE !");
        $("#exmodule").focus();
        return false;
    }
    if (rmk == "") {
        alert("Please enter remark !");
        $("#txtRemarks").focus();
        return false;
    }
    var mode = $("#exmodule").val();
    if (mode == null) {
        mode = "0";
    }
    Data = CRFID + 'µ' + $("[id*=hdRqstID]").val() + 'µ' + $("[id*=hdUserId]").val() + 'µ' + rmk + 'µ' + reqstType + 'µ' + mode + 'µ';
    
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "RequestTypeUpdation.aspx/Headcorrection",
        data: "{pageVal:'HeadCorrection',pageval1:'" + Data + "'}",
        dataType: "json",
        async: false,
        success: function (Result) {
            Result = Result.d;
            
            if (Result == '111') {

                let timerInterval
                Swal.fire({
                    width: 400,
                    type: 'success',
                    title: 'Updated !',
                    html: "Successful!! ",
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
                        window.open('RequestTypeUpdation.aspx', '_self');
                    }
                }).then((result) => {
                    if (
                        result.dismiss === Swal.DismissReason.timer
                    ) {
                        window.open('RequestTypeUpdation.aspx', '_self');
                    }
                })

            }

        }

    });

}
function frmExit() {
    window.open("index.aspx", "_self");
}
