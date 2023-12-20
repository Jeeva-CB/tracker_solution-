
//    function ba_DocumentUpload() {
//    var CRFID = $("#ddlCrf").val();

//    if (CRFID != null && CRFID != '-1' ) {
//        var crfdata = $('#ddlCrf option:selected').text();

//    var ddtl = crfdata.split('~');
//    window.open("baDocumentation.aspx?noteid=" + ddtl[1] + "=" + ddtl[0] , '_self');
//}
//    else {
//        Swal.fire("Please Choose CRF and Module!");
//    $("#ddlCrf").focus();
//    $("#ddlmdl").focus();
//    return false;
//}
//}
$(window).on('load', function () {
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
   // accessibility_Check();
    CRFLoad();
    let querystring = window.location.search.substring(1);
    //alert(querystring);
    if (querystring == '0' || querystring == '' || querystring == 'undefined' || querystring == null) {

        crfNo = 0;

    }
    else {
        let querynoteid = querystring.split("=")[1];
        crfNo = querynoteid;
        fillCRFData();
        crfNo = 0;
        
    }

    $("[id*=hdRqstID]").val('');
    
});
function accessibility_Checkuser() {
     var crf = $('#ddlbaCrf option:selected').val();
    
    var usr = $("[id*=Hidden1]").val();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "Ba_Docupload.aspx/getaccess",
        data: "{pageVal:'Get_badoc_access_user', pageval1:'" + usr + "',pageval2:'" + crf + "'}",
        dataType: "json",
        async: false,
        success: function (Result) {
            Result = Result.d;
            if (Result == '1') { accessility = 1; $("#showContents").show(); $("#rmkShow").hide(); $("#developerShow").hide(); $("#attachments").hide(); }//ba
            else if (Result == '2') { accessility = 2; $("#showContents").hide(); $("#rmkShow").show(); $("#developerShow").show(); $("#attachments").show(); }// user or dept head
            else { accessility = '111'; $("#showContents").hide(); $("#rmkShow").hide(); $("#developerShow").hide(); $("#attachments").hide(); } //all other            
      }
    });
    //  detailsLoad(crf);
}
function accessibility_Check() {
  //  var crf = $('#ddlbaCrf option:selected').val();
  //  data: "{pageVal:'Get_badoc_access', pageval1:'" + usr + "',pageval2:'" + crf + "'}",
    var usr = $("[id*=Hidden1]").val();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "Ba_Docupload.aspx/getaccess",
        data: "{pageVal:'Get_badoc_access', pageval1:'" + usr + "',pageval2:''}",
        dataType: "json",
        async: false,
        success: function (Result) {
            Result = Result.d;
            if (Result == '1') { accessility = 1; $("#showContents").show(); $("#rmkShow").hide(); $("#developerShow").hide(); $("#attachments").hide(); }//ba
           else if (Result == '2') { accessility = 2; $("#showContents").hide(); $("#rmkShow").show(); $("#developerShow").show(); $("#attachments").show();  }// user or dept head
            else { accessility = '111'; $("#showContents").hide(); $("#rmkShow").hide(); $("#developerShow").hide(); $("#attachments").hide(); } //all other            
        }
    });
  //  detailsLoad(crf);
}
function CRFLoad() {
    var usr = $("[id*=Hidden1]").val();
   
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "Ba_Docupload.aspx/get_crflist",
        data: "{pageVal:'Get_bacrflist',pageval1:'" + usr + "'}",
        dataType: "json",
        async: false,
        success: function (Result) {
            Result = Result.d;
            $.each(Result, function (key, value) {
                $('#ddlbaCrf').append($("<option></option>").val(value.crf_id).html(value.crf));
            });
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
function detailsLoad(noteid) {
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "Ba_Docupload.aspx/getcrfcontent",
        data: "{pageVal:'GetRequestNotes', pageval1:'" + noteid + "',pageval2:'2'}",
        dataType: "json",
        async: false,
        success: function (Result) {
            Result = Result.d;
            $('.summernoteview').summernote('code', Result);
        }
         
    });
  //  accessibility_Checkuser();
}


//function fillCRFData () {
//    accessibility_Check();

