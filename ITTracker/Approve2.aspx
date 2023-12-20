<%@ Page Title="" Language="C#" MasterPageFile="~/PWA_Master.Master" AutoEventWireup="true" CodeBehind="Approve2.aspx.cs" Inherits="ITTacker.Approve2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<link href="StyleAutoComplete.css" rel="stylesheet" />
<script src="AutoCompleteJS.js"></script>
<link href="css/MultipleUpload.css" rel="stylesheet"/>
<script src="js/MultipleUpload.js"></script>
    <script src="js/aes.js"></script>
<script> 
$(function() {
    window.sr = ScrollReveal();
    //sr.reveal('.timeline-content', { container: '.modal-body' });

    if ($(window).width() < 768) {
        if ($('.timeline-content').hasClass('js--fadeInLeft')) {
            $('.timeline-content').removeClass('js--fadeInLeft').addClass('js--fadeInRight');
        }

        sr.reveal('.js--fadeInRight', {
            origin: 'right',
            distance: '300px',
            easing: 'ease-in-out',
            duration: 800,
            container: '.modal-body',
        });

    } else {
        sr.reveal('.js--fadeInLeft', {
            origin: 'left',
            distance: '300px',
            easing: 'ease-in-out',
            duration: 800,
            container: '.modal-body',
        });

        sr.reveal('.js--fadeInRight', {
            origin: 'right',
            distance: '300px',
            easing: 'ease-in-out',
            duration: 800,
            container: '.modal-body',
        });

    }

    sr.reveal('.js--fadeInLeft', {
        origin: 'left',
        distance: '300px',
        easing: 'ease-in-out',
        duration: 800,
        container: '.modal-body',
    });

    sr.reveal('.js--fadeInRight', {
        origin: 'right',
        distance: '300px',
        easing: 'ease-in-out',
        duration: 800,
        container: '.modal-body',
    });


});
</script>
<style>
.timeline1 {
  position: relative;
  padding: 50px 0;
}
.timeline1::before {
  content: '';
  background: #C5CAE9;
  width: 5px;
  height: 95%;
  position: absolute;
  left: 50%;
  transform: translateX(-50%);
}

.timeline-item {
  width: 100%;
  margin-bottom: 5px;
}
.timeline-item:nth-child(even) .timeline-content {
  float: right;
  padding: 40px 30px 10px 30px;
}
.timeline-item:nth-child(even) .timeline-content .wf-date {
  right: auto;
  left: 0;
}
.timeline-item:nth-child(even) .timeline-content::after {
  content: '';
  position: absolute;
  border-style: solid;
  width: 0;
  height: 0;
  top: 30px;
  left: -15px;
  border-width: 10px 15px 10px 0;
  border-color: transparent #f5f5f5 transparent transparent;
}
.timeline-item::after {
  content: '';
  display: block;
  clear: both;
}

.timeline-content {
  position: relative;
  width: 45%;
  padding: 10px 15px;
  border-radius: 4px;
  background: #f5f5f5;
  box-shadow: 0 20px 25px -15px rgba(0, 0, 0, 0.3);
}
.timeline-content::after {
  content: '';
  position: absolute;
  border-style: solid;
  width: 0;
  height: 0;
  top: 30px;
  right: -15px;
  border-width: 10px 0 10px 15px;
  border-color: transparent transparent transparent #f5f5f5;
}

.timeline-img {
  width: 30px;
  height: 30px;
  background: #3F51B5;
  border-radius: 50%;
  position: absolute;
  left: 50%;
  margin-top: 25px;
  margin-left: -15px;
  color: #fff;
  text-align: center;
  padding-top: 7px;
}

.bnt-more {
  cursor: pointer;
  background: #3F51B5;
  color: #FFFFFF;
  padding: 3px 10px;
  text-transform: uppercase;
  font-size: 12px; 
  display: inline-block;
  border-radius: 2px;
  box-shadow: 0 1px 3px -1px rgba(0, 0, 0, 0.6);
}
.bnt-more:hover, .bnt-more:active, .bnt-more:focus {
  background: #32408f;
  color: #FFFFFF;
  text-decoration: none;
}

.timeline-card {
  padding: 0 !important;
}
.timeline-card p {
  padding: 0 20px;
}
.timeline-card a {
  margin-left: 20px;
}

.timeline-item .timeline-img-header {
  background: linear-gradient(rgba(0, 0, 0, 0), rgba(0, 0, 0, 0.4)), url("https://picsum.photos/1000/800/?random") center center no-repeat;
  background-size: cover;
}

.timeline-img-header {
  height: 200px;
  position: relative;
  margin-bottom: 20px;
}
.timeline-img-header h2 {
  color: #FFFFFF;
  position: absolute;
  bottom: 5px;
  left: 20px;
}

.wf-date {
  background: #FF4081;
  display: inline-block;
  color: #FFFFFF;
  padding: 5px;
  position: absolute;
  top: 0;
  right: 0;
  font-size: .75rem;
}

@media screen and (max-width: 768px) {
  .timeline::before {
    left: 50px;
  }
  .timeline1 .timeline-img {
    left: 50px;
  }
  .timeline1 .timeline-content {
    max-width: 100%;
    width: auto;
    margin-left: 70px;
  }
  .timeline1 .timeline-item:nth-child(even) .timeline-content {
    float: none;
  }
  .timeline1 .timeline-item:nth-child(odd) .timeline-content::after {
    content: '';
    position: absolute;
    border-style: solid;
    width: 0;
    height: 0;
    top: 30px;
    left: -15px;
    border-width: 10px 15px 10px 0;
    border-color: transparent #f5f5f5 transparent transparent;
  }
}
.read-more-state {
  display: none;
}

.read-more-target {
  opacity: 0;
  max-height: 0;
  font-size: 0;
  transition: .25s ease;
}

.read-more-state:checked ~ .read-more-wrap .read-more-target {
  opacity: 1;
  font-size: inherit;
  max-height: 999em;
}

.read-more-state ~ .read-more-trigger:before {
  content: 'Show more';
}

.read-more-state:checked ~ .read-more-trigger:before {
  content: 'Show less';
}


</style>
<script>

