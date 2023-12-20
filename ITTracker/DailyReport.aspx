<%@ Page Title="" Language="C#" MasterPageFile="~/PWA_Master.Master" AutoEventWireup="true" CodeBehind="DailyReport.aspx.cs" Inherits="ITTracker.DailyReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   
    <head>
        <style type="text/css" title="currentStyle">
			@import "css/demo_page.css"; 
			@import "css/demo_table.css";
			@import "css/jquery-ui-1.8.4.custom.css";
			@import "css/TableTools.css";
            .scroll {
                overflow-x: auto;
                white-space: nowrap;
            }
        </style>
        
    </head>
     <%--<script src="js/ReviewDailyWork.js" ></script>  --%>
   <%-- <link href="Content/themes/base/jquery-ui.css" rel="stylesheet" />
    <link href="Content/jquery.jqGrid/ui.jqgrid.css" rel="stylesheet" />
    <script src="Scripts/jquery-ui-1.10.0.js"></script>
    <script src="Scripts/i18n/grid.locale-en.js"></script>
    <script src="Scripts/jquery.jqGrid.min.js"></script>--%>
    <script src="js/jquery.js"></script>
    <script src="js/jquery.dataTables.min.js"></script>
    <script src="js/ZeroClipboard.js"></script>
    <script src="js/TableTools.js"></script>
    <script src="js/FixedColumns.js"></script>


