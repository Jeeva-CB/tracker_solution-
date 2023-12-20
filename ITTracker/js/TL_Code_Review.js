
var tot = 0;
var days = "";
var f = 0;
var c;
var accessility = 0;
$(window).on('load', function () {
   // alert("fdd");

    accessibility_Check();
   // alert("afsg");
    //DevLoad();
    
    CRFLoad();

   

    
    $("#Doc").hide();
    $("#Doc1").hide();
    $("#lblstaDt").datepicker({ dateFormat: 'dd-MM-y', minDate: 0, changeMonth: true, changeYear: true, stepMonths: true, todayHighlight: true, onSelsect: function (dateText, inst) { } });
    $("#lblendDt").datepicker({ dateFormat: 'dd-MM-y', minDate: 0, changeMonth: true, changeYear: true, stepMonths: true, todayHighlight: true, onSelsect: function (dateText, inst) { } });
    // $("#tardt").datepicker({ dateFormat: 'dd-MM-y', minDate: 0, changeMonth: true, changeYear: true, stepMonths: true, todayHighlight: true, onSelsect: function (dateText, inst) { } });
    $("#startdt").datepicker({
        dateFormat: 'dd/MM/yy',
        changeMonth: true,
        changeYear: true,
        stepMonths: true,
        todayHighlight: true,
        onSelect: function (dateText, inst) {
        }

    });
    $("#tardt").datepicker({
        dateFormat: 'dd/MM/yy',
        changeMonth: true,
        changeYear: true,
        stepMonths: true,
        todayHighlight: true,
        onSelect: function (dateText, inst) {
        }

    });




  



});


function CRFLoad() {

    var usr = $("[id*=hdUserId]").val();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "frm_techLead_code_review.aspx/getCrfFillData",
        data: "{pageVal:'TechLeadCodeReviewCrf', pageval1 :'" + usr + "',pageval2 : '" + accessility + "'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            // $('#ddlCrf').append($("<option selected disabled></option>").val("-1").html("Choose CRF"));
            $.each(Result, function (key, value) {
                $('#ddlCrf').append($("<option></option>").val(value.id).html(value.name));
            });
        }
    });
}





function DevLoad() {
    //alert("dsfhj");
    var usr = $("[id*=hdUserId]").val();
    //alert(usr);
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "frm_techLead_code_review.aspx/getFillData",
        data: "{pageVal:'TechLeadCodeReviewDev', pageval1 :'" + usr + "'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            $.each(Result, function (key, value) {
                $('#ddlDev').append($("<option></option>").val(value.id).html(value.name));
            });
        }
    });
}


function filldescription() {
   // alert("asdfg");
   
     var dtl = $("#ddlCrf").val(); 

  


   
    CRFSearch();
 // alert("grehkyet");
    var usr = $("[id*=hdUserId]").val();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "frm_techLead_code_review.aspx/fillReviewDes",
        data: "{pageVal:'TechLeadCodeReviewDes', pageval1 :'" + usr + "',pageval2 :'" + accessility + "',pageval3 :'" + dtl + "'}",
        dataType: "json",
        success: function (Result) {
            if (Result.d != "") {

                valData = Result.d;


                fillTable(valData);
            }
            else {
                alert(Result);
            }
        },
        error: function (Result) {

            alert(Result);
        }
    });
}

function fillTable(data) {



    var valData, valData1;
    valData = data.split('Θ');

    if (valData.length > 0) {

        //$('#dvData').show();
        //$("#tbCustomerData").show();
        $("#tbCustomerData").empty();

        $('#tbCustomerData').append('<thead class="bg-success text-white">' +
            '<th> <input class="form-control input-sm align-right" id="chkall" name="Paymntall" type="checkbox" onclick="Payall()" />All</th> ' +
            '<th>Description</th> ' +
            //'<th> PO Id</th> ' +
            //'<th>Vendor Id</th>' +
            //'<th>Vendor Name</th> ' +
            //'<th>Total Amount </th> ' +
            //'<th>Invoice Date</th> ' +
            //'<th>Description</th> ' +
            //'<th>User Id</th> ' +

            '</thead>/<tbody class="border border-dark">');

        for (i = 0; i < valData.length - 1; i++) {

            valData1 = valData[i].split('^');

            $('#tbCustomerData').append('<tr>' +
                '<td><input class="form-control input-sm align-right " id="chkbx' + (i + 1) + '"  name="Pay" type="checkbox" onclick="showdate(' + i + ')"/></td>' +

                '<td>' + valData1[0] + '</td>' +
                '<td style="display:none">' + valData1[1] + '</td>' +
                //'<td>' + valData1[2] + '</td>' +
                //'<td>' + valData1[3] + '</td>' +
                //'<td>' + valData1[4] + '</td>' +
                //'<td>' + valData1[5] + '</td>' +
                //'<td>' + valData1[6] + '</td>' +
                //'<td>' + valData1[7] + '</td>' +
                //'<td class="text-center" style="width:auto"><button type="button" style="width:100px"  id="confbut' + (i + 1) + '" onclick=viewInvoice("' + valData1[0] + '","' + (i + 1) + '")>VIEW</button></td>' +
                '</tr>');

        }
        $('#tbCustomerData').append('</tbody >');

    }

    else {

        //$('#div5').hide();

        $("#tbCustomerData").empty();

        alert('No data found');
    }

}
  
