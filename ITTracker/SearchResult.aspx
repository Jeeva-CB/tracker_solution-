<%@ Page Title="" Language="C#" MasterPageFile="~/PWA_Master.Master" AutoEventWireup="true" CodeBehind="SearchResult.aspx.cs" Inherits="ITTracker.SearchResult" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <head>
        <style type="text/css" title="currentStyle">
			@import "css/demo_page.css"; 
			@import "css/demo_table.css";
			@import "css/jquery-ui-1.8.4.custom.css";
			@import "css/TableTools.css";
            .scroll {
                overflow-x: auto;
               
            }


            .odd_gradeX:hover {
                background: aliceblue;
                cursor:pointer
            }
            .DTTT_container{
                display:none;
            }

            .ui-widget-header {
    border: 4px solid #d7c576;
    background: #001730 url(../images/ui-bg_highlight-soft_75_cccccc_1x100.png) 50% 50% repeat-x !important;
    color: #d7c576;
    font-weight: bold;
}

        </style>
        
    </head>
   <script type="text/javascript" charset="utf-8">  

       $(document).ready(function () {
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

            }


       );

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
    var win = NULL;
onerror = stopError();
function stopError(){
    return true;
}

function gr() {

    $('#example').find('tr').click(function () {
        var row = $(this).find('td:eq(0)').text();
        if (row!="") {
        var note = Encrypt(row);
       //alert(row);
        //WorkLogView(row);
        //UserApprvTview(row);
        //global_tickno = row;
        //$('#example').removeEventListener();
        window.location = "ViewerNoteDetails.aspx?noteid=" + note;
        }
      
    });
}

</script>
<%--     <script src="../js/ReportStyle.js"></script>--%>
    <script src="js/jquery.js"></script>
    <script src="js/jquery.dataTables.min.js"></script>
    <script src="js/ZeroClipboard.js"></script>
    <script src="js/TableTools.js"></script>
    <script src="js/FixedColumns.js"></script>

<%--<script type="text/javascript" charset="utf-8">
			$(document).ready( function () {
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

			} );
</script>--%>
    
<script language="javascript" type="text/javascript">

function btnPrint_onclick() 
{
   window.print();
}

function ShowCurrentTime() 
{
  var dt = new Date();
  document.getElementById("lblTime").innerHTML = 'Time : '+ dt.toLocaleTimeString();
    window.setTimeout("ShowCurrentTime()", 1000); 
}

</script> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="Form1" class="form-horizontal row-border" action="#" runat="server" >
        <div class="container-result">
           <div class="col-md-12 well align-center">
              
               <div class="col-md-12 align-center">
                   <asp:Label ID="lbldate" runat="server" Font-Bold="True" ForeColor="Navy" Width="25%"></asp:Label><br />
                   <asp:Label ID="lblTime" runat="server" Font-Bold="True" ForeColor="Navy" Width="258px"></asp:Label><br />
               </div>
               <div class="col-md-12 align-center">
                   <asp:Panel ID="Panel1" runat="server" Height="16%" Style="z-index: 100; left: 11px; top: 7px" Width="100%">
                        <div style="margin-left: auto; margin-right: auto; text-align: center">
                       
                        </div>
                        <div id="demo" class="scroll">
                            <div id="MyTable" runat="server" style="margin-left: auto; margin-right: auto; text-align: center">
                            </div>
                        </div>
                   </asp:Panel>
               </div>
        
        
    
    </div>
            </div>
        </form>
    <input id="hdSearchKey" type="hidden" runat="server"/>
</asp:Content>