function frmExit() {
    window.open("index.aspx", "_self");
}
$(window).on('load', function () {
    $("[id*=hdnContentNoteId]").val("");
    let querystring = window.location.search.substring(1);
    
    if (querystring == '0' || querystring == '' || querystring == 'undefined' || querystring == null) {
         $("[id*=hdnquerynoteid]").val("");
    }
    else {
        let querynoteid = Decrypt(querystring.split("=")[1]); 
        //let querynoteid = querystring.split("=")[1]; 
        $("[id*=hdnquerynoteid]").val(querynoteid);        
    }


     $("#contentModel").hide();
     $("#contentModelFiles").hide();
     $("#contentModelFlow").hide();

     $("#showBtnsRec").hide();
      $("#showBtnsAppr").hide();
     $("#showRemarks").hide();
     $("#showSubmitBtn").hide();
    $("#showEmpForward").hide();
    $("#showAttach").hide();
      $("#showBtnRet").hide();//Add approver
    $("#showEmpReturn").hide();
     $("#btnEdit").hide();
  
    
    
    
   //  document.getElementById("r_emp1").innerHTML = "";
     //document.getElementById('' + ShowValVariable + '').innerHTML = "";
      $("#divContentHide").hide();
     
    $("#contentDiv").resizable();
     //$( "#contentDiv" ).resizable();    
     getList();
    //setInterval("getList();", 1000);
     
});
$(document).ready(function () {   
    $('.summernoteview').summernote({
        height: 350, // set editor height
        minHeight: null, // set minimum height of editor
        maxHeight: null, // set maximum height of editor
        focus: false, // set focus to editable area after initializing summernote
        toolbar: [
        ]
    });
    $(".summernoteview").summernote("disable");

$("#btnRecommend").click(function () {
    //$('#test').attr('class');   
//$(this).find("i").removeClass("fa-thumbs-up").addClass("fa-spinner fa-spin");
    $("#showRemarks").show();
    $('#txtRemarks').val("");
$("#showSubmitBtn").show();
 $("#showEmpForwardRed").hide();
//$("#showBtnsAppr").hide();
    $("#showEmpForward").hide();
     $("#showEmpReturn").hide();
    
   document.getElementById("parallelrowRed").innerHTML = "";
//$(this).find("i").removeClass("fa-spinner fa-spin").addClass("fa-thumbs-up");
$("#btnSubmit").find("i").removeClass().addClass("fa fa-thumbs-up");
//document.getElementById("r_emp1").innerHTML = "";
});


$("#btnNotRecommend").click(function(){
    $("#showRemarks").show();
    $('#txtRemarks').val("");
    $("#showSubmitBtn").show();
    $("#showEmpForwardRed").hide();
    //$("#showBtnsAppr").hide();
    $("#showEmpForward").hide();
    $("#showEmpReturn").hide();
     document.getElementById("parallelrowRed").innerHTML = "";
    $("#btnSubmit").find("i").removeClass().addClass("fa fa-thumbs-down");
    //document.getElementById("r_emp1").innerHTML = "";
});

    $("#btnForward").click(function () {
      document.getElementById("parallelrowRed").innerHTML = "";
    $("#showRemarks").show();
    $('#txtRemarks').val("");
    $("#showSubmitBtn").show();
    $("#showEmpForward").show();
    $("#showEmpReturn").hide();
    $("#showEmpForwardRed").hide();
    //$("#showBtnsRec").hide();

//$("#showBtnsAppr").hide();
    $("#btnSubmit").find("i").removeClass().addClass("fa fa-share");
    //document.getElementById("r_emp1").innerHTML = "";
});

    $("#btnRedirect").click(function () {
      document.getElementById("parallelrowRed").innerHTML = "";
    $("#showRemarks").show();
    $('#txtRemarks').val("");
    $("#showSubmitBtn").show();
    $("#showEmpForwardRed").show();
    $("#showEmpReturn").hide();
    $("#showEmpForward").hide();
    addEmployee();
    //$("#showBtnsRec").hide();
    //$("#showBtnsAppr").hide();
    $("#btnSubmit").find("i").removeClass().addClass("fa fa-user-plus");
    //document.getElementById("r_emp1").innerHTML = "";

    });
    $("#btnApprRedirect").click(function () {
      document.getElementById("parallelrowRed").innerHTML = "";
    $("#showRemarks").show();
    $('#txtRemarks').val("");
    $("#showSubmitBtn").show();
    $("#showEmpForwardRed").show();
    $("#showEmpReturn").hide();
     $("#showEmpForward").hide();
    addEmployee();
    //$("#showBtnsRec").hide();
    //$("#showBtnsAppr").hide();
    $("#btnSubmit").find("i").removeClass().addClass("fa fa-user-plus");
    //document.getElementById("r_emp1").innerHTML = "";

    });
    
    $("#btnApprove").click(function () {
      document.getElementById("parallelrowRed").innerHTML = "";
    $("#showRemarks").show();
    $('#txtRemarks').val("");
    $("#showSubmitBtn").show();
    //$("#showBtnsRec").hide();
    //$("#showBtnsAppr").hide();
    $("#showEmpForward").hide();
    $("#showEmpReturn").hide();
         $("#showEmpForwardRed").hide();
    $("#btnSubmit").find("i").removeClass().addClass("fa fa-thumbs-up");
    //document.getElementById("r_emp1").innerHTML = "";

    });
$("#btnReject").click(function(){
    $("#showRemarks").show();
    $('#txtRemarks').val("");
    $("#showSubmitBtn").show();
    //$("#showBtnsRec").hide();
    //$("#showBtnsAppr").hide();
    $("#showEmpForward").hide();
    $("#showEmpReturn").hide();
    $("#showEmpForwardRed").hide();
    document.getElementById("parallelrowRed").innerHTML = "";
    
    $("#btnSubmit").find("i").removeClass().addClass("fa fa-ban");
    //document.getElementById("r_emp1").innerHTML = "";
});

    $("#btnApprReturn").click(function () {
      document.getElementById("parallelrowRed").innerHTML = "";
    $("#showRemarks").show();
    $('#txtRemarks').val("");
    $("#showSubmitBtn").show();
    $("#showEmpReturn").show();
     $("#showEmpForwardRed").hide();
    $("#showEmpForward").hide();
    $("#btnSubmit").find("i").removeClass().addClass("fa fa-reply");
    //document.getElementById("r_emp1").innerHTML = "";
    });

    $("#btnRecReturn").click(function () {
      document.getElementById("parallelrowRed").innerHTML = "";
    $("#showRemarks").show();
    $('#txtRemarks').val("");
    $("#showSubmitBtn").show();
    $("#showEmpReturn").show();
    $("#showEmpForwardRed").hide();
    $("#showEmpForward").hide();
    $("#btnSubmit").find("i").removeClass().addClass("fa fa-reply");
    //document.getElementById("r_emp1").innerHTML = "";
});

    $("#btnRecDiscuss").click(function () {
      document.getElementById("parallelrowRed").innerHTML = "";
    $("#showRemarks").show();
    $('#txtRemarks').val("");
    $("#showSubmitBtn").show();
    $("#showEmpForward").hide();
    $("#showEmpReturn").hide();
     $("#showEmpForwardRed").hide();
    $("#btnSubmit").find("i").removeClass().addClass("fa fa-comments");
    //document.getElementById("r_emp1").innerHTML = "";
});

    $("#btnApprDiscuss").click(function () {
      document.getElementById("parallelrowRed").innerHTML = "";
    $("#showRemarks").show();
    $('#txtRemarks').val("");
    $("#showSubmitBtn").show();
    $("#showEmpForward").hide();
    $("#showEmpReturn").hide();
     $("#showEmpForwardRed").hide();
    $("#btnSubmit").find("i").removeClass().addClass("fa fa-comments");
   // document.getElementById("r_emp1").innerHTML = "";
 });

    $("#btnApprNoted").click(function () {
      document.getElementById("parallelrowRed").innerHTML = "";
    $("#showRemarks").show();
    $('#txtRemarks').val("");
    $("#showSubmitBtn").show();
        $("#showEmpForward").hide();
        $("#showEmpForwardRed").hide();
    $("#showEmpReturn").hide();
    
    $("#btnSubmit").find("i").removeClass().addClass("fa fa-pen-square");
   
   // document.getElementById("r_emp1").innerHTML = "";
});

    //$("#btnAddAppr").change(function () {
    //    alert($("#btnAddAppr").prop("checked"));

    //    if ($("#btnAddAppr").prop("checked") == true) {

    //        $("#btnAddAppr").prop("checked", false);
    //    }
    //    else {
    //        $("#btnAddAppr").prop("checked", true);
    //    }
    //});

    $("#btnAddAppr").click(function () {
          document.getElementById("parallelrowRed").innerHTML = "";

        if ($("#btnAddAppr").prop("checked") == true) {

            $("#showEmpForwardRed").show();
             addEmployee();
        }
        else {
            $("#showEmpForwardRed").hide();
        }
         
    });
    

    function addEmployee() {
    var paraDiv = $("#parallelrowRed");
    var j = $("#p_rowid").length + 1;
    var apprvType = "Add Employee";
    var ApprType = "S";  
    var SrchStringLen = addQuotes('2');
    var hiddenVariable = addQuotes('hdnEmpCodeRec' + j);
    var pageflag = addQuotes('PWAAPP');
    var QueryID = addQuotes('GetEmployeeNote');
    var ShowValue = addQuotes('r_emp' + j);
    $('<div class="row" id="p_rowid"><div class="col-md-2"><div class="form-group"><b>' + apprvType + '</b></div></div><div class="col-md-8 employee-id-row"><div class="form-group"><div class="all-emp" id="r_emp' + j + '"></div><div class="autocomplete" style="width:100%;" align="left"><input type="text" id="txtEmpCode' + j + '" autocomplete="off" class= "text-uppercase" style = "border-top: none;border-left: none;width:100%" name = "search" placeholder = "Search Employee.." onkeyup = "SearchDataAutoCompleteEmpMul(this.id, this.value,' + SrchStringLen + ',' + hiddenVariable + ',' + pageflag + ',' + QueryID + ' ,' + ShowValue + ')"/></div ></div></div><div class="col-md-2"><input id="hdnEmpCodeRec' + j + '" type="hidden"/><input id="hdnApprType' + j + '" type="hidden" value="' + ApprType + '" class="hdnApprType"/></div></div> ').appendTo(paraDiv);
    j++;
    return false;
}

  


function addQuotes(value) {
    var quotedVar = "\'" + value + "\'";
    return quotedVar;
}
$(document).on('click', '.cancel-emp', function () {
    $(this).parent().remove();
});
});

function getList() {
        $(".loaderColor").show();
        //debugger;
        getListPending();
         $(".loaderColor").fadeOut();
    }