//}
function ba_DocumentUpload() {
    var CRFID = $('#ddlbaCrf option:selected').val();
    //alert(CRFID);
    if (CRFID != null && CRFID != '-1') {
        var crfdata = $('#ddlbaCrf option:selected').text();
        //alert(crfdata);
        var ddtl = crfdata.split('~');
        //alert(ddtl);
        window.open("baDocumentation.aspx?noteid=" + ddtl[0] + "=" + ddtl[2], '_self');
    }
    else {
        Swal.fire("Please Choose CRF and Module!");
        $("#ddlbaCrf").focus();
        return false;
    }
}
function fillCRFData() {
    accessibility_Checkuser();
    var CRFID = "";
    if (crfNo != 0) {
      
        CRFLoad();
      
        CRFID = crfNo;


        Swal.fire("Uploaded Successfully");

        $("#ddlbaCrf").val(crfNo);
       

    }
    else {
       
        CRFID = $("#ddlbaCrf").val();
        var crf = $('#ddlbaCrf option:selected').text();


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
    var crfdata = $('#ddlbaCrf option:selected').text();
    var ddtl = crfdata.split('~');
    var req = ddtl[0];
    //alert("1");
    //alert(req);
    $("[id*=hdRqstID]").val(req);
    Documents_Load1(req);

    $("#txtRemarks").val("");
}
function CRFSearch() {
    var crfval = "";
    var reqid = "";
    var CRFID = "";
    var reqid1 = "";
    if (crfNo != 0) {
        
        CRFID = crfNo;
        loadStatus();
        Already_Upload_doc();
    }
    else {
        loadStatus();
        crfval = $("#ddlbaCrf option:selected").text();
        reqid = crfval.split('~');
        reqid1 = reqid[0];
        CRFID = $("#ddlbaCrf").val();
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
        async: false,
        success: function (Result) {

            Result = Result.d;
            $.each(Result, function (key, value) {
                var crfdtl = value.id;

                var cdtl = crfdtl.split('±');

               
            });
        },
        error: function (Result) {

            //alert(Result);
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
function loadStatus() {
    $("#txtData").show();
    $("#txtData1").show();
    $("#txtData2").show();
    $("#txtData3").show();
}
function Documents_Load1(request_id) {
    //alert("documents");
    var count = 0;
    $("#tblFiles").empty();
    var filenm = "ReleaseDocuments_" + $("[id*=Hidden1]").val() + "_" + request_id.replace(/[^a-zA-Z0-9]/g, '') + "_";
    //alert(filenm);
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "Ba_Docupload.aspx/getFileData",
        async: false,
        data: "{pageVal:'GetBADocumentation', pageval1 :'" + request_id + "', pageval2 :'" + filenm + "'}",
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
function Documents_Load(noteid) {
    $("#tblFiles").empty();
    var filenm = $("[id*=Hidden1]").val() + noteid.replace(/[^a-zA-Z0-9]/g, '') + "_";
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "Documentation_upload.aspx/getFileData",
        async: false,
        data: "{pageVal:'GetBADocumentation', pageval1 :'" + noteid + "', pageval2 :'" + filenm + "'}",
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
function Already_Upload_doc() {
    //alert("hail");
    var crfval = $("#ddlbaCrf option:selected").text();
    var reqid = crfval.split('~');
    var reqid1 = reqid[0];
    //alert(reqid1);
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "ba_Docupload.aspx/getRequestNote",
        data: "{pageVal:'baDocCheck', pageval1 :'" + reqid1 + "'}",
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
               
            }

        }
    });
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

            var data = "";
            CRFID = $("#ddlbaCrf").val();
            if (CRFID == null || CRFID == '-1') {
                Swal.fire("Please Choose CRF!");
                $("#ddlbaCrf").focus();
                return false;
            }

            else {
                var crfdata = $('#ddlbaCrf option:selected').text();
                var ddtl = crfdata.split('~');
                $("[id*=hdRqstID]").val(ddtl[0]);
            }
            //if (accessility == 3) {
            //    if ($('#ddlbaCrf option:selected').val() == '-1') {
            //        Swal.fire("Please Choose Module!");
            //        $("#ddlbaCrf").focus();
            //        return false;
            //    }
            //}
            if ( accessility == 2) {
                if ($("#txtRemarks").val() == "") {
                    Swal.fire("Kindly add Remarks..!");
                    return false;
                }
                else {

                    data = $("#ddlbaCrf").val() + '^' + $("#txtRemarks").val() + '^' + $("[id*=hdRqstID]").val() + '^' + $("[id*=Hidden1]").val() + '^' + accessility + '^' + 'CONFIRM';
                    setTimeout(function () {
                        Confirm_Doc_Upload(data);
                    }, 3000);

                }
            }
            else if(accessility == 1) {
                if ($("#lblData").text() == "Files Uploaded" ) {
                    data = $("#ddlbaCrf").val() + '^' + 'nil' + '^' + $("[id*=hdRqstID]").val() + '^' + $("[id*=Hidden1]").val() + '^' + accessility + '^' + 'CONFIRM' ;
                   //alert(data);
                    setTimeout(function () {
                        Confirm_Doc_Upload(data);
                    }, 3000);
                }
                else {
                    Swal.fire("Please Upload Files ..!");
                    return false;
                }

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
        url: "ba_Docupload.aspx/BaDoc_Confirm",
        data: "{pageVal:'ConfirmbaDocUpload',pageval1 :'" + data + "',pageval2 :'', pageval3:''}",
        dataType: "json",
        async: false,
        success: function (Result) {
            $('.block-ui').addClass('clear');
            Result = Result.d;
            var noteid = Result;
            if (noteid != "") {

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
                        window.open('Ba_Docupload.aspx', '_self');
                    }
                }).then((result) => {
                    if (
                        // Read more about handling dismissals
                        result.dismiss === Swal.DismissReason.timer
                    ) {
                        window.open('Ba_Docupload.aspx', '_self');
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