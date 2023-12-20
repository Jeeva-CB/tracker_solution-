var teck_dependency = 0;
var td_count = 0;
var admin_dependency = 0;
var sts = 0;
var valdat = 0;
$(window).on('load', function () {
   // alert("hii");
    GetReqTypeList();
    GetModuleName();
    
    $("[id*=hddraftid]").val('');
    let querystring = window.location.search.substring(1);
    let crfid = querystring.split("=")[1];
    $("[id*=hdman]").val(0);
    $("[id*=hddev]").val(0);
    $("[id*=hdcst]").val(0);
    $("[id*=hdtest]").val(0);
    $("[id*=hddata]").val("");
    $("[id*=hddatas]").val("");
    $("#txtModRemarks2").val("");
    $("[id*=hdRqstID]").val(0);
    $("[id*=hdDevlpr]").val("");
    $("[id*=hdcost]").val(0);
    $("#Doc").hide();
    if (crfid == 1) {
        $("#div1").show();
        $("#div2").hide();
        CRFLoad();
    }
    else {
        $("#div1").hide();
        $("#div2").show();
        crfid = Decrypt(crfid);
        $("[id*=hddraftid]").val(crfid);

        CRFIDLBL(crfid);
        CRFSearch(crfid);
        $("#snote").show();
        detailsLoad(crfid);
        filesFill(crfid);
        
    }

    $("#txtEndDt").datepicker({
        dateFormat: 'dd/MM/yy',
        changeMonth: true,
        changeYear: true,
        stepMonths: true,
        todayHighlight: true,
        onSelect: function (dateText, inst) {
        }

    });
    $("#txtStartDt1").datepicker({
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

    $("#txtEndDt1").datepicker({
        dateFormat: 'dd/MM/yy',
        changeMonth: true,
        changeYear: true,
        stepMonths: true,
        todayHighlight: true,
        onSelect: function (dateText, inst) {
        }

    });


    
   
    GetTestValue();
    TeamMembers();
    getDepartment();
    
    
   // techlead();
  
});
function CRFLoad() {
    var usr = $("[id*=hdUserId]").val();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "TechnicalAnalysis.aspx/getFillData",
        data: "{pageVal:'TechLeadVerification', pageval1 :'" + usr + "'}",
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
function already_tech_dep(CRFID) {
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "TechnicalAnalysis.aspx/getRequestNote",
        data: "{pageVal:'TechDependencyData', pageval1 :'" + CRFID + "',pageval2:''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            var output = Result.split('±');
            if (output[0] == 1) {
                td_count = 1;
                Swal.fire({
                    title: 'Information',
                    text: "The other TA for the same CRF has been marked YES for tech lead dependency,The target date is " + output[1],
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes!'
                }).then((result) => {
                    if (result.value == true) {
                        $('#dependency_sel').prop('checked', true);
                        teck_dependency = 1;
                    }
                    else {
                        $('#dependency_sel').prop('checked', true);
                        teck_dependency = 1;
                    }
                })
            }
        }
    });
}
function CRFIDLBL(noteid) {
    var usr = $("[id*=hdUserId]").val();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "TechnicalAnalysis.aspx/getRequestNote",
        data: "{pageVal:'CRFSUBJECTREQST', pageval1:'" + noteid + "',pageval2:'" + usr+"'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            $('#lblCRFID').html(Result);
            var reqid = Result.split('~');
            
            $("[id*=hdRqstID]").val(reqid[1]);
        }
    });
}
function GetRequestId(CRFID) {    
    var usr = $("[id*=hdUserId]").val();
    usr = usr + '^' + CRFID;
    var dtl = $('#ddlCrf option:selected').text();
    var ddtl = dtl.split('~');
    $("[id*=hdRqstID]").val(ddtl[1]);   
}
/************* Load CRF's Details **************/
function CRFSearch(CRFID) {
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "TechnicalAnalysis.aspx/getFillData",
        data: "{pageVal:'DraftApproveDetail', pageval1 :'" + CRFID + "'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            //alert(Result);
            $.each(Result, function (key, value) {
                var crfdtl = value.id;
                var cdtl = crfdtl.split('±');
                $('#lblTeam').html(cdtl[0]);
                //alert(cdtl[0]).val;
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
/************* To content of the CRF **************/
function detailsLoad(noteid) {
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "TechnicalAnalysis.aspx/getRequestNote",
        data: "{pageVal:'GetRequestNotes', pageval1:'" + noteid + "',pageval2:'2'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            $('.summernoteview').summernote('code', Result);
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
        url: "TechnicalAnalysis.aspx/getFileData",
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
/************* When click Exit button **************/
function frmExit() {
    window.open("index.aspx", "_self");
}
function manpower() {
    $("#dman").show();
    $("#dman1").show();
    $("#dman2").show();
    $("#dman3").show();
   // $("#dman4").show();
    $("#dman5").show();
    GetChangeList();
}
function infra() {
    $("#dmans").show();
    $("#dmans1").show();
    $("#dmans2").show();
    $("#dmans3").show(); 
   // $("#dman4").show();
    $("#dman5").show();
}

function rand_D() {
    
    if ($('#ddlCrf').val() == -1) {
        alert("Please Select a CRF..");
        $('#r_and_d').prop('checked', false);
        return false;
    }
    if ($('#r_and_d').prop('checked')) {
        $("#rdlabel").show();
        $("#randd").show(); 
        Rand_D_Work_load();
    }
    else {
        $("#rdlabel").hide();
        $("#randd").hide();
    }
    
}
//$('#ddlMode').prop("disabled", true);
function Rand_D_Work_load() {
    $('#ddlRD').empty();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "RandDWorkCreate.aspx/getFillData",
        data: "{pageVal:'RDWORINTAPAGE', pageval1 :''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            $('#ddlRD').append($("<option></option>").val("-1").html("Choose R&D Work"));
            $.each(Result, function (key, value) {
                $('#ddlRD').append($("<option></option>").val(value.id).html(value.name));
            });
        }
    });
}



function infras() {
    $("#dmans").hide();
    $("#dmans1").hide();
    $("#dmans2").hide();
    $("#dmans3").hide();
 //   $("#dman4").show();
    $("#dman5").show();
}

function inimp() {
    $("#dmanz").show();
}
function ApplicableHide() {
    if ($('#ddlCrf').val() == -1) {
        alert("Please Select a CRF..");
        $('#tech_handOver').prop('checked', false);
        return false;
    }
    //alert('egfdhfhfgjgfjn');
    if ($('#tech_handOver').prop('checked')) {
        $('#DivBug').show();
        techlead();
       // Clear();
    }
    else {
        $('#DivBug').hide();
    }
}
function inimpa() {
    $("#dmanz").hide();
}
/************* for the dependency of tech leads **************/
function check_techlead(CRFID) {
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "TechnicalAnalysis.aspx/ModHdFeedback",
        data: "{pageVal:'TechCount', pageval1 :'" + CRFID + "'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            if (Result == '1')  sts = 1;
            else sts = 0;
        }
    });
 
}
function Dependency_Check() {
    
    var CRFID = $("#ddlCrf").val();
    
    if ($('#ddlCrf').val() == -1) {
        alert("Please Select a CRF..");
        $('#dependency_sel').prop('checked', false);
        return false;
    }

    var table = document.getElementById('tabChange');
    var rowLength = table.rows.length;
    if (rowLength < 2) {
        Swal.fire("Please fill TA Properly");
        $('#dependency_sel').prop('checked', false);
        return false;
    }
    if (td_count = 1) {
        if (!($('#dependency_sel').prop('checked'))) {
            Swal.fire({
                title: 'Are you sure?',
                text: "The previous TA for same CRF, the dependency selected as  YES. You need to change it.?!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes!'
            }).then((result) => {
                if (result.value == true) {
                    $('#dependency_sel').prop('checked', false);
                    teck_dependency = 0;
                    return false;
                }
                else {
                    $('#dependency_sel').prop('checked', true);
                    teck_dependency = 1;                    
                }
            })
        }
    }

    if ($('#dependency_sel').prop('checked')) {
   
        if (sts == 1) {
            Swal.fire({
                title: 'Are you sure?',
                text: "Before you choose Yes, PLease add another TechLead through Admin module!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Okay!'
            }).then((result) => {
                if (result.value == true) {
                    teck_dependency = 1;
                }
                else {
                    $('#dependency_sel').prop('checked', false);
                    teck_dependency = 0;
                    return false;
                }
                })
            admin_dependency = 1;
            setTimeout(function () {
                window.open('TechnicalAnalysis.aspx?crfid=1', '_self');
            }, 5000);
            // window.open('TechnicalAnalysis.aspx?crfid=1', '_self');
        }
        else {
            Swal.fire({
                title: 'Are you sure?',
                text: "If you choose Yes, The maximum date among every TA of this CRF will taken as Target Date.!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes!'
            }).then((result) => {
                if (result.value == true) {
                    teck_dependency = 1;
                }
                else {
                    $('#dependency_sel').prop('checked', false);
                    teck_dependency = 0;
                    return false;
                }
                })
            admin_dependency = 0;
        }
        }
        
        
}