<script type="text/javascript" charset="utf-8">
    $(document).ready(function () {
       // getdata();
        getInputDatas();
        //alert('hii');	
                
        var oTable = $('#example').dataTable( {
					"bJQueryUI": true,
					"sPaginationType": "full_numbers",
					"sDom": 'T<"clear"><"H"lfr>t<"F"ip>',
                    "bAutoWidth": false,
					"oTableTools": {
						"aButtons": [
							"copy", "csv", "xls", "pdf",
							{
								"sExtends":    "collection",
								"sButtonText": "Save",
								"aButtons":    [ "csv", "xls", "pdf" ]
							}
						]
					}
				} );
    });
    function getInputDatas() {
        var usr = $("[id*=Hduser]").val();
        checkAccessiblity(usr);
       var men = $("[id*=menuid]").val();
       // alert(men);
    }

    function checkAccessiblity(usr) {
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "DailyTrackReport.aspx/Accessible",
        data: "{pageVal:'GetAccessible', pageval1 :'" + usr+"', pageval2 :''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            var men = $("[id*=menuid]").val();
            if (Result == '999') {
                $("#showhide").hide();
               // $("#showremarks").hide();

            }
            else if (men=='Pnjblkchk' && Result == '123') {
            $("#showhide").hide();
            }
            else {
                 $("#showhide").show();
               // $("#showremarks").show();
            }
        }
    });
    }

    function VerifyDailyWork() {

    //alert("okayjsworkin");
        var Data = $("[id*=menuid]").val()+'æ'+$("[id*=Hduser]").val();
        
    //alert(Data);
    //$.ajax({
    //    type: "post",
    //    contentType: "application/json; charset=utf-8",
    //    url: "DailyTrackReport.aspx/ReviewDailyWork",
    //    data: "{pageVal:'checkdailywork, pageval1 :'" + Data + "',pageval2:''}",
    //    dataType: "json",
    //    async: false,
    //    success: function (Result) {
    //        $('.block-ui').addClass('clear');
    //        Result = Result.d;
    //        var noteid = Result;

    //        if (noteid == "1") {
    //            Swal.fire(" SUCCESS!!");
    //        }
    //        //if (noteid == "1") {
    //        //    let timerInterval
    //        //    Swal.fire({
    //        //        width: 400,
    //        //        type: 'success',
    //        //        title: 'Success!',
    //        //        html: "Success ",
    //        //        //showConfirmButton: false,
    //        //        allowOutsideClick: false,
    //        //        timer: 10000,
    //        //        onBeforeOpen: () => {
    //        //            //Swal.showLoading()
    //        //            timerInterval = setInterval(() => {
    //        //                Swal.getContent().querySelector('strong')
    //        //                    .textContent = Swal.getTimerLeft()
    //        //            }, 100)
    //        //        },
    //        //        onClose: () => {
    //        //            clearInterval(timerInterval)
    //        //            window.open('DailyReport.aspx?crfid=1', '_self');
    //        //        }
    //        //    }).then((result) => {
    //        //        if (
    //        //            // Read more about handling dismissals
    //        //            result.dismiss === Swal.DismissReason.timer
    //        //        ) {
    //        //            window.open('DailyReport.aspx?crfid=1', '_self');
    //        //        }
    //        //    })
    //        //}
    //        //else {
    //        //    alert("Something went wrong.! Please contact IT support..")
    //        //}

    //    }
    //});
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "DailyTrackReport.aspx/ReviewDailyWork",
        data: "{pageVal:'checkdailywork', pageval1 :'" + Data + "',pageval2:''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            // $('#ddlCrf').append($("<option selected disabled></option>").val("-1").html("Choose CRF"));
            //$.each(Result, function (key, value) {
            //    $('#ddlCrf').append($("<option></option>").val(value.id).html(value.name));
            //});
            var noteid = Result;
           

            //alert('noteid')
            if (noteid != "-1") {
            
                let timerInterval
                Swal.fire({
                    width: 400,
                    type: 'success',
                    title: 'Success!',
                    html: "Success!! ",
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
                        window.open('DailyTrackReport.aspx', '_self');
                    }
                }).then((result) => {
                    if (
                        // Read more about handling dismissals
                        result.dismiss === Swal.DismissReason.timer
                    ) {
                        window.open('DailyTrackReport.aspx', '_self');
                    }
                })
            }
            else {
                Swal.fire("Something went wrong..! Please contact IT support.!");
            }

        }

    });


}
    function getdata() {
        debugger;
        //            
        var men = $("[id*=menuid]").val();
        //alert(men);
        $.ajax(
            {
                type: "post",
               contentType: "application/json; charset=utf-8",
                url: "DailyReport.aspx/getData",
                 data: "{menuId:'" + men + "'}",
                   dataType: "json",
                success: function (response) {
                    debugger;
                    var item =json.parse(response);
                   // alert(jsondata);
                   // coln = response.colmodel;
                   // coldata = json.parse(response.coldata);
                   //alert(response);

       //var data = {
       //    rows:coldata
       // }
        //            alert(item);
        //            if (item != null && item != "" && typeof (item) != 'undefined') {
                        // }



                         $(function () {
                        debugger;
                        // var menuid = "314706æ100614æ2020-08-25æ2020-09-01æ";
                        //alert("meu:" + men);
                             $("#jqGrid").jqGrid({
                            //contentType: "application/json; charset=utf-8",
                            //url: 'DailyReport.aspx/getData',
                           // data: "{ menuId :'" + men + "'}",
                            //data: item,
                            datatype: 'json',
                            mtype: 'GET',
                            //colModel: colN,
                            //datastr: data,

                            // datastr:data,
                            //serializeGridData: function (postData) {
                            //    debugger;
                            //    return JSON.stringify(postData);
                            //},

                            //ajaxGridOptions: { contentType: "application/json" },

                            loadonce: true,
                            // colNames: colModel,
                            // colModel:colData,
                            colNames: ['ASSIGNEDPROJECT','WORKPERFORMED', 'REASON', 'REMARKS', 'WORKDATE', 'TIME'],
                            colModel: [
                                { name: 'ASSIGNEDPROJECT', index: 'AssignedProject', width: 80, key: true },
                                { name: 'WORKPERFORMED', index: 'WORKPERFORMED', width: 140, key: true },
                                { name: 'REASON', index: 'REASON', width: 160, key: true },
                                { name: 'REMARKS', index: 'REMARKS', width: 180, key: true },
                                { name: 'WORKDATE', index: 'WORKDATE', width: 180, key: true },
                                { name: 'TIME', index: 'TIME', width: 180, key: true }
                            ],
                            //  data:colData,
                            pager: '#jqGridPager',
                            rowNum: 5,
                            rowList: [10, 20, 30],
                            viewrecords: true,
                            gridview: true,
                            jsonReader: {
                                page: function (obj) { return 1; },
                                total: function (obj) { return 1; },
                                records: function (obj) { return obj.d.length; },
                                root: function (obj) { return obj.d; },
                                repeatitems: false,
                                id: "0"
                            },

                            caption: 'Daily Tracking Report'
                            //});
                        }).pagingGrid("#pager", { edit: true, add: true, del: false });
                        // $('#jqGrid').jqGrid('filterToolbar', {
                        //  stringResult: true,
                        //searchOnEnter: false,
                        // searchOperators: true
                        //    });
                        });
                    //}//if
                }//success
                
           });//ajax
        //});
      // });
       //})
    }
      

