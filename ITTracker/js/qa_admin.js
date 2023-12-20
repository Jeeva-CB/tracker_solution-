$(window).on('load', function () {
   
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "Qa_admin.aspx/get_qa_emplyees",
        data: "{pageVal:'Fill_qa_team',pageval1 :'ewrergt'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            $.each(Result, function (key, value) {
                $('#ddl_qateam').append($("<option></option>").val(value.emp_id).html(value.emp_name));
            });
        }
    });
    fill_modules();
    fill_qatechleads();
});
function fill_modules() {
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "Qa_admin.aspx/get_modules",
        data: "{pageVal:'Fill_qa_modules'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            $.each(Result, function (key, value) {
                $('#ddl_module').append($("<option></option>").val(value.emp_id).html(value.emp_name));
            });
        }
    });
}
function confirm() {
    var modules = "";
    var emp = $('#ddl_qateam option:selected').val();
    var usr = $("[id*=hdUserId]").val();
    //var module_id = $('#ddl_module option:selected').val();
   
    modules = $('.module').val();

   
    if (emp == "-1") {

        Swal.fire("Please Select an employee.!");
        $("#ddl_qateam").focus();
        return false;
    }
    if (modules == null) {

        Swal.fire("Please Choose Modules.!");
        $("#ddl_module").focus();
        return false;
    }
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "Qa_admin.aspx/confirm_qatech",
        data: "{pageVal:'insert_qatech',pageval1:'" + modules + "',pageval2:'" + emp + "',pageval3:'" + usr +"'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            if (Result == "111") {
                let timerInterval
                Swal.fire({
                    width: 400,
                    type: 'success',
                    title: 'Success!',
                    html: "New QA Techlead created!! ",
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
                        window.open('Qa_admin.aspx', '_self');
                    }
                }).then((result) => {
                    if (
                        result.dismiss === Swal.DismissReason.timer
                    ) {
                        window.open('Qa_admin.aspx', '_self');
                    }
                })
            }
            else if (Result == "333") {
                let timerInterval
                Swal.fire({
                    width: 400,
                    type:'Sorry',
                    title: 'Sorry!',
                    html: "Already created!! ",
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
                        window.open('Qa_admin.aspx', '_self');
                    }
                }).then((result) => {
                    if (
                        result.dismiss === Swal.DismissReason.timer
                    ) {
                        window.open('Qa_admin.aspx', '_self');
                    }
                })
            }
            else {
                alert("Something went wrong.!Please contact IT Support");
            }
        }
    });
}
function addnew_qatech() {
    
    hide_backgroundcolor()
    $("#div_edit").hide();
    $("#div_create").show();
    document.getElementById("div_info1").style.backgroundColor = "#cefbf7";
}
function edit_techlead_modules() {
  
    hide_backgroundcolor()
    $("#div_create").hide();
    $("#div_edit").show();
    document.getElementById("div_info2").style.backgroundColor = "#cefbf7";
}
function hide_backgroundcolor() {

    document.getElementById("div_info1").style.backgroundColor = "#fff";
    document.getElementById("div_info2").style.backgroundColor = "#fff";
}
function fill_qatechleads() {
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "Qa_admin.aspx/get_qa_techleads",
        data: "{pageVal:'Fill_qa_techs'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            $.each(Result, function (key, value) {
                $('#ddl_qateam_edt').append($("<option></option>").val(value.emp_id).html(value.emp_name));
            });
        }
    });
}
function fill_qamodules() {
    var emp = $('#ddl_qateam_edt option:selected').val();
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "Qa_admin.aspx/get_qa_techdtls",
        data: "{pageVal:'get_qatech_dtls',pageval1 :'" + emp +"'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
           
            filltable(Result);
        }
    });
}
function filltable(data) {
   
    $("#tab_techdtls").empty();
    valData = data.split('@');
    
    if($("#tab_techdtls tr").length == 0) {
      
        $('#tab_techdtls').append('<tr style="background-color:#f6edec;font-size:medium"><th class="text-center">Currently assigned Modules</th></tr>');
    }
    for (i = 0; i < valData.length - 1; i++) {
       var valData1 = valData ;
        
    }
  
        $('#tab_techdtls').append('<tbody><tr>' +
            '<td style="text-center;font-size:medium">' + valData1 + '</td></tr > </tbody > ');
           
  
  



}
function Addmore_module() {
    $("#ed_mod_div").show();
    fill_modules1();
}
function fill_modules1() {
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "Qa_admin.aspx/get_modules",
        data: "{pageVal:'Fill_qa_modules'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            $.each(Result, function (key, value) {
                $('#ddl_module_edt').append($("<option></option>").val(value.emp_id).html(value.emp_name));
            });
        }
    });
}
function confirm_edit() {
    var emp = $('#ddl_qateam_edt option:selected').val();
    var usr = $("[id*=hdUserId]").val();
    //var module_id = $('#ddl_module option:selected').val();

    modules = $('.module1').val();


    if (emp == "-1") {

        Swal.fire("Please Select an employee.!");
        $("#ddl_qateam_edt").focus();
        return false;
    }
    if (modules == null) {

        Swal.fire("Please Choose Modules.!");
        $("#ddl_module_edt").focus();
        return false;
    }
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "Qa_admin.aspx/confirm_edit",
        data: "{pageVal:'confirm_qaedit',pageval1:'" + modules + "',pageval2:'" + emp + "',pageval3:'" + usr + "'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            if (Result == "0") {
                let timerInterval
                Swal.fire({
                    width: 400,
                    type: 'success',
                    title: 'Success!',
                    html: "New modules added !! ",
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
                        window.open('Qa_admin.aspx', '_self');
                    }
                }).then((result) => {
                    if (
                        result.dismiss === Swal.DismissReason.timer
                    ) {
                        window.open('Qa_admin.aspx', '_self');
                    }
                })
            }
            else if (Result == "1") {
                let timerInterval
                Swal.fire({
                    width: 400,
                    type: 'Sorry',
                    title: 'Sorry!',
                    html: "Already Added Modules!! ",
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
                        window.open('Qa_admin.aspx', '_self');
                    }
                }).then((result) => {
                    if (
                        result.dismiss === Swal.DismissReason.timer
                    ) {
                        window.open('Qa_admin.aspx', '_self');
                    }
                })
            }
            else {
                alert("Something went wrong.!Please contact IT Support");
            }
        }
    });
}
function confirm_add() {
    var emp = $('#ddl_qateam_edt option:selected').val();
    var usr = $("[id*=hdUserId]").val();
    //var module_id = $('#ddl_module option:selected').val();

    modules = $('.module1').val();


    if (emp == "-1") {

        Swal.fire("Please Select an employee.!");
        $("#ddl_qateam_edt").focus();
        return false;
    }
    if (modules == null) {

        Swal.fire("Please Choose Modules.!");
        $("#ddl_module_edt").focus();
        return false;
    }
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "Qa_admin.aspx/confirm_add",
        data: "{pageVal:'verify_module',pageval1:'" + modules + "',pageval2:'" + emp + "',pageval3:'" + usr + "'}",
        dataType: "json",
        success: function (Result) {
          
            Result = Result.d;
            if (Result == "1") {
                Swal.fire("Some Modules are already added.!");
                $("#ddl_module_edt").focus();
                $("#showSubmitBtn_edt").hide();
                return false;
            }
            if (Result == "0") {
                
                $("#showSubmitBtn_edt").show();
            }
        }
        });
}
function viewbtn() {
   
    $("#showSubmitBtn_edt").hide();
}
function frmExit() {
    window.open("index.aspx", "_self");
}