var EmpStatus = "";
$(window).on('load', function () {
    setInterval("getPendingCount();", 1000);
    GetEmpStatusDelay();
    CRFLoad();

    $("#txtRemarks").val("");
    $("#txtEndDt").datepicker({
        dateFormat: 'dd/MM/yy',
        changeMonth: true,
        changeYear: true,
        stepMonths: true,
        todayHighlight: true,
        onSelect: function (dateText, inst) {
        }

    });
    $("#txtStartDt").datepicker({
        dateFormat: 'dd/MM/yy',
        changeMonth: true,
        changeYear: true,
        stepMonths: true,
        todayHighlight: true,
        onSelect: function (dateText, inst) {
        }

    });
});
function ddlOnChange() {
    var CRFID = $("#ddlCrf").val();
    CRFIDLBL(CRFID);
    CRFSearch(CRFID);
    $("#snote").show();
    detailsLoad(CRFID);  
}
function getPendingCount() {

    var Data = '';
    Data = '' + 'µ' + '' + 'µ' + $("[id*=hdUserId]").val()
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "CrfDelayTracking.aspx/getBugCount",
        data: "{pageVal:'GetEnquiryCount', pageval1:'" + Data + "',pageval2:''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;            
            document.getElementById("pendCount").innerHTML = Result;
           

        }
    });
}

function CRFLoad() {    
    var Flag = "";
 
    if (EmpStatus == "TECHLEAD") {
    
        Flag = "DelayCrfListForTL";
    } else if (EmpStatus == "AMSHEAD") {
 
        Flag = "DelayCrfListForAMS";
    }
    else if (EmpStatus == "CTO") {
   
        Flag = "DelayCrfListForCTO";
    }
 
    var usr = $("[id*=hdUserId]").val();   
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "CrfDelayTracking.aspx/getFillData",
        data: "{pageVal:'" + Flag + "', pageval1 :'" + usr + "',pageval2 :'" + EmpStatus + "'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            $.each(Result, function (key, value) {
                $('#ddlCrf').append($("<option></option>").val(value.id).html(value.name));
            });
        }
    });
}

function ModalFill() {
    $("#IdModTree").hide();
    $('#txtMessage').val("");
    $("#btnReply").show();
    $("#btnSent").hide();
    DdlEnquiryFill();   
   
}
function DdlEnquiryFill() {
    var usr = $("[id*=hdUserId]").val();
    $('#ddlCrfReq').empty();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "CrfDelayTracking.aspx/getFillData",
        data: "{pageVal:'EnquiryCRFList', pageval1 :'" + usr + "',pageval2 :'" + EmpStatus + "'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            $('#ddlCrfReq').append($("<option></option>").val("-1").html("Choose CRF"));
            $.each(Result, function (key, value) {
                $('#ddlCrfReq').append($("<option></option>").val(value.id).html(value.name));
            });
        }
    });
}
function fillCRFData() {
    var CRFID = $("#ddlCrf").val();
    
    $("[id*=hddraftid]").val(CRFID);
    var dtl = $('#ddlCrf option:selected').text();
    var ddtl = dtl.split('~');
    $("[id*=hdRqstID]").val(ddtl[0]);
    CRFSearch(CRFID);
    WorkFlowFill(CRFID);
    $("#snote").show();
    if (CRFID == -1) {
        $("#CrfDetailsID").hide();  
        $("#IdTree").hide();

    }
    else {
        $("#CrfDetailsID").show();
        $("#IdTree").show();

    }
    detailsLoad(CRFID);
    GetRequestId();
    $("#txtRemarks").val("");

}

