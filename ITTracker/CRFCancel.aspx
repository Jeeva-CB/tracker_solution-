<%@ Page Title="" Language="C#" MasterPageFile="~/PWA_Master.Master" AutoEventWireup="true" CodeBehind="CRFCancel.aspx.cs" Inherits="ITTracker.CRFCancel" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="StyleAutoComplete.css" rel="stylesheet" />
    <script src="AutoCompleteJS.js"></script>

    <script type="text/javascript">
$(document).on('click','.cancel-emp',function(){	  
    $(this).parent().remove();	
    $("#txtEmpCode").prop("readonly", false);
        });
        </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-md-3 employee-id-row" id="parallelrow">
                    <div class="form-group">
                        <div class="all-emp" id="r_emp"></div>
                        <div class="autocomplete" style="width: 100%;" align="left" id="paral">
                            <input type="text" id="txtEmpCode" autocomplete="off" class="text-uppercase" style="border-top: none; border-left: none; width: 100%" name="search" placeholder="Search User.." onkeyup="SearchDataAutoCompleteEmp(this.id, this.value,'3','hdnEmpCodeRec','GetCRFID','GetCRFID' ,'r_emp')" />

                        <input id="hdnEmpCodeRec" type="hidden" />
                        </div>
                    </div>
                </div>
</asp:Content>
