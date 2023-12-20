var tot = 0;
var days = "";
var f = 0;
var c;
var accessility = 0;
$(window).on('load', function () {

    $("#txtModRemar").val("");
    $("#checkfile").hide();
        crfload();
      
        
});

function statusLoad() {
    var crf = $("#ddlCrf").val();
    var usr = $("[id*=hdUserId]").val();
    var data = crf + "^" + usr;
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "RandDWorkCreate.aspx/getFillData",
        data: "{pageVal:'STATUSLOADRANDD', pageval1 :'" + data+"'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            $('#ddlStatus').append($("<option></option>").val("-1").html("Choose Status"));
            $.each(Result, function (key, value) {
                $('#ddlStatus').append($("<option></option>").val(value.id).html(value.name));
            });
        }
    });
}


function detailsLoad() {
    var crf = $("#ddlCrf").val();
    $("#checkfile").hide();

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
            async:false,
            success: function (Result) {

                Result = Result.d;
                var crfdtl = Result;
                var cdtl = crfdtl.split('~');
                $('#lblTeam').html(cdtl[0]);
                $('#lblStDt').html(cdtl[1]);
                $('#lblTarDt').html(cdtl[2]);
                statusLoad();
            },
            error: function (Result) {

                alert(Result);
            }
        });


        $.ajax({
            type: "post",
            contentType: "application/json; charset=utf-8",
            url: "RandDWorkCreate.aspx/AccessCheck",
            data: "{pageVal:'GetRADDetails', pageval1 :'" + crf + "',pageval2 :''}",
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
        filesFill(crf);
        GetRequestId(crf);
    }
}
function GetRequestId(CRFID) {

    var usr = $("[id*=hdUserId]").val();
    usr = usr + '^' + CRFID;
    var dtl = $('#ddlCrf option:selected').text();
    var ddtl = dtl.split('~');

    $("[id*=hdRqstID]").val(ddtl[0]);

}
function frmExit() {
    window.open("index.aspx", "_self");
}
function crfload() {
    var usr = $("[id*=hdUserId]").val();
    $('#ddlCrf').empty();
    //alert(usr);
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "RandDWorkCreate.aspx/getFillData",
        data: "{pageVal:'RDWORKDEVUPDATE', pageval1 :'" + usr + "'}",
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

function WorkCreateConfirm() {
    var flag = 0;

   // var usr = $("[id*=hdUserId]").val();
    if ($("#ddlCrf").val() == "-1") {
        Swal.fire("Please choose a work.!");
        flag = 1;
        return false;
    }
    if ($("#ddlStatus").val() == "-1") {
        Swal.fire("Please choose status.!");
        flag = 1;
        return false;
    }
    uploadedElements = $(".file-uploaded");
    if ($("#ddlStatus").val() == "2") {
        if (uploadedElements.length <= 0) {

            alert("Please Attach File..! Testrequestform/Unittestform");
            return false;
        }
        else {
            Testrequestform();

        }
    }
    
    if (flag == 0) {
        var details = $("[id*=hdUserId]").val() + '^' + $("#ddlCrf").val() + '^' + $("#ddlStatus").val() + '^' + $("#txtModRemar").val();
        $.ajax({
            type: "post",
            contentType: "application/json; charset=utf-8",
            url: "RandDWorkCreate.aspx/RequestNoteConfirm",
            data: "{pageVal:'WORKUPDATERANDD', pageval1:'WORKUPDATERANDD',pageval2:'" + details + "',pageval3:'" + $("[id*=hdUserId]").val() + "'}",
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
                        html: "Work status has been updated.",
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
                            window.open('RandDDeveloperUpdate.aspx?crfid=1', '_self');
                        }
                    }).then((result) => {
                        if (
                            result.dismiss === Swal.DismissReason.timer
                        ) {
                            window.open('RandDDeveloperUpdate.aspx?crfid=1', '_self');
                        }
                    })
                }
                else {
                    alert("Something went wrong.!Please contact IT Support");
                }

            }
        });
    }
    

}