function CRFIDLBL(noteid) {
    var usr = $("[id*=hdUserId]").val();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "CrfDelayTracking.aspx/getRequestNote",
        data: "{pageVal:'CRFSUBJECTREQST', pageval1:'" + noteid + "',pageval2:'" + usr+"'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            $('#lblCRFID').html(Result);
            var reqid = Result.split('~');
            
            $("[id*=hdRqstID]").val(reqid[1]);
           // alert($("[id*=hdRqstID]").val());
        }
    });
}
function GetRequestId() {    
    var usr = $("[id*=hdUserId]").val();
    var dtl = $('#ddlCrf option:selected').text();
    var ddtl = dtl.split('~');
}

function EnquiryWorkFlowFill(noteid) {
    //a.note_id,e.firm_abbr Firm,a.subject,a.remarks,initcap(d.EMP_NAME) Created_by,to_char(a.created_date, 'dd-Mon-yyyy hh:mi:ss am') createdDate,to_char(b.received_date, 'dd-Mon-yyyy hh:mi:ss am') received_date,c.doc_name,decode(a.nature, 'Y', 'Confidential', 'Non Confidential') nature,a.priority,decode(a.circular, 'Y', 'Yes', 'No') circular
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "CrfDelayTracking.aspx/getListPending",
        data: "{pageVal:'GetEnqWorkFlowList', pageval1 :'" + noteid + "', pageval2 :''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            document.getElementById("WorkFlowSectionPop").innerHTML = "";
            var parentSec = document.createElement("section");
            parentSec.className = "timeline1";

            var parentDiv = document.createElement("div");
            parentDiv.className = "container";
            var sideNum = 1;
            $.each(Result, function (key, value) {

                var listOfApprove = value.lst;
                var workflowList = listOfApprove.split('µ');

                var tlitemDiv = document.createElement("div");
                tlitemDiv.className = "timeline-item";
                var tlimgDiv = document.createElement("div");
                tlimgDiv.className = "timeline-img";
                tlimgDiv.innerHTML = workflowList[0];
                tlitemDiv.appendChild(tlimgDiv);

                var tlConDiv = document.createElement("div");

                tlConDiv.className = "timeline-content js--fadeInLeft";

                var tlConDateDiv = document.createElement("div");
                tlConDateDiv.className = "wf-date";
                tlConDateDiv.innerHTML = workflowList[1];

                var tlConHead = document.createElement("h6");
                tlConHead.innerHTML = workflowList[2];
                var tlConHead1 = document.createElement("h7");
                tlConHead1.setAttribute('style', 'color:#e32bb5;');
                tlConHead1.innerHTML = workflowList[3];

                tlConDiv.appendChild(tlConDateDiv);
                tlConDiv.appendChild(tlConHead);
                tlConDiv.appendChild(tlConHead1);

                var tlInChk = document.createElement("input");
                tlInChk.setAttribute('type', 'checkbox');
                tlInChk.setAttribute('id', 'post-' + sideNum);
                tlInChk.className = "read-more-state";
                tlConDiv.appendChild(tlInChk);

                var tlConP = document.createElement("p");
                tlConP.className = "read-more-wrap";
                var x = workflowList[4];
                var c = x.split(' ').length;
                var y = x.split(' ').slice(0, 10).join(' ');
                var z = x.split(' ').slice(10, c).join(' ');


                tlConP.innerHTML = y;
                if (c > 10) {
                    var tlConSpanP = document.createElement("span");
                    tlConSpanP.className = "read-more-target";
                    tlConSpanP.innerHTML = z;
                    tlConP.appendChild(tlConSpanP);
                }
                tlConDiv.appendChild(tlConP);
                if (c > 10) {
                    var tlLbl = document.createElement("label");
                    tlLbl.setAttribute('for', 'post-' + sideNum);
                    tlLbl.className = "read-more-trigger bnt-more";
                    tlConDiv.appendChild(tlLbl);
                }


                tlitemDiv.appendChild(tlConDiv);
                parentDiv.appendChild(tlitemDiv);
                sideNum = sideNum + 1;

            });
            parentSec.appendChild(parentDiv);
            document.getElementById("WorkFlowSectionPop").appendChild(parentSec);


        },
        error: function (Result) {
        }
    });
}
   
