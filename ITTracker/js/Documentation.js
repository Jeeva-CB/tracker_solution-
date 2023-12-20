var crfNo = 0;
var reqNo = 0;
var accessility = 0;
var module_id = 0;
$(window).on('load', function () {
    GetDelayCountDD();
   
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
    crfNo = 0;
    accessibility_Check();
    CRFLoad();
    fillmodules();
    let querystring = window.location.search.substring(1);  

    if (querystring == '0' || querystring == '' || querystring == 'undefined' || querystring == null) {

        crfNo = 0;

    }
    else {
        let querynoteid = querystring.split("=")[1];
        let querynoteid1 = querystring.split("=")[2];
        let querynoteid2 = querystring.split("=")[3];
        crfNo = querynoteid;
        reqNo = querynoteid1;
        module_id = querynoteid2;
        fillCRFData();
        crfNo = 0;
        reqNo = 0;
    }

    $("[id*=hdRqstID]").val('');
   

});
function fillmodules() {
  
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "Documentation_upload.aspx/get_itmodules",
        data: "{pageVal:'Documentation_modules', pageval1:'a'}",
        dataType: "json",
        async: false,
        success: function (Result) {
            Result = Result.d;
            $.each(Result, function (key, value) {
                $('#ddlmdl').append($("<option></option>").val(value.id).html(value.name));
            });
        }
    });
}
function accessibility_Check() {
    var usr = $("[id*=hdUserId]").val();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "Documentation_upload.aspx/getRequestNote",
        data: "{pageVal:'AccessibilityCheck', pageval1:'" + usr + "',pageval2:''}",
        dataType: "json",
        async: false,
        success: function (Result) {
            Result = Result.d;
            //alert(Result);
            if (Result == '1') { accessility = 1; $("#showContents").hide(); $("#rmkShow").show(); $("#developerShow").show(); $("#attachments").show(); $("#div_module").hide();}//  reviewer sunitha
            else if (Result == '2') { accessility = 2; $("#showContents").hide(); $("#rmkShow").show(); $("#developerShow").show(); $("#attachments").show(); $("#div_module").hide(); }// tech lead
            else if (Result == '4') { accessility = 4; $("#showContents").hide(); $("#rmkShow").show(); $("#developerShow").show(); $("#attachments").show(); $("#div_module").hide(); }// assistant tech lead
            else if (Result == '5') { accessility = 5; $("#showContents").hide(); $("#rmkShow").show(); $("#developerShow").show(); $("#attachments").show(); $("#div_module").hide(); }//Team Head
            else { accessility = '3'; $("#showContents").show(); $("#rmkShow").hide(); $("#developerShow").hide(); $("#attachments").hide(); $("#div_module").show(); } //all other            
        }
    });
}