function techlead() {
    $('#techlead').empty();
    var usr = $("[id*=hdUserId]").val();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "TechnicalAnalysis.aspx/getFillData",
        data: "{pageVal:'techleadselect', pageval1 :'" + usr + "'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
           // alert(Result);

            $('#techlead').append($("<option selected disabled></option>").val("-1").html("Choose Tech Lead"));
            $.each(Result, function (key, value) {
                $('#techlead').append($("<option></option>").val(value.id).html(value.name));

            });
        }
    });
}
/*************************************************** */
function LoadModalData() {
    load = 1;

   
 
}
/*********************************** */




/************* To fill changes **************/
function GetChangeList() {
    $('#ddlChange').empty();
    var CRFID1 = $("#ddlCrf").val();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "TechnicalAnalysis.aspx/getFillData",
        data: "{pageVal:'IT_CHANGES', pageval1 :'" + CRFID1 + "'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            $('#ddlChange').append($("<option selected disabled></option>").val("-1").html("Choose Changes"));
            $.each(Result, function (key, value) {
                $('#ddlChange').append($("<option></option>").val(value.id).html(value.name));
            });
        }
    });
}
/************* To fill Related work field **************/
function GetWorkList() {
    var chid = $("#ddlChange").val();
    $('#ddlWork').empty();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "TechnicalAnalysis.aspx/getFillData",
        data: "{pageVal:'WORKLIST', pageval1 :'" + chid +"'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            $('#ddlWork').append($("<option selected disabled></option>").val("-1").html("Choose Related Work"));
            $.each(Result, function (key, value) {
                $('#ddlWork').append($("<option></option>").val(value.id).html(value.name));
            });
        }
    });
}


/************************* when choose the technology**************** */
function GetTechnology() {
    var chid = $("#ddlTechno").val();
    $('#ddlTechno').empty();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "TechnicalAnalysis.aspx/getFillData",
        data: "{pageVal:'Technology', pageval1 :'" + chid + "'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            //if (Result != "0§") {
            //    $("#butShow").show();
            //}
            //else $("#butShow").hide();

            $('#ddlTechno').append($("<option selected disabled></option>").val("-1").html("Choose Technology"));
            $.each(Result, function (key, value) {
                $('#ddlTechno').append($("<option></option>").val(value.id).html(value.name));
            });
        }
    });
}


/**********************MODAL ADD ********************* */

function CalAdd() {

    if ($("#txtStartDt1").val() != "") {
        var frmDateComm = $("#txtStartDt1").val();
        var newFrmDatee = Date.parse(frmDateComm);
    }
    else {
        alert("Choose Start Date.!")
        $("#txtStartDt1").focus();
        return false;
    }
    if ($("#txtEndDt1").val() != "") {
        var ToDateComm = $("#txtEndDt1").val();
        var NewToDatee = Date.parse(ToDateComm);
    }
    else {
        alert("Choose End Date.!")
        $("#txtEndDt1").focus();
        return false;
    }
    var dateDifference1 = NewToDatee - newFrmDatee;
    if (dateDifference1 < 0) {
        alert("Choose End Date greater than Start Date.!");
        $("#txtEndDt1").val("");
        $("#txtEndDt1").focus();
        return false;
    }

    if ($("#txtModRemarks2").val() == "") {
        alert("Describe the Changes...!!!");
        $("#txtModRemarks2").focus();
        return false;
    }

    var data2, data3 = "";
    datas = $("#txtStartDt1").val() + "^" + $("#txtEndDt1").val() + "^" + $("#txtModRemarks2").val() + "¶" ;
    //alert(datas);
   
    filltab1(datas);
   



}
/*********************  Rowclick************************** */
var wbsrowid = 0;
function grTab() {


    $('#tabChange').find('tr').click(function () {
        var row = $(this).find('td:eq(0)').text();
        var Rowid = row;
        wbsrowid = Rowid;
       // alert(Rowid);
        $('#txtId').val(Rowid);
        //$('#tabChange').removeEventListener();
    });


}


/********************* Select details wbs  ************************* */