function getListPending() { 
    var Data = '';
    Data = $("[id*=hdBranchId]").val() + 'µ' + $("[id*=hdFirmId]").val() + 'µ' + $("[id*=hdUserId]").val()
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "Approve2.aspx/getListPending",
        data: "{pageVal:'GetPendingtoApproveList', pageval1 :'" + Data + "', pageval2 :''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            document.getElementById("contentSectionID").innerHTML="";
            var parentDiv = document.createElement("div");
            parentDiv.className = "panel-body";
            parentDiv.setAttribute('id', 'listPending');  
            var lenRow = Result.length;
            if (lenRow == 0) {
                let timerInterval
                Swal.fire({
                    width: 400,
                    type: 'info',
                    title: 'No Pending Notes...!',
                    html: 'You dont have any pending notes for recommendation...!',
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
                        window.open('Index.aspx', '_self');
                    }
                }).then((result) => {
                    if (
                        // Read more about handling dismissals
                        result.dismiss === Swal.DismissReason.timer
                    ) {
                        window.open('Index.aspx', '_self');
                    }
                })
            }
            var rowid = 0;
            var firstNote = '';
            
            $.each(Result, function (key, value) {    
                $("#divContentHide").show();
                $("#divListHide").show();
                //ListLoad(value.lst);
                var listOfApprove = value.lst;
                var approveList = listOfApprove.split('µ');
                var listLength = approveList.length;
                var splitApproveList;

                var alertSpan1 = document.createElement("div");
                alertSpan1.className = "ms-Persona-imageArea";
                var aItem2 = document.createElement("div");
                //aItem2.className = "ms-Persona-initials ms-Persona-initials--blue";
                if (approveList[3] == 1) {aItem2.className = "ms-Persona-initials ms-Persona-initials--red";}
                else if (approveList[3] == 2) { aItem2.className = "ms-Persona-initials ms-Persona-initials--orange"; }
                else if(approveList[3] == 3) {aItem2.className = "ms-Persona-initials ms-Persona-initials--yellow";}

                //aItem2.setAttribute('href', 'javascript:void(0)');
                var aValue2 = document.createTextNode(approveList[0]);
                //aItem2.appendChild(aValue2); 
                aItem2.innerHTML = approveList[0];
                alertSpan1.appendChild(aItem2); 

                //alertSpan1.appendChild(iItem1); 

                var alertDiv = document.createElement("div");
                alertDiv.className = "alert alert-pending";
                rowid = rowid + 1;
                if (rowid == 1) {                  
                    firstNote = approveList[1];
                }
                alertDiv.setAttribute('id', 'dival' + approveList[1]);  
                //alertDiv.setAttribute('aria-selected', 'True');   
                alertDiv.onclick = function () { ContentFill(approveList[1]);/*alert("Hi clicked")*/};
                var myDiv = document.createElement("div");
                myDiv.className = "notification-info";          
                var myList = document.createElement("ul");
    
                // add a class name to list
                myList.className="clearfix notification-meta";
      
                // create list item for every element 
                var listItem = document.createElement("li");

                listItem.className = "pull-left notification-sender";
                var pItem1 = document.createElement("p");
                var span1 = document.createElement("span");
                var aItem1 = document.createElement("a");
                //pItem1.appendChild(span1); 
                aItem1.setAttribute('href', '#');
                //aItem1.setAttribute('onclick', 'displayIframe("' + url + '")');
                //aItem1.addEventListener("click", func, false); 
                // aItem1.onclick = function () { func();/*alert("Hi clicked")*/};
                // create a text node to store value
                var aValue = document.createTextNode(approveList[1]);
                aItem1.appendChild(aValue); 
                span1.appendChild(aItem1); 
                pItem1.appendChild(span1); 
                var pItem2 = document.createElement("p");
                var maxLength = 10;
                var subj = approveList[2].substring(0, maxLength) + '...';
                var pValue2 = document.createTextNode(subj);
                pItem2.appendChild(pValue2);

                listItem.appendChild(pItem1); 
                listItem.appendChild(pItem2); 
        
                myList.appendChild(listItem);
                var listItem1 = document.createElement("li");

                listItem1.className = "pull-right notification-time";

                var listValue1 = document.createTextNode("");
           var splitTime;
           splitTime = approveList[4].split('¥');//5
           if (splitTime[0] > 0) { listValue1 = document.createTextNode(splitTime[0]+" Years ago");}
           else if (splitTime[1] > 0) { listValue1 = document.createTextNode(splitTime[1] + " Months ago"); }
           else if (splitTime[2] > 0) { listValue1 = document.createTextNode(splitTime[2] + " Days ago"); }
           else if (splitTime[3] > 0) { listValue1 = document.createTextNode(splitTime[3] + " Hours ago"); }
           else if (splitTime[4] > 0) { listValue1 = document.createTextNode(splitTime[4]+" Minutes ago");}
            else if (splitTime[5] > 0) { listValue1 = document.createTextNode(splitTime[5]+" Seconds ago");}
          listItem1.appendChild(listValue1); 

          myList.appendChild(listItem1);
          myDiv.appendChild(myList); 
          alertDiv.appendChild(alertSpan1);
          alertDiv.appendChild(myDiv);
          
          parentDiv.appendChild(alertDiv); 
         });
            document.getElementById("contentSectionID").appendChild(parentDiv);
            
            var querynote = $("[id*=hdnquerynoteid]").val();
            if (querynote == '0' || querynote == '' || querynote == 'undefined' || querynote == null) {
                ContentFill(firstNote);
            }
            else {                
                  ContentFill(querynote);
            }
            
        },
        error: function (Result) {
        }
    });
}
function ContentFill(noteid) { 
    $(".loaderColorCont").show(); 
    $('.radio-button').prop('checked', false);
    $("#showBtnsRec").hide();
    $("#showBtnsAppr").hide();
    $("#showEmpForward").hide(); 
    $("#showEmpReturn").hide();
     $("#showRemarks").hide();
    $("#showSubmitBtn").hide();
    $("#ddlEmp").empty();
    $("#showAttach").hide();
    $("[id*=hdnContentNoteId]").val(noteid);
    document.getElementById("lstApprovers").innerHTML = "";

   // document.getElementById("div" + noteid).style.backgroundColor = "lightblue"; 
        var header = document.getElementById("listPending");
        divlist = $("div[id^='dival']");

    var btns = header.getElementsByClassName("alert");
    for (var i = 0; i < btns.length; i++) {
        selectdiv1 = document.getElementById("dival" + noteid);
        selectdiv2 = btns[i];
        if (selectdiv1 == selectdiv2) {
            btns[i].style.backgroundColor = "#b7b7b7";
        }
        else {
            btns[i].style.backgroundColor = "#e5e5e5";
        }
    }
    //a.note_id,e.firm_abbr Firm,a.subject,a.remarks,initcap(d.EMP_NAME) Created_by,to_char(a.created_date, 'dd-Mon-yyyy hh:mi:ss am') createdDate,to_char(b.received_date, 'dd-Mon-yyyy hh:mi:ss am') received_date,c.doc_name,decode(a.nature, 'Y', 'Confidential', 'Non Confidential') nature,a.priority,decode(a.circular, 'Y', 'Yes', 'No') circular
     var Data = '';
    Data = $("[id*=hdBranchId]").val() + 'µ' + $("[id*=hdFirmId]").val() + 'µ' + $("[id*=hdUserId]").val()+ 'µ' + noteid
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "Approve2.aspx/getTableData",
        data: "{pageVal:'GetPendingtoApproveData', pageval1 :'" + Data + "', pageval2 :''}",
        dataType: "json",
        success: function (Result) {            
            Result = Result.d;
            //alert(Result);
            var contentDtl = Result.split('µ');
            
                document.getElementById("sNameDiv").innerHTML = "";
                var snDiv = document.createElement("div");
            snDiv.className = "ms-Persona-imageArea";
            snDiv.setAttribute('style', 'float: left;');
                var snItemDiv = document.createElement("div");
                if (contentDtl[15] == 1) {snItemDiv.className = "ms-Persona-initials ms-Persona-initials--red";}
                else if (contentDtl[15] == 2) { snItemDiv.className = "ms-Persona-initials ms-Persona-initials--orange"; }
                else if(contentDtl[15] == 3) {snItemDiv.className = "ms-Persona-initials ms-Persona-initials--yellow";}
            
                snItemDiv.innerHTML = contentDtl[14];
                snDiv.appendChild(snItemDiv); 
                document.getElementById("sNameDiv").appendChild(snDiv);

            document.getElementById("lblNoteId").innerHTML = contentDtl[0];
            $("[id*=hdnNoteId]").val(contentDtl[0]);
            document.getElementById("lblSubject").innerHTML = contentDtl[2];

            document.getElementById("lblFirm").innerHTML = contentDtl[1];
            document.getElementById("lblDocType").innerHTML = contentDtl[7];

            $("[id*=DocTypenew]").val(contentDtl[21]);
            //document.getElementById("lblCreateBy").innerHTML = contentDtl[4] + "<br />" + contentDtl[12] + "";
            document.getElementById("lblCreateBy").innerHTML = contentDtl[4];
            
            document.getElementById("lblDepartment").innerHTML = contentDtl[12] ;
            
            document.getElementById("lblCreateDate").innerHTML = contentDtl[5];
            document.getElementById("lblAssignDate").innerHTML = contentDtl[6];
            document.getElementById("lblNature").innerHTML = contentDtl[8];
            document.getElementById("divRemarks").innerHTML = "";

                var remkDiv = document.createElement("div");
                //var remkStrong = document.createElement("strong");
                
                var remkChk = document.createElement("input");
                remkChk.setAttribute('type', 'checkbox');
                remkChk.setAttribute('id', 'post-'+contentDtl[0]);
                remkChk.className = "read-more-state";
                remkDiv.appendChild(remkChk);
                

                 var remkP = document.createElement("p");
            remkP.className = "read-more-wrap text-maroon";
            remkP.setAttribute('style', 'margin-bottom: 0;');
                var x1 ='Remarks :'+ contentDtl[3];
                var c1=x1.split(' ').length;
                var y1 = x1.split(' ').slice(0,10).join(' ');
                var z1 = x1.split(' ').slice(10, c1).join(' ');
                

                remkP.innerHTML = y1;
            if (c1 > 10) {
                var remkSpanP = document.createElement("span");
                remkSpanP.className = "read-more-target";
                remkSpanP.innerHTML = z1;
                remkP.appendChild(remkSpanP);
                //<label for="post-1" class="read-more-trigger bnt-more"></label>

            }
             remkDiv.appendChild(remkP);
            if (c1 > 10) {

                var remkLbl = document.createElement("label");
                remkLbl.setAttribute('for', 'post-'+contentDtl[0]);
                remkLbl.className = "read-more-trigger bnt-more";
                remkDiv.appendChild(remkLbl);
            }

                //remkStrong.appendChild(remkP);


               
                
                document.getElementById("divRemarks").appendChild( remkDiv); 
            
                //document.getElementById("lblRemarks").innerHTML = contentDtl[3];
                // document.getElementById("lblDepartment").innerHTML = "("+ contentDtl[12] + ")" ;

             
            priority = document.getElementById("lblPriority");
            if (contentDtl[9] == 1) {
                document.getElementById("lblPriority").innerHTML = "High";
                priority.classList.remove('label-medium');
                priority.classList.remove('label-low');
                 priority.classList.add('label-high');           
            }
            else if (contentDtl[9] == 2) {
                document.getElementById("lblPriority").innerHTML = "Medium"; 
                priority.classList.remove('label-high');
                priority.classList.remove('label-low');
                 priority.classList.add('label-medium');           
            }
            else if (contentDtl[9] == 3) {
                document.getElementById("lblPriority").innerHTML = "Low";  
                priority.classList.remove('label-high');
                priority.classList.remove('label-medium');
                 priority.classList.add('label-low');           
            }
           nature = document.getElementById("lblNature");
            if (contentDtl[17] == "Y") {
                nature.classList.remove('label-primary');
                nature.classList.add('label-high');
            }
            else {
                nature.classList.remove('label-high');
                nature.classList.add('label-primary');
            }

            var reqr = contentDtl[16];
            var usr = $("[id*=hdUserId]").val();
            var retStat = contentDtl[18];
            var discussStat = contentDtl[19];
            var discussResStat = contentDtl[20];

            $("[id*=hdnReturnStatus]").val("0");
            $("[id*=hdnDiscussResStatus]").val("0");
            
            $("[id*=hdnReqEmp]").val(reqr);
            if (contentDtl[13] == "F" && discussResStat == "1") {
                $("#showBtnsAppr").show();
                $("#showBtnsRec").hide();
                if (usr == '10001') {
                    $("#showForBtn").hide();
                } 
                if (discussStat == "0") {
                    $("#showApprDiscussBtn").hide();
                }
                else {
                     $("#showApprDiscussBtn").show(); 
                }
            }
            else {
                if (retStat == "0") {
                    $("#showBtnsRec").hide();
                    $("#showBtnsAppr").hide();
                    $("#showEmpForward").hide();    
                    $("#showEmpReturn").hide();
                    $("#showRemarks").show();                    
                    
                    $('#txtRemarks').val("");
                    $("#showSubmitBtn").show();
                    $("[id*=hdnReturnStatus]").val("1");
                       $("#showBtnRet").show();//Add approver
                     $("#showAttach").show();
                    //if (usr == reqr) {
                    //    $("#showAttach").show();
                    //}
                    //else {
                    //    $("#showAttach").hide();
                    //}
                }
                else if (discussResStat == "5") {
                    $("#showBtnsRec").hide();
                    $("#showBtnsAppr").hide();
                    $("#showEmpForward").hide();    
                    $("#showEmpReturn").hide();
                    $("#showRemarks").show();                    
                     $("#showBtnRet").hide();//Add approver
                    $('#txtRemarks').val("");
                    $("#showSubmitBtn").show();
                    $("[id*=hdnDiscussResStatus]").val("1");
                    //if (usr == reqr) {
                    //    $("#showAttach").show();
                    //}
                    //else {
                    //    $("#showAttach").hide();
                    //}
                }
                else {
                       $("#showBtnRet").hide();//Add approver
                     $("#showBtnsRec").show();
                    $("#showBtnsAppr").hide();
                    if (discussStat == "0") {
                        $("#showRecDiscussBtn").hide();
                    }
                    else {
                        $("#showRecDiscussBtn").show(); 
                    }
                }
               
            }
           
            $("[id*=hdnNoteOrderId]").val(contentDtl[11]);
           
            //alert(contentDtl[1]);
            GetEmpList(noteid);
            ContentAprroverFill(noteid);
            
            //detailsLoad(noteid);
            filesFill(noteid);
            WorkFlowFill(noteid);
            //GetMoreDocCheck();
            $(".loaderColorCont").fadeOut();
        },
        error: function (Result) {
        }
    });
    }
function GetEmpList(noteid) {
     $("#ddlEmp").empty();
    var QueryString = "GetEmpListRet";
    var data = noteid + "µ" + $("[id*=hdUserId]").val();
        $.ajax({
            type: "post",
            contentType: "application/json; charset=utf-8",
            url: "Approve2.aspx/getFillData",
            data: "{pageVal:'GetEmpListRet', pageval1 :'" + data + "', pageval2 :''}",
            dataType: "json",
            success: function (Result) {
                Result = Result.d;
                //$('#ddlEmp').append($("<option selected disabled></option>").val("-1").html("Select Employee"));
                $.each(Result, function (key, value) {                   
                    $('#ddlEmp').append($("<option></option>").val(value.id).html(value.name));                    
                });
                
            }
        });
 }
