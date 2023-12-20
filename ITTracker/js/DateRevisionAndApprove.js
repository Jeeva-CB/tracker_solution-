$(window).on('load', function () {
    //alert("haii");
   
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
    $("#lblstaDt1").datepicker({
        dateFormat: 'dd/MM/yy',
        changeMonth: true,
        changeYear: true,
        stepMonths: true,
        todayHighlight: true,
        onSelect: function (dateText, inst) {
        }

    });
    $("#lblTarDt1").datepicker({
        dateFormat: 'dd/MM/yy',
        changeMonth: true,
        changeYear: true,
        stepMonths: true,
        todayHighlight: true,
        onSelect: function (dateText, inst) {
        }

    });
    $("#lblstaDt").datepicker({
        dateFormat: 'dd/MM/yy',
        changeMonth: true,
        changeYear: true,
        stepMonths: true,
        todayHighlight: true,
        onSelect: function (dateText, inst) {
        }

    });
    $("#lblTarDt").datepicker({
        dateFormat: 'dd/MM/yy',
        changeMonth: true,
        changeYear: true,
        stepMonths: true,
        todayHighlight: true,
        onSelect: function (dateText, inst) {
        }

    });
    $("#lblprtdate").datepicker({
        dateFormat: 'dd/MM/yy',
        changeMonth: true,
        changeYear: true,
        stepMonths: true,
        todayHighlight: true,
        onSelect: function (dateText, inst) {
        }

    });
    $("#txtRemarks").val("");
    $("#txtRemarks1").val("");
    crfload();
 

});
function fillCRFData() {
    var noteid = $("#ddlCrf").val();
    detailsLoad(noteid);
    Tafill(noteid);
    subcrffill(noteid);
    datefills(noteid);
}

function datefills(noteid) {
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "DateRevisionAndApprove.aspx/CheckEmpAccessNew",
        data: "{pageVal:'OldDatessAndNew', pageval1:'" + noteid + "',pageval2:''}",
        dataType: "json",
        async: false,
        success: function (Result) {
            Result = Result.d;
            var cdtl = Result.split('~');
            
            $('#lblRqstDt').text(cdtl[0]);
            $('#lbldevstdt').text(cdtl[1]);
            $('#lbldevenddt').text(cdtl[2]);
            $('#lbltstdt').text(cdtl[3]);
            $('#lbltstenddt').text(cdtl[4]);
            $('#iblprjtdate').text(cdtl[5]);

            $('#lblstaDt3').val(cdtl[6]);
            $('#lblTarDt3').val(cdtl[7]);
            $('#lblstaDt2').val(cdtl[8]);
            $('#lblTarDt2').val(cdtl[9]);
            $('#lblprtdate1').val(cdtl[10]);
           
        }
    });
}

function DateConfirmation() {
    var data = "";
    var reqid = $('#ddlCrf option:selected').text().split('~')[1];
 
    if ($("#txtRemarks1").val() == "") {
        Swal.fire("Please add your remarks.!");
        return false;
    }
    data = $("#ddlCrf").val() + "^" + reqid + "^" + $("[id*=hdUserId]").val() + "^" + $("#lblstaDt3").val() + "^" + $("#lblTarDt3").val() + "^" + $("#lblstaDt2").val() + "^" + $("#lblTarDt2").val() + "^" + $("#lblprtdate1").val() + "^" + $("#txtRemarks1").val();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "DateRevisionAndApprove.aspx/RequestConfirm",
        data: "{pageVal:'DateChangeRequest', pageval1 :'" + data + "',pageval2:'APPROVEDATECHANGE'}",
        dataType: "json",
        async: false,
        success: function (Result) {
            $('.block-ui').addClass('clear');
            Result = Result.d;
            var noteid = Result;

            if (noteid != '0') {
                let timerInterval
                Swal.fire({
                    width: 400,
                    type: 'success',
                    title: 'Success!',
                    html: "Target Date Change Approved!!",
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
                        window.open('DateRevisionAndApprove.aspx?crfid=1', '_self');
                    }
                }).then((result) => {
                    if (
                        result.dismiss === Swal.DismissReason.timer
                    ) {
                        window.open('DateRevisionAndApprove.aspx?crfid=1', '_self');
                    }
                })
            }
            else {
                alert("Something went wrong.!Please contact IT Support");
            }
        }
    });
}