function Getdata() {
   
    var usr = $("[id*=hdUserId]").val();
    var crfid = $("[id*=hddraftid]").val();
    var reqid = $("[id*=hdRqstID]").val();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "TechnicalAnalysis.aspx/GetDetails",
        data: "{pageVal:'getwbsdata', pageval1 :'" + usr + "µ" + crfid + "µ" + reqid +"', pageval2: '', pageval3: ''}",

        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            //alert(Result);
            fillwbstab(Result);
            
        }
    });
    
}
function fillwbstab(data) {
    var valData, valData1;
    $("#tabChange").empty();
    valData = data.split('¶');
    if ($("#tabChange tr").length == 0) {
        $("#tabChange").empty();
        $('#tabChange').append('<tr style="color:black; background-color:honeydew" class="text-left"><th class="text-left">WBSID</th><th class="text-left">Phase</th><th class="text-left">change</th><th class="text-left">Work</th><th class="text-left">Number</th><th class="text-left">Manpower</th><th class="text-left">Developer</th><th class="text-left">StartDt</th><th class="text-left">EndDt</th><th class="text-left">Cost</th> <th class="text-left">Technology</th><th class="text-center">WBS</th><th class="text-left">Delete</th></tr>');
    }
    for (i = 0; i < valData.length - 1; i++) {
        valData1 = valData[i].split('^');
        var col = valData1[16]; var desi = ""; var disabl = "";
        var checkval = 0;
       // alert(col);
        if (col == "0") {
            desi = "btn-danger btn-flat";
            disabl = " title = 'click here to add WBS';";
            checkval = 0;
        }
        else {
            desi = "btn-success btn-flat";
            disabl = "disabled='true'; title=' Already WBS Added';";
            checkval = 1;
        }
        $('#tabChange').append('<tbody><tr>' +
            '<td>' + valData1[0] + '</td>' +
            '<td>' + valData1[3] + '</td>' +
            '<td>' + valData1[9] + '</td>' +
            '<td>' + valData1[15] + '</td>' +
            '<td>' + valData1[10] + '</td>' +
            '<td>' + valData1[11] + '</td>' +
            '<td>' + valData1[5] + '</td>' +
            '<td>' + valData1[6] + '</td>' +
            '<td>' + valData1[7] + '</td>' +
            '<td>' + valData1[12] + '</td>' +
            '<td>' + valData1[13] + '</td>' +
            //'<td>' + valData1[16] + '</td>' +
            '<td style="text-align:center"><div class="form-group"> <button type="button" id="btnVIEW" data-toggle="modal" onclick="return loadModal(); "' + disabl + '" data-target="#ModeModal" class="' + desi + '">WBS</button></div></td>' +

            '<td style="display:none">' + valData1[9] + '</td>' +
            '<td style="display:none">' + valData1[10] + '</td>' +
            '<td style="display:none">' + valData1[11] + '</td>' +
            '<td style="display:none">' + valData[12] + '</td>' +
            '<td style="display:none">' + valData1[13] + '</td>' +
            '<td style="display:none">' + valData1[14] + '</td>' +
            '<td style="display:none">' + checkval + '</td>' +
            '<td><a href="javascript:void(0);" class="remove"  id="remrow"><span class="glyphicon glyphicon-trash">Remove</span></a></td></tr > </tbody > ');
    }

    calculateDetails();
}
function calculateDetails() {
   
    var data1, totm = 0, totc = 0, cst, wrkhr, tcst = 0, noc, data = "", totman = 0, totcst = 0, tstval, tstrslt, totdev = 0, tottst = 0, totcod = 0, totvapt = 0, totcost = 0, totcos = 0; 
    var table = document.getElementById('tabChange');
    var rowLength = table.rows.length;
    for (var i = 1; i < rowLength; i += 1) {
        var row = table.rows[i];
        var cellLength = row.cells.length;
        //for (var y = 4; y < 10; y += 1) {
            var cell = row.cells[5];
            
            var cell1 = row.cells[9];
        //alert(cell1);
            totdev = parseInt(totdev) + parseInt(cell.innerText);
        //totcost = parseInt(totcost) + parseInt(cell1.innerText);
        
       // }
        //alert(totdev);
        //alert(totcost);
    }
    tstval = $("[id*=hdtest]").val();
    //alert(tstval);
    tstrslt = tstval.split('^');
    //alert(tstrslt[1]);
    //alert(totdev);
    totcod = parseFloat(totdev * tstrslt[1]).toFixed(2);
    //alert(totcod);
    totman = parseFloat(totdev) + parseFloat(totcod);
    //alert(tstval);
    //alert(tstrslt);
   // alert(totcod);
   //alert(totman);
   // totcos = parseInt(totdev) + parseFloat(totcod) + parseInt(totman);
    //alert(totcos);
    totcost = parseFloat(totman) * 600;
    //alert(totcost); 
    $("#DevWork").val(totdev);
    $("#TCost").val(totcost);
    $("#TstWrk").val(tottst);
    $("#CodWork").val(totcod);
    $("#TWork").val(totman);
    $("[id*=hddev]").val(totdev);

    $("[id*=hdcost]").val(totcost);

    $("[id*=hdman]").val(totman);


    $("#txtReason").val("");
}




function AddWbsData() {
    debugger;
   // alert("hii");
    var crfid = $("[id*=hddraftid]").val();
    $("[id*=hdUserId]").val();
    var change = $("#ddlChange").val();
    var workid = $("#ddlWork").val().split('^')[0];

    var reqid = $("[id*=hdRqstID]").val();
    if ($("#ddlCrf").val() == -1) {
        alert("Please choose a CRF.!");
        $("#ddlCrf").focus();
        return false;
    }
    if ($("#ddlDevlp").val() == -1) {
        alert("Choose a developer.!");
        $("#ddlDevlp").focus();
        return false;
    }
    if ($("#txtStartDt").val() != "") {
        var frmDateCom = $("#txtStartDt").val();
        var newFrmDate = Date.parse(frmDateCom);
    }
    else {
        alert("Choose Start Date.!")
        $("#txtStartDt").focus();
        return false;
    }
    if ($("#txtEndDt").val() != "") {
        var ToDateCom = $("#txtEndDt").val();
        var NewToDate = Date.parse(ToDateCom);
    }
    else {
        alert("Choose End Date.!")
        $("#txtEndDt").focus();
        return false;
    }
    var dateDifference = NewToDate - newFrmDate;
    if (dateDifference < 0) {
        alert("Choose End Date greater than Start Date.!");
        $("#txtEndDt").val("");
        $("#txtEndDt").focus();
        return false;
    }
    if ($("#ddlChange").val() == -1 || $("#ddlChange").val() == null) {
        alert("Select Changes !!!");
        $("#ddlChange").focus();
        return false;
    }
    if ($("#ddlWork").val() == -1 || $("#ddlWork").val() == null) {
        alert("Select Related Work  !!!");
        $("#ddlWork").focus();
        return false;
    }
    if ($("#TNoc").val() == "" || $("#TNoc").val() == '0') {
        alert("Enter No Of  Changes!!!");
        $("#TNoc").focus();
        return false;
    }
    if ($("#TNoc1").val() == "" || $("#TNoc1").val() == '0') {
        alert("Enter Manpower!!!");
        $("#TNoc1").focus();
        return false;
    }
    if ($("#TNoc2").val() == "" || $("#TNoc2").val() == '0') {
        alert("Enter the Cost Estimation !!!");
        $("#TNoc2").focus();
        return false;
    }
    if ($("#ddlTechno").val() == -1 || $("#ddlTechno").val() == null) {
        alert("Select Technology !!!");
        $("#ddlTechno").focus();
        return false;
    }
    rbmodl = $("input:radio[name=rbmodl]:checked").val();
    if (rbmodl == '0') module = "Low";
    else if (rbmodl == '1') module = "Medium";
    else if (rbmodl == '2') module = "High";
    if (module == "") {
        alert("Please Choose Module Complexity  ..");
        return false;
    }

    rbCritcl = $("input:radio[name=rbCritcl]:checked").val();
    if (rbCritcl == '0') criticalcom = "Low";
    else if (rbCritcl == '1') criticalcom = "Medium";
    else if (rbCritcl == '2') criticalcom = "High";
    if (criticalcom == "") {
        alert("Please Choose Critical Complexity  ..");
        return false;
    }


    var selectedmodulename = $("#ddlmodulname option:selected").text();
    if (selectedmodulename == "Choose Module Name") {
        alert("Please Choose Module Name  ..");
        return false;
    }



    var chid = $("#ddlWork").val();
    var wrk = chid.split('^');
    var data1, totm = 0, totc = 0, cst, wrkhr, tcst = 0, noc, data = "", totman = 0, totcst = 0, tstval, tstrslt, totdev = 0, tottst = 0, totcod = 0, totvapt = 0, totcost = 0;
   
    


    //$("[id*=hddata]").val(data1);


    totdev = $("[id*=hddev]").val();
    totcst = $("[id*=hdcst]").val();
    tstval = $("[id*=hdtest]").val();

    totcost = $("[id*=hdcost]").val();

    //data1 = $("[id*=hddata]").val();
    tstrslt = tstval.split('^');
    noc = $("#TNoc").val();
    wrkhr = wrk[1];
    wrkhr = $("#TNoc1").val();
    cst = wrk[2];
    totm = wrkhr;

    tcst = $("#TNoc2").val();
    data = $('#txtPhase').val() + "^" + $('#ddlChange option:selected').text() + "^" + $('#ddlWork option:selected').text() + "^" + $("#TNoc").val() + "^" + totm + "^" + $('#ddlDevlp option:selected').text() + "^" + $("#txtStartDt").val() + "^" + $("#txtEndDt").val() + "^" + $("#TNoc2").val() + "^" + $('#ddlWork').val() + "^" + $('#ddlDevlp').val() + "^" + $('#ddlChange').val() + "^" + $('#ddlTechno option:selected').text() + "^" + $("[id*=hdUserId]").val() + '^' + crfid + '^' + reqid + '^' + change + '^' + workid + '^' + module + '^' + criticalcom + '^' + selectedmodulename + "¶";
   
    data1 = data1 + data;

    
   // alert($('#ddlWork').val());
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "TechnicalAnalysis.aspx/TACompleteConfirm",
        data: "{pageVal:'WBS', pageval1 :'" + data + "',pageval2:'" + ' ' + "',pageval3:'',pageval4:'" + '' + "'}",
        dataType: "json",
        async: false,  
        success: function (Result) {
            Result = Result.d;
           
            $("[id*=hddata]").val(Result);

        }

    })
    



    Getdata();

}