function detailsLoad(noteid) {
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "Approve2.aspx/getRequestNote",
        data: "{pageVal:'GetRequestNotes', pageval1:'" + noteid + "',pageval2:'2'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            $('.summernoteview').summernote('code', Result);
        }
    });
}
function ContentAprroverFill(noteid) {
   // alert(noteid);
    //a.note_id,e.firm_abbr Firm,a.subject,a.remarks,initcap(d.EMP_NAME) Created_by,to_char(a.created_date, 'dd-Mon-yyyy hh:mi:ss am') createdDate,to_char(b.received_date, 'dd-Mon-yyyy hh:mi:ss am') received_date,c.doc_name,decode(a.nature, 'Y', 'Confidential', 'Non Confidential') nature,a.priority,decode(a.circular, 'Y', 'Yes', 'No') circular
     $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "Approve2.aspx/getListPending",
        data: "{pageVal:'GetApproversList', pageval1 :'" + noteid + "', pageval2 :''}",
        dataType: "json",
        success: function (Result) {            
            Result = Result.d;
            
  //          <ul class="multi-steps">
  //  <li class="li-bar" data-toggle="tooltip" title="Recommended on 10-Aug-2019 10:00:52 am">Minnu</li>
  //  <li class="li-bar" data-toggle="tooltip" title="Not Recommended on 11-Aug-2019 12:00:52 am">Durga</li>
  //  <li class="li-bar is-active" data-toggle="tooltip" title="Assigned on 12-Aug-2019 9:00:52 am">John</li>
  //  <li class="li-bar">Lima</li>
  //  <li class="li-bar">Lima</li>
  //  <li class="li-bar">Lima</li>
  //  <li class="li-bar">Lima</li>
  //  <li class="li-bar">Lima</li>
  //  <li class="li-bar">Lima</li>
  //</ul>
            
            document.getElementById("lstApprovers").innerHTML = "";
             var parentUl = document.createElement("ul");
            parentUl.className = "multi-steps";
           
            $.each(Result, function (key, value) {
                
                var listOfApprove = value.lst;
                var approveList = listOfApprove.split('µ');
                
                // create list item for every element --a.order_id,a.approver_name,decode(a.status_id,0,'Recommended',1,'Assigned',2,'Not Assigned',3,'Not Assigned',9,'Rejected') status,to_char(a.received_date,'dd-Mon-yyyy hh:mi:ss am') received_date,to_char(a.updated_date,'dd-Mon-yyyy hh:mi:ss am') updated_date
                var listItem = document.createElement("li");
                //debugger;
                //alert(approveList[5]+approveList[6]);
                //alert($("[id*=hdUserId]").val());
                if (((approveList[5] == "1" && approveList[6] == $("[id*=hdUserId]").val()) || approveList[5] == "5")) {
                    //alert(approveList[6]);
                    listItem.className = "li-bar recommend is-active";
                }
                else if (approveList[5] == "3") {
                    listItem.className = "li-bar notrecommend";
                }
                    else if (approveList[5] == "6") {
                    listItem.className = "li-bar  autoskip";
                }
                else {
                    listItem.className = "li-bar recommend";
                }
                listItem.setAttribute('data-toggle', 'tooltip');
                listItem.setAttribute('title', approveList[2]+approveList[7]);
                var lValue = document.createTextNode(approveList[1]);
                listItem.appendChild(lValue);
                parentUl.appendChild(listItem);
            });
             document.getElementById("lstApprovers").appendChild(parentUl);

        },
        error: function (Result) {
        }
    });
    }
function WorkFlowFill(noteid) {
   // alert(noteid);
    //a.note_id,e.firm_abbr Firm,a.subject,a.remarks,initcap(d.EMP_NAME) Created_by,to_char(a.created_date, 'dd-Mon-yyyy hh:mi:ss am') createdDate,to_char(b.received_date, 'dd-Mon-yyyy hh:mi:ss am') received_date,c.doc_name,decode(a.nature, 'Y', 'Confidential', 'Non Confidential') nature,a.priority,decode(a.circular, 'Y', 'Yes', 'No') circular
     $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "Approve2.aspx/getListPending",
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
                 //<section class="timeline1">
        //  <div class="container">
        //<div class="timeline-item">
        //<div class="timeline-img">JJ</div>

        //<div class="timeline-content js--fadeInLeft">
        //<div class="wf-date">1 MAY 2016  05:45:20 pm</div>
        //<h4>Jenin J</h4>
        //<h6 style="color:#FF4081;">Recommended</h6>
                //<input type="checkbox" class="read-more-state" id="post-1" />

        //<p class="read-more-wrap">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.
        //<span class="read-more-target">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.</span></p>
  
        //<label for="post-1" class="read-more-trigger bnt-more"></label>
        //</div>
        //</div> 
                
                var tlitemDiv = document.createElement("div");
                tlitemDiv.className = "timeline-item";
                 var tlimgDiv = document.createElement("div");
                tlimgDiv.className = "timeline-img";
                 tlimgDiv.innerHTML = workflowList[0];
                tlitemDiv.appendChild(tlimgDiv);

                var tlConDiv = document.createElement("div");
                if ((sideNum % 2) == 0) {
                    /*even */
                  tlConDiv.className = "timeline-content js--fadeInRight";
                }
                else if ((sideNum % 2) != 0) {
                    /*odd */
                 tlConDiv.className = "timeline-content js--fadeInLeft";
                };
                

                var tlConDateDiv = document.createElement("div");
                tlConDateDiv.className = "wf-date";
                tlConDateDiv.innerHTML = workflowList[1];

                var tlConHead = document.createElement("h6");
                 tlConHead.innerHTML = workflowList[2];
                 //<input type="checkbox" class="read-more-state" id="post-1" />

                //<p class="read-more-wrap">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.
                //<span class="read-more-target">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maxime ipsa ratione omnis alias cupiditate saepe atque totam aperiam sed nulla voluptatem recusandae dolor, nostrum excepturi amet in dolores. Alias, ullam.</span></p>
  
                //<label for="post-1" class="read-more-trigger bnt-more"></label>
                  var tlConHead1 = document.createElement("h7");
                tlConHead1.setAttribute('style', 'color:#FF4081;');
                tlConHead1.innerHTML = workflowList[3];

                tlConDiv.appendChild(tlConDateDiv);
                tlConDiv.appendChild(tlConHead);
                 tlConDiv.appendChild(tlConHead1);

                 var tlInChk = document.createElement("input");
                tlInChk.setAttribute('type', 'checkbox');
                tlInChk.setAttribute('id', 'post-'+sideNum);
                tlInChk.className = "read-more-state";
                tlConDiv.appendChild(tlInChk);

            //    var remkP = document.createElement("p");
            //remkP.className = "read-more-wrap text-maroon";
            //remkP.setAttribute('style', 'margin-bottom: 0;');
            //    var x1 ='Remarks :'+ contentDtl[3];
            //    var c1=x1.split(' ').length;
            //    var y1 = x1.split(' ').slice(0,10).join(' ');
            //    var z1 = x1.split(' ').slice(10, c1).join(' ');
                

            //    remkP.innerHTML = y1;
            //if (c1 > 10) {
            //    var remkSpanP = document.createElement("span");
            //    remkSpanP.className = "read-more-target";
            //    remkSpanP.innerHTML = z1;
            //    remkP.appendChild(remkSpanP);
            //    //<label for="post-1" class="read-more-trigger bnt-more"></label>

            //}
            // remkDiv.appendChild(remkP);
            //if (c1 > 10) {

            //    var remkLbl = document.createElement("label");
            //    remkLbl.setAttribute('for', 'post-'+contentDtl[0]);
            //    remkLbl.className = "read-more-trigger bnt-more";
            //    remkDiv.appendChild(remkLbl);
            //}

            //    //remkStrong.appendChild(remkP);


               
                
            //    document.getElementById("divRemarks").appendChild( remkDiv); 



                 var tlConP = document.createElement("p");
                tlConP.className = "read-more-wrap";
                var x =workflowList[4];
                var c=x.split(' ').length;
                var y = x.split(' ').slice(0,10).join(' ');
                var z = x.split(' ').slice(10, c).join(' ');
                
                tlConP.innerHTML = y;
                if (c > 10) {
                     var tlConSpanP = document.createElement("span");
                    tlConSpanP.className = "read-more-target";
                    tlConSpanP.innerHTML = z;
                    tlConP.appendChild(tlConSpanP);
                    //<label for="post-1" class="read-more-trigger bnt-more"></label>
                }
                tlConDiv.appendChild(tlConP);
                if (c > 10) {
                     var tlLbl = document.createElement("label");
                    tlLbl.setAttribute('for', 'post-'+sideNum);
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
function filesFill(noteid) {
    $("#tblFiles").empty();
    var filenm = $("[id*=hdUserId]").val() + noteid.replace(/[^a-zA-Z0-9]/g, '')+"_";
             $.ajax({
                type: "post",
                contentType: "application/json; charset=utf-8",
                url: "Approve2.aspx/getFileData",
                data: "{pageVal:'GetAttachList', pageval1 :'" + noteid + "', pageval2 :'" + filenm + "', pageval3 :'" + $("[id*=hdUserId]").val() + "'}",
                dataType: "json",
                success: function (Result) {
                    Result = Result.d;
                    var valData, valData1;
                    var n = 0;
                    valData = Result.split('Θ');
                    var len = valData.length;
                    document.getElementById("attachCount").innerHTML = len-1;
                    if (len == 1) {
                        document.getElementById("btnAttach").disabled = true;
                    }
                    else {
                        document.getElementById("btnAttach").disabled = false;
                    }
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
                            myUrl = applicationName+"Images/" + filename;
                        }
                        else {
                            myUrl = applicationName+"paperless/Images/" + filename;
                        }                        
                        $('#tblFiles').append('<tbody><tr>' +
                            '<td>' + contentDtl[0] + '</td>' +
                            '<td><a href="' + myUrl + '" download="' + filename + '" class="file-list1">' + contentDtl[1] + '</a></td>' +
                            '</tr> </tbody>');
                    }

                }
            });
}
function createApprList(arr) {        
var ul = "<ul>";
for(var i=0; i < arr.length; i++) {
  ul += "<li><a href=\"#\">" + arr[i] + "</a></li>";
}
  ul += "</ul>";

//var ulElem = $(ul);
  return ul;
}
function createList(spacecrafts){    
    var listView = document.createElement('ul'); 

for(var i=0;i<spacecrafts.length;i++)
{
    var listViewItem=document.createElement('li');
    listViewItem.appendChild(document.createTextNode(spacecrafts[i]));
    listView.appendChild(listViewItem);
    }
     //listView.addClass('clearfix notification-meta');

return listView;
    }
