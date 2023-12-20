$(window).on('load', function () {

    TestCaseUpdateChecking();
});

function frmExit() {
    window.open('index.aspx', '_self');
}

function TestCaseUpdateChecking() {
    
    var usr = $("[id*=hdUserId]").val();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "TestCaseUpdation.aspx/getFillData",
        data: "{pageVal:'testcaseupdatingaccess', pageval1 :'" + usr + "',pageval2 :''}",
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

function TestCaseUpdationform() {
    uploadedElements = $(".file-uploaded");
    //alert(uploadedElements.length);
    if (uploadedElements.length <= 0) {

        alert("Please Attach File..! If you don't need to attach Test Case ,Please Click REMOVE Button", 3000);
        return false;
    }


    else {
        debugger;
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
                    //alert("hit");
                    let fileno = i + 1;
                    let imageData1 = fileReader.result;
                    let InputData1 = fileno + "µ" + extension + "µ" + fileName.replace(/[^a-zA-Z0-9._]/g, '') + "µ" + $("[id*=hdUserId]").val();
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
                        url: "TestCaseUpdation.aspx/UploadingFiles",
                        data: "{ImageData:'" + imageData1 + "',InputData:'" + encryptedInput + "'}",
                        dataType: "json",
                        async: false,
                        success: function (Result) {
                            //alert(Result.d);
                            data = Result.d;
                            if (Result.d.toString() == "666")
                            {

                                //dangerAlert("Failed to upload files. File type not supported. Please try again.", 3000);
                                alert("Failed to upload files. File type not supported. Please try again.", 3000);
                                window.open('TestCaseUpdation.aspx', '_self');
                                return flase;

                            }
                            else if (data == "Successfully Uploaded") {
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
                                        window.open('TestCaseUpdation.aspx', '_self');
                                    }
                                }).then((result) => {
                                    if (
                                        // Read more about handling dismissals
                                        result.dismiss === Swal.DismissReason.timer
                                    ) {
                                        window.open('TestCaseUpdation.aspx', '_self');
                                    }
                                })
                            }
                            else {
                                if (i == uploadedElements.length - 1) {



                                }
                            }

                        },
                        error: function (Result) {
                            alert(Result);
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
                                   // window.open('TestCaseUpdation.aspx', '_self');
                                }
                            }).then((result) => {
                                if (
                                    // Read more about handling dismissals
                                    result.dismiss === Swal.DismissReason.timer
                                ) {
                                    //window.open('TestCaseUpdation.aspx', '_self');
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

function ConfirmNote() {
    //alert("gg");
    TestCaseUpdationform();
   
}