/**************** MODAL LOAD******************** */

function loadModal() {
    
    $('#txtId').prop("disabled", true);

}
/****************   WBS CONFRIM *************** */

function WbsConfirm() {
   // alert('haii');
    var data = "";
    $('#txtId').prop("disabled", true);
    wbsid = $("#txtId").val();

    var change = $("#ddlChange").val();
    var workid = $("#ddlWork").val().split('^')[0];

    var Wbs = '';
    var crfid = $("[id*=hddraftid]").val();
    var reqid = $("[id*=hdRqstID]").val();
    var devid = $("[id*=hdDevlpr]").val().split('^')[0];
    

    var table = document.getElementById('tabChange1');
    var rowLength = table.rows.length;
    for (var i = 1; i < rowLength; i += 1) {
        var row = table.rows[i];
        var cellLength = row.cells.length;
        for (var y = 0; y < cellLength - 1; y += 1) {
            var cell = row.cells[y];
            data = data + cell.innerText + '^';
        }
        data = data + '¶';
    }
    
   // alert(data);

    Wbs = $("[id*=hdUserId]").val() + '^' + crfid + '^' + reqid + '^' + devid + '^' + change + '^' + workid + '^' + wbsid;
   // alert(Wbs);
    //imodal();
    var proceed = confirm(' Are you sure you want to  Confirm?');
    if (proceed) {

        $.ajax({
            type: "post",
            contentType: "application/json; charset=utf-8",
            url: "TechnicalAnalysis.aspx/getChangeData",
           // data: "{pageVal:'WBSwork', pageval1 :'" + '' + "',pageval2:'" + Wbs + "', pageval3: ''}",
            data: "{pageVal:'WBSwork', pageval1 :'" + data + "',pageval2:'" + Wbs + "', pageval3: ''}",

            dataType: "json",
            async: false,
            success: function (Result) {
                $('.block-ui').addClass('clear');
                Result = Result.d;
                var noteid = Result;
               
                if (noteid != '0') {
                    
                    let timerInterval
                    Swal.fire({
                        title: 'Saving!',
                        html: 'Successfully Saved..',
                        timerProgressBar: true,
                        didOpen: () => {
                            Swal.showLoading()
                            const b = Swal.getHtmlContainer().querySelector('b')
                            timerInterval = setInterval(() => {
                                b.textContent = Swal.getTimerLeft()
                            }, 100)
                        },
                        willClose: () => {
                            clearInterval(timerInterval)
                        }
                    }).then((result) => {
                        /* Read more about handling dismissals below */
                        if (result.dismiss === Swal.DismissReason.timer) {
                            console.log('I was closed by the timer')
                        }
                        })
                    $('#ModeModal').modal('hide');
                    $("#txtStartDt1").val("");
                    $("#txtEndDt1").val("");
                    $("#txtModRemarks2").val("");
                    $("#txtId").val("");
                    $("#tabChange1").empty();
                    $("#tabChange").empty();
                    Getdata();
                
                }   
                else {
                    alert("Something went wrong.!Please contact IT Support");
                }


            }
        });
    }
    else {

        return false;
    }
}

function validation_check() {
    var count = 0;
    var table = document.getElementById('tabChange');
    var rowLength = table.rows.length;
    for (var i = 1; i < rowLength; i += 1) {
        var row = table.rows[i];
        var cellLength = row.cells.length;
        var cell = row.cells[18];
        if (cell.innerText == "0") valdat = 1;
        else count++;
   
    }
    if (rowLength - 1 == count) {
        valdat = 0;
    }
    if (valdat == 1) return 1;
    else return 0;
}    