function CRFLoad() {
   // alert(accessility);
    var usr = $("[id*=hdUserId]").val();
    $("#ddlCrf").empty();
    $('#ddlCrf').append($("<option></option>").val("-1").html("Choose crf"));
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "Documentation_upload.aspx/getFillData",
        async: false,
        data: "{pageVal:'DocUpdationLoad', pageval1 :'" + usr + "',pageval2 :'" +accessility+"'}",
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
    var CRFID = "";
    if (crfNo != 0) {

        CRFLoad();
        fillmodules();
        CRFID = crfNo;
        

        Swal.fire("Uploaded Successfully");
        
        $("#ddlCrf").val(crfNo);
        $("#ddlmdl").val(module_id);
        
    }
    else {
     
        CRFID = $("#ddlCrf").val();
        var crf = $('#ddlCrf option:selected').text();
        
        
    }
    if (accessility == 4) {
        assistanttechecking();
    }
    CRFSearch();
    $("#snote").show();
    if (CRFID == -1) {
        $("#CrfDetailsID").hide();
    }
    else {
        $("#CrfDetailsID").show();
    }
    detailsLoad(CRFID);
    //filesFill(CRFID);
    var crfdata = $('#ddlCrf option:selected').text();
    var ddtl = crfdata.split('~');
    var req = ddtl[0];
    $("[id*=hdRqstID]").val(req);
    Documents_Load(req);
    $("#txtRemarks").val("");
}
function assistanttechecking() {
    
    var usr = $("[id*=hdUserId]").val();
    var crfdata = $('#ddlCrf option:selected').text();
    var ddtl = crfdata.split('~');
    var req = ddtl[0];
    var crfid = ddtl[1];

    data = req + '^' + usr + '^' + crfid
    
    debugger;
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "Documentation_upload.aspx/assistanttechecking",
        async: false,
        data: "{pageVal:'assistanttechecking', pageval1 :'" + data + "'}",
        dataType: "json",
        success: function (Result) {
           // alert(Result.d);
            Result = Result.d;
            $("[id*=hd_crfsts]").val(Result);
            
            if (Result == "1") {
               // alert("mmm");
                $("#showContents").hide();
                $("#rmkShow").show();
                $("#developerShow").show();
                $("#attachments").show();
                $("#div_module").hide();
            }
            else {
                $("#showContents").show();
                $("#rmkShow").hide();
                $("#developerShow").hide();
                $("#attachments").hide();
                $("#div_module").show();
            }
        }
    });
}
function CRFSearch() {
    var crfval = "";
    var reqid = "";
    var CRFID = "";
    var reqid1 = "";
    if (crfNo != 0) {
        reqid1 = reqNo;
        CRFID = crfNo;
        loadStatus();
        Already_Upload_doc();
    }
    else {
        loadStatus();
        crfval = $("#ddlCrf option:selected").text();
        reqid = crfval.split('~');
        reqid1 = reqid[0];
        CRFID = $("#ddlCrf").val();
        Already_Upload_doc();

    }
    
    if (CRFID == "") {
        Swal.fire("Please Choose CRF!!!");
    }
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "Documentation_upload.aspx/getFillData",
        data: "{pageVal:'DataLoadDocUpload', pageval1 :'" + CRFID + "',pageval2 :'" + reqid1 + "'}",
        dataType: "json",
        async:false,
        success: function (Result) {

            Result = Result.d;
           
            $.each(Result, function (key, value) {
                var crfdtl = value.id;

                var cdtl = crfdtl.split('±');

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
function loadStatus() {
    $("#txtData").show();
    $("#txtData1").show();
    $("#txtData2").show();
    $("#txtData3").show();
}
function Documents_Load(request_id) {
    debugger;
    var count = 0;
    $("#tblFiles").empty();
    var filenm = "ReleaseDocuments_" + $("[id*=hdUserId]").val() + "_" + request_id.replace(/[^a-zA-Z0-9]/g, '') + "_";
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "Documentation_upload.aspx/getFileData",
        async: false,
        data: "{pageVal:'GetDocumentation', pageval1 :'" + request_id + "', pageval2 :'" + filenm + "'}",
        dataType: "json",
        success: function (Result) {

            Result = Result.d;

           
            var valData, valData1;
            var n = 0;
            valData = Result.split('Θ');
            if ($("#tblFiles tr").length == 0) {
                $('#tblFiles').append('<thead class="bg-success text-white"><tr><th scope="col">File Name</th></tr></thead>');
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
                    '<td><a href="' + myUrl + '" download="' + filename + '" class="file-list1">' + contentDtl[1] + '</a></td>' +
                    '</tr> </tbody>');
            }


        },
        error: function (Result) {

        }
    });

}


function detailsLoad(noteid) {
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "Documentation_upload.aspx/getRequestNote",
        data: "{pageVal:'GetRequestNotes', pageval1:'" + noteid + "',pageval2:'2'}",
        dataType: "json",
        async:false,
        success: function (Result) {
            Result = Result.d;
            $('.summernoteview').summernote('code', Result);
        }
    });
}

function filesFill(noteid) {
    $("#tblFiles").empty();
    var filenm = $("[id*=hdUserId]").val() + noteid.replace(/[^a-zA-Z0-9]/g, '') + "_";
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "Documentation_upload.aspx/getFileData",
        async: false,
        data: "{pageVal:'GetDocumentation', pageval1 :'" + noteid + "', pageval2 :'" + filenm + "'}",
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
}

function frmExit() {
    window.open("index.aspx", "_self");
}

