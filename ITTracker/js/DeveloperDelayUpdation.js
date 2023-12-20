$(window).on('load', function () {
    Formaccesschecking();
    $("#Doc").hide();
    $("#Doc1").hide();
    $("#TNoc2").hide();
    $("#appenddelayreason").hide();
    $("#remar").hide();
    $("#remar1").hide();
    $("#divdelayreason").hide();
    $("#btnSubmit").show();
    $("#remar2").hide();
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
function Formaccesschecking() {
   
    var usr = $("[id*=hdUserId]").val();

    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "DeveloperDelayUpdation.aspx/Formaccess",
        data: "{pageVal:'Formaccess', pageval1 :'" + usr + "'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
           
            debugger;

            $("[id*=hdcount]").val(Result);
           
            var formacesscount = $("[id*=hdcount]").val();

            if (formacesscount == '333') {

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
            else if (formacesscount == '222') {
                
                $("#appenddelayreason").hide();
                $("#remar").show();
                $("#remar1").hide();
                $("#divdelayreason").show();
                $("#remar2").hide();

                crfdelayreason();
                CRFLoad();
            }

            else if (formacesscount == '111') {
               
                $("#divdelayreason").hide();
                $("#TNoc2").show();
                $("#remar").hide();
                $("#remar1").show();
                $("#appenddelayreason").show();
                $("#remar2").show();

                
                CRFLoad();
            }

        }
    });
   
}
function CRFLoad() {
   
    var usr = $("[id*=hdUserId]").val();
    var formacesscount = $("[id*=hdcount]").val();
   
    if (formacesscount == '222'){

        $.ajax({
            type: "post",
            contentType: "application/json; charset=utf-8",
            url: "DeveloperDelayUpdation.aspx/getFillData",
            data: "{pageVal:'developerdelaycrfload', pageval1 :'" + usr + "'}",
            dataType: "json",
            async: false,
            success: function (Result) {
                Result = Result.d;
                $.each(Result, function (key, value) {
                    $('#ddlCrf').append($("<option></option>").val(value.id).html(value.name));
                });
            }
        });
    }
    else if (formacesscount == '111') {
        
        $.ajax({
            type: "post",
            contentType: "application/json; charset=utf-8",
            url: "DeveloperDelayUpdation.aspx/getFillData",
            data: "{pageVal:'Techleadverifydelaycrf', pageval1 :'" + usr + "'}",
            dataType: "json",
            async: false,
            success: function (Result) {
                Result = Result.d;
                $.each(Result, function (key, value) {
                    $('#ddlCrf').append($("<option></option>").val(value.id).html(value.name));
                });
            }
        });
    }
    
}