function WorkFlowFill(noteid) {
    //a.note_id,e.firm_abbr Firm,a.subject,a.remarks,initcap(d.EMP_NAME) Created_by,to_char(a.created_date, 'dd-Mon-yyyy hh:mi:ss am') createdDate,to_char(b.received_date, 'dd-Mon-yyyy hh:mi:ss am') received_date,c.doc_name,decode(a.nature, 'Y', 'Confidential', 'Non Confidential') nature,a.priority,decode(a.circular, 'Y', 'Yes', 'No') circular
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "CrfDelayTracking.aspx/getListPending",
        data: "{pageVal:'GetWorkFlowList', pageval1 :'" + noteid + "', pageval2 :''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            document.getElementById("WorkFlowSection").innerHTML = "";
            var parentSec = document.createElement("section");
            parentSec.className = "timeline1";

            var parentDiv = document.createElement("div");
            parentDiv.className = "container";
            var sideNum = 1;
            $.each(Result, function (key, value) {

                var listOfApprove = value.lst;
                var workflowList = listOfApprove.split('µ');

                var tlitemDiv = document.createElement("div");
                tlitemDiv.className = "timeline-item";
                var tlimgDiv = document.createElement("div");
                tlimgDiv.className = "timeline-img";
                tlimgDiv.innerHTML = workflowList[0];
                tlitemDiv.appendChild(tlimgDiv);

                var tlConDiv = document.createElement("div");

                tlConDiv.className = "timeline-content js--fadeInLeft";

                var tlConDateDiv = document.createElement("div");
                tlConDateDiv.className = "wf-date";
                tlConDateDiv.innerHTML = workflowList[1];

                var tlConHead = document.createElement("h6");
                tlConHead.innerHTML = workflowList[2];
                var tlConHead1 = document.createElement("h7");
                tlConHead1.setAttribute('style', 'color:#e32bb5;');
                tlConHead1.innerHTML = workflowList[3];

                tlConDiv.appendChild(tlConDateDiv);
                tlConDiv.appendChild(tlConHead);
                tlConDiv.appendChild(tlConHead1);

                var tlInChk = document.createElement("input");
                tlInChk.setAttribute('type', 'checkbox');
                tlInChk.setAttribute('id', 'post-' + sideNum);
                tlInChk.className = "read-more-state";
                tlConDiv.appendChild(tlInChk);

                var tlConP = document.createElement("p");
                tlConP.className = "read-more-wrap";
                var x = workflowList[4];
                var c = x.split(' ').length;
                var y = x.split(' ').slice(0, 10).join(' ');
                var z = x.split(' ').slice(10, c).join(' ');


                tlConP.innerHTML = y;
                if (c > 10) {
                    var tlConSpanP = document.createElement("span");
                    tlConSpanP.className = "read-more-target";
                    tlConSpanP.innerHTML = z;
                    tlConP.appendChild(tlConSpanP);
                }
                tlConDiv.appendChild(tlConP);
                if (c > 10) {
                    var tlLbl = document.createElement("label");
                    tlLbl.setAttribute('for', 'post-' + sideNum);
                    tlLbl.className = "read-more-trigger bnt-more";
                    tlConDiv.appendChild(tlLbl);
                }


                tlitemDiv.appendChild(tlConDiv);
                parentDiv.appendChild(tlitemDiv);
                sideNum = sideNum + 1;

            });
            parentSec.appendChild(parentDiv);
            document.getElementById("WorkFlowSection").appendChild(parentSec);


        },
        error: function (Result) {
        }
    });
}
function CRFSearch(CRFID) {
    var crfval = $("#ddlCrf option:selected").text();
    var reqid = crfval.split('~');
    var CRFID = $("#ddlCrf").val();
    if (CRFID == "") {
        Swal.fire("Please Choose CRF!!!");
    }   

    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "CrfDelayTracking.aspx/getFillData",
        data: "{pageVal:'DelayCRFDetails', pageval1 :'" + CRFID + "',pageval2 :'" + reqid[0] + "'}",
        dataType: "json",
        success: function (Result) {

            Result = Result.d;
            $.each(Result, function (key, value) {
                var crfdtl = value.id;
                var cdtl = crfdtl.split('±');
                var data = cdtl[8];
                //empdatesel(data);
                //GetProjectType();
                $('#lblTeam').html(cdtl[0]);
                $('#lblType').html(cdtl[1]);
                $('#lblReqtr').html(cdtl[2]);
                $('#lblRqstDt').html(cdtl[3]);
                $('#lblTarDt').html(cdtl[6]);
                $('#lblUserExpectDate').html(cdtl[4]);
                $('#lblTechLead').html(cdtl[9]);
                $('#lblCreator').html(cdtl[10]);
                $('#lblDvlpmtStartDate').html(cdtl[11]);
                $('#lblDeptName').html(cdtl[12]);
                $('#lblTargetDt').html(cdtl[13]);
         

                if (cdtl[7] == 1) {
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
                
                //empdatesel(cdtl[6]);
                //$('#txtStartDt').val()
            });
        },
        error: function (Result) {

        }
    });

}
function Reply() {
    $("#btnSent").show();
    $("#txtMessage").prop("disabled", false);
    $("#txtMessage").val("");
    $("#btnReply").hide();

    
}
function EnquiryDetailsFill() {
    $("#btnReply").show();
    $("#btnSent").hide();
    var crfval = $("#ddlCrfReq option:selected").text();
    var reqid = crfval.split('-');
    var CRFID = $("#ddlCrfReq").val();

    if (CRFID == -1) { 
        $("#IdModTree").hide();
    }
    else {  
        $("#IdModTree").show();
    }

    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "CrfDelayTracking.aspx/getRequestNote",
        data: "{pageVal:'EnquiryDetailsFill', pageval1 :'" + CRFID + "',pageval2 :'" + reqid[0] + "'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            $('#txtMessage').val(Result);
            $("#txtMessage").prop("disabled", true);
      
        },
        error: function (Result) {

        }
    });
    EnquiryWorkFlowFill(reqid[0]) 

}
function showPhase() {
    var val = ($('#ddlProjType').val());
    $('#ddlPhase').empty();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "CrfDelayTracking.aspx/getFillData",
        data: "{pageVal:'GetProjectPhase', pageval1 :'" + val + "', pageval2 :''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            $('#ddlPhase').append($("<option></option>").val("-1").html("Choose Phase"));
            $.each(Result, function (key, value) {
                $('#ddlPhase').append($("<option></option>").val(value.id).html(value.name));
            });
        }
    });
}