</script>
    
<script language="javascript" type="text/javascript">

function btnPrint_onclick() 
{
   window.print();
}

function ShowCurrentTime() 
{
    var dt = new Date();
    //alert(dt);
  document.getElementById("lblTime").innerHTML = 'Time : '+ dt.toLocaleTimeString();
    window.setTimeout("ShowCurrentTime()", 1000); 
}
    function frmExit() {
    window.open("DailyTrackReport.aspx", "_self");
}



</script> 
    <!--------------jqgrid section-->
     
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <input id="Reportcount" type="hidden" runat="server" />
    <form id="Form1" class="form-horizontal row-border" action="#" runat="server" >
        <input type="hidden" id="menuid" runat="server" />
                <input type="hidden" id="Hduser" runat="server" />

        <div class="container">
           <div class="col-md-12 well align-center">
               <div class="col-md-12 align-right">               
                   <asp:Button ID="btn_Excel" runat="server" BackColor="LightSteelBlue" BorderStyle="Ridge"
                 EnableTheming="True" Font-Bold="True" Font-Names="Book Antiqua" Font-Size="10pt"
                 ForeColor="Black" Height="30%" Style="border-right: thin ridge; border-top: thin ridge;
                 border-left: thin ridge; cursor: hand; border-bottom: thin ridge" Text="EXPORT TO EXCEL"
                 Width="168px" OnClick="btn_Excel_Click"/>
                   <input id="btnPrint" onclick="return btnPrint_onclick()" style="font-weight: bold;
                width: 73pt; cursor: hand; font-family: 'Book Antiqua'; background-color: lightsteelblue"
                type="button" value="PRINT" />
               </div>
               <div class="col-md-12 align-center">
                   <asp:Label ID="lbldate" runat="server" Font-Bold="True" ForeColor="Navy" Width="25%"></asp:Label><br />
                   <asp:Label ID="lblTime" runat="server" Font-Bold="True" ForeColor="Navy" Width="258px"></asp:Label><br />
               </div>
               <div class="col-md-12 align-center">
                   <asp:Panel ID="Panel1" runat="server" Height="16%" Style="z-index: 100; left: 11px; top: 7px" Width="100%">
                        <div style="margin-left: auto; margin-right: auto; text-align: center">
                             <asp:Label ID="Label2" runat="server" BackColor="Transparent" Font-Bold="True" Font-Size="X-Large"
                                 ForeColor="Green" Height="28px" Text="MANAPPURAM FINANCE LIMITED" Width="100%"></asp:Label>
                            <asp:Label ID="lblTitle" runat="server" BackColor="Transparent" Font-Bold="True" Font-Size="Large"
                                 ForeColor="Purple" Height="21px" Width="100%">DAILY TRACK REPORT</asp:Label><br />
                        </div>
                        <div id="demo" class="scroll">
                            <div id="MyTable" runat="server" style="margin-left: auto; margin-right: auto; text-align: center;">
                            </div>
                           <%--  <table id="jqGrid"></table>
    <div id="jqGridPager"></div>--%>
                        </div>
                   </asp:Panel>
               </div>
               
                  <%-- <div class="row col-md-12 p-1"id="showremarks" style="display:none;margin-bottom:1%;">
                       <label class="pure-material-textfield-outlined">Remarks</label>
                           <textarea rows="1" cols="15" style="width:100%" name="Remarks" id="txtRemarks" maxlength="3500" title="Remarks" oninput="this.value = this.value.replace(/[^-@.,/#&+\w\s]/g, '');>
                            </textarea>
                    
                   </div>--%>
              
        
        
    
    </div>
 
             <div class="row" id="showhide"style="display:none;margin-bottom:1%;">
            <div class="col-md-2 col-sm-2 col-xs-4">
                        <a href="#" class="btn btn-sm animated-button thar-one btn-primary" style="width: 100%; margin: 5px;"
                            onclick="return VerifyDailyWork();" id="btnSubmit"><i class="fa fa-thumbs-up"></i>Confirm</a>
                    </div>

            <div class="col-md-2 col-sm-2 col-xs-4">
                        <a href="#" class="btn btn-sm animated-button thar-one btn-red" style="width: 100%; margin: 5px;"
                            onclick="return frmExit();"><i class="fa fa-sign-out-alt"></i>Exit</a>
                    </div>

            </div>
        </form>
</asp:Content>