/************* When click ADD button **************/
function CalTotal() {
    var crfid = $("[id*=hddraftid]").val();
    $("[id*=hdUserId]").val();
    var change = $("#ddlChange").val();
    var workid = $("#ddlWork").val().split('^')[0];

    var reqid = $("[id*=hdRqstID]").val();
    if ($("#ddlCrf").val() == -1) {
        alert("Please choose a CRF.!");
        $("#ddlCrf").focus();
        return false;
    }
    if ($("#ddlDevlp").val() == -1) {
        alert("Choose a developer.!");
        $("#ddlDevlp").focus();
        return false;
    }  
    if ($("#txtStartDt").val() != "") {
        var frmDateCom = $("#txtStartDt").val();
        var newFrmDate = Date.parse(frmDateCom);
    }
    else {
        alert("Choose Start Date.!")
        $("#txtStartDt").focus();
        return false;
    }
    if ($("#txtEndDt").val() != "") {
        var ToDateCom = $("#txtEndDt").val();
        var NewToDate = Date.parse(ToDateCom);
    }
    else {
        alert("Choose End Date.!")
        $("#txtEndDt").focus();
        return false;
    }
    var dateDifference = NewToDate - newFrmDate;
    if (dateDifference < 0) {
        alert("Choose End Date greater than Start Date.!");
        $("#txtEndDt").val("");
        $("#txtEndDt").focus();
        return false;
    }
    if ($("#ddlChange").val() == -1 || $("#ddlChange").val() == null) {
        alert("Select Changes !!!");
        $("#ddlChange").focus();
        return false;
    }
    if ($("#ddlWork").val() == -1|| $("#ddlWork").val() == null) {
        alert("Select Related Work  !!!");
        $("#ddlWork").focus();
        return false;
    }
    if ($("#TNoc").val() == "" || $("#TNoc").val() == '0') {
        alert("Enter No Of  Changes!!!");
        $("#TNoc").focus();
        return false;
    }
    if ($("#TNoc1").val() == "" || $("#TNoc1").val() == '0') {
        alert("Enter Manpower!!!");
        $("#TNoc1").focus();
        return false;
    }
    if ($("#TNoc2").val() == "" || $("#TNoc2").val() == '0') {
        alert("Enter the Cost Estimation !!!");
        $("#TNoc2").focus();
        return false;
    }
    if ($("#ddlTechno").val() == -1 || $("#ddlTechno").val() == null) {
        alert("Select Technology !!!");
        $("#ddlTechno").focus();
        return false;
    }

    var chid = $("#ddlWork").val();
    var wrk = chid.split('^');
    var data1, totm = 0, totc = 0, cst, wrkhr, tcst = 0, noc, data = "", totman = 0, totcst = 0, tstval, tstrslt, totdev = 0, tottst = 0, totcod = 0, totvapt = 0, totcost=0;
    totdev = $("[id*=hddev]").val();
    totcst = $("[id*=hdcst]").val();
    tstval = $("[id*=hdtest]").val();

    totcost = $("[id*=hdcost]").val();
   // alert(totcost);
    data1 = $("[id*=hddata]").val();
    tstrslt = tstval.split('^');
    noc = $("#TNoc").val();
    wrkhr = wrk[1];
    wrkhr = $("#TNoc1").val();
    cst = wrk[2];
    totm = wrkhr; 

    tcst = $("#TNoc2").val();
   // alert(tcst);
    //data = $('#txtPhase').val() + "^" + $('#ddlChange option:selected').text() + "^" + $('#ddlWork option:selected').text() + "^" + $("#TNoc").val() + "^" + totm + "^" + $('#ddlDevlp option:selected').text() + "^" + $("#txtStartDt").val() + "^" + $("#txtEndDt").val() + "^" + $('#ddlChange').val() + "^" + $('#ddlWork').val() + "^" + $('#ddlDevlp').val() + "¶" + "^" + $("#TNoc1").val() + "^" + $("#TNoc2").val() 
        //data = $('#txtPhase').val() + "^" + $('#ddlChange option:selected').text() + "^" + $('#ddlWork option:selected').text() + "^" + $("#TNoc").val() + "^" + totm + "^" + $('#ddlDevlp option:selected').text() + "^" + $("#txtStartDt").val() + "^" + $("#txtEndDt").val() + "^" + $('#ddlChange').val() + "^" + $('#ddlWork').val() + "^" + $('#ddlDevlp').val() + "¶" +"^" + $("#TNoc2").val(); 
    data = $('#txtPhase').val() + "^" + $('#ddlChange option:selected').text() + "^" + $('#ddlWork option:selected').text() + "^" + $("#TNoc").val() + "^" + totm + "^" + $('#ddlDevlp option:selected').text() + "^" + $("#txtStartDt").val() + "^" + $("#txtEndDt").val() + "^" + $("#TNoc2").val() + "^" + $('#ddlWork').val() + "^" + $('#ddlDevlp').val() + "^" + $('#ddlChange').val() + "^" + $('#ddlTechno option:selected').text() + "^" + $("[id*=hdUserId]").val() + "^" + crfid + "^" + reqid + "^" + change + "^" + workid + "^" + module + "^";
    //alert($('#ddlWork').val());
   

    data1 = data1 + data;
    //alert(data1);
   // $("[id*=hddata]").val(data1);


   // alert($("[id*=hddata]").val(data1));
   // filltab(data);

    totdev = parseInt(totdev) + parseInt(totm);
    totcod = parseFloat(totdev * tstrslt[1]).toFixed(2);
    totman = parseFloat(totdev) + parseFloat(totcod);

    totcost = parseInt(totcost) + parseInt(tcst);

    $("#DevWork").val(totdev);
    $("#TCost").val(totcost);
    $("#TstWrk").val(tottst);
    $("#CodWork").val(totcod);
    $("#TWork").val(totman);
    $("[id*=hddev]").val(totdev);

    $("[id*=hdcost]").val(totcost);

    $("[id*=hdman]").val(totman);
    $("#TNoc").val("");


   

}
/************* Filling the table with TA data **************/
function filltab(data) {
      var valData, valData1;
      valData = data.split('¶');
     if ($("#tabChange tr").length == 0) {
          $("#tabChange").empty();
         $('#tabChange').append('<tr style="color:black; background-color:honeydew" class="text-left"><th class="text-left">WBSID</th><th class="text-left">Phase</th><th class="text-left">change</th><th class="text-left">Work</th><th class="text-left">Number</th><th class="text-left">Manpower</th><th class="text-left">Developer</th><th class="text-left">StartDt</th><th class="text-left">EndDt</th><th class="text-left">Cost</th> <th class="text-left">Technology</th><th class="text-center">WBS</th><th class="text-left">Delete</th></tr>');
     }
      for (i = 0; i < valData.length - 1; i++) {
        valData1 = valData[i].split('^');       
          $('#tabChange').append('<tbody><tr>' +
             '<td>' + valData1[0] + '</td>' +
            '<td>' + valData1[0] + '</td>' +
            '<td>' + valData1[1] + '</td>' +
            '<td>' + valData1[2] + '</td>' +
            '<td>' + valData1[3] + '</td>' +
            '<td>' + valData1[4] + '</td>' +
            '<td>' + valData1[5] + '</td>' +
            '<td>' + valData1[6] + '</td>' +
            '<td>' + valData1[7] + '</td>' +
            '<td>' + valData1[8] + '</td>' +
            '<td>' + valData1[15] + '</td>' +
            //'<td>' + valData1[16] + '</td>' +
            '<td style="text-align:center"><div class="form-group"> <button type="button" id="btnVIEW" data-toggle="modal" onclick="return loadModal();" data-target="#ModeModal" class="btn-success btn-flat">WBS</button></div></td>'+

            '<td style="display:none">' + valData1[9] + '</td>' +
            '<td style="display:none">' + valData1[10] + '</td>' +
            '<td style="display:none">' + valData1[11] + '</td>' +
            '<td style="display:none">' + valData[112] + '</td>' +
            '<td style="display:none">' + valData1[13] + '</td>' +
            '<td style="display:none">' + valData1[14] + '</td>' +
            '<td><a href="javascript:void(0);" class="remove"  id="remrow"><span class="glyphicon glyphicon-trash">Remove</span></a></td></tr > </tbody > ');
         }
}
/**********************  FILL MODAL  TAB******************** */