function Testrequestform() {

    uploadedElements = $(".file-uploaded");
    if (uploadedElements.length <= 0) {

        alert("Please Attach File..! If you don't need to attach Test Case ,Please Click REMOVE Button", 3000);
        return false;
    }


    else {

        for (let i = 0; i < uploadedElements.length; i++) {

            let extension = "";
            let element = uploadedElements.eq(i)[0];
            let fileList = element.files;
            let fileReader = new FileReader();
            if (fileReader && fileList && fileList.length) {
                let fileSize = fileList[0].size / 1048576;
                if (fileSize > 10) {
                    //dangerAlert("Please Upload Files Less Than 10MB..!", 3000);
                    alert("Please Upload Files Less Than 10MB");
                    return false;
                }
                let fileName = fileList[0].name;
                // Use a regular expression to trim everything before final dot
                extension = fileName.replace(/^.*\./, '');
                // Iff there is no dot anywhere in filename, we would have extension == filename,
                // so we account for this possibility now
                if (extension == fileName) {
                    extension = '';
                } else {

                    extension = extension.toLowerCase();
                }
                fileReader.readAsDataURL(fileList[0]);
                fileReader.onload = function () {
                    let fileno = i + 1;
                    let imageData1 = fileReader.result;
                    let InputData1 = $("[id*=hdRqstID]").val() + "µ" + fileno + "µ" + extension + "µ" + fileName.replace(/[^a-zA-Z0-9._]/g, '') + "µ" + $("[id*=hdUserId]").val();
                    var sessionkey = $("[id*=hdSesssion]").val();
                    var keySession = sessionkey.substring(0, 16);

                    var key = CryptoJS.enc.Utf8.parse(keySession);
                    var iv = CryptoJS.enc.Utf8.parse(keySession);
                    var encryptedInput = CryptoJS.AES.encrypt(CryptoJS.enc.Utf8.parse(InputData1), key,
                        {
                            keySize: 128 / 8,
                            iv: iv,
                            mode: CryptoJS.mode.CBC,
                            padding: CryptoJS.pad.Pkcs7
                        });
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "RandDDeveloperUpdate.aspx/UploadingFiles",
                        data: "{ImageData:'" + imageData1 + "',InputData:'" + encryptedInput + "'}",
                        dataType: "json",
                        async: false,
                        success: function (Result) {

                            if (Result.d.toString() == "666") {

                                dangerAlert("Failed to upload files. File type not supported. Please try again.", 3000);
                                return flase;

                            }
                            else {
                                if (i == uploadedElements.length - 1) {



                                }
                            }

                        },
                        error: function (Result) {
                            //alert(Result);
                            let timerInterval
                            Swal.fire({
                                width: 400,
                                type: 'error',
                                title: 'Oops...!',
                                html: Result,
                                //showConfirmButton: false,
                                allowOutsideClick: false,
                                timer: 5000,
                                onBeforeOpen: () => {
                                    //Swal.showLoading()
                                    timerInterval = setInterval(() => {
                                        Swal.getContent().querySelector('strong')
                                            .textContent = Swal.getTimerLeft()
                                    }, 100)
                                },
                                onClose: () => {
                                    clearInterval(timerInterval)
                                    //window.open('Approve2.aspx', '_self');
                                }
                            }).then((result) => {
                                if (
                                    // Read more about handling dismissals
                                    result.dismiss === Swal.DismissReason.timer
                                ) {
                                    //window.open('Approve2.aspx', '_self');
                                }
                            })
                        }
                    });

                };
            }
            else {

                return false;
            }


        }
    }
}
function filesFill(noteid) {

    $("#tblFiles").empty();
    var filenm = $("[id*=hdUserId]").val() + noteid.replace(/[^a-zA-Z0-9]/g, '') + "_";
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "DeveloperUpdation.aspx/getFileData",
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
function updationcheck() {
    var err = $("#ddlCrf").val();
    var sta = $("#ddlStatus option:selected");
    var value = sta.text();
    alert(value);


    if (err != -1) {
        if (value == "Work Completed") {


            $("#checkfile").show();
            //getobject();


        }
        else {

            $("#checkfile").hide();
        }
    }
    else {
        $("#error").show();
        $("#checkfile").hide();
    }
}
