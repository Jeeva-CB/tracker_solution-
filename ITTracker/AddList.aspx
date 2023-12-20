<%@ Page Title="" Language="C#" MasterPageFile="~/PWA_Master.Master" AutoEventWireup="true" CodeBehind="AddList.aspx.cs" Inherits="ITTacker.AddList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<link href="StyleAutoComplete.css" rel="stylesheet" />
<script src="AutoCompleteJS.js"></script>
<script type="text/javascript">
$(document).on('click','.cancel-emp',function(){	  
	      $(this).parent().remove();	
    });
$(document).on('click','.remove-prow',function(){	  
	      $(this).parent().parent().remove();	
    });
function addQuotes(value){
    var quotedVar = "\'" + value + "\'";
    return quotedVar;
}
$(function () {
    $("#btnAdd").bind("click", function () {
        var div = $("<tr />");
        div.html(GetDynamicTextBox(""));
        $("#TextBoxContainer").append(div);
    });
     var scntDiv = $("#frm_scents");
    var i = $("#p_scents").length + 1;

    $("#addScnt").click(function() {
    $(
      '<div class="row" id="p_scents"><div class="form-group"><input type="text" class="form-control tx-sm" id="Fld_Alias(' +
        i +
        ')" placeholder="Field Alias" /></div><div class="form-group"><input type="text" class="form-control tx-sm" id="Fld_Name(' +
        i +
        ')" placeholder="Field Name" /></div><div class="form-group"><input type="text" class="form-control tx-md" id="Fld_Value(' +
        i +
        ')" placeholder="Field Value" /></div><div class="form-group"><input type="text" class="form-control tx-md" id="Fld_Dflt_Val(' +
        i +
        ')" placeholder="Field Default Value" /></div><div class="form-group"><select class="form-control tx-md" id="Field_Type(' +
        i +
        ')"><option value="0">Field Type</option><option value="1">Text Box </option><option value="2">Combo Box </option><option value="3">Date </option></select></div><div class="form-group"><input type="checkbox" class="form-control" id="Mandatory(' +
        i +
        ')"  />Mandatory <input type="checkbox" class="form-control" id="Dispaly(' +
        i +
        ')" />Dispaly <input type="checkbox" class="form-control" id="Enable(' +
        i +
        ')" />Enable</div><a href="#" id="remScnt" onclick="removeCont(this);"><i class="fa fa-minus-circle" aria-hidden="true"></i> Remove</a></div>'
    ).appendTo(scntDiv);
    i++;
    return false;
    });

        var paraDiv = $("#parallelrow");
        var j = $("#p_rowid").length + 1;
    $("#addPara").bind("click", function () {         
        var SrchStringLen = addQuotes('2');  
        var hiddenVariable = addQuotes('hdnEmpCodeRec'+j);
        var pageflag = addQuotes('PWAAPP');
        var QueryID = addQuotes('GetEmployee');
        var ShowValue = addQuotes('r_emp'+j);
        $('<div class="row" id="p_rowid"><div class="col-md-9 employee-id-row"><div class="form-group"><div class="all-emp" id="r_emp'+ j +'"></div><div class="autocomplete" style="width:50%;" align="left"><input type="text" id="txtEmpCode'+j+'" autocomplete="off" class= "text-uppercase" style = "border-top: none;border-left: none;width:100%" name = "search" placeholder = "Search Employee.." onkeyup = "SearchDataAutoCompleteEmp(this.id, this.value,' + SrchStringLen + ',' + hiddenVariable + ',' + pageflag + ',' + QueryID + ' ,' + ShowValue + ')"/></div ></div></div><div class="col-md-3"><input id="hdnEmpCodeRec'+ j +'" type="hidden"/><button type="button" class="btn btn-danger remove-prow"><i class="fa fa-minus-circle"></i>&nbsp; Remove&nbsp;</button></div></div> ').appendTo(paraDiv);
    //    $(
    //  '<div class="row" id="p_scents"><div class="form-group"><input type="text" class="form-control tx-sm" id="Fld_Alias(' +
    //    i +
    //    ')" placeholder="Field Alias" /></div><div class="form-group"><input type="text" class="form-control tx-sm" id="Fld_Name(' +
    //    i +
    //    ')" placeholder="Field Name" /></div><div class="form-group"><input type="text" class="form-control tx-md" id="Fld_Value(' +
    //    i +
    //    ')" placeholder="Field Value" /></div><div class="form-group"><input type="text" class="form-control tx-md" id="Fld_Dflt_Val(' +
    //    i +
    //    ')" placeholder="Field Default Value" /></div><div class="form-group"><select class="form-control tx-md" id="Field_Type(' +
    //    i +
    //    ')"><option value="0">Field Type</option><option value="1">Text Box </option><option value="2">Combo Box </option><option value="3">Date </option></select></div><div class="form-group"><input type="checkbox" class="form-control" id="Mandatory(' +
    //    i +
    //    ')"  />Mandatory <input type="checkbox" class="form-control" id="Dispaly(' +
    //    i +
    //    ')" />Dispaly <input type="checkbox" class="form-control" id="Enable(' +
    //    i +
    //    ')" />Enable</div><a href="#" id="remScnt" onclick="removeCont(this);"><i class="fa fa-minus-circle" aria-hidden="true"></i> Remove</a></div>'
    //).appendTo(scntDiv);   
    j++;
    return false;
  });
    $("body").on("click", ".remove", function () {
        $(this).closest("tr").remove();
    });
    });