function confirm() {
   // alert("dsfdgndhm");
  //  alert(accessility);
    if (accessility == 1) {
        var flag = 'TLCODEREVIEWCNFM';
    }
    else { var flag = 'TLCODEREVIEWDEVCNFM'; }
   
   
    dtl = $("#ddlCrf").val();
   // dev = $("#ecode").value.text
    dev = $("#ecode").text();
   // dev = '358191';
        //$("#ecode").text();
  //  alert(dev);
    //var dev = $('#ddlDev option:selected').text();

    var l;
    var tblAmntData = '';
    var usr = $("[id*=hdUserId]").val();
    var data = dev+'^'+usr;
    var table = document.getElementById("tbCustomerData");
    var l = $("#tbCustomerData tr").length;
    //alert(l);
    var b = chk();
   
    for (i = 1; i < l; i++) {

        if ($('#chkbx' + i).prop('checked')) {
            tblAmntData = tblAmntData + table.rows[i].cells[2].innerText + '!';
            //alert(tblAmntData);
        }
        
    }
    if (b == 1) {

    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "frm_techLead_code_review.aspx/TLCodeReviewConfirm",
        data: "{pageVal:'" + flag + "', pageval1 :'" + tblAmntData + "',pageval2:'" + dtl + "',pageval3:'" + data + "'}",
        dataType: "json",
        success: function (Result) {
            let timerInterval;
            Swal.fire({
                width: 400,
                type: 'success',
                title: 'Success!',
                html: "Done..!  ",
                showConfirmButton: false,
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
                    window.open('frm_techLead_code_review.aspx', '_self');
                }
            }).then((result) => {
                if (
                    // Read more about handling dismissals
                    result.dismiss === Swal.DismissReason.timer
                ) {
                    window.open('frm_techLead_code_review.aspx', '_self');
                }
            })
            if (stat == "9") {
                Swal.fire(content, 5000);
                return false;
            }

           // window.open('frm_techLead_code_review.aspx', '_self');
        },
        error: function (Result) {

            alert(Result);
        }
        });
    } else {
        alert("Please Complete the evaluvation");
    }

}


function chk() {
    //alert('V');
    c = 0;
    var table = document.getElementById("tbCustomerData");

    var l = $("#tbCustomerData tr").length;
  //  alert(l);
    for (i = 1; i <= l; i++) {

        if ($('#chkbx' + i).prop('checked')) {
                f = 1;
                c = c + 1;
                //alert(c);
            }
    }
    if (c < l - 1) {

        return 0;

    } else {
        return 1;
    }
}