function Decrypt(value)
{
  var result="";
  var array = value.split("-");

  for(i=0;i<array.length;i++)
  {
    result+=String.fromCharCode(array[i]-10);
  }
  return result;
} 
//function getRootWebSitePath()
//{
//    var _location = document.location.toString();
//    var applicationNameIndex = _location.indexOf('/', _location.indexOf('://') + 3);
//    var applicationName = _location.substring(0, applicationNameIndex) + '/';
//    var webFolderIndex = _location.indexOf('/',location.indexOf(applicationName) + applicationName.length);
//    var webFolderFullPath = _location.substring(0, webFolderIndex);

//    return webFolderFullPath;
//}

//$( function() {
//    $( "#resizable" ).resizable();
//  } );


/************************************/
    //inline-editor
    /************************************/
    $('.inline-editor').summernote({
        airMode: true
    });  

    /************************************/
    //airmode editor
    /************************************/
    $('.airmode-summer').summernote({
        airMode: true
        });

//    function GetMoreDocCheck() {
       
//    var selectedEmployee = $("#ddlEmp option:selected").val();
//    var reqEmployee = $("[id*=hdnReqEmp]").val();
//    if (selectedEmployee == reqEmployee) {
//        $("#divNeedMoreDocs").show();
//    }
//    else {
//        $("#divNeedMoreDocs").hide();
//    }
//}

function ShowContent() {
       // $("#contentModel").show();
    var noteid = $("[id*=hdnContentNoteId]").val();
    var editOption = $("[id*=hdEditOption]").val();
   
    var str = Encrypt(noteid+"~"+editOption);
    settings = "width=840, height=580, top=20, left=20, scrollbars=yes, location=no, directories=no, status=no, menubar=no, toolbar=no, resizable=no, dependent=no";
    win = window.open('ViewerNoteContent.aspx?noteid='+str, '', settings);
    win.focus();
    }

  

    function HideContent() {
        $("#contentModel").hide();
        }
    function ShowContentFiles() {
        $("#contentModelFiles").show();
    }

    function HideContentFiles() {
        $("#contentModelFiles").hide();
    }

function ShowContentFlow() {
        $("#contentModelFlow").show();
    }

    function HideContentFlow() {
        $("#contentModelFlow").hide();
    }
function checkSpcialChar(event){
            if(!((event.keyCode >= 65) && (event.keyCode <= 90) || (event.keyCode >= 97) && (event.keyCode <= 122) || (event.keyCode >= 48) && (event.keyCode <= 57) && (event.keyCode == 220 || event.keyCode == 222))){
               event.returnValue = false;
               return;
    }
     //if (event.keyCode == 220 || event.keyCode == 222) {
     //       event.returnValue = false;
     //       return false;
     //   }
            event.returnValue = true;
    }

function NoteRecommendConfirm() {

    //var div = document.getElementById('summernoteview');
    var Data, itmdata, dateval, itmdatachild, circularStatus, confidentStatus, firmid, docType, noteid,orderid,systemip;
    //Nature of Note---Is it Confidential?
    systemip = "";
    systemip = $("[id*=hdnSystemIP]").val();
    
    var docType1 = $("[id*=DocTypenew]").val();

    noteid = $("[id*=hdnNoteId]").val();
    orderid = $("[id*=hdnNoteOrderId]").val();
    //$('.radio-button').prop('checked', false);
    //if ($("#btnRecommend").prop("checked") == false) {
    //    //ModelPopWarning("Select Any Option...!");
    //    alert("Select Any Option...!");
    //    return false;
    //}
    var recStatus = -1;
    //hdnReturnStatus

    var returnStat = $("[id*=hdnReturnStatus]").val();
    //hdnDiscussResStatus
    var DiscussResStat = $("[id*=hdnDiscussResStatus]").val();

    if ($("#btnRecommend").prop("checked") == false && $("#btnNotRecommend").prop("checked") == false && $("#btnRedirect").prop("checked") == false && $("#btnApprove").prop("checked") == false && $("#btnForward").prop("checked") == false && $("#btnReject").prop("checked") == false && $("#btnRecReturn").prop("checked") == false && $("#btnApprReturn").prop("checked") == false && $("#btnApprRedirect").prop("checked") == false && $("#btnRecDiscuss").prop("checked") == false && $("#btnApprDiscuss").prop("checked") == false && $("#btnApprNoted").prop("checked") == false && $("#btnAddAppr").prop("checked") == false) { 
        //ModelPopWarning("Select Approve Or Reject...!");
        if (returnStat == "1") {
           recStatus =8;
        }
        else if (DiscussResStat == "1") {
           recStatus =14;
        }
        else {  alert("Select Any Option...!");
            return false;}
        
    }
    else if ($("#btnRecommend").prop("checked") == true) {
        recStatus =0;
    }
    else if ($("#btnNotRecommend").prop("checked") == true) {
        recStatus =3;
    }
    else if ($("#btnRedirect").prop("checked") == true) {
        recStatus = 4;
    }
    else if ($("#btnApprove").prop("checked") == true) {
        recStatus =0;
    }
    else if ($("#btnReject").prop("checked") == true) {
        recStatus =9;
    }
    else if ($("#btnForward").prop("checked") == true) {
        recStatus = 5;
    }
    else if ($("#btnRecReturn").prop("checked") == true) {
        recStatus =6;
    }
    else if ($("#btnApprReturn").prop("checked") == true) {
        recStatus =7;
    }
    else if ($("#btnApprRedirect").prop("checked") == true) {
        recStatus =10;
    }
    else if ($("#btnRecDiscuss").prop("checked") == true) {
        recStatus =11;
    }
    else if ($("#btnApprDiscuss").prop("checked") == true) {
        recStatus =12;
    }
    else if ($("#btnApprNoted").prop("checked") == true) {
        recStatus =13;
    }
    else if($("#btnAddAppr").prop("checked") == true) {
         recStatus =15;
    }
    if (recStatus==-1) {
        alert("Select Any Option...!");
        return false;
    }
    var empdata = "";
    if (recStatus == 5) {
         var apprRow = document.getElementById("parallelrow").querySelectorAll("div.row");
        var len1 = apprRow.length;
        for (var i = 0; i < len1; i++) {        
            apprRow1 = apprRow[i].childNodes;
            empRow = apprRow1[1].querySelectorAll("span.visuallyhidden");
            var len3 = empRow.length;
            if (len3 > 0) {
                for (var j = 0; j < len3; j++) {
                    if (j == 0) { empdata += empRow[j].innerHTML; }
                    else { empdata += '¥' + empRow[j].innerHTML; }
                }
            }
            else {
                alert("Add Employee...!");
                return false;
            }
            
        }
    }


     if (recStatus == 4 || recStatus == 10 || recStatus == 15) {
         var apprRow = document.getElementById("parallelrowRed").querySelectorAll("div.row");
        var len1 = apprRow.length;
        for (var i = 0; i < len1; i++) {        
            apprRow1 = apprRow[i].childNodes;
            empRow = apprRow1[1].querySelectorAll("span.visuallyhidden");
            var len3 = empRow.length;
            if (len3 > 0) {
                for (var j = 0; j < len3; j++) {
                    if (j == 0) { empdata += empRow[j].innerHTML; }
                    else { empdata += '¥' + empRow[j].innerHTML; }
                }
            }
            else {
                alert("Add Employee...!");
                return false;
            }
            
        }
    }

    if (recStatus == 6 || recStatus == 7) {
        empdata = $("#ddlEmp option:selected").val();
        if (empdata=='-1') {
        alert("Select an employee from the List...!");
        return false;
        }
    }
   // debugger;
    //var uploadedCnt = $(".file-uploaded");
    //alert(uploadedCnt.length);
    var str = $('#txtRemarks').val();
    var remark = str.replace(/\\/g, '\\\\').replace(/[“”‘’']/g, '\\\'');
    Data = '';
    itmdata = '';
    Data = $("[id*=hdBranchId]").val() + 'µ' + $("[id*=hdFirmId]").val() + 'µ' + noteid + 'µ' + orderid + 'µ' +  remark + "µ" + $("[id*=hdUserId]").val() + "µ" + recStatus + "µ" + empdata

    //$('#test').attr('class');   
    //$(this).find("i").removeClass("fa-thumbs-up").addClass("fa-spinner fa-spin");
    var cls = $('#btnSubmit').find("i").attr('class');
    $('#btnSubmit').find("i").removeClass(cls).addClass("fa fa-spinner fa-spin");


    let uploadedElements = $(".file-uploaded");
    if (uploadedElements.length > 0) {
        for (let i = 0; i < uploadedElements.length; i++) {
            let extension = "";
            let element = uploadedElements.eq(i)[0];
            let fileList = element.files;
            let fileReader = new FileReader();
            if (fileReader && fileList && fileList.length) {
                let fileSize = fileList[0].size / 1048576;
                if (fileSize > 10) {
                    alert("Please Upload Files Less Than 10MB");
                    return false;
                }
            }
        }
    }


    var res;
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "Approve2.aspx/NoteRecommendConfirm",
         data: "{pageVal:'ConfirmRecommendNote', pageval1 :'" + Data + "',pageval2:'"+ noteid +"',pageval3:'"+ docType1 +"'}",
        dataType: "json",
        async: false,
        success: function (Result) {
          Result = Result.d;
          $('#btnSubmit').find("i").removeClass("fa-spinner fa-spin").addClass(cls);
          res = Result.split('µ');
            var stat = res[0];
            if (stat == 2) {                
            let uploadedElements = $(".file-uploaded");
            if (uploadedElements.length > 0) {
                  for (let i = 0; i < uploadedElements.length; i++) {
                      let extension = "";
                      let element = uploadedElements.eq(i)[0];
                      let fileList = element.files;
                      let fileReader = new FileReader();
                      if (fileReader && fileList && fileList.length) {
                          let fileSize = fileList[0].size / 1048576;
                          if (fileSize > 10) {
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
                          }
                          else {
                              // if there is an extension, we convert to lower case
                              // (N.B. this conversion will not effect the value of the extension
                              // on the file upload.)
                              extension = extension.toLowerCase();
                          }
                          
                        fileReader.readAsDataURL(fileList[0]);
                          fileReader.onload = function () {
                            
                        
                        let fileno = i + 1;
                              let imageData1 = fileReader.result;
                        let InputData1 = noteid + "µ" + fileno + "µ" + extension + "µ" + fileName;
                        let sessionkey = $("[id*=hdSesssion]").val();  
                        
                        let keySession = sessionkey.substring(0, 16);
                        //var key = CryptoJS.enc.Utf8.parse('8080808080808080');
                        //var iv = CryptoJS.enc.Utf8.parse('8080808080808080');
                        let key = CryptoJS.enc.Utf8.parse(keySession);
                        let iv = CryptoJS.enc.Utf8.parse(keySession);

                        let encryptedInput = CryptoJS.AES.encrypt(CryptoJS.enc.Utf8.parse(InputData1), key,
                            {
                                keySize: 128 / 8,
                                iv: iv,
                                mode: CryptoJS.mode.CBC,
                                padding: CryptoJS.pad.Pkcs7
                                  });   
                        $.ajax({
                                  type: "POST",
                                  contentType: "application/json; charset=utf-8",
                                  url: "Approve2.aspx/UploadingFile",
                                  data: "{ImageData:'" + imageData1 + "',InputData:'" + encryptedInput + "'}",
                                  dataType: "json",
                                  success: function (Result) {
                                      //$("#imgFileType").val(null);
                                      //return Result.d;
                                      //alert('Successfully Uploaded');
                                      //window.open('POUpload.aspx', '_self');
                                      let timerInterval
                                      Swal.fire({
                                          width: 400,
                                          type: 'success',
                                          title: 'Success!',
                                          html: res[1],
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
                                              window.open('Approve2.aspx', '_self');
                                          }
                                      }).then((result) => {
                                          if (
                                              // Read more about handling dismissals
                                              result.dismiss === Swal.DismissReason.timer
                                          ) {
                                              window.open('Approve2.aspx', '_self');
                                          }
                                      })
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
                      //do something with element

                  }
            }
              //else {
                
              //  }
                let timerInterval
                Swal.fire({
                        width: 400,
                        type: 'success',
                        title: 'Success!',
                        html: res[1],
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
                            window.open('Approve2.aspx', '_self');
                        }
                    }).then((result) => {
                        if (
                            // Read more about handling dismissals
                            result.dismiss === Swal.DismissReason.timer
                        ) {
                            window.open('Approve2.aspx', '_self');
                        }
            })
          }
          else if (stat == 1) {
            let timerInterval
            Swal.fire({
                width: 400,
                type: 'success',
                title: 'Success!',
                html: res[1],
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
                    window.open('Approve2.aspx', '_self');
                }
            }).then((result) => {
                if (
                    // Read more about handling dismissals
                    result.dismiss === Swal.DismissReason.timer
                ) {
                    window.open('Approve2.aspx', '_self');
                }
            })       
            //window.open('Approve2.aspx', '_self');
            }
          else {
            let timerInterval
            Swal.fire({
                width: 400,
                type: 'error',
                title: 'Oops...!',
                html: res[1],
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
                    window.open('Approve2.aspx', '_self');
                }
            }).then((result) => {
                if (
                    // Read more about handling dismissals
                    result.dismiss === Swal.DismissReason.timer
                ) {
                    window.open('Approve2.aspx', '_self');
                }
            })  
            }
            //var noteid = Result;
            //alert("Recommended Successfully...!");
        }
        //error: function (Result) {
        //     $('#btnSubmit').find("i").removeClass("fa-spinner fa-spin").addClass(cls);
        //   let timerInterval
        //    Swal.fire({
        //        width: 300,
        //        height: 200,
        //        type: 'error',
        //        title: 'Oops...!',
        //        html: 'Something went wrong!',
        //        //showConfirmButton: false,
        //        allowOutsideClick: false,
        //        timer: 5000,
        //        onBeforeOpen: () => {
        //            //Swal.showLoading()
        //            timerInterval = setInterval(() => {
        //                Swal.getContent().querySelector('strong')
        //                    .textContent = Swal.getTimerLeft()
        //            }, 100)
        //        },
        //        onClose: () => {
        //            clearInterval(timerInterval)
        //            window.open('Approve2.aspx', '_self');
        //        }
        //    }).then((result) => {
        //        if (
        //            // Read more about handling dismissals
        //            result.dismiss === Swal.DismissReason.timer
        //        ) {
        //            window.open('Approve2.aspx', '_self');
        //        }
        //    })
        //}
    });

 }