function filltab1(datas) {
    var valDataz, valData2;
    valDataz = datas.split('¶');
    if ($("#tabChange1 tr").length == 0) {
        $("#tabChange1").empty();
        $('#tabChange1').append('<tr style="color:black; background-color:honeydew" class="text-left"><th class="text-left">Start date</th><th class="text-left">End date</th><th class="text-left">Describe</th><th class="text-left">Delete</th></tr>');
    }
    for (i = 0; i < valDataz.length - 1; i++) {
        valData2 = valDataz[i].split('^');
        $('#tabChange1').append('<tbody><tr>' +
            '<td>' + valData2[0] + '</td>' +
            '<td>' + valData2[1] + '</td>' +
            '<td>' + valData2[2] + '</td>' +
            
            
            '<td><a href="javascript:void(0);" class="remove"  id="remrow"><span class="glyphicon glyphicon-trash">Remove</span></a></td></tr > </tbody > ');
    }

    //$("#txtStartDt1").val("");
    //$("#txtEndDt1").val("");
    $("#txtModRemarks2").val("");
}

/************************************************ */
function GetTestValue() { 
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "TechnicalAnalysis.aspx/getFillData",
        data: "{pageVal:'TESTVALUE', pageval1 :''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            $.each(Result, function (key, value) {
                var val1 = value.id;
                $("[id*=hdtest]").val(val1);
            });
        }
    });
}
/************* To get developers under the team **************/
function TeamMembers() {
    var usr = $("[id*=hdUserId]").val();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "TechnicalAnalysis.aspx/fillTable",
        data: "{pageVal:'TEAMMEMBERS', pageval1 :'" + usr + "'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            fillTableDtl(Result);
            TeamMembers2();
        }
    });
}

/*----------------dilu--------------*/
function TeamMembers2() {
    
    var usr = $("[id*=hdUserId]").val();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "TechnicalAnalysis.aspx/fillTableDt2",
        data: "{pageVal:'TEAMMEMBERS2', pageval1 :'" + usr + "'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            
            fillTableDt2(Result);
        }
    });
}
    /*--------------dilu-------------------*/
/************* Filling the Table **************/
function fillTableDtl(data) {
    var valData, valData1;
    valData = data.split('§');
    $('#ddlDevlp').empty();
    $('#ddlDevlp').append($("<option></option>").val("-1").html("Choose Developer"));
    if ($("#tblEmps tr").length == 0) {
        $("#tblEmps").empty();
        $('#tblEmps').append('<tr style="background-color:rosybrown;color:black"><th class="text-center">EmpCode</th><th class="text-center">EmpName</th><th class="text-center">Date</th></tr>');
    }
    for (i = 0; i < valData.length - 1; i++) {
        valData1 = valData[i].split('^');
        $('#tblEmps').append('<tbody><tr class="text-center" style="background-color:linen" >' +
            '<td>' + valData1[0] + '</td>' +
            '<td>' + valData1[1] + '</td>' +
            '<td>' + valData1[2] + '</td></tr > </tbody > ');
        $('#ddlDevlp').append($("<option></option>").val(valData1[0]+'^'+valData1[3]).html(valData1[1]));
    }
}

/*--------------dilu----------------*/
function fillTableDt2(data) {
    var valData, valData1;
    valData = data.split('§');
    if ($("#tblEmps1 tr").length == 0) {
        $("#tblEmps1").empty();
        $('#tblEmps1').append('<tr style="background-color:rosybrown;color:black"><th class="text-center">EmpCode</th><th class="text-center">EmpName</th><th class="text-center">Date</th></tr>');
    }
    for (i = 0; i < valData.length - 1; i++) {
        valData1 = valData[i].split('^');
        $('#tblEmps1').append('<tbody><tr class="text-center" style="background-color:linen" >' +
            '<td>' + valData1[0] + '</td>' +
            '<td>' + valData1[1] + '</td>' +
            '<td>' + valData1[2] + '</td></tr > </tbody > ');
    }
}
/*--------------dilu----------------*/
/************* Filtering the month  from date **************/
function dateCheck(dateValue) {
    switch (dateValue) {
        case "jan": return "January";
            break;
        case "feb": return "February";
            break;
        case "mar": return "March";
            break;
        case "apr": return "April";
            break;
        case "may": return "May";
            break;
        case "jun": return "June";
            break;
        case "jul": return "July";
            break;
        case "aug": return "August";
            break;
        case "sep": return "September";
            break;
        case "oct": return "October";
            break;
        case "nov": return "November";
            break;
        case "dec": return "December";
            break;
    }

}

