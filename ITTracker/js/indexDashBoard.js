$(window).on('load', function () {
    
    //$(".loader").show();
    $("[id*=hdnNotifyCount]").val("0");
    $("[id*=hdnAlertCount]").val("0")
    $(".loaderColor").show();
   // getNotification();
    getAlert();
    loadbasicpieChart();
    //$(".loader").fadeOut();        
    $(".loaderColor").fadeOut();    
     //setInterval("my_function();", 10000);
    my_function();
    my_Alert($("[id*=hdUserId]").val());
   // Tracker_IndexPage_data($("[id*=hdUserId]").val());
    check_GeneralParameter();
  
    //$('#graphDiv').hide();
    //$('#graphEmptyDiv').show();
    
});

function check_GeneralParameter() {
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "Index.aspx/PendingWorkVerify",
        data: "{pageVal:'GeneralP', pageval1 :'', pageval2 :''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            
            if (Result == "1") {
                $("#pro_det2").hide();
                $("#pro_det").show();
                index_RelatedDetails($("[id*=hdUserId]").val());
                
            }
            else {
                $("#pro_det2").show();
                $("#pro_det").hide();
                //index_RelatedDetails2($("[id*=hdUserId]").val());
                getNotification();
            }
            
        }
    });
}

//function index_RelatedDetails2(usr) {
//    $.ajax({
//        type: "post",
//        contentType: "application/json; charset=utf-8",
//        url: "Index.aspx/PendingWorkVerify",
//        data: "{pageVal:'TakingCount', pageval1 :'" + usr+"', pageval2 :''}",
//        dataType: "json",
//        success: function (Result) {
//            Result = Result.d;
//            if (Result != "123") {
//                var valData = Result.split('~');
//                $("#lb1").text(valData[0]);
//                $("#lb2").text(valData[1]);
//                $("#lb3").text(valData[2]);
//                $("#lb4").text(valData[3]);
//                $("#lb5").text(valData[4]);
//                $("#lb6").text(valData[5]);
//            }
//            else {
                
//            }

//        }
//    });
//}


function index_RelatedDetails(usr) { 
    var sum = 0;
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "Index.aspx/PendingWorkVerify",
        data: "{pageVal:'RelatedDetails', pageval1 :'" + usr + "', pageval2 :''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
           
            if ($("#tbl_Task_List tr").length == 0) {
                $("#tbl_Task_List").empty();
                //$('#tbl_Task_List').append('<tr style="background-color:#1484b6;color:white"><th class="text-center">Project Stage</th><th class="text-center">No.of Projects</th><th class="text-center">On Track</th><th class="text-center">1 to 10 days Delay</th><th class="text-center">11 to 30 days Delay</th><th class="text-center">Above 30 days Delay</th></tr>');
                $('#tbl_Task_List').append('<tr style="background-color:#1484b6;color:white"><th class="text-center">Project Stage</th><th class="text-center">No.of Projects</th><th class="text-center">Delay</th><th class="text-center">1-10 Days Delay</th><th class="text-center">11-30 Days Delay</th><th class="text-center">Above 30 Days Delay</th></tr>');

            }
            var valData;
            valData = Result.split('µ');
            document.getElementById("loader").style.display = "none";
            for (i = 0; i < valData.length - 1; i++) {
                valData1 = valData[i].split('~');
                sum = sum + parseInt(valData1[2]) + parseInt(valData1[3]) + parseInt(valData1[4]);
                if (valData1[0] == 'UNDER QA') {
                    valData1[0] = 'UNDER QA/BUG FIXING';
                }
                $('#tbl_Task_List').append('<tbody><tr class="text-center" >' +
                    '<td><a href="#">' + valData1[0] + '</a></td>' +
                    '<td><a href="#">' + valData1[1] + '</a></td>' +
                    '<td><a href="#">' + sum + '</a></td > ' +
                    '<td><a href="#">' + valData1[2] + '</a></td > ' +
                    '<td><a href="#">' + valData1[3] + '</a></td > ' +
                    '<td><a href="#">' + valData1[4] + '</a></td></tr > </tbody > ');
                sum = 0;
            }
        }
    });
  
}
var datass = "1";
function grT() {   
    var row;
    var column_num;
    $('#tbl_Task_List').find('tr').click(function () {
        row = $(this).find('td:eq(0)').text();
        if (row != "") datass = row;
    });
    $('#tbl_Task_List tbody').on('click', 'td', function () {
        column_num = parseInt($(this).index());
        if (column_num != "") datass = datass + "~" + column_num;
        else datass = datass + "~0";
    });
    if (datass == "1" || datass.includes("~0")) {
        //alert("Please choose again!!");
        return false;
    }
    else if (datass.includes("LIVE & CLOSED")) {
        to_SearchWindow(datass.replace('&', 'AND'));
    }

    else to_SearchWindow(datass);
}
function to_SearchWindow(dtls) {

    window.open("SearchResult.aspx?mnuId=" + dtls + "", '_self');
}