function GetEmpStatusDelay() {

    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "CrfDelayTracking.aspx/CheckEmpAccess",
        async: false,
        data: "{pageVal:'CheckEmpAccess', pageval1 :'" + $("[id*=hdUserId]").val() + "', pageval2 :''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            EmpStatus = Result;

            if (EmpStatus == "TECHLEAD") { } else if (EmpStatus == "AMSHEAD") { }
            else if (EmpStatus == "CTO") { } else {
                Swal.fire({
                    title: 'You Dont Have Permission to visit this page.',
                    width: 600,
                    padding: '3em',
                    background: '#fff url(/images/trees.png)',
                    backdrop: `
    rgba(0,0,123,0.4)
    url("/images/restricdted.gif")
    left top
    no-repeat
  `
                })
            }
           
       
        }
    });
}
////     
function ActionTaken(flag) {
    var pageval3 = "";
    if ($('#ddlCrf').val() == -1) {
        Swal.fire("Please Select a CRF..");
        return false;
    }
    if (flag == 1) {
        pageval3 = "ActionTaken";
        if ($('#txtRemarks').val() == "") {
            Swal.fire("You cannot Confirm without Action, Please fill");
            return false;
        }
    }
    else {
        pageval3 = "Escalate";    
        if ($('#txtRemarks').val() == "") {
            Swal.fire("You cannot Escalate without Action, Please fill");
            return false;
        }
    }
    var usr = $("[id*=hdUserId]").val();
    var reqid = $("[id*=hdRqstID]").val();
    var crfid = $("[id*=hddraftid]").val();
    var action = $('#txtRemarks').val();
    var data = crfid + 'µ' + reqid + 'µ' + action + 'µ' + EmpStatus + 'µ';
    var proceed = confirm(' Are you sure you want to Proceed this?');
    if (proceed) {
        $.ajax({
            type: "post",
            contentType: "application/json; charset=utf-8",
            url: "CrfDelayTracking.aspx/ActionConfirm",
            data: "{pageVal:'CrfDelayActions', pageval1 :'" + usr + "',pageval2:'" + data + "',pageval3:'"+ pageval3 +"'}",
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
                if (noteid != '0') {

                    let timerInterval
                    Swal.fire({
                        width: 400,
                        type: 'success',
                        title: 'Success!',
                        html: "Action Taken.!! ",
                        showConfirmButton: true,
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
                            window.open('CrfDelayTracking.aspx', '_self');
                        }
                    }).then((result) => {
                        if (
                            // Read more about handling dismissals
                            result.dismiss === Swal.DismissReason.timer
                        ) {
                            window.open('CrfDelayTracking.aspx', '_self');
                        }
                    })


                }
                else {
                    Swal.fire("Something went wrong.!Please contact IT Support");
                }


            }
        });
    }
    else {

        return false;
    }
}
/////
function showRelatedWork() {
    var val = ($('#ddlPhase').val());
    var val1 = ($('#ddlProjType').val());
    $('#ddlRelWork').empty();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "CrfDelayTracking.aspx/getFillData",
        data: "{pageVal:'GetProjectRelWork', pageval1 :'" + val1 + "', pageval2 :'" + val + "'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            $('#ddlRelWork').append($("<option></option>").val("-1").html("Choose Related Work"));
            $.each(Result, function (key, value) {
                $('#ddlRelWork').append($("<option></option>").val(value.id).html(value.name));
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
        url: "CrfDelayTracking.aspx/getRequestNote",
        data: "{pageVal:'GetRequestNotes', pageval1:'" + noteid + "',pageval2:'2'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            $('.summernoteview').summernote('code', Result);
        }
    });
}


