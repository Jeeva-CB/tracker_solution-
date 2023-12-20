<%@ Page Title="" Language="C#" MasterPageFile="~/PWA_Master.Master" AutoEventWireup="true" CodeBehind="RDReportShow.aspx.cs" Inherits="ITTracker.RDReportShow" %>
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
            if (Result == '999') {
                $("#showhide").hide();
               // $("#showremarks").hide();

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
        

    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "DailyTrackReport.aspx/ReviewDailyWork",
        data: "{pageVal:'checkdailywork', pageval1 :'" + Data + "',pageval2:''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
    
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

      

</script>
    
<script language="javascript" type="text/javascript">

function btnPrint_onclick() 
{
   window.print();
}

function ShowCurrentTime() 
{
    var dt = new Date();
   // alert(dt);
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
                                 ForeColor="Purple" Height="21px" Width="100%">R&D REPORT</asp:Label><br />
                        </div>
                        <div id="demo" class="scroll">
                            <div id="MyTable" runat="server" style="margin-left: auto; margin-right: auto; text-align: center;">
                            </div>

                        </div>
                   </asp:Panel>
               </div>
               
        
              
        
        
    
    </div>
 
            
        </form>
</asp:Content>