function fillCRFData() {

    var CRFID = $("#ddlCrf").val();
    $("#checkfile").hide();
    $("#buttongro").show(); 
    $("#snote").show();
    if (CRFID == -1) {
        $("#CrfDetailsID").hide();
        $("#txtRemarks1").val("");
        $("#TNoc2").val("");

        
    }
    else {

        
        CRFSearch(CRFID);

        $("#textgroup1").show();
        $("#atta").show();
        $("#CrfDetailsID").show();

        Tafill(CRFID);
        detailsLoad(CRFID);
        filesFill(CRFID);
        GetRequestId(CRFID);

        var formacesscount = $("[id*=hdcount]").val();

        if (formacesscount == '111') {

            getcrfdelayreason();
            getcrfdelayremark();
            
        }
        
    }
   
    
    $("#txtRemarks").val("");
    
    
}
function GetRequestId(CRFID) {
    
    var usr = $("[id*=hdUserId]").val();
    usr = usr + '^' + CRFID;
    var dtl = $('#ddlCrf option:selected').text();
    var ddtl = dtl.split('~');

    $("[id*=hdRqstID]").val(ddtl[0]);
    
}
function CRFSearch(CRFID) {
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "TechnicalAnalysis.aspx/getFillData",
        data: "{pageVal:'DraftApproveDetailTaTargetDate', pageval1 :'" + CRFID + "'}",
        dataType: "json",
        async: false,
        success: function (Result) {

            Result = Result.d;
            $.each(Result, function (key, value) {
                var crfdtl = value.id;

                var cdtl = crfdtl.split('±');

                $('#lblTeam').html(cdtl[0]);
                $('#lblType').html(cdtl[1]);
                $('#lblReqtr').html(cdtl[2]);
                $('#lblRqstDt').html(cdtl[3]);
                $('#lblTarDt').html(cdtl[6]);
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
function detailsLoad(noteid) {
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "DeveloperUpdation.aspx/getRequestNote",
        data: "{pageVal:'GetRequestNotes', pageval1:'" + noteid + "',pageval2:'2'}",
        dataType: "json",
        async: false,
        success: function (Result) {
            Result = Result.d;
            $('.summernoteview').summernote('code', Result);
        }
    });
}
function filesFill(noteid) {

    $("#tblFiles").empty();
    if ($("#tblFiles tr").length > 1) {
        $("#Doc").show();
    }
}






function frmExit() {
    window.open("index.aspx", "_self");
}


function filltab(data) {
    var valData, valData1, gstno, n = 1;
    valData = data.split('¶');
    
    if ($("#tblObject tr").length == 0) {
        $("#tblObject").empty();
        $('#tblObject').append('<tr style="background-color:darkgrey;color:black"><th class="text-center">Type</th><th class="text-center">Object</th><th class="text-center">Typeid</th><th class="text-center">DELETE</th></tr>');
    }
    
    for (i = 0; i < valData.length - 1; i++) {
        valData1 = valData[i].split('^');

        $('#tblObject').append('<tbody><tr>' +

            '<td>' + valData1[0] + '</td>' +
            '<td>' + valData1[1] + '</td>' +
            '<td>' + valData1[2] + '</td>' +
            '<td><a href="javascript:void(0);" class="remove"  id="remrow"><span class="glyphicon glyphicon-trash">Remove</span></a></td></tr > </tbody > ');
    }
    


}

$(document).on('click', '.remove', function () {

    $(this).closest('tr').remove();
    dirRemovefromHidden();
    return false;
});
function dirRemovefromHidden() {
    var data = "";

    var table = document.getElementById('tblObject');

    var rowLength = table.rows.length;

    for (var i = 1; i < rowLength; i += 1) {
        var row = table.rows[i];

        //your code goes here, looping over every row.
        //cells are accessed as easy

        var cellLength = row.cells.length;
        for (var y = 0; y < cellLength - 1; y += 1) {
            var cell = row.cells[y];
            data = data + cell.innerText + '^';
        }
        data = data + '¶';
    }

    $("[id*=hddata]").val(data);


}

function Doc_confirm() {

    var crf = $("#ddlCrf").val();
    var crfdelayreason = $("#wstatus").val();
    var usr = $("[id*=hdUserId]").val();
    var trr = $("#txtRemarks2").val();
    var formacesscount = $("[id*=hdcount]").val();
    var crfSelect = $("#ddlCrf option:selected").val();
    var ws = $("#wstatus").val();
    var tr = $("#txtRemarks").val();
    var mdn = $("#mdnames").val();
    var ff = $("#filetfs").val();
    var ul = $("#uatlink").val();
    var pro = $("#proc").val();
    var tt = $("#table").val();
    var usr = $("[id*=hdUserId]").val();
    var objdata = $("[id*=hddata]").val();
    var dtl;
    var wspace = tr.replace(/ /g, "");
    var len = wspace.length;
   
    var jspace = trr.replace(/ /g, "");
    var lenn = jspace.length;
    
    if (crf== null || crf == '-1') {
        Swal.fire("Please Choose CRF!");
        $("#ddlCrf").focus();
        return false;
    }
    if (formacesscount == '222') {
        var rem = $("#txtRemarks").val();
        if (crfdelayreason == null || crfdelayreason == '-1') {
            Swal.fire("Kindly Choose CRF Delay Reason..!");
            return false;
         }
        
        else if (rem.trim() == "") {
            Swal.fire("Kindly add Remarks..!");
            return false;

        }
        

    }
    else {
        var remm = $("#txtRemarks2").val();
        if (remm.trim() == "") {
            Swal.fire("Kindly add Remarks..!");
            return false;

        }
    }
    if (formacesscount == '222') {
        if (len <= 50) {


            alert("Please enter minimum 50 characters");
            return false;
        }
    }
    else {
        if (lenn <= 50) {


            alert("Please enter minimum 50 characters");
            return false;
        }
    }

    Swal.fire({
        title: 'Information',
        text: "Are You Ready to Confirm?",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes'
    }).then((result) => {
        debugger;
        if (result.value == true) {

            var dataa = "";
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
            if (formacesscount == '222') {
                var rem = $("#txtRemarks").val();
               
                if (rem.trim() == "") {
                    Swal.fire("Kindly add Remarks..!");
                    return false;

                }
                else if ($("#wstatus").val() == "") {
                    Swal.fire("Kindly Choose CRF Delay Reason..!");
                    return false;
                }
                else {
                    
                    dataa = formacesscount + '^' + ws + '^' + crf + '^' + usr + '^' + $("[id*=hdRqstID]").val();
                   

                    Confirm_Delay_Crf_Upload(dataa);
                

                }

            }
            else {
                dataa = formacesscount + '^' + usr + '^' + $("[id*=hdRqstID]").val();

                Confirm_Delay_Crf_Upload(dataa);

            }
        }
        else {
            return false;
        }


    })
}

function Confirm_Delay_Crf_Upload(ddata) {
    var formacesscount = $("[id*=hdcount]").val();
    var remark = "";
    if (formacesscount == '222') {
        remark = $("#txtRemarks").val();
    }
    else {
        remark = $("#txtRemarks2").val();
    }
    
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "DeveloperDelayUpdation.aspx/DeveloperDelayConfirm",
        data: "{pageVal:'ConfirmDeveloperDelay',pageval1 :'" + ddata + "',p_parval1:'" + remark + "'}",
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

            if (noteid != "") {
                let timerInterval
                Swal.fire({
                    width: 400,
                    type: 'success',
                    title: 'Success!',
                    html: "Success!! ",
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
            else {
                alert("Something went wrong..! Please contact IT support.!");
            }

        }
    });

}
function Tafill(noteid) {
    $("#tabChange").empty();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "ViewerNoteDetails.aspx/getTableData",
        data: "{pageVal:'TACompleteData', pageval1 :'" + noteid + "', pageval2:''}",
        dataType: "json",
        async: false,
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
        $('#tabChange').append('<tr style="color:black; background-color:honeydew"><th colspan="10" class="text-center"><b>Technical Analysis Completed Details</b></th></tr>');
        $('#tabChange').append('<tr style="color:black; background-color:honeydew"><th class="text-center">RequestId</th><th class="text-center">TechLead</th><th class="text-center">Developer</th><th class="text-center">StartDate</th><th class="text-center">EndDate</th><th class="text-center">Phase</th><th class="text-center">TechChanges</th><th class="text-center">Description</th><th class="text-center">NoOfChanges</th><th class="text-center">TotalHours</th></tr>');
    }
   
    for (i = 0; i < valData.length - 1; i++) {
        valData1 = valData[i].split('µ');

        $('#tabChange').append('<tbody><tr class="text-center" style="" >' +


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

}

function crfdelayreason() {
   
    var usr = $("[id*=hdUserId]").val();
   
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "DeveloperDelayUpdation.aspx/getFillData",
        data: "{pageVal:'crfdelayreason', pageval1 :'" + usr + "'}",
        dataType: "json",
        async: false,
        success: function (Result) {
            Result = Result.d;
           
            $.each(Result, function (key, value) {
                $('#wstatus').append($("<option></option>").val(value.id).html(value.name));
            });
        }
    });
}
function getcrfdelayreason() {
    debugger;
   
    var reqid = $("[id*=hdRqstID]").val();
    
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "DeveloperDelayUpdation.aspx/getcrfdelayreason",
        data: "{pageVal:'getcrfdelayreason', pageval1 :'" + reqid + "'}",
        dataType: "json",
        async: false,
        success: function (Result) {
            Result = Result.d;
            
                $('#TNoc2').val(Result);
           
                
            
        }
    });
}

function getcrfdelayremark() {
    debugger;
    
    var reqid = $("[id*=hdRqstID]").val();
   
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "DeveloperDelayUpdation.aspx/getcrfdelayremark",
        data: "{pageVal:'getcrfdelayremark', pageval1 :'" + reqid + "'}",
        dataType: "json",
        async: false,
        success: function (Result) {
            Result = Result.d;
          
            $('#txtRemarks1').val(Result);


        }
    });
}