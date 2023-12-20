var sesInfo = 0;
$(window).on('load', function () {
    $("#TarDt").datepicker({
        dateFormat: 'dd/MM/yy',
        minDate: 0,
        changeMonth: true,
        changeYear: true,
        stepMonths: true,
        todayHighlight: true,
        onSelect: function (dateText, inst) {
        }

    });
    $("[id*=hdnPriority]").val("3"); 
    $("[id*=hdnErrorReportImpact]").val("2");
    $("[id*=hdnPolicyChangesImpact]").val("2");
    $("#txtRemarks").val("");

  
    $("#txtReason").val("");
    GetTeamList();
    GetReqTypeList();
    getModule();
    getBenifit();
   
});
function frmExit() {
    window.open("index.aspx", "_self");
}
/* To get team list  */
function GetTeamList() {
    
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "AddRequest.aspx/getFillData",
        data: "{pageVal:'IT_TEAM', pageval1 :''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            $('#ddlTeam').append($("<option selected disabled></option>").val("-1").html("Choose Team"));
            $.each(Result, function (key, value) {
                $('#ddlTeam').append($("<option></option>").val(value.id).html(value.name));
            });
        }
    });
}
/* To load request type list  */
function GetReqTypeList() {
   
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "AddRequest.aspx/getFillData",
        data: "{pageVal:'TYPE', pageval1 :''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            $('#ddlReqType').append($("<option selected disabled></option>").val("-1").html("Choose Request Type"));
            $.each(Result, function (key, value) {
                $('#ddlReqType').append($("<option></option>").val(value.id).html(value.name));
            });
        }
    });
}



function remarktext() {
    
    debugger;
    $("#div_01").show();
 
}
function remarktext1() {

    debugger;
    $("#div_01").hide();
    
}

//function getBenifit() {

//    $.ajax({
//        type: "post",
//        contentType: "application/json; charset=utf-8",
//        url: "AddRequest.aspx/getFillData",
//        data: "{pageVal:'getBenifits', pageval1 :''}",
//        dataType: "json",
//        success: function (Result) {
//            Result = Result.d;
//            $('#ddlBens').append($("<option selected disabled></option>").val("-1").html("Choose Benifits"));
//            $.each(Result, function (key, value) {
//                $('#ddlBens').append($("<option></option>").val(value.id).html(value.name));
//            });
//        }
//    });
//}


function getBenifit() {
    debugger
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "AddRequest.aspx/getFillData",
        data: "{pageVal:'getBenifits', pageval1 :''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            $('#ddlBens').append($("<option></option>").val("-1").html("Choose Benifits"));
            $.each(Result, function (key, value) {
                $('#ddlBens').append($("<option></option>").val(value.id).html(value.name));
            });
        }
    });
}


function frmExit() {
    window.open("index.aspx", "_self");
}
function successAlert(msg, tim) {
    $("#msgSuccess").text(msg);
    $(".alertSuccess").show();
    setTimeout(function () {
        $(".alertSuccess").hide();
    }, tim);
}

function dangerAlert(msg, tim) {
    $("#msgDanger").text(msg);
    $(".alertDanger").show();
    setTimeout(function () {
        $(".alertDanger").hide();
    }, tim);
}