function GetDynamicTextBox(value) {
    return '<td><input name = "DynamicTextBox" type="text" value = "' + value + '" class="form-control" /></td>' + '<td><select name="" class="form-control"><option> Select</option><option> Male</option><option> Female</option></select></td>' + '<td><input name = "DynamicTextBox" type="radio" value = "' + value + '" /></td>' + '<td><input name = "DynamicTextBox" type="checkbox" value = "' + value + '" /></td>' + '<td><button type="button" class="btn btn-danger remove"><i class="fa fa-minus-circle"></i></button></td>'
    }
   

function removeCont(_this) {
  if (i > 1) {
    $(_this).parent().remove();
    i--;
  }
    }

   

</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="row">
<div class="col-12">
<div class="card card-5 rightmarg"> 
<form class="form-horizontal" runat="server" >    
<div class="card-body">
<div class="row">
<div class="col-md-3">
<div class="form-group">
<label for="fundcat">Select Employee : <span class="text-danger">*</span></label>
<div class="autocomplete" style="width:100%;"><input type="text" id="txtEmpCode" class="form-control text-uppercase" style="width:100%" name="search" placeholder="Search Employee.." onkeyup="SearchDataAutoComplete(this.id, this.value, '2', 'hdnEmpCodeRec', 'PWAAPP', 'GetEmployee','all-emp')"  onkeypress="EmpName.innerHTML=''"/>
</div>
</div>
</div>
<div class="col-sm-12 employee-id-row"><div class="all-emp"></div></div>
</div>

<div class="row">
<div class="col-md-12">
<div class="table table-responsive">
<table class="table table-responsive table-striped table-bordered">
<thead>
	<tr>
    	<td>TextBox</td>
    	<td>Dropdown List</td>
    	<td>Radio</td>
    	<td>CheckBox</td>
    	<td>BTN</td>
    </tr>
</thead>
<tbody id="TextBoxContainer">
</tbody>
<tfoot>
  <tr>
    <th colspan="5">
    <button id="btnAdd" type="button" class="btn btn-primary" data-toggle="tooltip" data-original-title="Add more controls"><i class="fa fa-plus" aria-hidden="true"></i>&nbsp; Add&nbsp;</button></th>
  </tr>
</tfoot>
</table>
</div>
</div>
<%--<div class="col-md-3">
<div class="form-group">
<label for="fundcat">Main Account : <span class="text-danger">*</span></label>
<div class="autocomplete" style="width:100%;"><input type="text" id="txtLoanAcc" class="form-control text-uppercase" style="width:100%" name="search" placeholder="Search Disbursement Account.." onkeyup="LoadingDataAutoComplete(this.id, this.value, '2', 'hdnLoanMainAcc', 'TRESURYLOAN', 'GetLoanMainLedger','LoanAccName')"  onkeypress="LoanAccName.innerHTML=''"/>
</div>
    <small id="LoanAccName" class="form-text text-muted"></small>
</div>
</div>
<div class="col-md-3">
<div class="form-group">     
<label for="fundcat">Sub Account : <span class="text-danger">*</span></label>
<div class="autocomplete" style="width:100%;"><input type="text" id="txtLoanSubAcc" class="form-control text-uppercase" style="width:100%" name="search" placeholder="Search Disbursement Sub Account.." onkeyup="var accno =document.getElementById('txtLoanAcc').value;LoadingDataAutoComplete(this.id, accno+'µ'+this.value, '2', 'hdnLoanSubAcc', 'TRESURYLOAN', 'GetLoanSubLedger','LoanSubAccName')"  onkeypress="LoanSubAccName.innerHTML=''"/>
</div>
     <small id="LoanSubAccName" class="form-text text-muted"></small>
</div>
</div>
<div class="col-md-3">
<div class="form-group">
<label for="fundcat">Main Account : <span class="text-danger">*</span></label>
<div class="autocomplete" style="width:100%;"><input type="text" id="txtFtMainAcc" class="form-control text-uppercase" style="width:100%" name="search" placeholder="Search Fund Transfer Main Account.." onkeyup="LoadingDataAutoComplete(this.id, this.value, '2', 'hdnFTMainAcc', 'TRESURYLOAN', 'GetLoanMainLedger','FTMainAccName')"  onkeypress="FTMainAccName.innerHTML=''"/>
</div>
    <small id="FTMainAccName" class="form-text text-muted"></small>
</div>
</div>
<div class="col-md-3">
<div class="form-group">     
<label for="fundcat">Sub Account : <span class="text-danger">*</span></label>
    <div class="autocomplete" style="width:100%;"><input type="text" id="txtFtSubAcc" class="form-control text-uppercase" style="width:100%" name="search" placeholder="Search Fund Transfer Sub Account.." onkeyup="var accno =document.getElementById('txtFtMainAcc').value;LoadingDataAutoComplete(this.id, accno+'µ'+this.value, '2', 'hdnFTSubAcc', 'TRESURYLOAN', 'GetLoanSubLedger','FTSubAccName')"  onkeypress="FTSubAccName.innerHTML=''"/>
</div>
    <small id="FTSubAccName" class="form-text text-muted"></small>
</div>
</div>--%>
</div>

<div class="row">
<div class="col-md-12" id="frm_scents">
<div class="row" id="p_scents">      
      <a href="#" id="addScnt"><i class="fa fa-plus" aria-hidden="true"></i> Add</a>
    </div>
</div>
</div>

<div class="row">
<div class="col-md-12" id="parallelrow">
<div class="row" id="p_rowid">      
 <button id="addPara" type="button" class="btn btn-primary" data-toggle="tooltip" data-original-title="Add more controls"><i class="fa fa-plus" aria-hidden="true"></i>&nbsp; Add&nbsp;</button>
</div>
</div>
</div>
</div>
</form>      
</div>
</div>
</div>
    
</asp:Content>