function tlcodereviewreturn() {
  //  alert("dsfdgndhm");

    dtl = $("#ddlCrf").val();
    dev = $("#ecode").text();
    //dev = '358191';
   // dev = $("#ddlDev").val();
    //var dev = $('#ddlDev option:selected').text();

    var l;
    var tblAmntData = '';
    var usr = $("[id*=hdUserId]").val();
    var data = dev + '^' + usr
    var table = document.getElementById("tbCustomerData");
    var l = $("#tbCustomerData tr").length;
    //alert(l);
    //var b = chk();

    for (i = 1; i < l; i++) {
        //inputs[i].checked = false

        if (!($('#chkbx' + i).prop('checked')))


        {
            tblAmntData = tblAmntData + table.rows[i].cells[2].innerText + '!';
          //  alert(tblAmntData);
        }
    }
  

        $.ajax({
            type: "post",
            contentType: "application/json; charset=utf-8",
            url: "frm_techLead_code_review.aspx/TLCodeReviewreturn",
            data: "{pageVal:'TLCODEREVIEWRet', pageval1 :'" + tblAmntData + "',pageval2:'" + dtl + "',pageval3:'" + data + "'}",
            dataType: "json",
            success: function (Result) {
                let timerInterval;
                Swal.fire({
                    width: 400,
                    type: 'success',
                    title: 'Success!',
                    html: "Done..!  ",
                    showConfirmButton: false,
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
                        window.open('frm_techLead_code_review.aspx', '_self');
                    }
                }).then((result) => {
                    if (
                        // Read more about handling dismissals
                        result.dismiss === Swal.DismissReason.timer
                    ) {
                        window.open('frm_techLead_code_review.aspx', '_self');
                    }
                })
                if (stat == "9") {
                    Swal.fire(content, 5000);
                    return false;
                }


               // window.open('frm_techLead_code_review.aspx', '_self');
            },
            error: function (Result) {

                alert(Result);
            }
        });
    

}


function fillCRFData() {
    checkHours = 0;
    $("#parallelrow").hide();
    $("#txtBusHours").val("");
    $("#lblBusHours").html("");
    Clear();
    Clear1();
    var CRFID = $("#ddlCrf").val();
    $("[id*=hddraftid]").val(CRFID);
    var dtl = $('#ddlCrf option:selected').text();
    var ddtl = dtl.split('~');
    $("[id*=hdRqstID]").val(ddtl[0]);
    //CRFSearch(CRFID);
    $("#snote").show();
    if (CRFID == -1) {
        $("#CrfDetailsID").hide();
        $('#boxTestEng').hide();
    }
    else {
        $("#CrfDetailsID").show();
        $('#boxTestEng').show();

    }

    detailsLoad(CRFID);
    filesFill(CRFID)
    GetRequestId();
    $("#txtRemarks").val("");

}



function CRFSearch() {
    var CRFID =  $("#ddlCrf").val();
    if (CRFID == -1) {
        $("#CrfDetailsID").hide();
    }
    else {
        $("#CrfDetailsID").show();

    }
    var crfval = $("#ddlCrf option:selected").text();
    var reqid = crfval.split('~');
   // alert(crfval);
    //alert(reqid[0] + " " + reqid[1] + "  " + reqid[2]);
    var CRFID = $("#ddlCrf").val();
    if (CRFID == "") {
        alert("Please Choose CRF!!!");
    }


    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "frm_techLead_code_review.aspx/TLCodeReviewConfirm1",
        data: "{pageVal:'fillDeveloper', pageval1 :'" + reqid[1] + "',pageval2 :'" + CRFID + "',pageval3:'" + accessility + "'}",
        dataType: "json",
        success: function (Result) {

            Result = Result.d;
            //alert("Result is" + Result);
           
                var cdtl = Result.split('±');
              
                $('#lblReqtr').html(cdtl[0]);
              $('#ecode').html(cdtl[2]);
                $('#lblTarDt').html(cdtl[1]);
              
        },
        error: function (Result) {

            alert(Result);
        }
    });

}

function Payall() {
    var vRate = 0;
    if ($("#chkall").is(':checked')) {
        //if ($("#chkall").prop("checked", true)) {
        for (i = 1; i < $("#tbCustomerData tr ").length; i++) {
            $("#chkbx" + i).prop("checked", true);
            //vRate = parseFloat(vRate) + parseFloat($("#txtPyble" + i).val());
        }
       
    }
    else {
        $("#chkall").prop("checked", false);
        for (i = 1; i < $("#tbCustomerData tr ").length; i++) {
            $("#chkbx" + i).prop("checked", false);
        }
    

    }
}


function accessibility_Check() {
   // alert("sfghfjgkhl");
    var usr = $("[id*=hdUserId]").val();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "frm_techLead_code_review.aspx/getRequestNote",
        data: "{pageVal:'TLCheck', pageval1:'" + usr + "',pageval2:''}",
        dataType: "json",
        async: false,
        success: function (Result) {
            Result = Result.d;
            if (Result == '1') { accessility = 1; }//ashik  reviewer

            else {
                accessility = 2;
                $("#btnReturn").hide();} //all other            
        }
    });
}