function my_Alert(usr) {
    var option = "";
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "Index.aspx/PendingWorkVerify",
        data: "{pageVal:'GetWorkVerifyAlert', pageval1 :'" + usr + "', pageval2 :''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;

            if (Result == "111") {
                Swal.fire({
                    title: 'Information',
                    text: 'Please Verify work updation of your Team..',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'GO to Verify'
                }).then((result) => {
                    if (result.value == true) {
                        window.open('DailyWorkVerifying.aspx', '_self');
                    }
                })
            }
        }
    });
}
//function Tracker_IndexPage_data(usr) {
//    var splitData;
//    $.ajax({
//        type: "post",
//        contentType: "application/json; charset=utf-8",
//        url: "Index.aspx/PendingWorkVerify",
//        data: "{pageVal:'IndexDetails', pageval1 :'" + usr + "', pageval2 :''}",
//        dataType: "json",
//        success: function (Result) {
//            Result = Result.d;
//            // alert(Result);
//            splitData = Result.split('^');
//            $("#lbl1").text(splitData[0]);
//            $("#lbl2").text(splitData[1]);
//            $("#lbl3").text(splitData[2]);
//            $("#lbl4").text(splitData[3]);
//            $("#lbl5").text(splitData[4]);
//            $("#lbl6").text(splitData[5]);
//        }
//    });
//}


function my_function() {
    //$('#refresh').load(location.href + ' #jotime');
    //$(".loader").show();
    
    $(".loaderColor").show();
    
    getAlert();
    loadbasicpieChart();
    //$(".loader").fadeOut();
    $(".loaderColor").fadeOut();
}