//  function ListLoad(listOfApprove) {
//         //myArr = ['Electronics Watch','House wear Items','Kids wear','Women Fashion'];
//       //  debugger;
//        //document.getElementById("contentSectionID").appendChild(createApprList(myArr));
//        //var approveList = [];
//        var approveList = listOfApprove.split('µ');
//// assign values to array
////approveList = ["P.R.K.VSHPµNT091000542µNEW NORMS FOR PROVIDING LAPTOP","VVVKVPPµNT091000542µNEW NORMS FOR PROVIDING LAPTOP","JTµNT091000542µNEW NORMS FOR PROVIDING LAPTOP","JTµNT091000542µNEW NORMS FOR PROVIDING LAPTOP","JTµNT091000542µNEW NORMS FOR PROVIDING LAPTOP","JTµNT091000542µNEW NORMS FOR PROVIDING LAPTOP"];
  
//// define the function 
//    //MKµ69µCrf For Branch Openingµ2µ0¥0¥5¥19¥30¥36
//     var listLength = approveList.length;
  
  
//  //if(listLength>0){
    
//    // Create the Unordered list if there are elements present in the array  
//     // debugger;
    
//    // iterate through the array 
//    //  for (var i = 0; i < listLength; i++){
//           var splitApproveList;
//          //splitApproveList = approveList[i].split('µ');
//            //<span class="alert-icon1 bg-transparent">
//            //<i class="far fa-share-square"></i></span>
//          //<a class="btn-circle btn btn-info" href="javascript:void(0)">SS</a>
//          var alertSpan1 = document.createElement("span");
//          alertSpan1.className = "alert-icon1 bg-transparent";
//       //   var iItem1 = document.createElement("i");

//       //iItem1.className="far fa-share-square";
//          var aItem2 = document.createElement("a");
//          if (approveList[3] == 1) {aItem2.className = "btn btn-circle btn-danger";}
//          else if (approveList[3] == 2) { aItem2.className = "btn btn-circle btn-orange"; }
//          else if(approveList[3] == 3) {aItem2.className = "btn btn-circle btn-info";}


//          aItem2.setAttribute('href', 'javascript:void(0)');
//          var aValue2 = document.createTextNode(approveList[0]);
//          aItem2.appendChild(aValue2); 
//          alertSpan1.appendChild(aItem2); 
//          //alertSpan1.appendChild(iItem1); 

//          var alertDiv = document.createElement("div");
//      //    if (i == 0) {
//      //         alertDiv.className = "alert alert-pending clearfix";
//      //    }
//      //else
//      //    {
//              alertDiv.className = "alert alert-pending";

//          //}
          
//          var myDiv = document.createElement("div");
//          myDiv.className = "notification-info";

          
//         var myList = document.createElement("ul");
    
//    // add a class name to list
//    myList.className="clearfix notification-meta";
      
//      // create list item for every element 
//      var listItem = document.createElement("li");

//        listItem.className = "pull-left notification-sender";

//       // var iItem = document.createElement("i");

//       //iItem.className="fa fa-circle m-r-5 text-cyan font-12";
//       // listItem.appendChild(iItem); 

//        //<p>
//        //<span><a href="#">NT091000542-NEW NORMS FOR PROVIDING LAPTOP</a>
//        //</span>
//        //</p>
//        //<p>
//        //Pending for Recommendation
//        //</p>
//        //</li>

//        //<li class="pull-right notification-time">10 min ago</li>

//          var pItem1 = document.createElement("p");
//          var span1 = document.createElement("span");
//          var aItem1 = document.createElement("a");
//          //pItem1.appendChild(span1); 
//           aItem1.setAttribute('href', '#');
//           //aItem1.setAttribute('onclick', 'displayIframe("' + url + '")');
//         //aItem1.addEventListener("click", func, false); 
//          aItem1.onclick = function () { func();/*alert("Hi clicked")*/};
//        // create a text node to store value
//         var aValue = document.createTextNode(approveList[1]);
//           aItem1.appendChild(aValue); 
//          span1.appendChild(aItem1); 
//          pItem1.appendChild(span1); 
//    var pItem2 = document.createElement("p");
//    var maxLength = 20;
//var subj = approveList[2].substring(0, maxLength) + '...';
//          var pValue2 = document.createTextNode(subj);
//          pItem2.appendChild(pValue2);

//      // create a text node to store value
//      //var listValue = document.createTextNode(approveList[i]);
      
//      // append the value in the list item
//        listItem.appendChild(pItem1); 
//listItem.appendChild(pItem2); 
        
//      // append the list item in the list
//          myList.appendChild(listItem);
//          var listItem1 = document.createElement("li");

//          listItem1.className = "pull-right notification-time";

//    var listValue1 = document.createTextNode("10 min ago");

//          listItem1.appendChild(listValue1); 

//          myList.appendChild(listItem1);
//          myDiv.appendChild(myList); 
//          alertDiv.appendChild(alertSpan1);
//          alertDiv.appendChild(myDiv);
          
//         parentDiv.appendChild(alertDiv); 
//    //}

      
//    // append the list in the container
//    //container.appendChild(myList);
    
// // }

//  //else {
    
//  //  // Create a text node with the message
//  //  var message = document.createTextNode("No Friends");
//  //   document.getElementById("contentSectionID").appendChild(message);
//  //  // Append the message to the container
//  //  //container.appendChild(message);    
//  //  }
//    }
</script>
<style>
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