function warningAlert(msg, tim) {
    $("#msgWarning").text(msg);
    $(".alertWarning").show();
    setTimeout(function () {
        $(".alertWarning").hide();
    }, tim);
}
function CleanPastedHTML(input) {
    // 1. remove line breaks / Mso classes
    var stringStripper = /(\n|\r| class=(")?Mso[a-zA-Z]+(")?)/g;
    var output = input.replace(stringStripper, ' ');
    // 2. strip Word generated HTML comments
    var commentSripper = new RegExp('<!--(.*?)-->', 'g');
    var output = output.replace(commentSripper, '');
    var tagStripper = new RegExp('<(/)*(meta|link|span|\\?xml:|st1:|o:|font)(.*?)>', 'gi');
    // 3. remove tags leave content if any
    output = output.replace(tagStripper, '');
    // 4. Remove everything in between and including tags '<style(.)style(.)>'
    var badTags = ['style', 'script', 'applet', 'embed', 'noframes', 'noscript'];

    for (var i = 0; i < badTags.length; i++) {
        tagStripper = new RegExp('<' + badTags[i] + '.*?' + badTags[i] + '(.*?)>', 'gi');
        output = output.replace(tagStripper, '');
    }
    // 5. remove attributes ' style="..."'
    var badAttributes = ['style', 'start'];
    for (var i = 0; i < badAttributes.length; i++) {
        var attributeStripper = new RegExp(' ' + badAttributes[i] + '="(.*?)"', 'gi');
        output = output.replace(attributeStripper, '');
    }
    return output;
}
$(document).ready(function () {
    $('.summernote').summernote({
        height: 135, // set editor height
        minHeight: null, // set minimum height of editor
        maxHeight: null, // set maximum height of editor
        focus: false, // set focus to editable area after initializing summernote
        toolbar: [
            ['font', ['bold', 'italic', 'underline', 'strikethrough', 'superscript', 'subscript', 'clear']],
            ['fontname', ['fontname']],
            ['fontsize', ['fontsize']],
            ['color', ['color']],
            ['para', ['ol', 'ul', 'paragraph', 'height']],
            ['table', ['table']],
            ['view', ['undo', 'redo']]

        ]
    });

    $('#summerNote').on('summernote.paste', function (e) {
        var thisNote = $(this);
        var updatePastedText = function (someNote) {
            var original = someNote.code();
            var cleaned = CleanPastedHTML(original); //this is where to call whatever clean function you want. I have mine in a different file, called CleanPastedHTML.
            someNote.code('').html(cleaned); //this sets the displayed content editor to the cleaned pasted code.
        };
        setTimeout(function () {
            updatePastedText(thisNote);
        }, 10);


    });
    
    $(".note-editable").on("keypress", function () {

        var limiteCaracteres = 255;
        var caracteres = $(this).text();
        var totalCaracteres = caracteres.length;
        $("#total-caracteres").text(totalCaracteres);
    });

  

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

    $('#rbnErrorReportImpact a').on('click', function () {
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
            $('a[data-toggle="' + tog + '"]').not('[data-title="' + sel + '"]').removeClass('btn-yellow').addClass('btn-dark');
            $('a[data-toggle="' + tog + '"][data-title="' + sel + '"]').removeClass('btn-dark').addClass('btn-yellow');
        }    


    })

    $('#rbnPolicyChangesImpact a').on('click', function () {
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
            $('a[data-toggle="' + tog + '"]').not('[data-title="' + sel + '"]').removeClass('btn-yellow').addClass('btn-dark');
            $('a[data-toggle="' + tog + '"][data-title="' + sel + '"]').removeClass('btn-dark').addClass('btn-yellow');
        }


    })
   
    //$('#rbnsensiteInfo a').on('click', function () {
    //    var sel = $(this).data('title');
    //    var tog = $(this).data('toggle');
    //    $('#' + tog).prop('value', sel);

    //    $('a[data-toggle="' + tog + '"]').not('[data-title="' + sel + '"]').removeClass('active').addClass('notActive');
    //    $('a[data-toggle="' + tog + '"][data-title="' + sel + '"]').removeClass('notActive').addClass('active');
    //    if (sel == 1) {
    //        $('a[data-toggle="' + tog + '"]').not('[data-title="' + sel + '"]').removeClass('btn-red').addClass('btn-dark');
    //        $('a[data-toggle="' + tog + '"][data-title="' + sel + '"]').removeClass('btn-dark').addClass('btn-red');
    //    }
    //    if (sel == 2) {
    //        $('a[data-toggle="' + tog + '"]').not('[data-title="' + sel + '"]').removeClass('btn-yellow').addClass('btn-dark');
    //        $('a[data-toggle="' + tog + '"][data-title="' + sel + '"]').removeClass('btn-dark').addClass('btn-yellow');
    //    }


    //})

    var paraDiv = $("#parallelrow");
    var j = $("#p_rowid").length + 1;


   
});
/************************************/
//inline-editor
/************************************/
$('.inline-editor').summernote({
    airMode: true
});

