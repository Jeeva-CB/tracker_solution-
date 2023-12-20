<%@ Page Title="" Language="C#" MasterPageFile="~/PWA_Master.Master" AutoEventWireup="true" CodeBehind="CRFtracker.aspx.cs" Inherits="ITTracker.CRFtracker" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="StyleAutoComplete.css" rel="stylesheet" />
    <script src="AutoCompleteJS.js"></script>
    <script type="text/javascript">
$(document).on('click','.cancel-emp',function(){	  
    $(this).parent().remove();	
    $("#txtEmpCode").prop("readonly", false);
        });
        </script>
    <script>
    $(window).on('load', function () {
    $("#txt_date").datepicker({
        dateFormat: 'dd/MM/yy',
        minDate: 0,
        changeMonth: true,
        changeYear: true,
        stepMonths: true,
        todayHighlight: true,
        onSelect: function (dateText, inst) {
        }

    });
   
        });
        </script>
    <script src="js/CRFtracker.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 
    <center>
          <h6>CHANGE REQUEST FORM  DATE REVISION</h6>  
    <div class="col-md-6 employee-id-row" id="parallelrow">
                    <div class="form-group">
                        <div class="all-emp" id="r_emp"></div>
                        <div class="autocomplete" style="width: 100%;" align="left" id="paral">
                            <input type="text" id="txtEmpCode" autocomplete="off" class="text-uppercase" style="border-top: none; border-left: none; width: 100%" name="search" placeholder="Search CRF.." onkeyup="SearchDataAutoCompleteEmp(this.id, this.value,'3','hdnEmpCodeRec','GettacompletedCRFID','GettacompletedCRFID' ,'r_emp')"  onchange="GetCRFDetails()"/>

                        <input id="hdnEmpCodeRec" type="hidden" />
                        </div>
                    </div>
                </div>
        <div>
            <br />
        </div>
        
                                <div class="table-responsive">
                                    <table class="table1 table-hover" id="tabChange">
                                    </table>
                                </div>
                           
        <div class="col-md col-12 from-group align-content-center" >
            <div class="col-md-12">

            </div><label>Date&nbsp;&nbsp;</label><input type="text"id="txt_date" name="txtdate" style ="width:100px"  /><label>


        </div >
        <div class="col-md col-12 from-group align-content-center">
            <div class="col-md-12" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label>Reason For Change</label>&nbsp;&nbsp;&nbsp;<input type ="text" id="txtreason" name="txtreason" style="width:500px"/>
                
            </div>

        </div>
        <div class="col-md col-12 from-group align-content-center">
            <div class="col-md-12">
                <br/><br />

            </div><input type="button" id="btnconfirm"name="btnconfirm" value="Confirm"  onclick="ConfirmNote()" />&nbsp;&nbsp;
            <input type="button"id="btnexit"name="btnexit" value="Exit"onclick="frmExit()" />

        </div>
      </center>
    <input id="hdnCRFID" type="hidden" runat="server"/>
    <input id="hdUserId" type="hidden" runat="server"/>
        <input id="hdBranchId" type="hidden" runat="server"/>
        <input id="hdFirmId" type="hidden" runat="server"/>
    <input id="hdrqtid" type="hidden" runat="server"/>
      
    <input id="hdnSystemIP" type="hidden" runat="server"/>
     <input id="hdSesssion" type="hidden" runat="server"/>
    
</asp:Content>