function empdatesel() {
    var devlp = $("[id*=hdDevlpr]").val();
    var emp = $('#ddlDevlp').val();
    var empsplt = emp.split('^');
    var stdt = empsplt[1];
    stdt = stdt.replace(/-/g, '/');
    var monthValue = stdt.split("/")[1];
    var mon = dateCheck(monthValue.toString().toLowerCase().substring(0, 3)); 
    var empid = empsplt[0];
    
    if (stdt.split("/")[2].length > 2) {
        $('#txtStartDt').val(stdt.split("/")[0] + "/" + mon + "/"+ stdt.split("/")[2]);
    }
    else {
        $('#txtStartDt').val(stdt.split("/")[0] + "/" + mon + "/20" + stdt.split("/")[2]);
    }   
    devlp = empid + '^' + devlp;
    $("[id*=hdDevlpr]").val(devlp);
}
/************* When click Remove **************/
$(document).on('click', '.remove', function () {

    $(this).closest('tr').remove();
    dirRemovefromHidden();
    return false;
});
/************* For removing the row **************/
function dirRemovefromHidden() {
    calculateDetails();
   
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "TechnicalAnalysis.aspx/getChangeData",
        data: "{pageVal:'WBSREMOVE', pageval1 :'" + wbsrowid + "', pageval2 :''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            
            if (Result == '111') alert("Deleted!");
            else alert("No rows found..!");
            
            //fillTableDtl(Result);
        }
    });
    wbsrowid = 0;
    //var data = "";
    //var table = document.getElementById('tabChange');
    //var rowLength = table.rows.length;
    //for (var i = 1; i < rowLength; i += 1) {
    //    var row = table.rows[i];
    //    var cellLength = row.cells.length;
    //    for (var y = 0; y < cellLength - 1; y += 1) {
    //        var cell = row.cells[y];
    //        data = data + cell.innerText + '^';
    //    }
    //    data = data + '¶';
    //}
    //$("[id*=hddata]").val(data);
    //calTotdtl(data);
}
/************* For the calculation after remove the row from grid **************/
function calTotdtl(data) {  
    var valData, valData1, totman = 0, totcst = 0, tstval, tstrslt, totdev = 0, totcod = 0, totcost=0;
    valData = data.split('¶');
    for (i = 0; i < valData.length - 1; i++) {
        valData1 = valData[i].split('^');
        totdev = parseInt(totdev)+ parseInt(valData1[4]);
    }
    tstval = $("[id*=hdtest]").val();
    tstrslt = tstval.split('^');   
    totcod = totdev * tstrslt[1];
    totman = parseInt(totdev) + parseInt(totcod);
    $("#DevWork").val(totdev);
    $("#CodWork").val(totcod);
    $("#TWork").val(totman);
    $("#TCost").val(totcost);
    $("[id*=hddev]").val(totdev);
    $("[id*=hdman]").val(totman);
}
/************* When click Confirm Button **************/
function TAConfirm() {
    //alert("hiiii");
    debugger;
    var check = validation_check();
    var randdcheck = 0;
    var randid;
    var selectedReqType = $("#ddlReqType option:selected").val();
    var mode = $("#exmodule").val();
    var reqstType1 = $("#ddlReqType option:selected").text();
    var pre_typ = $("#lblType").text();
    if (check == 1) {
        alert("Please Complete WBS (Work Break down Structure)");
        return false;
    }
    if ($('#r_and_d').prop('checked')) {
        if ($("#ddlRD").val() == "-1") {
            Swal.fire("Please Choose respective R&D work.!");
            $("#ddlRD").focus();
            return false;
        }
        else {
            randdcheck = 1;
            randid = $("#ddlRD").val();
        }
    }
    else {
        randdcheck = 0;
        randid = 0;
    }
    
    var Prio = "", imp = "", rb = "", infr = "", Re = "", CRFID, module = "",criticalcom="";
    CRFID = $("#ddlCrf").val();
    if (CRFID == -1) {
        alert("Please Choose CRF..");
        return false;
    }
    //rbIn = $("input:radio[name=rbIn]:checked").val();
    //if (rbIn == '0') rb = "Yes";
    //else if (rbIn == '1') rb = "No";
    rbImp = $("input:radio[name=rbImp]:checked").val();
    if (rbImp == '0') imp = "Yes";
    else if (rbImp == '1') imp = "No";    
    rbInfra = $("input:radio[name=rbInfra]:checked").val();
    if (rbInfra == '0') infr = "Yes";
    else if (rbInfra == '1') infr = "No";
      
    if (infr == "") {
        alert("Please Choose InfrastructureChange ..");
        return false;
    }      
    Module = $("#txtmodule").val();
    Space = $("#txtspac").val();
    Estimate = $("#txtestimate").val();
    Reason = $("#txtreason").val();
    rbPrio = $("input:radio[name=rbPrio]:checked").val();
    if (rbPrio == '0') Prio = "Low";
    else if (rbPrio == '1') Prio = "Medium";
    else if (rbPrio == '2') Prio = "High";
    if (Prio == "") {
        alert("Please Choose Risk Classification  ..");
        return false;
    }  
    rbRe = $("input:radio[name=rbRe]:checked").val();
    if (rbRe == '0')  Re = "Low";
    else if (rbRe == '1') Re = "Medium";
    else if (rbRe == '2') Re = "High";
    if (infr == 'Yes') {
        if (Re == "") {
            alert("Please Choose Impact in server resource..");
            return false;
        }
        if ($("#txtmodule").val() == "") {
            alert("Please Complete Infrastructure Change !!!");
            $("#txtmodule").focus();
            return false;
        }
        if ($("#txtspace").val() == "") {
            alert("Please Complete Infrastructure Change !!!");
            $("#txtspace").focus();
            return false;
        }
        if ($("#txtestimate").val() == "") {
            alert("Please Complete Infrastructure Change !!!");
            $("#txtestimate").focus();
            return false;
        }
        if ($("#txtreason").val() == "") {
            alert("Please Complete Infrastructure Change !!!");
            $("#txtreason").focus();
            return false;
        }
    }
    else {
        Re = 'Nil';
        $("#txtreason").val('Nil');
        $("#txtestimate").val('Nil');
        $("#txtspace").val('Nil');
        $("#txtmodule").val('0');
    }   
    if (mode == null) {
        mode = '0';
    }
    if (pre_typ == reqstType1) {
        alert("ALREADY IN SAME REQUEST TYPE !");
        $("#exmodule").focus();
        return false;
    }
    //rbmodl = $("input:radio[name=rbmodl]:checked").val();
    //if (rbmodl == '0') module = "Low";
    //else if (rbmodl == '1') module = "Medium";
    //else if (rbmodl == '2') module = "High";
    //if (module == "") {
    //    alert("Please Choose Module Complexity  ..");
    //    return false;
    //}

    if (reqstType1 == "Choose Request Type") {

        alert("If any changes Please choose Correct Request Type, otherwise Select 'No change' Option!");
        return false;

    }
   
    //rbCritcl = $("input:radio[name=rbCritcl]:checked").val();
    //if (rbCritcl == '0') criticalcom = "Low";
    //else if (rbCritcl == '1') criticalcom = "Medium";
    //else if (rbCritcl == '2') criticalcom = "High";
    //if (criticalcom == "") {
    //    alert("Please Choose Critical Complexity  ..");
    //    return false;
    //} 


    //var selectedmodulename = $("#ddlmodulname option:selected").text();
   
    //if (selectedmodulename == "Choose Module Name") {
    //    alert("Please Choose Module Name  ..");
    //    return false;
    //} 


    $("[id*=hddraftid]").val(CRFID);
    var Data = '', itmdata = '',audit='';
    audit = infr + 'µ' + Prio + 'µ' + $("#txtmodule").val() + 'µ' + $("#txtspace").val() + 'µ' + $("#txtestimate").val() + 'µ' + Re + 'µ' + $("#txtreason").val() + 'µ' + randdcheck + 'µ' + randid;
    var rmk = $('#txtRemarks').val();
    Data = $("[id*=hddraftid]").val() + 'µ' + $("[id*=hdRqstID]").val() + 'µ' + $("[id*=hdUserId]").val() + 'µ' + $('#DevWork').val() + 'µ' + $('#CodWork').val() + 'µ' + $('#TWork').val() + 'µ' + rmk + 'µ' + teck_dependency + 'µ' + $('#TNoc2').val() + 'µ' + $('#TCost').val() + 'µ' + selectedReqType + 'µ' + mode + 'µ';
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "TechnicalAnalysis.aspx/getChangeData",
        data: "{pageVal:'WBSDETAILS', pageval1 :'" + $("[id*=hddraftid]").val() + "',pageval2:'" + $("[id*=hdRqstID]").val() + "'}",
        dataType: "json",
        async: false,
        success: function (Result) {
            Result = Result.d;
            $("[id*=hddata]").val(Result);

        }

    })

    if ($("[id*=hddata]").val() == "") {
        alert("Please Complete TA properly!!!");
        return false;
    }
    itmdata = $("[id*=hddata]").val();
 
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "TechnicalAnalysis.aspx/TACompleteConfirm",
        data: "{pageVal:'TACONFIRM', pageval1 :'" + Data + "',pageval2:'" + itmdata + "',pageval3:'1',pageval4:'" + audit + "'}",
        dataType: "json",
        async: false,
        success: function (Result) {
            $('.block-ui').addClass('clear');
            Result = Result.d;
            var noteid = Result;
            //alert(noteid);
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
                    html: "TA Completed!! ",
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
                        window.open('TechnicalAnalysis.aspx?crfid=1', '_self');
                    }
                }).then((result) => {
                    if (
                        result.dismiss === Swal.DismissReason.timer
                    ) {
                        window.open('TechnicalAnalysis.aspx?crfid=1', '_self');
                    }
                })
            }
            else {
                alert("Something went wrong.!Please contact IT Support");
            }
        }
    });
}
/************* Decryption **************/
function Decrypt(value) {
    var result = "";
    var array = value.split("-");

    for (i = 0; i < array.length; i++) {
        result += String.fromCharCode(array[i] - 10);
    }
    return result;
} 
/************* For check whether entered data is number or not **************/
function isNumber(evt, val1, isDec) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (isDec == 0 && charCode == 46) {
        return false;
    } else if (isDec == 1 && charCode == 46) {
        var dec = val1.split('.');
        if (dec.length > 1 && charCode == 46) {
            return false;
        }
    }
    if (charCode == 37 || charCode == 39 || charCode == 46) {
        return true;
    }
    if ((charCode > 31 && charCode < 48) || charCode > 57) {
        return false;
    }
    return true;
}
/************* When Click Return button **************/
function ReturnNote() {
    var crfid = $("[id*=hddraftid]").val();
    if ($("#ddlCrf").val() == -1) {
        alert("Please choose a CRF to return..!");
        $("#ddlCrf").focus();
        return false;
    }
    if ($("#txtRemarks").val() == "") {
        alert("You need to add remarks for return.!");
        $("#txtRemarks").focus();
        return false;
    }
    var Data = '', sts = '2';
    Data = $("#txtRemarks").val() + 'µ' + crfid + 'µ' + $("[id*=hdUserId]").val() + 'µ' + $("[id*=hdRqstID]").val() + 'µ';
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "TechnicalAnalysis.aspx/TACompleteConfirm",
        data: "{pageVal:'PMOReturn', pageval1 :'" + Data + "',pageval2:'" + crfid + "',pageval3:'" + sts + "',pageval4:''}", 
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
                    window.open('TechnicalAnalysis.aspx?crfid=1', '_self');
                }
            }).then((result) => {
                if (
                    result.dismiss === Swal.DismissReason.timer
                ) {
                    window.open('TechnicalAnalysis.aspx?crfid=1', '_self');
                }
            })

        }
    });
} 
/***************    Hand over to Techlead******************/ 
function HandOver() {
    var Tech = '';
    var crfid = $("[id*=hddraftid]").val();

    if ($('#ddlCrf').val() == -1) {
        alert("Please Select a CRF..");
        return false;
    }
    //alert(crfid);
    var pur = $("#techlead").val();
    if (pur == -1) {
        alert("Please Select Tech Lead...!!!");
        $("#techlead").focus();
        return false;
    }

    if ($("#txtRemarks").val() == "") {
        alert("Please Enter Remark...!!!");
        $("#txtRemarks").focus();
        return false;
    }

    var usr = $("[id*=hdUserId]").val();
    var rmk = $("#txtRemarks").val();
    //Tech = $("#techlead").val() + 'µ' + crfid + 'µ' + $("[id*=hdUserId]").val() + 'µ';id*=hdRqstID]
    Tech = $("#techlead").val() + '^' + crfid + '^' + $("[id*=hdRqstID]").val();
    ItemTech = rmk + '^' + usr;
    var proceed = confirm(' Are you sure you want to HandOver this?');
    if (proceed) {

        $.ajax({
            type: "post",
            contentType: "application/json; charset=utf-8",
            url: "TechnicalAnalysis.aspx/getChangeData",
            // data: "{pageVal:'TechHandover', pageval1 :'" + Tech + "',pageval2:''}",
            //data: "{pageVal:'TechHandover', pageval1 :'" + Tech +
                data: "{pageVal:'TechHandover', pageval1 :'" + Tech + "',pageval2:'" + ItemTech + "', pageval3: ''}",

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
                        html: "Handed Over.!! ",
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
                            window.open('TechnicalAnalysis.aspx?crfid=1', '_self');
                        }
                    }).then((result) => {
                        if (
                            // Read more about handling dismissals
                            result.dismiss === Swal.DismissReason.timer
                        ) {
                            window.open('TechnicalAnalysis..aspx?crfid=1', '_self');
                        }
                    })


                }
                else {
                    alert("Something went wrong.!Please contact IT Support");
                }


            }
        });
    }
    else {

        return false;
    }
}
/*************To get feedbacks from HODs **************/
function ModHdFdback(crfid) {
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "TechnicalAnalysis.aspx/ModHdFeedback",
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
    for (i = 0; i < valData.length-1; i++) {
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
/****************** change request type load 115350 *****************/
function GetReqTypeList() {

    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "TechnicalAnalysis.aspx/getFillData",
        data: "{pageVal:'TYPE', pageval1 :''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            //alert(Result);
            $('#ddlReqType').append($("<option></option>").val("-1").html("Choose Request Type"));
            $.each(Result, function (key, value) {
                $('#ddlReqType').append($("<option></option>").val(value.id).html(value.name));
            });
        }
    });
}