/************************************/
//edit and save mode
/************************************/
window.edit = function () {
    $(".click2edit").summernote()
},
    window.save = function () {
        $(".click2edit").summernote('destroy');
    }

var edit = function () {
    $('.click2edit').summernote({ focus: true });
};

var save = function () {
    var markup = $('.click2edit').summernote('code');
    $('.click2edit').summernote('destroy');
};

/************************************/
//airmode editor
/************************************/
$('.airmode-summer').summernote({
    airMode: true
});


$(document).on('click', '.remove-prow', function () {
    $(this).parent().parent().remove();
});
$(document).on('click', '.cancel-emp', function () {
    $(this).parent().remove();
});
function addQuotes(value) {
    var quotedVar = "\'" + value + "\'";
    return quotedVar;
}
$(function () {
    

    $("body").on("click", ".remove", function () {
        $(this).closest("tr").remove();
    });


});
 /* To get Impact modules  */
function getModule() {

    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "AddRequest.aspx/getFillData",
        data: "{pageVal:'getModulesCRF', pageval1 :''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            $('#ddlDept').append($("<option></option>").val("-1").html("Choose Module"));
            $.each(Result, function (key, value) {
                $('#ddlDept').append($("<option></option>").val(value.id).html(value.name));
            });
        }
    });
}
/************* For check whether entered data is number or not **************/
function isNumberKey(evt, element) {

    var charCode = (evt.which) ? evt.which : event.keyCode
    if (charCode > 31 && (charCode < 48 || charCode > 57) && !(charCode == 8))
        return false;
}
/************* When Click Return button **************/


function SaveImage(noteid) {
    var extension = "";

    let uploadedElements = $(".file-uploaded");
    for (let i = 0; i < uploadedElements.length; i++) {

        let element = uploadedElements.eq(i)[0];
        let fileList = element.files;
        let fileReader = new FileReader();
        if (fileReader && fileList && fileList.length) {
            let fileSize = fileList[0].size / 1048576;
            if (fileSize > 2) {
                alert("Please Upload Files Less Than 2MB");
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
                // if there is an extension, we convert to lower case
                // (N.B. this conversion will not effect the value of the extension
                // on the file upload.)
                extension = extension.toLowerCase();
            }
            fileReader.readAsDataURL(fileList[0]);
            fileReader.onload = function () {
                let fileno = i + 1;
                let imageData1 = fileReader.result;
                let InputData1 = noteid + "µ" + fileno + "µ" + extension + "µ" + fileName.replace(/[^a-zA-Z0-9._]/g, '');
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
                    url: "RequestNote.aspx/UploadingFile",
                    data: "{ImageData:'" + imageData1 + "',InputData:'" + encryptedInput + "'}",
                    dataType: "json",
                    success: function (Result) {
                    },
                    error: function (Result) {
                        alert(Result);

                    }
                });

            };
        }
        else {

            return false;
        }

    }
}
var start = function () {
    $('.block-ui').removeClass('clear');
}

var finish = function () {
    $('.block-ui').addClass('clear');
}


function onlyNos(e, t) {


    try {
        if (window.event) {
            //To disable other button clicks
            if (window.event.keyCode == 13) {
                e.preventDefault();
                //  if (!($('#txt_PartAmount').prop(disable, true))) {
                if ($('#txt_PartAmount').attr('readonly') == undefined) {
                    $("#btn_paypart").click();
                }
            }
            var charCode = window.event.keyCode;
        }
        else if (e) {
            var charCode = e.which;
        }
        else { return true; }
        if (charCode > 31 && (charCode < 48 || charCode > 57)) {
            return false;
        }
        return true;
    }
    catch (err) {
        alert(err.Description);
    }
}