<style>
 .radio-tile-group {
	 display: flex;
	 flex-wrap: wrap;
	 justify-content: center;
}
 .radio-tile-group .input-container {
	 position: relative;
	 height: 2.5rem;
	 width: 7rem;
	 margin: 0.5rem;
}
 .radio-tile-group .input-container .radio-button {
	 opacity: 0;
	 position: absolute;
	 top: 0;
	 left: 0;
	 height: 100%;
	 width: 100%;
	 margin: 0;
	 cursor: pointer;
}
 .radio-tile-group .input-container .radio-tile {
	 display: flex;
	 flex-direction: column;
	 align-items: center;
	 justify-content: center;
	 /*width: 100%;*/
	 height: 100%;
	 border: 2px solid #079ad9;
	 border-radius: 5px;
	 /*padding: 1rem;*/
	 transition: transform 300ms ease;
}

 .radio-tile-group .input-container .radio-tile-label {
	 text-align: center;
	 font-size: 0.75rem;
	 font-weight: 400;
	 /*text-transform: uppercase;*/
	 letter-spacing: 1px;
	 color: #079ad9;
     margin-bottom: 0;
}
 .radio-tile-group .input-container .radio-tile-i {
	 color: #079ad9;
}
 .radio-tile-group .input-container .radio-button:checked + .radio-tile {
	 background-color: #079ad9;
	 border: 2px solid #079ad9;
	 color: white;
	 transform: scale(1.1, 1.1);
}
 .radio-tile-group .input-container .radio-button:checked + .radio-tile .icon svg {
	 fill: white;
	 background-color: #079ad9;
}
 .radio-tile-group .input-container .radio-button:checked + .radio-tile .radio-tile-label {
	 color: white;
	 background-color: #079ad9;
}
 .radio-tile-group .input-container .radio-button:checked + .radio-tile .radio-tile-i {
	 color: white;
}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="row"  id="divContentHide">
<div class="col-md-3 ">
<div class="card card-5 animated bounceIn">  
<div class="loaderColor">
<div class="loaderColor--dot"></div>
<div class="loaderColor--dot"></div>
<div class="loaderColor--dot"></div>
<div class="loaderColor--dot"></div>
<div class="loaderColor--dot"></div>
<div class="loaderColor--dot"></div>
<div class="loaderColor--text"></div>
</div>
<section class="panel vh-75 scrollable"  id="contentSectionID">
</section>
</div>  
</div>
<div class="col-md-9">
<div class="card animated bounceIn " style="background-color: #e5e5e5;">
<div class="loaderColorCont">
<div class="loaderColorCont--dot"></div>
<div class="loaderColorCont--dot"></div>
<div class="loaderColorCont--dot"></div>
<div class="loaderColorCont--dot"></div>
<div class="loaderColorCont--dot"></div>
<div class="loaderColorCont--dot"></div>
<div class="loaderColorCont--text"></div>
</div>
<form class="form-horizontal" runat="server" method="post" enctype="multipart/form-data">   
<section class="panel <%--vh-75 scrollable--%>"  id="contentDivID" >

<div class="card-header" style="background: #b7b7b7;">
<div class="row">
<div class="col-md-6 text-left font-12" >
<div class="form-group">
<div class="col-md-3" id="sNameDiv">
<%--    <div class="ms-Persona-imageArea" style="float: left;">
    <div class="ms-Persona-initials ms-Persona-initials--red">LA
    </div>
    </div> --%>
</div>
<div class="col-md-9"><strong><span id="lblCreateBy" class="head5 text-primary"<%--class="font-12"--%> style="margin-left: 10px;margin-top: -40px;"></span><br><span id="lblDepartment" style="margin-left: 10px;margin-top: -40px;" class="head7"></span></strong></div>
   
</div>
</div>
<div class="col-md-6" >
Note ID : <span id="lblNoteId" class ="head6 text-primary"></span><input type="hidden" name="NoteId" id="hdnNoteId"><input type="hidden" name="NoteOrderId" id="hdnNoteOrderId"> &nbsp&nbsp&nbsp&nbsp<strong><span class="label label-rounded" id="lblPriority"></span></strong>&nbsp&nbsp&nbsp&nbsp<strong><span id="lblNature" class="label label-primary font-12"></span></strong>
</div>

</div>
<div class="row">
<div class="col-md-12" >
<div class="form-group">Subject : 
<span id="lblSubject"  class ="head6 text-primary"></span>
</div>
</div>
</div>



<div class="row">
<div class="col-md-3 font-10" >
<div class="form-group">Created Date  : <span id="lblCreateDate" class="font-10 text-maroon"></span></div>
</div>
<div class="col-md-3 font-10" >
<div class="form-group">Assigned Date : <span id="lblAssignDate" class="font-10 text-maroon"></span></div>
</div>
 
<div class="col-md-3 font-11">
<div class="form-group">Note Type : <strong><span id="lblDocType" class="font-11 text-maroon"></span></strong></div>
</div>
<div class="col-md-3 font-11">
 <div class="form-group">Firm : <strong><span id="lblFirm" class="font-11 text-maroon"></span></strong></div>
</div>    
</div>

<div class="row">
<%--<div class="col-md-6 text-left font-12">
<div class="form-group">Department : </div> 
</div>--%>
<div class="col-md-12 text-left font-12">
<div id="divRemarks"><strong> <%--<span id="lblRemarks" class="font-12"></span>--%></strong>
</div>
</div>
</div>
<div class="row">
<div class="col-md-12 text-left font-12">

</div>
</div>

</div>
<div class="card-body " >
 <div class="row">
<div class="col-md-12 text-center">
    <%--<img src="../../assets/images/alert/model2.png" alt="Note Content" data-toggle="modal" data-target=".bs-example-modal-lg" class="model_img img-fluid" onclick="ShowContent();"/>--%>
<%--<button type="button" class="btn btn-outline-primary btn-rounded font-10" data-toggle="modal" data-target=".bs-example-modal-lg" onclick="ShowContent();" ><i class="fa fa-file-alt"></i>Show Content</button>--%>
<button type="button" class="btn btn-outline-primary btn-rounded font-10" onclick="ShowContent();" ><i class="fa fa-file-alt"></i> Show Content</button>
   
<button type="button" id="btnAttach" class="btn btn-outline-primary btn-rounded1 font-10" data-toggle="modal" data-target=".bs-example-modal-lg1" onclick="ShowContentFiles();" ><i class="fa fa-paperclip"></i> Show Attachments<span class="badge3 badge-danger" id="attachCount">0</span></button>
<button type="button" class="btn btn-outline-primary btn-rounded font-10" data-toggle="modal" data-target=".bs-example-modal-lg2" onclick="ShowContentFlow();" ><i class="fa fa-users"></i> Workflow History</button>
</div>
<%--<div class="col-md-4 text-center">    
   </div>--%>
<%--<div class="col-md-4 text-left">--%>
    <%--<img src="../../assets/images/alert/model2.png" alt="Note Content" data-toggle="modal" data-target=".bs-example-modal-lg" class="model_img img-fluid" onclick="ShowContent();"/>--%>
  <%-- </div>--%>
</div>


</div>
<div class="animated bounceIn" style="background-color: #e5e5e5;">

<div class="row">
<div class="col-md-12" id="lstApprovers">
<%--<ul class="multi-steps">
    <li class="li-bar" data-toggle="tooltip" title="Recommended on 10-Aug-2019 10:00:52 am">Minnu</li>
    <li class="li-bar" data-toggle="tooltip" title="Not Recommended on 11-Aug-2019 12:00:52 am">Durga</li>
    <li class="li-bar is-active" data-toggle="tooltip" title="Assigned on 12-Aug-2019 9:00:52 am">John</li>
    <li class="li-bar">Lima</li>
    <li class="li-bar">Lima</li>
    <li class="li-bar">Lima</li>
    <li class="li-bar">Lima</li>
    <li class="li-bar">Lima</li>
    <li class="li-bar">Lima</li>
  </ul>--%>
</div>  
</div>

</div>
<div class="animated bounceIn">
<%--<div class="row" id="showBtnsRec">
<div class="col-md-4 col-lg-2" id="showRecBtn">
<button type="button" id="btnRecommend" class="btn waves-effect waves-light btn-primary btn-rounded" style="width: 100%;
"><i class="fa fa-thumbs-up"></i> Recommend</button>
</div>
<div class="col-md-6 col-lg-3" id="showNotRecBtn">
<button type="button" id="btnNotRecommend" class="btn waves-effect waves-light btn-primary btn-rounded" style="width: 100%;
"><i class="fa fa-thumbs-down"></i> Not Recommend</button>
</div>
<div class="col-md-4 col-lg-2" id="showBackBtn">
<button type="button" id="btnRedirect" class="btn waves-effect waves-light btn-primary btn-rounded" style="width: 100%;
"><i class="fa fa-user-plus"></i> Redirect</button>
</div>
</div>
<div class="row" id="showBtnsAppr">
<div class="col-md-4 col-lg-2" id="showApprBtn">
<button type="button" id="btnApprove" class="btn waves-effect waves-light btn-primary btn-rounded" style="width: 100%;
"><i class="fa fa-thumbs-up"></i> Approve</button>
</div>
<div class="col-md-4 col-lg-2" id="showForBtn">
<button type="button" id="btnForward" class="btn waves-effect waves-light btn-primary btn-rounded" style="width: 100%;
"><i class="fa fa-share"></i> Forward</button>
</div>
<div class="col-md-4 col-lg-2" id="showRejBtn">
<button type="button" id="btnReject" class="btn waves-effect waves-light btn-primary btn-rounded" style="width: 100%;
"><i class="fa fa-times"></i> Reject</button>
</div>
</div>--%>
    <div class="radio-tile-group" id="showBtnRet" style="text-align:right">
<div class="input-container" id="showAddAppr">
<input id="btnAddAppr" class="radio-button" type="checkbox" name="radio" />
<div class="radio-tile">       
<label for="btnAddAppr" class="radio-tile-label"><i class="fa fa-user-plus"></i>  Add Approver</label>
</div>
</div>
</div>

<div class="radio-tile-group" id="showBtnsRec">
<div class="input-container" id="showRecBtn">
<input id="btnRecommend" class="radio-button" type="radio" name="radio" />
<div class="radio-tile">        
<label for="btnRecommend" class="radio-tile-label" ><i class='fa fa-thumbs-up radio-tile-i'id="iRecommend" ></i>  Recommend</label>
</div>
</div>
<div class="input-container" id="showNotRecBtn">
<input id="btnNotRecommend" class="radio-button" type="radio" name="radio" />
<div class="radio-tile">        
<label for="btnNotRecommendv" class="radio-tile-label"><i class="fa fa-thumbs-down"></i>  Not Recommend</label>
</div>
</div>
<div class="input-container" id="showBackBtn">
<input id="btnRedirect" class="radio-button" type="radio" name="radio" />
<div class="radio-tile">       
<label for="btnRedirect" class="radio-tile-label"><i class="fa fa-user-plus"></i>  Redirect</label>
</div>
</div>
<div class="input-container" id="showRecReturnBtn">
<input id="btnRecReturn" class="radio-button" type="radio" name="radio" />
<div class="radio-tile">       
<label for="btnRecReturn" class="radio-tile-label"><i class="fa fa-reply"></i>  Return</label>
</div>
</div>
<div class="input-container" id="showRecDiscussBtn">
<input id="btnRecDiscuss" class="radio-button" type="radio" name="radio" />
<div class="radio-tile">       
<label for="btnRecDiscuss" class="radio-tile-label"><i class="fa fa-comments"></i>  Need Discussion</label>
</div>
</div>
</div>