/******************* choose module modification module 115350********************/
function selectmodule() {
    
    var name = $("#ddlReqType option:selected").text();
    
    var rqstid = $("[id*=hdRqstID]").val();
    $("#exmodule").empty();
    if (name == "Modification Module") {
        $.ajax({
            type: "post",
            contentType: "application/json; charset=utf-8",
            url: "TechnicalAnalysis.aspx/getFillData",
            data: "{pageVal:'Getheadchangemodule',pageval1:'" + rqstid + "'}",
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
/*******************115865********************/
function costestimation() {
    var manpow = $("#TNoc1").val()
   // alert(manpow);
    var Estimatecost = manpow * 600;
    //alert(Estimatecost);
    $("#TNoc2").val(Estimatecost);
}
/*******************choose module name 115865********************/
function GetModuleName() {
    //alert("hi");
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "TechnicalAnalysis.aspx/getFillData",
        data: "{pageVal:'getmodulename', pageval1 :''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            //alert(Result);
            $('#ddlmodulname').append($("<option></option>").val("-1").html("Choose Module Name"));
            $.each(Result, function (key, value) {
                $('#ddlmodulname').append($("<option></option>").val(value.id).html(value.name));
            });
        }
    });
}
function RejctCRF() {

    var crfid = $("[id*=hddraftid]").val();
    var usr = $("[id*=hdUserId]").val();
    var rmk = $('#txtRemarks').val();
   var rqstid = $("[id*=hdRqstID]").val();

    data = crfid + '^' + usr + '^' + rmk + '^' + rqstid;

    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "TechnicalAnalysis.aspx/CRFreject",
        data: "{pageVal:'CRFreject', pageval1 :'" + data + "',pageval2:''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
          // alert("js done")
            let timerInterval
            Swal.fire({
                width: 400,
                type: 'success',
                title: 'Success!',
                html: "CRF Rejected.!! ",
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
                    window.open('TechnicalAnalysis.aspx?crfid=1', '_self');
                }
            }).then((result) => {
                if (
                    // Read more about handling dismissals
                    result.dismiss === Swal.DismissReason.timer
                ) {
                    window.open('TechnicalAnalysis..aspx?crfid=1', '_self');
                }
            })
        }
    });
}