function getNotification() {
    
   
    var Data = '';
    Data = $("[id*=hdBranchId]").val() + 'µ' + $("[id*=hdFirmId]").val() + 'µ' + $("[id*=hdUserId]").val()
   
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "Index.aspx/getListPending",
        data: "{pageVal:'GetDashBoardNotification', pageval1 :'" + Data + "', pageval2 :''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            var lenRow = Result.length;
            var notifyCount = $("[id*=hdnNotifyCount]").val();
            if (lenRow == 0) {
                $('#notifyDiv').hide();
                $('#notifyEmptyDiv').show();
            }
            else if (lenRow != notifyCount) {
                document.getElementById("notifyDiv").innerHTML = "";
                $('#notifyDiv').show();
                $('#notifyEmptyDiv').hide();
                var rowid = 0;
                var firstNote = '';
                
               
                $.each(Result, function (key, value) {
                    var listOfNotify = value.lst;
                    var notifyList = listOfNotify.split('µ');
                    var listLength = notifyList.length;
                    //alert(notifyList[0]);
                    //a.note_id|| 'µ' ||c.subject|| 'µ' ||a.alert||'µ'||a.status||'µ'||trunc(months_between(SYSDATE,a.updated_date)/12)||'¥'||trunc(mod( months_between(SYSDATE,a.updated_date) ,12))||'¥'||trunc(SYSDATE - add_months( a.updated_date, months_between(SYSDATE,a.updated_date)))||'¥'||trunc(24*mod(SYSDATE - a.updated_date,1))||'¥'||trunc( mod(mod(SYSDATE - a.updated_date,1)*24,1)*60 )||'¥'||trunc(mod(mod(mod(SYSDATE - a.updated_date,1)*24,1)*60,1)*60)
                    var notifyDiv1 = document.createElement("div");

                    if (notifyList[3] == "Created") { notifyDiv1.className = "alert alert-requested"; }
                    else if (notifyList[3] == "Recommended") { notifyDiv1.className = "alert alert-recommend"; }
                    else if (notifyList[3] == "Not Recommended") { notifyDiv1.className = "alert alert-reject"; }
                    else if (notifyList[3] == "Rejected") { notifyDiv1.className = "alert alert-reject"; }
                    else { notifyDiv1.className = "alert alert-recommend"; }

                    rowid = rowid + 1;
                    if (rowid == 1) {
                        firstNote = notifyList[0];                        
                    }
                    notifyDiv1.setAttribute('id', 'dival' + notifyList[0]);
                    notifyDiv1.onclick = function () { /*ContentFill(approveList[0]);alert(notifyList[0]);*/ var note = Encrypt(notifyList[0]); window.location = "ViewerNoteDetails.aspx?noteid=" + note; };

                    var notifySpan1 = document.createElement("div");
                    if (notifyList[3] == "Created") { notifySpan1.className = "alert-icon bg-info"; }
                    else if (notifyList[3] == "Recommended") { notifySpan1.className = "alert-icon bg-orange"; }
                    else if (notifyList[3] == "Not Recommended") { notifySpan1.className = "alert-icon bg-danger"; }
                    else if (notifyList[3] == "Rejected") { notifySpan1.className = "alert-icon bg-danger"; }
                    else { notifySpan1.className = "alert-icon bg-orange"; }
                    

                    var notifyI1 = document.createElement("i");
                    notifyI1.className = "far fa-bell";

                    var notifyDiv2 = document.createElement("div");
                    notifyDiv2.className = "notification-info";

                    var myList = document.createElement("ul");

                    // add a class name to list
                    myList.className = "clearfix notification-meta";

                    // create list item for every element 
                    var listItem = document.createElement("li");

                    listItem.className = "pull-left notification-sender";

                    var span1 = document.createElement("span");
                    var aItem1 = document.createElement("a");
                    aItem1.className = "head6 text-maroon";
                    aItem1.setAttribute('href', '#');
                    var aValue = document.createTextNode(notifyList[0]);
                    aItem1.appendChild(aValue);
                    span1.appendChild(aItem1);
                    listItem.appendChild(span1); 

                    var pItem2 = document.createElement("p");
                    var span2 = document.createElement("span");
                    span2.className = "head7 text-primary";
                    var spanValue2 = document.createTextNode(notifyList[1]);
                    span2.appendChild(spanValue2);
                    pItem2.appendChild(span2);
                    listItem.appendChild(pItem2); 

                    var pItem3 = document.createElement("p");
                    var pValue3 = document.createTextNode(notifyList[2]);
                    pItem3.appendChild(pValue3);
                    listItem.appendChild(pItem3);                        

                    myList.appendChild(listItem);
                    

                    var listItem1 = document.createElement("li");

                    listItem1.className = "pull-right notification-time";

                    var listValue1 = document.createTextNode("");
                    var splitTime;
                    splitTime = notifyList[4].split('¥');//5
                    if (splitTime[0] > 0) { listValue1 = document.createTextNode(splitTime[0] + " Years ago"); }
                    else if (splitTime[1] > 0) { listValue1 = document.createTextNode(splitTime[1] + " Months ago"); }
                    else if (splitTime[2] > 0) { listValue1 = document.createTextNode(splitTime[2] + " Days ago"); }
                    else if (splitTime[3] > 0) { listValue1 = document.createTextNode(splitTime[3] + " Hours ago"); }
                    else if (splitTime[4] > 0) { listValue1 = document.createTextNode(splitTime[4] + " Minutes ago"); }
                    else if (splitTime[5] > 0) { listValue1 = document.createTextNode(splitTime[5] + " Seconds ago"); }
                    listItem1.appendChild(listValue1);

                    myList.appendChild(listItem1);

                    notifyDiv2.appendChild(myList);
                    notifySpan1.appendChild(notifyI1);
                    notifyDiv1.appendChild(notifySpan1);

                    notifyDiv1.appendChild(notifyDiv2);
                    

                    document.getElementById("notifyDiv").appendChild(notifyDiv1);
                });
                $("[id*=hdnNotifyCount]").val(rowid);
            }



        },
        error: function (Result) {
        }
    });
}
function getAlert() {
   
    //$('#alertDiv').hide();
    //$('#alertEmptyDiv').show();
    var Data = '';
    Data = $("[id*=hdBranchId]").val() + 'µ' + $("[id*=hdFirmId]").val() + 'µ' + $("[id*=hdUserId]").val()
   
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "Index.aspx/getListPending",
        data: "{pageVal:'GetDashBoardAlert', pageval1 :'" + Data + "', pageval2 :''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            var lenRow = Result.length;
            var AlertCount = $("[id*=hdnAlertCount]").val();
            if (lenRow == 0) {
                $('#alertDiv').hide();
                $('#alertEmptyDiv').show();
            }
            else if (lenRow != AlertCount) {
                document.getElementById("alertDiv").innerHTML = "";
                $('#alertDiv').show();
                $('#alertEmptyDiv').hide();
                var rowid = 0;
                var firstNoteAlert = '';
     

                $.each(Result, function (key, value) {

                    var listOfAlert = value.lst;
                    var alertList = listOfAlert.split('µ');
                    var listLength = alertList.length;
                    //alert(notifyList[0]);
                    //substr(replace (translate (initcap (REGEXP_REPLACE(REGEXP_REPLACE(a.creater_name,'[.]',' '), '[^0-9A-Za-z .]', '')), ' abcdefghijklmnopqrstuvwxyz', ' '), ' '),1,2)||'µ'||a.note_id||'µ'||initcap (a.subject)||'µ'||a.priority||'µ'||trunc(months_between(SYSDATE,c.received_date)/12)||'¥'||trunc(mod( months_between(SYSDATE,c.received_date) ,12))||'¥'||trunc(SYSDATE - add_months( c.received_date, months_between(SYSDATE,c.received_date)))||'¥'||trunc(24*mod(SYSDATE - c.received_date,1))||'¥'||trunc( mod(mod(SYSDATE - c.received_date,1)*24,1)*60 )||'¥'||trunc(mod(mod(mod(SYSDATE - c.received_date,1)*24,1)*60,1)*60)
                    var alertDiv1 = document.createElement("div");
                    alertDiv1.className = "alert alert-pending";
            
                    rowid = rowid + 1;
                    if (rowid == 1) {
                        firstNoteAlert = alertList[1];
                    }

                    alertDiv1.setAttribute('id', 'divalert' + alertList[1]);
                    
                    var alertSpan1 = document.createElement("div");
                    alertSpan1.className = "ms-Persona-imageArea";
                    var aItem2 = document.createElement("div");
                    if (alertList[3] == 1) { aItem2.className = "ms-Persona-initials ms-Persona-initials--red"; }
                    else if (alertList[3] == 2) { aItem2.className = "ms-Persona-initials ms-Persona-initials--orange"; }
                    else if (alertList[3] == 3) { aItem2.className = "ms-Persona-initials ms-Persona-initials--yellow"; }
                    aItem2.innerHTML = alertList[0];
                    alertSpan1.appendChild(aItem2); 
                    var alertDiv2 = document.createElement("div");
                    alertDiv2.className = "notification-info";

                    var myList = document.createElement("ul");
                    myList.className = "clearfix notification-meta";
                    var listItem = document.createElement("li");

                    listItem.className = "pull-left notification-sender";

                    var span1 = document.createElement("span");
                    var aItem1 = document.createElement("a");
                    aItem1.className = "head6 text-maroon";
                    aItem1.setAttribute('href', '#');
                    var aValue = document.createTextNode(alertList[1]);
                    aItem1.appendChild(aValue);
                    span1.appendChild(aItem1);
                    listItem.appendChild(span1);

                    var pItem2 = document.createElement("p");
                    var span2 = document.createElement("span");
                    span2.className = "head7 text-primary";
                    var spanValue2 = document.createTextNode(alertList[2]);
                    span2.appendChild(spanValue2);
                    pItem2.appendChild(span2);
                    listItem.appendChild(pItem2);

                    var pItem3 = document.createElement("p");
                    var pVal = "";
                
                   
                    if (alertList[9] == "000") {
                        pVal = "Pending for HOD Recommendation";
                    }
                    else if (alertList[9] == "111") {
                        pVal = "Pending Edit CRF";
                    }
                    else if (alertList[9] == "222") {
                        pVal = "Pending for Technical Analysis";
                    }
                    else if (alertList[9] == "333") {
                        pVal = "Pending for UAT";
                    }
                    else if (alertList[9] == "444") {
                        pVal = "Pending for User Feed back";
                    }
                    else if (alertList[9] == "555") {
                        pVal = "Pending for Testing TA";
                    }
                    else if (alertList[9] == "666") {
                        pVal = "Pending for Test work Assign";
                    }
                    else if (alertList[9] == "777") {
                        pVal = "Pending for Developer Updation";
                    }
                    else if (alertList[9] == "888") {
                        pVal = "Pending for Feed back Request";
                    }
                    else if (alertList[9] == "999") {
                        pVal = "Pending in Bug Tracking Tool";
                    }
                    else if (alertList[9] == "123") {
                        pVal = "Pending in Code Review Stage";
                    }
                    else if (alertList[9] == "456") {
                        pVal = "Pending in Documents Upload/Verification";
                    }
                    else if (alertList[9] == "678") {
                        pVal = "Pending in Code Review";
                    }
                    else {
                        pVal = "Pending for Recommendation";
                    }
                    var pValue3 = document.createTextNode(pVal);
                    pItem3.appendChild(pValue3);


                    var pItem4 = document.createElement("p");

                    var span4 = document.createElement("span");
                    span4.className = "text-info";
                    var spanValue4 = document.createTextNode("CRF Created By " + alertList[8]);
                    span4.appendChild(spanValue4);
                    pItem4.appendChild(span4);

                    //var pVal4 = ;

                    //var pValue4 = document.createTextNode(pVal4);
                    //pItem4.appendChild(pValue4);

                    listItem.appendChild(pItem3);
                    listItem.appendChild(pItem4);
                    myList.appendChild(listItem);


                    var listItem1 = document.createElement("li");

                    listItem1.className = "pull-right notification-time";

                    var listValue1 = document.createTextNode("");
                    var splitTime;
                    splitTime = alertList[4].split('¥');//5
                    if (splitTime[0] > 0) { listValue1 = document.createTextNode(splitTime[0] + " Years ago"); }
                    else if (splitTime[1] > 0) { listValue1 = document.createTextNode(splitTime[1] + " Months ago"); }
                    else if (splitTime[2] > 0) { listValue1 = document.createTextNode(splitTime[2] + " Days ago"); }
                    else if (splitTime[3] > 0) { listValue1 = document.createTextNode(splitTime[3] + " Hours ago"); }
                    else if (splitTime[4] > 0) { listValue1 = document.createTextNode(splitTime[4] + " Minutes ago"); }
                    else if (splitTime[5] > 0) { listValue1 = document.createTextNode(splitTime[5] + " Seconds ago"); }
                    listItem1.appendChild(listValue1);

                    myList.appendChild(listItem1);

                    alertDiv2.appendChild(myList);
                    //notifySpan1.appendChild(notifyI1);
                    alertDiv1.appendChild(alertSpan1);

                    alertDiv1.appendChild(alertDiv2);

                    alertDiv1.onclick = function () {
                        //alert(alertList[9]);
                        var note = Encrypt(alertList[1]);
                        if (alertList[9] == "000") {  window.location = "CRFHODApprove.aspx?crfid=1" }
                        else if (alertList[9] == "111") {  window.location = "CrfContentUserEdit.aspx?crfid=1" }
                        else if (alertList[9] =="222") { window.location = "TechnicalAnalysis.aspx?crfid=1" }
                        else if (alertList[9] == "333") { window.location = "uatlink.aspx" }
                        else if (alertList[9] == "444") { window.location = "userfeedback.aspx" }
                        else if (alertList[9] == "555") { window.location = "TechnicalAnalysisTesting.aspx?crfid=1" }
                        else if (alertList[9] == "666") { window.location = "Testing_Work_assign.aspx" }
                        else if (alertList[9] == "777") { window.location = "DeveloperUpdation.aspx?crfid=1" }
                        else if (alertList[9] == "888") { window.location = "CRFFeedbackRequest.aspx" }
                        else if (alertList[9] == "999") { window.location = "CRFTestResult.aspx" }
                        else if (alertList[9] == "123") { window.location = "CRF_CodeReview.aspx" }
                        else if (alertList[9] == "456") { window.location = "Documentation_upload.aspx" }
                        else if (alertList[9] == "678") { window.location = "CRF_CodeReview.aspx" }
                        
                    };



                    document.getElementById("alertDiv").appendChild(alertDiv1);
                });

            }



        },
        error: function (Result) {
        }
    });
}
function Encrypt(value) {
    var result = "";
    for (i = 0; i < value.length; i++) {
        if (i < value.length - 1) {
            result += value.charCodeAt(i) + 10;
            result += "-";
        }
        else {
            result += value.charCodeAt(i) + 10;
        }
    }
    return result;
}

function loadbasicpieChart() {
    var Option = "";
    Data = $("[id*=hdBranchId]").val() + 'µ' + $("[id*=hdFirmId]").val() + 'µ' + $("[id*=hdUserId]").val();
    
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "Index.aspx/pieChart1",
        data: "{typ:'', val1 :'" + Data +"'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            Option = Result;

            basicpieChart1(Option);
           
        }
    });
}
function basicpieChart1(Option) {
    "use strict";
    var basicpieChart = echarts.init(document.getElementById('basic-pie1'));
    basicpieChart.setOption(Option);
}