/* When confirm button clickss  */
function CRFRequestConfirm() {
    
    var markup = $('.summernote').summernote('code');
    var selectedTeam = $("#ddlTeam option:selected").val();
    var mod = $("#exmodule option:selected").text();
    var reqstType = $("#ddlReqType option:selected").text();
    var Ben = $("#ddlBens option:selected").val();
    var mode = $("#exmodule").val();
    var team = $("#ddlTeam option:selected").text();
    var mk = $("#txtReason").val();
    var subj = $('#txtSubject').val();
    //alert(subj);
    var usermob = $('#txtusermobno').val();
    //alert(usermob);
    var wspace = usermob.replace(/ /g, "");
    var len = wspace.length;




    if (subj == '' || subj == 'undefined' || subj == null) {
        $('#txtSubject').focus();
        alert("Please Enter Subject..!", 3000);
        return false;
    }
    if (markup == "<br>" || markup == "" || markup == null) {
        alert("Please Enter Content");
        return false;
    }
    if (team == "RPA") {   

        if ($("#res").val() == "" || $("#time").val() == "" || $("#Freq").val() == "-1") {
            
            alert("Please input value and then proceed!", 3000);
            return false;
        }        
    }
    if (selectedTeam === '-1') {
        $('#ddlTeam').focus();
        alert("Please select Team from the list and then proceed!", 3000);
        return false;
    }
    else {
        Teamid = selectedTeam;
    } 
    if (reqstType == "Choose Request Type") {        
        alert("Please select Request Type from the list and then proceed!");
        $("#exmodule").focus();
        return false;
    }

    if (mod == "Choose Module") {        
        alert("Please select module from the list and then proceed!", 3000);
        $("#exmodule").focus();
        return false;
    }
    if ($("#txtReason").val() == "") {
        alert("Please Enter Objective of CRF...!!!");
        $("#txtReason").focus();
        return false;
    }
    if (Ben === '-1') {
        $('#ddlBens').focus();
        alert("Please select Benifits from the list and then proceed!", 3000);
        return false;
    }
   
    if ($("#txtBreason").val() == "") {
        alert("Please Enter Benifits Reason...!!!");
        $("#txtBreason").focus();
        return false;
    }
    if (usermob == '' || usermob == 'undefined' || usermob == null) {
        alert("Please Enter Mobile Number...!!!");
        $("#txtusermobno").focus();
        return false;
    }
    if (len < 10) {


        alert("Please enter minimum 10 numbers");
        return false;
    }
     

    var rmk = $("#txtRemarks").val();
   
    var selectedReqType = $("#ddlReqType option:selected").val();
    if (selectedReqType === '-1') {
        $('#ddlDocType').focus();
        warningAlert("Please select Request Type from the list and then proceed!", 3000);
        return false;
    }
    else {
        reqType = selectedReqType;
       
    }


    var len1 = markup.length;
    var Data, itmdata, dateval, itmdatachild, circularStatus, confidentStatus, Teamid, reqType, Priority, TarDt, ErrorRptImpact, PolicyChgImpact;
    

    ErrorRptImpact = $("[id*=hdnErrorReportImpact]").val();
    PolicyChgImpact = $("[id*=hdnPolicyChangesImpact]").val();
    
    Priority = $("[id*=hdnPriority]").val();

      
    
    if ($('#TarDt').val() == '') {
        alert("Please enter Date.", 5000);
        return false;

    }

  
    //Check file size
    let uploadedElements = $(".file-uploaded");
    for (let i = 0; i < uploadedElements.length; i++) {
        let extension = "";
        let element = uploadedElements.eq(i)[0];
        let fileList = element.files;
        let fileReader = new FileReader();
        if (fileReader && fileList && fileList.length) {
            let fileSize = fileList[0].size / 1048576;
            if (fileSize > 10) {
               // dangerAlert("Please Upload Files Less Than 10MB..!", 3000);
                alert("Please Upload Files Less Than 10MB");
                return false;
            }
        }
    }


   





    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "AddRequest.aspx/GetNewNoteID",
        data: "{pageVal:'GetNewDraftId'}",
        dataType: "json",
        async: false,
        success: function (Result) {

            Result = Result.d;
            $("[id*=hdNoteID]").val(Result);

        },
        error: function (Result) {
            dangerAlert("Failed to create Request", 5000);
            return false;
        }
    });

 

    //upload image
    uploadedElements = $(".file-uploaded");
    if (uploadedElements.length <= 0) {

       
            ConfirmNote();
      
           
        
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
                    let InputData1 = $("[id*=hdNoteID]").val() + "µ" + fileno + "µ" + extension + "µ" + fileName.replace(/[^a-zA-Z0-9._]/g, '');
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
                        url: "AddRequest.aspx/UploadingFile",
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

                                    ConfirmNote();

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
    


    function ConfirmNote() {
       // alert("ccc");
        debugger;
        var res = $("#res").val();

        var time = $("#time").val();

        var fre = $("#Freq").val();
        if ($("#ddlReqType option:selected").text() !="Modification Module") {
            mode = 0;
        }
        if ($("#Freq").val() ==null) {
            fre = "";
        }

        $('.block-ui').removeClass('clear');
        Data = '';
        itmdata = '';
        var subjectval = $('#txtSubject').val();
        subjectval = subjectval.replace(/\\/g, '\\\\').replace(/[“”‘’']/g, '\\\'');
        var imp_mod = $('#ddlDept').val();
        if (imp_mod == "") imp_mod = '0';
        if (sesInfo == 1) {
            if ($("#txtRemarks").val() == "") {
                alert("Kindly add you description about sensitive information");
                $("#txtRemarks").focus();
                return false;
            }
        }
        else {
            $("#txtRemarks").val("Nil");//paper_id
        }
        var ERImpact, PLImpact;
        var circuler_id = $("#paper_id").val();

        if (PolicyChgImpact == 1) {
            debugger
            
            PLImpact = "YES";
            circuler_id = circuler_id.trim();
            if (circuler_id == "") {
                alert("Kindly add circular id or paperless id");
                $("#paper_id").focus();
                return false;
            }


        }
        else {
            PLImpact = "NO";
            
            circuler_id = "Nil";
        }
        if (ErrorRptImpact == 1) {
            ERImpact = "YES";
        }
        else {
            ERImpact = "NO";
        }
       
      



       

        Data = $("[id*=hdBranchId]").val() + 'µ' + Teamid + 'µ' + subjectval + 'µ' + reqType + 'µ' + Priority + 'µ' + $("[id*=hdUserId]").val() + 'µ' + $('#TarDt').val() + 'µ' + $("[id*=hdNoteID]").val() + 'µ' + mode + 'µ' + res + 'µ' + time + 'µ' + fre + 'µ' + ErrorRptImpact + 'µ' + sesInfo + 'µ' + $("#txtRemarks").val() + 'µ' + $("#txtReason").val() + 'µ' + Ben + 'µ' + $("#txtBreason").val() + 'µ' + PolicyChgImpact + 'µ' + usermob + 'µ' + circuler_id;//paper_id
        markup = markup.replace(/\\/g, '\\\\').replace(/[“”‘’']/g, '\\\'');
       

        var proceed = confirm("You Selected Error Report Impact as : " + ERImpact + "!. Are you ready to proceed with it?");
        var proceed1 = confirm("You Selected Policy Change Impact as : " + PLImpact + "!. Are you ready to proceed with it?");
        if (proceed) {
            count = 1;
            $("#butShow").hide();

        }
        else {
            return false;
        }
        if (proceed1) {
            count = 1;
            $("#butShow").hide();

        }
        else {
            return false;
        }
        if (PolicyChgImpact == 2) {

            $.ajax({
                type: "post",
                contentType: "application/json; charset=utf-8",
                url: "AddRequest.aspx/RequestNoteConfirm",
                data: "{pageVal:'ConfirmRequestNote', pageval1 :'" + Data + "',pageval2:'" + imp_mod + "',pageval3:'" + markup + "'}",
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
                    let timerInterval
                    Swal.fire({
                        width: 400,
                        type: 'success',
                        title: 'Success!',
                        html: "Requested Successfully...!Request ID is :-  " + noteid,
                        showConfirmButton: false,
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
                            window.open('AddRequest.aspx', '_self');
                        }
                    }).then((result) => {
                        if (
                            // Read more about handling dismissals
                            result.dismiss === Swal.DismissReason.timer
                        ) {
                            window.open('AddRequest.aspx', '_self');
                        }
                    })

                }
            });
        }


        if (PolicyChgImpact == 1) {

            if (uploadedElements.length <= 0) {
                window.alert("Please upload Approval for Policy Change Impact");
                $("#butShow").show();
            }
            else {

                $.ajax({
                    type: "post",
                    contentType: "application/json; charset=utf-8",
                    url: "AddRequest.aspx/RequestNoteConfirm",
                    data: "{pageVal:'ConfirmRequestNote', pageval1 :'" + Data + "',pageval2:'" + imp_mod + "',pageval3:'" + markup + "'}",
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
                        let timerInterval
                        Swal.fire({
                            width: 400,
                            type: 'success',
                            title: 'Success!',
                            html: "Requested Successfully...!Request ID is :-  " + noteid,
                            showConfirmButton: false,
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
                                window.open('AddRequest.aspx', '_self');
                            }
                        }).then((result) => {
                            if (
                                // Read more about handling dismissals
                                result.dismiss === Swal.DismissReason.timer
                            ) {
                                window.open('AddRequest.aspx', '_self');
                            }
                        })

                    }
                });

            }
           
        }

       


    }

}
/* For loading modules as per selected team  */
function selectmodule() {
    var name = $("#ddlReqType option:selected").text();
    var team = $("#ddlTeam").val();
    $("#exmodule").empty();
    if (name == "Modification Module") {
        $.ajax({
            type: "post",
            contentType: "application/json; charset=utf-8",
            url: "AddRequest.aspx/getFillData",
            data: "{pageVal:'Getexmodule',pageval1:'"+team+"'}",
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
/* Check whether selected team is RPA  */
function rpacheck() {
    var name = $("#ddlTeam option:selected").text();
    if (name == "RPA") {
       
        $.ajax({
            type: "post",
            contentType: "application/json; charset=utf-8",
            url: "AddRequest.aspx/getFillData",
            data: "{pageVal:'Getfrequency',pageval1:''}",
            dataType: "json",
            async: false,
            success: function (Result) {

                Result = Result.d;
                $("#Freq").empty();
                $("#Freq").append($("<option></option>").val("-1").html("Select-one-Option"));
                $.each(Result, function (key, value) {
                    $("#Freq").append($("<option></option>").val(value.id).html(value.name));
                });

            }

        });
        $("#rpa").show();
        $("#rpa1").show();
        $("#fre").show();
        $("#res").val("");
        $("#time").val("");

    }
    else {
        $("#rpa").hide();
        $("#rpa1").hide();
        $("#fre").hide();
        $("#res").val("");
        $("#time").val("");
       

    }
}
function ApplicableHide() {
    
    if ($('#applicableOption').prop('checked')) {
        $("#sensInfotxt").show();
        sesInfo = 1;
    }
    else {
        $("#sensInfotxt").hide();
        sesInfo = 0;
    }
   
}