<div class="radio-tile-group" id="showBtnsAppr">
<div class="input-container"  id="showApprBtn">
<input id="btnApprove" class="radio-button" type="radio" name="radio" />
<div class="radio-tile">        
<label for="btnApprove" class="radio-tile-label"><i class="fa fa-thumbs-up"></i>  Approve</label>
</div>
</div>
<div class="input-container" id="showApprNotedBtn">
<input id="btnApprNoted" class="radio-button" type="radio" name="radio" />
<div class="radio-tile">       
<label for="btnApprNoted" class="radio-tile-label"><i class="fa fa-pen-square"></i>  Noted</label>
</div>
</div>
<%--<div class="input-container" id="showApprForwdBtn">
<input id="btnApprForwd" class="radio-button" type="radio" name="radio" />
<div class="radio-tile">       
<label for="btnApprForwd" class="radio-tile-label"><i class="fa fa-location-arrow"></i>  Approve & Forward</label>
</div>
</div>--%>
<div class="input-container"  id="showForBtn">
<input id="btnForward" class="radio-button" type="radio" name="radio" />
<div class="radio-tile">        
<label for="btnForward" class="radio-tile-label"><i class="fa fa-share"></i>  Forward</label>
</div>
</div>

<div class="input-container" id="showApprRedirBtn">
<input id="btnApprRedirect" class="radio-button" type="radio" name="radio" />
<div class="radio-tile">       
<label for="btnApprRedirect" class="radio-tile-label"><i class="fa fa-user-plus"></i>  Redirect</label>
</div>
</div>
<div class="input-container" id="showRejBtn">
<input id="btnReject" class="radio-button" type="radio" name="radio" />
<div class="radio-tile">        
<label for="btnReject" class="radio-tile-label"><i class="fa fa-ban"></i>  Reject</label>
</div>
</div>
<div class="input-container" id="showApprReturnBtn">
<input id="btnApprReturn" class="radio-button" type="radio" name="radio" />
<div class="radio-tile">
<label for="btnApprReturn" class="radio-tile-label"><i class="fa fa-reply"></i>  Return</label>
</div>
</div>
<div class="input-container" id="showApprDiscussBtn">
<input id="btnApprDiscuss" class="radio-button" type="radio" name="radio" />
<div class="radio-tile">       
<label for="btnApprDiscuss" class="radio-tile-label"><i class="fa fa-comments"></i>  Need Discussion</label>
</div>
</div>


</div>

    <div class="row" id="showEmpForward">
<div class="col-md-12">
<div class="col-md-12" id="parallelrow">
<div class="row" id="p_rowid"><div class="col-md-2"><div class="form-group"><b>Add Employee</b></div></div><div class="col-md-8 employee-id-row"><div class="form-group"><div class="all-emp" id="r_emp1"></div><div class="autocomplete" style="width:50%;" align="left"><input id="txtEmpCode1" autocomplete="off" class="text-uppercase" style="border-top: none;border-left: none;width:100%" name="search" placeholder="Search Employee.." onkeyup="SearchDataAutoCompleteEmpSingle(this.id, this.value,'2','hdnEmpCodeRec1','PWAAPP','GetEmployeeNote' ,'r_emp1')" type="text"></div></div></div><div class="col-md-2"><input id="hdnEmpCodeRec1" type="hidden"><input id="hdnApprType1" value="S" class="hdnApprType" type="hidden"></div></div>
</div>
</div>
</div>

<div class="row" id="showEmpForwardRed">
<div class="col-md-12">
<div class="col-md-12" id="parallelrowRed">
<%--<div class="row" id="p_rowid"><div class="col-md-2"><div class="form-group"><b>Add Employee</b></div></div><div class="col-md-8 employee-id-row"><div class="form-group"><div class="all-emp" id="r_emp1"></div><div class="autocomplete" style="width:50%;" align="left"><input id="txtEmpCode1" autocomplete="off" class="text-uppercase" style="border-top: none;border-left: none;width:100%" name="search" placeholder="Search Employee.." onkeyup="SearchDataAutoCompleteEmpSingle(this.id, this.value,'2','hdnEmpCodeRec1','PWAAPP','GetEmployeeNote' ,'r_emp1')" type="text"></div></div></div><div class="col-md-2"><input id="hdnEmpCodeRec1" type="hidden"><input id="hdnApprType1" value="S" class="hdnApprType" type="hidden"></div></div>--%>
</div>
</div>
</div>

<div class="row" id="showEmpReturn">
<div class="col-md-2">
<div class="form-group">
<label for="ddlEmp">Select Employee : <span class="text-danger">*</span></label>
</div>
</div>
<div class="col-md-4">
<div class="form-group">
<div class="div-select-dark">
  <select class="select-dark" name="Employee" id="ddlEmp">
  </select>
</div>
</div>
</div>
<%--<div class="col-md-6 text-left" id="divNeedMoreDocs">
<div class="form-group">
<label for="chkMoreDocument">Need More Documents?  :</label>
<input type="checkbox" class="toggle" id="chkMoreDocument" />
<label for="chkMoreDocument">
  <span class="on">Yes</span>
  <span class="off">No</span>
</label>
</div>
</div>--%>

</div>
    <div>
<div class="row" id="showAttach">
<div class="col-md-5">
<div class="form-group">
<label for="rdbNature">Attach File  : </label>  
<div class="file-upload">
<div class="file-select">
<div class="file-select-button" id="fileName">Choose File</div>
<div class="file-select-name" id="noFile">No file chosen...</div> 
<div class="file-chooser">
<input type="file" <%--name="chooseFile" id="fileUploaded"--%> class="file-chooser__input">
</div>
</div>
</div>
<div class="file-uploader__message-area">
<p>Select a file to upload</p>
</div>
</div>
</div>
</div>


</div>
<div class="row" id="showRemarks">
<div class="col-md-12">
<label class="pure-material-textfield-outlined">
    <textarea rows="1" cols="25" name="Remarks" id="txtRemarks" title="Remarks" style="background-color: #fff;">
</textarea>
  <span>Remarks</span>
</label>
</div>
</div>
<div class="row" id="showSubmitBtn">
    <div class="col-md-2 col-sm-2 col-xs-4"> <a href="#" class="btn btn-sm animated-button thar-one btn-primary" style="width: 100%;
margin: 5px;"onclick="return NoteRecommendConfirm();" id="btnSubmit"><i class="fa fa-thumbs-up"></i> Confirm</a> </div>
    <div class="col-md-2 col-sm-2 col-xs-4"> <a href="#" class="btn btn-sm animated-button thar-one btn-red" style="width: 100%;
margin: 5px;" onclick="return frmExit();"><i class="fa fa-sign-out-alt"></i> Exit</a> </div>

</div>
<%--<div class="row">
<div class="col-md-12">
<div class="form-group">     
<div class="buttonbox"> 
<input id="btnconfirm" type="button" value="Recommend" class="btn-input" onclick="return NoteRecommendConfirm();" data-toggle="modal" data-backdrop="false"/>
<input id="btnexit" type="button" value="Exit" class="btn-input" onclick="return frmExit();" data-toggle="modal" data-backdrop="false"/>
   
</div>
</div>
</div>

</div>--%>
<%--<div class="col-md-4">
<div class="form-group">     
     <input id="btnReject" type="button" value="Reject" class="btn-input" onclick="return NoteReject();" data-toggle="modal" data-backdrop="false"/>


</div>
</div>--%>
</div>
</section>
</form> 
</div>




<div class="card" id="contentModel">
<div class="card-body">
<!-- sample modal content -->
<div class="modal bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" style="display: none;" data-keyboard="false" data-backdrop="static">
<div class="modal-dialog modal-max1">
<div class="modal-content">
<div class="modal-header">
<h4 class="modal-title" id="myLargeModalLabel">Note Content</h4>
<button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="HideContent();">×</button>
</div>
<div class="modal-body">
<div class="summernoteview">
</div>
</div>
<div class="modal-footer">
<button type="button" class="btn btn-danger waves-effect text-left" data-dismiss="modal" onclick="HideContent();">Close</button>
</div>
</div>
<!-- /.modal-content -->
</div>
<!-- /.modal-dialog -->
</div>
<!-- /.modal -->
                                
</div>
</div>


<div class="card" id="contentModelFiles">
<div class="card-body">
<!-- sample modal content -->
<div class="modal bs-example-modal-lg1" tabindex="-1" role="dialog" aria-labelledby="lblFiles" aria-hidden="true" style="display: none;" data-keyboard="false" data-backdrop="static">
<div class="modal-dialog modal-xl">
<div class="modal-content">
<div class="modal-header">
<h4 class="modal-title" id="lblFiles">Attached Files</h4>
<button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="HideContentFiles();">×</button>
</div>
<div class="modal-body">
<div class="table-responsive">
<table class="table1 table-hover" id="tblFiles" > 
</table> 
</div>
</div>
<div class="modal-footer">
<button type="button" class="btn btn-danger waves-effect text-left" data-dismiss="modal" onclick="HideContentFiles();">Close</button>
</div>
</div>
<!-- /.modal-content -->
</div>
<!-- /.modal-dialog -->
</div>
<!-- /.modal -->

</div>
</div>

<div class="card" id="contentModelFlow" style="background-color: #e5e5e5;">
<div class="card-body">
<!-- sample modal content -->
<div class="modal bs-example-modal-lg2" tabindex="-1" role="dialog" aria-labelledby="lblFlow" aria-hidden="true" style="display: none;" data-keyboard="false" data-backdrop="static">
<div class="modal-dialog modal-max1">
<div class="modal-content">
<div class="modal-header">
<h4 class="modal-title" id="lblFlow">Work Flow</h4>
<button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="HideContentFlow();">×</button>
</div>
<div class="modal-body vh-75 scrollable">
<div class="card animated bounceIn" style="background-color: #e5e5e5;"  id="WorkFlowSection">  

<section class="timeline1">

</section>

</div>
</div>
<div class="modal-footer">
<button type="button" class="btn btn-danger waves-effect text-left" data-dismiss="modal" onclick="HideContentFlow();">Close</button>
</div>
</div>
<!-- /.modal-content -->
</div>
<!-- /.modal-dialog -->
</div>
<!-- /.modal -->
</div>
</div>



</div>     

</div> 

    



<input id="hdUserId" type="hidden" runat="server"/>
        <input id="hdBranchId" type="hidden" runat="server"/>
        <input id="hdFirmId" type="hidden" runat="server"/>
      <input id="hdnReturnStatus" type="hidden" runat="server"/>
    <input id="hdnAllEmployees" type="hidden" runat="server"/>
    <input id="hdnquerynoteid" type="hidden" runat="server"/>
    <input id="hdnContentNoteId" type="hidden" runat="server"/>
     <input id="hdnReqEmp" type="hidden" runat="server"/>
    <input id="hdnSystemIP" type="hidden" runat="server"/>
     <input id="hdSesssion" type="hidden" runat="server"/>
    <input id="hdEditOption" type="hidden" runat="server"/>
    <input id="hdnDiscussResStatus" type="hidden" runat="server"/>
      <input id="hdEditedContent" type="hidden" runat="server"/>
    <input id="DocTypenew" type="hidden" runat="server"/>
</asp:Content>
