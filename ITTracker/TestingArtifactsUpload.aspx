<%@ Page Title="" Language="C#" MasterPageFile="~/PWA_Master.Master" AutoEventWireup="true" CodeBehind="TestingArtifactsUpload.aspx.cs" Inherits="ITTracker.TestingArtifactsUpload" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<%--      <script src="js/Documentation.js"></script>--%>
    <link href="css/MultipleUpload.css" rel="stylesheet"/>
    <script src="js/MultipleUpload.js"></script>
    <script src="js/aes.js"></script>
    <script>
        $(window).on('load', function () {
            let querystring = window.location.search.substring(1);
            $("[id*=hdRqstID]").val(querystring.split("=")[2]);
            File_Load(); 
            });
        function YesOrNo() {
            let uploadedElements = "";
            uploadedElements = $(".file-uploaded");
            if (uploadedElements.length <= 0) {
                Swal.fire("Please Choose File less than 15 MB and Upload");
                return false;
            }
            else {


                Swal.fire({
                    title: 'Information',
                    text: "Are you ready to upload the selected files?",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes'
                }).then((result) => {
                    if (result.value == true) {
                        ///////////////////////////////////////////////////////

                        for (let i = 0; i < uploadedElements.length; i++) {

                            let extension = "";
                            let element = uploadedElements.eq(i)[0];
                            let fileList = element.files;
                            let fileReader = new FileReader();
                            if (fileReader && fileList && fileList.length) {
                                let fileSize = fileList[0].size / 1048576;
                                if (fileSize > 20) {
                                    Swal.fire("Please Upload Files Less Than 15 MB..!", 3000);
                                    return false;
                                }
                                let fileName = fileList[0].name;
                                extension = fileName.replace(/^.*\./, '');
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
                                        url: "TestingArtifactsUpload.aspx/UploadingFile",
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
                                                    Change_DocUpload();

                                                }
                                            }

                                        },
                                        error: function (Result) {
                                            let timerInterval
                                            Swal.fire({
                                                width: 400,
                                                type: 'error',
                                                title: 'Oops...!',
                                                html: Result,
                                                allowOutsideClick: false,
                                                timer: 5000,
                                                onBeforeOpen: () => {
                                                    timerInterval = setInterval(() => {
                                                        Swal.getContent().querySelector('strong')
                                                            .textContent = Swal.getTimerLeft()
                                                    }, 100)
                                                },
                                                onClose: () => {
                                                    clearInterval(timerInterval)
                                                }
                                            }).then((result) => {
                                                if (
                                                    result.dismiss === Swal.DismissReason.timer
                                                ) {
                                                }
                                            })
                                        }
                                    });

                                };
                            }
                            else {

                                return false;
                            }
                            //do something with element

                        }
                        //////////////////////////////////////////////////////
                        
                    }
                    else {
                        return false;
                    }
                })
            }
        }