function returnToRequester() {
    var data = "";
    if ($("#txtRemarks1").val() == "") {
        Swal.fire("Please add your remarks.!");
        return false;
    }
    var reqid = $('#ddlCrf option:selected').text().split('~')[1];
   
    data = $("#ddlCrf").val() + "^" + reqid + "^" + $("[id*=hdUserId]").val() + "^" + $("#txtRemarks1").val();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "DateRevisionAndApprove.aspx/RequestConfirm",
        data: "{pageVal:'DateChangeRequest', pageval1 :'" + data + "',pageval2:'RETURNDATECHANGE'}",
        dataType: "json",
        async: false,
        success: function (Result) {
            $('.block-ui').addClass('clear');
            Result = Result.d;
            var noteid = Result;

            if (noteid != '0') {
                let timerInterval
                Swal.fire({
                    width: 400,
                    type: 'success',
                    title: 'Success!',
                    html: "Return to Requester!!",
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
                        window.open('DateRevisionAndApprove.aspx?crfid=1', '_self');
                    }
                }).then((result) => {
                    if (
                        result.dismiss === Swal.DismissReason.timer
                    ) {
                        window.open('DateRevisionAndApprove.aspx?crfid=1', '_self');
                    }
                })
            }
            else {
                alert("Something went wrong.!Please contact IT Support");
            }
        }
    });
}


function crfload() {
    $("#ddlCrf").empty();
    var usr = checkemp($("[id*=hdUserId]").val());
    
    if (usr == 1) {
        $("#requesterdtls").show();
        $("#forapprover").hide();
        $.ajax({
            type: "post",
            contentType: "application/json; charset=utf-8",
            url: "DateRevisionAndApprove.aspx/getFillData",
            data: "{pageVal:'DateRequesting', pageval1:'',pageval2:''}",
            dataType: "json",
            async: false,
            success: function (Result) {
                Result = Result.d;
                $('#ddlCrf').append($("<option></option>").val("-1").html("Choose CRF"));

                $.each(Result, function (key, value) {
                    $('#ddlCrf').append($("<option></option>").val(value.id).html(value.name));
                });
            }
        });
    }
    else if (usr == 2) {
        $("#requesterdtls").hide();
        $("#forapprover").show();
        $.ajax({
            type: "post",
            contentType: "application/json; charset=utf-8",
            url: "DateRevisionAndApprove.aspx/getFillData",
            data: "{pageVal:'DateApprove', pageval1:'',pageval2:''}",
            dataType: "json",
            async: false,
            success: function (Result) {
                Result = Result.d;
                $('#ddlCrf').append($("<option></option>").val("-1").html("Choose CRF"));

                $.each(Result, function (key, value) {
                    $('#ddlCrf').append($("<option></option>").val(value.id).html(value.name));
                });
            }
        });
    }


}

function fillDates() {
   
    var reqid = $("#ddlSubCrf").val();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "DateRevisionAndApprove.aspx/CheckEmpAccessNew",
        data: "{pageVal:'GetImpDates', pageval1:'" + reqid + "',pageval2:''}",
        dataType: "json",
        async:false,
        success: function (Result) {
            Result = Result.d;
            var output = Result.split('~');
            $("#lblstaDt1").val(output[0]);
            $("#lblTarDt1").val(output[1]);
            $("#lblstaDt").val(output[2]);
            $("#lblTarDt").val(output[3]);
            $("#lblprtdate").val(output[4]);
        }
    });
}


function subcrffill(noteid) {
    $("#ddlSubCrf").empty();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "DateRevisionAndApprove.aspx/getFillData",
        data: "{pageVal:'TEAMMODULE',pageval1 :'SUBCRF',pageval2:'" + noteid + "'}",
        dataType: "json",
        async: false,
        success: function (Result) {
            Result = Result.d;
            $('#ddlSubCrf').append($("<option></option>").val("-1").html("Choose Sub CRF"));

            $.each(Result, function (key, value) {
                $('#ddlSubCrf').append($("<option></option>").val(value.id).html(value.name));
            });
        }
    });
}


function checkemp(usr) {
    var res = 0;
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "DateRevisionAndApprove.aspx/CheckEmpAccessNew",
        data: "{pageVal:'CheckConfirmer', pageval1:'" + usr + "',pageval2:''}",
        dataType: "json",
        async: false,
        success: function (Result) {
            Result = Result.d;
            res = Result;
        }
    });
   
    return res;
}