function Doc_confirm() {

    Swal.fire({
        title: 'Information',
        text: "Are You Ready to Confirm?",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes'
    }).then((result) => {
        if (result.value == true) {
            debugger;
            var data = "";
            CRFID = $("#ddlCrf").val();
            if (CRFID == null || CRFID == '-1') {
                Swal.fire("Please Choose CRF!");
                $("#ddlCrf").focus();
                return false;
            }
            
            else {
                var crfdata = $('#ddlCrf option:selected').text();
                var ddtl = crfdata.split('~');
                $("[id*=hdRqstID]").val(ddtl[0]);
            }
            if (accessility == 3) {
                if ($('#ddlmdl option:selected').val() == '-1') {
                    Swal.fire("Please Choose Module!");
                    $("#ddlmdl").focus();
                    return false;
                }
            }
            if (accessility == 1 || accessility == 2) {
                if ($("#txtRemarks").val() == "") {
                    Swal.fire("Kindly add Remarks..!");
                    return false;
                }
                else {
                   
                    data = $("#ddlCrf").val() + '^' + $("#txtRemarks").val() + '^' + $("[id*=hdRqstID]").val() + '^' + $("[id*=hdUserId]").val() + '^' + accessility + '^' + 'CONFIRM';
                    setTimeout(function () {
                        Confirm_Doc_Upload(data);
                    }, 3000);

                }
            }
            else if (accessility == 4) {   //Assi.TL
               // alert("ass");
                var stas = $("[id*=hd_crfsts]").val();
                if (stas == 0 || stas == 3|| stas ==  4) {    // crf for doc updation

                    if ($("#lblData").text() == "Files Uploaded" && $("#lblInfo1").text() == "Files Uploaded" && $("#lblInfo2").text() == "Files Uploaded") {
                        data = $("#ddlCrf").val() + '^' + 'nil' + '^' + $("[id*=hdRqstID]").val() + '^' + $("[id*=hdUserId]").val() + '^' + accessility + '^' + 'CONFIRM' + '^' + $('#ddlmdl option:selected').val() + '^' + stas ;
                        //alert(data);
                        setTimeout(function () {
                            Confirm_Doc_Upload(data);
                        }, 3000);
                    }
                    else {
                        Swal.fire("Please Upload Remaining Files too..!");
                        return false;
                    }


                }
                else {             // 1 for Doc verification

                    if ($("#txtRemarks").val() == "") {
                        Swal.fire("Kindly add Remarks..!");
                        return false;
                    }
                    else {

                        data = $("#ddlCrf").val() + '^' + $("#txtRemarks").val() + '^' + $("[id*=hdRqstID]").val() + '^' + $("[id*=hdUserId]").val() + '^' + accessility + '^' + 'CONFIRM' + '^' + 1 + '^' + stas;
                        setTimeout(function () {
                            Confirm_Doc_Upload(data);
                        }, 3000);

                    }

                }
            }
            else {
                if ($("#lblData").text() == "Files Uploaded" && $("#lblInfo1").text() == "Files Uploaded" && $("#lblInfo2").text() == "Files Uploaded") {
                    data = $("#ddlCrf").val() + '^' + 'nil' + '^' + $("[id*=hdRqstID]").val() + '^' + $("[id*=hdUserId]").val() + '^' + accessility + '^' + 'CONFIRM' + '^' + $('#ddlmdl option:selected').val() ;
                    //alert(data);
                    setTimeout(function () {
                        Confirm_Doc_Upload(data);
                    }, 3000);
                }
                else {
                    Swal.fire("Please Upload Remaining Files too..!");
                    return false;
                }

            }
        }
        else {
            return false;
        }
    })
   
}
function Doc_Return() {

    Swal.fire({
        title: 'Information',
        text: "Are You Ready to Return?",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes'
    }).then((result) => {
        if (result.value == true) {
            var data = "";
            CRFID = $("#ddlCrf").val();
            if (CRFID == null || CRFID == '-1') {
                Swal.fire("Please Choose CRF!");
                $("#ddlCrf").focus();
                return false;
            }
            else {
                var crfdata = $('#ddlCrf option:selected').text();
                var ddtl = crfdata.split('~');
                $("[id*=hdRqstID]").val(ddtl[0]);
            }
            if (accessility == 1 || accessility == 2) {
                if ($("#txtRemarks").val() == "") {
                    Swal.fire("Kindly add Remarks..!");
                    return false;
                }
                else {
                    data = $("#ddlCrf").val() + '^' + $("#txtRemarks").val() + '^' + $("[id*=hdRqstID]").val() + '^' + $("[id*=hdUserId]").val() + '^' + accessility + '^' + 'RETURN';
                    setTimeout(function () {
                        Confirm_Doc_Upload(data);
                    }, 3000);
                }
            }
            else if (accessility == 4) {
                data = $("#ddlCrf").val() + '^' + $("#txtRemarks").val() + '^' + $("[id*=hdRqstID]").val() + '^' + $("[id*=hdUserId]").val() + '^' + accessility + '^' + 'RETURN';
                setTimeout(function () {
                    Confirm_Doc_Upload(data);
                }, 3000);
            }
            else if (accessility == 5) {
                data = $("#ddlCrf").val() + '^' + $("#txtRemarks").val() + '^' + $("[id*=hdRqstID]").val() + '^' + $("[id*=hdUserId]").val() + '^' + accessility + '^' + 'RETURN';
                setTimeout(function () {
                    Confirm_Doc_Upload(data);
                }, 3000);
            }
        }
        else {
            return false;
        }
    })
    
}