function Change_DocUpload() {
    var note = "";
    var reqid = "";
    var module = "";
    let querystring = window.location.search.substring(1);  
    if (querystring == '0' || querystring == '' || querystring == 'undefined' || querystring == null) {
        Swal.fire("Please Go back and Try again!!");
        return false;
    }
    else {
        note = querystring.split("=")[1];
        reqid = querystring.split("=")[2];
         module = querystring.split("=")[3];
        window.location.href = "Documentation_upload.aspx?noteid=" + note +"="+ reqid + "=" + module
    }
     
     
        }
        function File_Load() {               
    
    var noteid = $("[id*=hdRqstID]").val();
            $("#tblFiles").empty();
            var filenm = "TestingDoc" + noteid.replace(/[^a-zA-Z0-9]/g, '') + "_";
            $.ajax({
                type: "post",
                contentType: "application/json; charset=utf-8",
                url: "TestingArtifactsUpload.aspx/getFileData",
                async: false,
                data: "{pageVal:'GetTestingArtiFact', pageval1 :'" + noteid+ "', pageval2 :'" + filenm + "'}",
                dataType: "json",
                success: function (Result) {
                    Result = Result.d;
                    var valData, valData1;
                    var n = 0;
                    valData = Result.split('Θ');
                    if ($("#tblFiles tr").length == 0) {
                        $('#tblFiles').append('<thead class="bg-success text-white"><tr><th scope="col">File No</th><th scope="col">File Name</th><th class="text-left">DELETE</th></tr></thead>');
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
                            '<td><a href="#" onclick="remove_data(\''+ contentDtl[0] + "~" + contentDtl[1] + '\'); return false">Remove</a></td>' +
                            '</tr> </tbody>');
                    }


                },
                error: function (Result) {

                }
            });
            
            if ($("#tblFiles tr").length > 1) {
                $("#doc").show();
            }
            else  $("#doc").hide();

        }          
  

        function remove_data(fileNo,fileName) {
             var data = fileNo + '~TESTING_DOC';
            Swal.fire({
                    title: 'Information',
                    text: "Are you ready to Delete the selected file from DB?",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes'
                }).then((result) => {
                    if (result.value == true) {
                         var noteid = $("[id*=hdRqstID]").val();
                         var usr = $("[id*=hdUserId]").val();
                        $.ajax({
                                type: "post",
                                contentType: "application/json; charset=utf-8",
                                url: "TestingArtifactsUpload.aspx/DeleteFileInDB",
                                data: "{pageVal:'DeleteDocs', pageval1:'" + noteid + "',pageval2:'" + usr+"',pageval3:'" + data+"'}",
                                dataType: "json",
                               success: function (Result) {
                                                    Result = Result.d;
                                                    if (Result!="") {
                                                        var note = "";
                                                        var reqid = "";
                                                        var module = "";
                                                        let querystring = window.location.search.substring(1);  
                                                        if (querystring == '0' || querystring == '' || querystring == 'undefined' || querystring == null) {
                                                            Swal.fire("Please Go back and Try again!!");
                                                            return false;
                                                        }
                                                        else {
                                                            note = querystring.split("=")[1];
                                                            reqid = querystring.split("=")[2];
                                                            module=querystring.split("=")[3];
                                                        }
                                                        Swal.fire("Successfully Deleted..");
                                                        window.location.href = "TestingArtifactsUpload.aspx?noteid=" + note + "=" + reqid + "=" +module
                                                        }
                                                  
                                                   }
                                });
                        return false;
                    }
                    else {
                        return false;
                    }
                })
    return false;
}
    </script>
    <style>
        .h2{
            position:center;
        }
        .pure-material-textfield-outlined {
            --pure-material-safari-helper1: rgb(var(--pure-material-primary-rgb, 33, 150, 243));
            position: relative;
            display: inline-block;
            padding-top: 7px;
            /*font-family: var(--pure-material-font, "Roboto", "Segoe UI", BlinkMacSystemFont, system-ui, -apple-system);*/
            font-size: 12px;
            line-height: 1.5;
            overflow: hidden;
            width: 100%;
            /*height: 2.3em;*/
        }

            /* Input, Textarea */
            .pure-material-textfield-outlined > input,
            .pure-material-textfield-outlined > textarea {
                box-sizing: border-box;
                margin: 0;
                border: solid 1px; /* Safari */
                border-color: rgba(var(--pure-material-onsurface-rgb, 0, 0, 0), 0.6);
                border-top-color: transparent;
                border-radius: 4px;
                padding: 5px 13px 5px;
                width: 100%;
                height: inherit;
                color: rgba(var(--pure-material-onsurface-rgb, 0, 0, 0), 0.87);
                background-color: transparent;
                box-shadow: none; /* Firefox */
                font-family: inherit;
                font-size: inherit;
                line-height: inherit;
                caret-color: rgb(var(--pure-material-primary-rgb, 33, 150, 243));
                transition: border 0.2s, box-shadow 0.2s;
            }

                /* Span */
                .pure-material-textfield-outlined > input + span,
                .pure-material-textfield-outlined > textarea + span {
                    position: absolute;
                    top: 0;
                    left: 0;
                    display: flex;
                    border-color: rgba(var(--pure-material-onsurface-rgb, 0, 0, 0), 0.6);
                    width: 100%;
                    max-height: 80%;
                    color: rgba(var(--pure-material-onsurface-rgb, 0, 0, 0), 0.6);
                    font-size: 75%;
                    line-height: 15px;
                    cursor: text;
                    transition: color 0.2s, font-size 0.2s, line-height 0.2s;
                }

                    /* Corners */
                    .pure-material-textfield-outlined > input + span::before,
                    .pure-material-textfield-outlined > input + span::after,
                    .pure-material-textfield-outlined > textarea + span::before,
                    .pure-material-textfield-outlined > textarea + span::after {
                        content: "";
                        display: block;
                        box-sizing: border-box;
                        margin-top: 6px;
                        border-top: solid 1px;
                        border-top-color: rgba(var(--pure-material-onsurface-rgb, 0, 0, 0), 0.6);
                        min-width: 10px;
                        height: 8px;
                        pointer-events: none;
                        box-shadow: inset 0 1px transparent;
                        transition: border-color 0.2s, box-shadow 0.2s;
                    }

                    .pure-material-textfield-outlined > input + span::before,
                    .pure-material-textfield-outlined > textarea + span::before {
                        margin-right: 4px;
                        border-left: solid 1px transparent;
                        border-radius: 4px 0;
                    }

                    .pure-material-textfield-outlined > input + span::after,
                    .pure-material-textfield-outlined > textarea + span::after {
                        flex-grow: 1;
                        margin-left: 4px;
                        border-right: solid 1px transparent;
                        border-radius: 0 4px;
                    }

            /* Hover */
            .pure-material-textfield-outlined:hover > input,
            .pure-material-textfield-outlined:hover > textarea {
                border-color: rgba(var(--pure-material-onsurface-rgb, 0, 0, 0), 0.87);
                border-top-color: transparent;
            }

                .pure-material-textfield-outlined:hover > input + span::before,
                .pure-material-textfield-outlined:hover > textarea + span::before,
                .pure-material-textfield-outlined:hover > input + span::after,
                .pure-material-textfield-outlined:hover > textarea + span::after {
                    border-top-color: rgba(var(--pure-material-onsurface-rgb, 0, 0, 0), 0.87);
                }

                .pure-material-textfield-outlined:hover > input:not(:focus):placeholder-shown,
                .pure-material-textfield-outlined:hover > textarea:not(:focus):placeholder-shown {
                    border-color: rgba(var(--pure-material-onsurface-rgb, 0, 0, 0), 0.87);
                }

            /* Placeholder-shown */
            .pure-material-textfield-outlined > input:not(:focus):placeholder-shown,
            .pure-material-textfield-outlined > textarea:not(:focus):placeholder-shown {
                border-top-color: rgba(var(--pure-material-onsurface-rgb, 0, 0, 0), 0.6);
            }

                .pure-material-textfield-outlined > input:not(:focus):placeholder-shown + span,
                .pure-material-textfield-outlined > textarea:not(:focus):placeholder-shown + span {
                    font-size: inherit;
                    line-height: 50px;
                }

                    .pure-material-textfield-outlined > input:not(:focus):placeholder-shown + span::before,
                    .pure-material-textfield-outlined > textarea:not(:focus):placeholder-shown + span::before,
                    .pure-material-textfield-outlined > input:not(:focus):placeholder-shown + span::after,
                    .pure-material-textfield-outlined > textarea:not(:focus):placeholder-shown + span::after {
                        border-top-color: transparent;
                    }

            /* Focus */
            .pure-material-textfield-outlined > input:focus,
            .pure-material-textfield-outlined > textarea:focus {
                border-color: rgb(var(--pure-material-primary-rgb, 33, 150, 243));
                border-top-color: transparent;
                box-shadow: inset 1px 0 var(--pure-material-safari-helper1), inset -1px 0 var(--pure-material-safari-helper1), inset 0 -1px var(--pure-material-safari-helper1);
                outline: none;
            }

                .pure-material-textfield-outlined > input:focus + span,
                .pure-material-textfield-outlined > textarea:focus + span {
                    color: rgb(var(--pure-material-primary-rgb, 33, 150, 243));
                }

                    .pure-material-textfield-outlined > input:focus + span::before,
                    .pure-material-textfield-outlined > input:focus + span::after,
                    .pure-material-textfield-outlined > textarea:focus + span::before,
                    .pure-material-textfield-outlined > textarea:focus + span::after {
                        border-top-color: var(--pure-material-safari-helper1) !important;
                        box-shadow: inset 0 1px var(--pure-material-safari-helper1);
                    }

            /* Disabled */
            .pure-material-textfield-outlined > input:disabled,
            .pure-material-textfield-outlined > input:disabled + span,
            .pure-material-textfield-outlined > textarea:disabled,
            .pure-material-textfield-outlined > textarea:disabled + span {
                border-color: rgba(var(--pure-material-onsurface-rgb, 0, 0, 0), 0.38) !important;
                border-top-color: transparent !important;
                color: rgba(var(--pure-material-onsurface-rgb, 0, 0, 0), 0.38);
                pointer-events: none;
            }

                .pure-material-textfield-outlined > input:disabled + span::before,
                .pure-material-textfield-outlined > input:disabled + span::after,
                .pure-material-textfield-outlined > textarea:disabled + span::before,
                .pure-material-textfield-outlined > textarea:disabled + span::after {
                    border-top-color: rgba(var(--pure-material-onsurface-rgb, 0, 0, 0), 0.38) !important;
                }

                .pure-material-textfield-outlined > input:disabled:placeholder-shown,
                .pure-material-textfield-outlined > input:disabled:placeholder-shown + span,
                .pure-material-textfield-outlined > textarea:disabled:placeholder-shown,
                .pure-material-textfield-outlined > textarea:disabled:placeholder-shown + span {
                    border-top-color: rgba(var(--pure-material-onsurface-rgb, 0, 0, 0), 0.38) !important;
                }

                    .pure-material-textfield-outlined > input:disabled:placeholder-shown + span::before,
                    .pure-material-textfield-outlined > input:disabled:placeholder-shown + span::after,
                    .pure-material-textfield-outlined > textarea:disabled:placeholder-shown + span::before,
                    .pure-material-textfield-outlined > textarea:disabled:placeholder-shown + span::after {
                        border-top-color: transparent !important;
                    }

        /* Faster transition in Safari for less noticable fractional font-size issue */
        @media not all and (min-resolution:.001dpcm) {
            @supports (-webkit-appearance:none) {
                .pure-material-textfield-outlined > input,
                .pure-material-textfield-outlined > input + span,
                .pure-material-textfield-outlined > textarea,
                .pure-material-textfield-outlined > textarea + span,
                .pure-material-textfield-outlined > input + span::before,
                .pure-material-textfield-outlined > input + span::after,
                .pure-material-textfield-outlined > textarea + span::before,
                .pure-material-textfield-outlined > textarea + span::after {
                    transition-duration: 0.1s;
                }
            }
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="card card-5 rightmarg">
        <form class="form-inline" runat="server" method="post" enctype="multipart/form-data">
            <div class="card-body">
                <h2> Attach Testing Artifacts</h2>
                 <div class="form-group col-md-12 padding-bottom-10px row" id="parallelrow">
               <div class="form-group col-md-2 align-right">
                 <label for="rdbNature">Attach Document: </label> 
               </div>
             <div class="file-upload col-md-4">
                <div class="file-select">
                  <div class="file-select-button" id="fileName">Choose File</div>
                  <div class="file-select-name" id="noFile">No file chosen...</div> 
                     <div class="file-chooser">
                         <input type="file" class="file-chooser__input">
                     </div>
                </div>
             </div> 
            <div class="file-uploader__message-area">
                   <p>Select a file to upload</p>
            </div>

        </div>
                <div id="doc" style="display: none">
                    <div class="row ">
                        <div class="col-md-6" id="attFiles">
                            <h6 class="modal-title" id="lblFiles">Already Uploaded File</h6>
                            <div class="table-responsive">
                                <table class="table1 table-hover" id="tblFiles">
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-2 col-xs-4">
                    <a href="#" class="btn btn-sm animated-button thar-one btn-primary" style="width: 70%; margin: 5px;"
                        onclick="return YesOrNo();" id="btnTesting_Doc"><i class="fa fa-upload"></i>Save</a>
                </div>
            </div>
      </form>
  </div>
     <input id="hdUserId" type="hidden" runat="server" />
    <input id="hdBranchId" type="hidden" runat="server" />
    <input id="hdFirmId" type="hidden" runat="server" />

    <input id="hdSesssion" type="hidden" runat="server" />
    <input id="hddata" type="hidden" runat="server" />
    <input id="hdRqstID" type="hidden" runat="server" />
</asp:Content>