function FileUploading() {
    
    let uploadedElements = $(".file-uploaded");
    for (let i = 0; i < uploadedElements.length; i++) {
        let extension = "";
        let element = uploadedElements.eq(i)[0];
        let fileList = element.files;
        let fileReader = new FileReader();
        if (fileReader && fileList && fileList.length) {
            let fileSize = fileList[0].size / 1048576;
            alert(fileSize);
            if (fileSize <= 0) {
                Swal.fire("File has no data!!");
                return false;
            }
            if (fileSize > 10) {
                // dangerAlert("Please Upload Files Less Than 10MB..!", 3000);
                Swal.fire("Please Upload Files Less Than 10MB");
                return false;
            }
        }
    }

    //upload image
    uploadedElements = $(".file-uploaded");
    if (uploadedElements.length <= 0) {
        
        ReqDateChange();
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
                    Swal.fire("Please Upload Files Less Than 10MB");
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
                    let InputData1 = $("#ddlCrf").val() + "µ" + $("#ddlSubCrf").val() +"µ"+ fileno + "µ" + extension + "µ" + fileName.replace(/[^a-zA-Z0-9._]/g, '');
                    
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
                        url: "DateRevisionAndApprove.aspx/UploadingFile",
                        data: "{ImageData:'" + imageData1 + "',InputData:'" + encryptedInput + "'}",
                        dataType: "json",
                        async: false,
                        success: function (Result) {

                            if (Result.d.toString() == "666") {

                                Swal.fire("Failed to upload files. File type not supported. Please try again.", 3000);
                                return flase;

                            }
                            else {
                                if (i == uploadedElements.length - 1) {

                                    ReqDateChange();

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


function ReqDateChange() {
    var data = "";
    if ($("#ddlCrf").val() == "") {
        Swal.fire("Please Choose a CRF!");
        return false;
    }
    if ($("#ddlSubCrf").val() == "") {
        Swal.fire("Please Choose Sub-CRF!");
        return false;
    }
    if ($("#lblstaDt1").val() == "" || $("#lblstaDt").val()== "" || $("#lblTarDt1").val()=="" || $("#lblTarDt").val()=="" || $("#lblprtdate").val() == "") {
        Swal.fire("Please Choose All dates.!");
        return false;
    }
    if ($("#txtRemarks").val() == "") {
        Swal.fire("Please add Remarks.!");
        return false;
    }
    data = $("#ddlCrf").val() + "^" + $("#ddlSubCrf").val() + "^" + $("[id*=hdUserId]").val() + "^" + $("#lblstaDt1").val() + "^" + $("#lblTarDt1").val() + "^" + $("#lblstaDt").val() + "^" + $("#lblTarDt").val() + "^" + $("#lblprtdate").val() + "^" + $("#txtRemarks").val();

    //Check file size
    

    


    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "DateRevisionAndApprove.aspx/RequestConfirm",
        data: "{pageVal:'DateChangeRequest', pageval1 :'" + data + "',pageval2:'CONFIRMTECH'}",
        dataType: "json",
        async: false,
        success: function (Result) {
            $('.block-ui').addClass('clear');
            Result = Result.d;
            var noteid = Result;
            
            if (noteid != '0') {
                let timerInterval
                Swal.fire({
                    width: 400,
                    type: 'success',
                    title: 'Success!',
                    html: "Target Date Change Requested!!",
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
                        window.open('DateRevisionAndApprove.aspx?crfid=1', '_self');
                    }
                }).then((result) => {
                    if (
                        result.dismiss === Swal.DismissReason.timer
                    ) {
                        window.open('DateRevisionAndApprove.aspx?crfid=1', '_self');
                    }
                })
            }
            else {
                alert("Something went wrong.!Please contact IT Support");
            }
        }
    });

}






function detailsLoad(noteid) {
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "ViewerNoteDetails.aspx/getRequestNote",
        data: "{pageVal:'GetRequestNotes', pageval1:'" + noteid + "',pageval2:'2'}",
        dataType: "json",
        async: false,
        success: function (Result) {
            Result = Result.d;
            $('.summernoteview').summernote('code', Result);
        }
    });
}







function Tafill(noteid) {
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "ViewerNoteDetails.aspx/getTableData",
        data: "{pageVal:'TACompleteData', pageval1 :'" + noteid + "', pageval2:''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            fillTATable(Result);
        }
    });
}



function fillTATable(data) {
    var valData, valData1;
    valData = data.split('Θ');

    if ($("#tabChange tr").length == 0) {
        $("#tabChange").empty();
        $('#tabChange').append('<tr style="background-color:#197969;color:white"><th class="text-center">REQUEST ID</th><th class="text-center">TECHLEAD</th><th class="text-center">DEVELOPER</th><th class="text-center">START DATE</th><th class="text-center">END DATE</th><th class="text-center">PHASE</th><th class="text-center">TECHCHANGES</th><th class="text-center">DESCRIPTION</th><th class="text-center">NO OF CHANGES</th><th class="text-center">TOTAL HOURS</th></tr>');
    }
    for (i = 0; i < valData.length - 1; i++) {
        valData1 = valData[i].split('µ');

        $('#tabChange').append('<tbody><tr class="text-center" style="background-color:#fff" >' +


            '<td>' + valData1[0] + '</td>' +
            '<td>' + valData1[1] + '</td>' +
            '<td>' + valData1[2] + '</td>' +
            '<td>' + valData1[3] + '</td>' +
            '<td>' + valData1[4] + '</td>' +
            '<td>' + valData1[5] + '</td>' +
            '<td>' + valData1[6] + '</td>' +
            '<td>' + valData1[7] + '</td>' +
            '<td>' + valData1[8] + '</td>' +
            '<td>' + valData1[9] + '</td></tr > </tbody > ');
    }
    //if ($("#tabChange tr").length > 1) {
    //    $("#taDetails").show();
    //}
    //else $("#taDetails").hide();
}