function Confirm_Doc_Upload(data) {
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "Documentation_upload.aspx/Doc_Confirm",
        data: "{pageVal:'ConfirmDocUpload',pageval1 :'" + data + "',pageval2 :'', pageval3:''}",
        dataType: "json",
        async: false,
        success: function (Result) {
            $('.block-ui').addClass('clear');
            Result = Result.d;
            var noteid = Result;
            if (noteid!="") {
              
                let timerInterval;
                Swal.fire({
                    width: 400,
                    type: 'success',
                    title: 'Success!',
                    html: "Done..!  ",
                    showConfirmButton: false,
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
                        window.open('Documentation_upload.aspx', '_self');
                    }
                }).then((result) => {
                    if (
                        // Read more about handling dismissals
                        result.dismiss === Swal.DismissReason.timer
                    ) {
                        window.open('Documentation_upload.aspx', '_self');
                    }
                })
                if (stat == "9") {
                    Swal.fire(content, 5000);
                    return false;
                }
            }
        }
    });
}
function Change_DocumentUpload() {
    var CRFID = $("#ddlCrf").val();
    var module = $("#ddlmdl").val();
    if (CRFID != null && CRFID != '-1' && module != null && module != '-1') {
        var crfdata = $('#ddlCrf option:selected').text();
        var mod_id = $('#ddlmdl option:selected').val();
        var ddtl = crfdata.split('~');
        window.open("ChangeDocUpload.aspx?noteid=" + ddtl[1] + "=" + ddtl[0] + "=" + mod_id, '_self');
    }
    else {
        Swal.fire("Please Choose CRF and Module!");
        $("#ddlCrf").focus();
        $("#ddlmdl").focus();
        return false;
    }
}
function Release_DocumentUpload() {
    CRFID = $("#ddlCrf").val();
    var module = $("#ddlmdl").val();
    if (CRFID != null && CRFID != '-1' && module != null && module != '-1') {
        var crfdata = $('#ddlCrf option:selected').text();
        var mod_id = $('#ddlmdl option:selected').val();
        var ddtl = crfdata.split('~');
        window.open("ReleaseNoteUpload.aspx?noteid=" + ddtl[1] + "=" + ddtl[0] + "=" + mod_id, '_self');
    }
    else {
        Swal.fire("Please Choose CRF and Module!");
        $("#ddlCrf").focus();
        return false;
    }
}
function Testing_DocumentUpload() {
    CRFID = $("#ddlCrf").val();
    var module = $("#ddlmdl").val();
    if (CRFID != null && CRFID != '-1' && module != null && module != '-1') {
        var crfdata = $('#ddlCrf option:selected').text();
        var mod_id = $('#ddlmdl option:selected').val();
        var ddtl = crfdata.split('~');
        window.open("TestingArtifactsUpload.aspx?noteid=" + ddtl[1] + "=" + ddtl[0] + "=" + mod_id, '_self');
    }
    else {
        Swal.fire("Please Choose CRF and Module!");
        $("#ddlCrf").focus();
        return false;
    }
}
function Other_DocumentUpload() {
   
    CRFID = $("#ddlCrf").val();
    var module = $("#ddlmdl").val();
    if (CRFID != null && CRFID != '-1' && module != null && module != '-1') {
        var crfdata = $('#ddlCrf option:selected').text();
        var mod_id = $('#ddlmdl option:selected').val();
        var ddtl = crfdata.split('~');
        window.open("OtherDocUpload.aspx?noteid=" + ddtl[1] + "=" + ddtl[0] + "=" + mod_id, '_self');
    }
    else {
        Swal.fire("Please Choose CRF and Module!");
        $("#ddlCrf").focus();
        return false;
    }
}
function Already_Upload_doc() {
    var crfval = $("#ddlCrf option:selected").text();
    var reqid = crfval.split('~');
    var reqid1 = reqid[0];
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "Documentation_upload.aspx/getRequestNote",
        data: "{pageVal:'DocCheck', pageval1 :'" + reqid1 + "', pageval2:''}",
        dataType: "json",
        async: false,
        success: function (Result) {
            Result = Result.d;
            if (Result != 'NA') {
                var details = Result.split('±');
                if (details[0] == '1') {
                    document.getElementById("lblData").classList.add('text-cyan');
                    document.getElementById("lblData").classList.remove('blink_me');
                    $("#lblData").text("Files Uploaded");
                }
                else {
                    document.getElementById("lblData").classList.remove('text-cyan');
                    document.getElementById("lblData").classList.add('blink_me');
                    document.getElementById("lblData").classList.add('text-danger');
                    $("#lblData").text("Uploading Pending..!");
                }
                if (details[1] == '1') {
                    document.getElementById("lblInfo2").classList.add('text-cyan');
                    document.getElementById("lblInfo2").classList.remove('blink_me');
                    $("#lblInfo2").text("Files Uploaded");
                }
                else {                    
                    document.getElementById("lblInfo2").classList.remove('text-cyan');
                    document.getElementById("lblInfo2").classList.add('blink_me');
                    document.getElementById("lblInfo2").classList.add('text-danger');
                    $("#lblInfo2").text("Uploading Pending..!");
                }
                if (details[2] == '1') {
                    document.getElementById("lblInfo1").classList.add('text-cyan');
                    document.getElementById("lblInfo1").classList.remove('blink_me');
                    $("#lblInfo1").text("Files Uploaded");
                }
                else {
                    document.getElementById("lblInfo1").classList.remove('text-cyan');
                    document.getElementById("lblInfo1").classList.add('blink_me');
                    document.getElementById("lblInfo1").classList.add('text-danger'); 
                    $("#lblInfo1").text("Uploading Pending..!");
                }
                if (details[3] == '1') {
                    document.getElementById("lblInfo3").classList.add('text-cyan');
                    document.getElementById("lblInfo3").classList.remove('blink_me');
                    $("#lblInfo3").text("Files Uploaded");
                }
                else {
                    document.getElementById("lblInfo3").classList.remove('text-cyan');
                    document.getElementById("lblInfo3").classList.add('blink_me');
                    document.getElementById("lblInfo3").classList.add('text-danger');
                    $("#lblInfo3").text("Uploading Pending..!");
                }
            }
           
        }
    });
}
function GetDelayCountDD() {
    //alert("Haii am developer");
    var Data = '';
    Data = $("[id*=hdUserId]").val()
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "DeveloperDelayUpdation.aspx/GetDelayCountDfreeze",
        data: "{pageVal:'GetDelayCountDFreez', pageval1:'" + Data + "',pageval2:''}",
        dataType: "json",
        async: false,
        success: function (Result) {
            Result = Result.d;
            //alert(Result);
            $("[id*=hdGetTechleader]").val(Result);
            //alert(Result);
            //document.getElementById("delaycount").innerHTML = Result;
            var formacesscount = $("[id*=hdGetTechleader]").val();
            //document.getElementById("delaycount").innerHTML = Result;
            if (formacesscount > 0) {

                let timerInterval
                Swal.fire({
                    width: 400,
                    type: 'error',
                    title: 'You Have Delay CRF !',
                    html: "Please Update the Delay Reason!! ",
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
                        window.open('DeveloperDelayUpdation.aspx', '_self');
                    }
                }).then((result) => {
                    if (
                        result.dismiss === Swal.DismissReason.timer
                    ) {
                        window.open('DeveloperDelayUpdation.aspx', '_self');
                    }
                })

            }
        }
    });
}