function frmExit() {
    window.open("index.aspx", "_self");
}


function EnquiryConfirm() {

    if ($("#ddlCrfReq").val() == -1) {
        swal.fire("Please Select CRF");
        return false;
    }
    if ($("#txtMessage").val() == "") {
        swal.fire("Please Type a Message");
        return false;
    }
    var crfval = $("#ddlCrfReq option:selected").text();
    var reqid = crfval.split('-');
   

    Data = $("#ddlCrfReq").val() + 'µ' +  reqid[0] + 'µ' + $("#txtMessage").val() + 'µ' + '' + 'µ' + $("[id*=hdUserId]").val() + 'µ' + '';

    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "CrfDelayTracking.aspx/ConfirmEnquiry",
        data: "{pageVal:'EnquiryConfirm', pageval1 :'" + Data + "',pageval2:'',pageval3:'RespondFrom'}",
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
                        EnquiryWorkFlowFill(reqid[0]);
                        DdlEnquiryFill();
                    }
                }).then((result) => {
                    if (
                        // Read more about handling dismissals
                        result.dismiss === Swal.DismissReason.timer
                    ) {
                        EnquiryWorkFlowFill(reqid[0]);
                        DdlEnquiryFill();
                    }
                })
            }
            else {
                Swal.fire("Something went wrong.! Please contact IT support..")
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


