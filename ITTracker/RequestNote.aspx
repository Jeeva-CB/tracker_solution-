<%@ Page Title="" Language="C#" MasterPageFile="~/PWA_Master.Master" AutoEventWireup="true" CodeBehind="RequestNote.aspx.cs" Inherits="ITTacker.RequestNote" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<link href="StyleAutoComplete.css" rel="stylesheet" />
<script src="AutoCompleteJS.js"></script>
<script src="js/RequestNote.js"></script>
    <script src="js/RequestNote.js"></script>
     <link href="css/MultipleUpload.css" rel="stylesheet"/>
    <script src="js/MultipleUpload.js"></script>

    <script type="text/javascript" src="http://github.com/malsup/blockui/raw/master/jquery.blockUI.js?v2.34"></script>
     <script src="js/aes.js"></script>
<%--<link href="css/accordian.css" rel="stylesheet"/>--%>

<%--<style>
.gin-group{ 
  position:relative; 
  margin-bottom:7px; 
   width: auto;
   height: 2.3em;
}
.gin-input{
  font-size:14px;
  /*padding:10px 10px 10px 5px;*/
  display:block;
  width:100%;
  border:none;
  border-bottom:1px solid #757575;
}
.gin-input:focus{ outline:none; }

/* LABEL ======================================= */
.gin-label 				 {
  color:#999; 
  font-size:16px;
  font-weight:normal;
  position:absolute;
  pointer-events:none;
  left:5px;
  top:2px;
  transition:0.2s ease all; 
  -moz-transition:0.2s ease all; 
  -webkit-transition:0.2s ease all;
}

/* active state */
.gin-input:focus ~ label, .gin-input:valid ~ label 		{
  top:-15px;
  font-size:12px;
  color:#5264AE;
}

/* BOTTOM BARS ================================= */
.gin-bar 	{ position:relative; display:block; width:100%; }
.gin-bar:before, .gin-bar:after 	{
  content:'';
  height:2px; 
  width:0;
  bottom:1px; 
  position:absolute;
  background:#5264AE; 
  transition:0.2s ease all; 
  -moz-transition:0.2s ease all; 
  -webkit-transition:0.2s ease all;
}
.gin-bar:before {
  /*left:50%;*/
}
.gin-bar:after {
  right:50%; 
}

/* active state */
.gin-input:focus ~ .gin-bar:before, gin-input:focus ~ .gin-bar:after {
  width:100%;
}

/* HIGHLIGHTER ================================== */
.gin-highlight {
  position:absolute;
  height:60%; 
  width:100%; 
  top:25%; 
  left:0;
  pointer-events:none;
  opacity:0.5;
}

/* active state */
.gin-input:focus ~ .gin-highlight {
  -webkit-animation:inputHighlighter 0.3s ease;
  -moz-animation:inputHighlighter 0.3s ease;
  animation:inputHighlighter 0.3s ease;
}

/* ANIMATIONS ================ */
@-webkit-keyframes inputHighlighter {
	from { background:#5264AE; }
  to 	{ width:0; background:transparent; }
}
@-moz-keyframes inputHighlighter {
	from { background:#5264AE; }
  to 	{ width:0; background:transparent; }
}
@keyframes inputHighlighter {
	from { background:#5264AE; }
  to 	{ width:0; background:transparent; }
}

</style>--%>

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
.myAlert-top{
    position: fixed;
    top: 10%; 
    left:8%;
    width: 90%;
}

.myAlert-bottom{
    position: fixed;
    bottom: 10%;
    left:5%;
    width: 90%;
}
.alert{
    display: none;
}
</style>

<style>
.block-ui {
  position: fixed;
  width: 100%;
  height: 100%;
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;
  background-color: black;
  opacity: 0.75;
  display: flex;
  text-align: center;
  z-index: 1100;
}
.block-ui .loading:after {
  content: " ";
  background: black;
  opacity: 0.4;
  pointer-events: none;
  border-radius: 4px;
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
}
.block-ui .loading .loaderwait {
  display: none;
  margin: auto;
  width: 50px;
  height: 30px;
  text-align: center;
  font-size: 10px;
  position: absolute;
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;
  z-index: 1100;
  display: block;
}
.block-ui .loading .loaderwait div {
  background-color: white;
  height: 100%;
  width: 6px;
  display: inline-block;
  animation: stretchdelay 1.2s infinite ease-in-out;
}
.block-ui .loading .loaderwait .rect2 {
  animation-delay: -1.1s;
}
.block-ui .loading .loaderwait .rect3 {
  animation-delay: -1s;
}
.block-ui .loading .loaderwait .rect4 {
  animation-delay: -0.9s;
}
.block-ui .loading .loaderwait .rect5 {
  animation-delay: -0.8s;
}
.block-ui .loading .loaderwait.load2 .loader2 {
  display: block;
}
.block-ui .loading .loaderwait.load3 .loader3 {
  display: block;
}
.block-ui .loading .loaderwait.load4 .loader4 {
  display: block;
}
.block-ui.clear {
  animation: dissappear 1s 1;
  -webkit-animation-fill-mode: forwards;
  animation-fill-mode: forwards;
}
.block-ui .loading-info {
  margin: auto;
  align-content: center;
  align-items: center;
  align-self: center;
}
.block-ui .loading-info .loading-text {
  display: block;
}
.block-ui .loading-info .loading-text .text {
  margin: 0 0 2em 0;
  position: relative;
  z-index: 9;
  color: white;
}
.block-ui .loading-info .loading-text button {
  margin-top: 15px;
  position: relative;
  z-index: 9;
}
@keyframes stretchdelay {
  0%,
  40%,
  100% {
    transform: scaleY(0.4);
  }
  20% {
    transform: scaleY(1);
  }
}
@keyframes dissappear {
  0% {
    opacity: 1;
  }
  99% {
    opacity: 0;
    display: none;
    width: 100%;
    height: 100%;
    margin-top: 0;
    margin-left: 0;
  }
  100% {
    width: 0;
    height: 0px;
    margin-top: -100000px;
    margin-left: -100000000px;
  }
}

</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


<div class="row">
<div class="col-12">
<div class="card card-5 rightmarg"> 
<form class="form-horizontal" runat="server" method="post" enctype="multipart/form-data">    
<div class="card-body">
<div class="row">
<div class="col-md-2">
<div class="form-group">
<label for="ddlFirm">Firm : <span class="text-danger">*</span></label>
<%--<select class="custom-select form-control" id="ddlFirm" onchange="FillFirm()" name="Firm">
</select> --%> 
<div class="div-select-dark">
  <select class="select-dark" name="Firm" id="ddlFirm">
    <%--<option selected disabled> Choose Firm</option>--%>
  </select>
</div>
</div>
</div>
<div class="col-md-2">
<div class="form-group">
<label for="ddlDocType">Document Type : <span class="text-danger">*</span></label>
<%--<select class="custom-select form-control" id="ddlDocType" onchange="FillDocType()" name="Firm">
</select> --%>     
<div class="div-select-dark">
  <select class="select-dark" name="DocType" id="ddlDocType">
    <%--<option selected disabled> Choose Document Type</option>--%>
  </select>
</div>
</div>
</div>
<div class="col-md-2">
<div class="form-group">
<label for="rbnPriority">Priority : </label>

<div id="rbnPriority" class="btn-group"  style="cursor: pointer;">
<a class="btn priority-red btn-sm notActive" data-toggle="hdnPriority" data-title="1">High</a>
<a class="btn priority-orange btn-sm notActive" data-toggle="hdnPriority" data-title="2">Medium</a>
<a class="btn priority-yellow btn-sm active" data-toggle="hdnPriority" data-title="3">Low</a>
</div>
<input type="hidden" name="hdnPriority" id="hdnPriority">
</div>
</div>

<div class="col-md-3 text-left">
<div class="form-group">
<label for="chkCircular">Issue Circular/Office Note?  :</label>
<input type="checkbox" class="toggle" id="chkCircular" />
<label for="chkCircular">
  <span class="on">Yes</span>
  <span class="off">No</span>
</label>
<label for="chkConfidential">Is it Confidential ? :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><input type="checkbox" class="toggle" id="chkConfidential" />
<label for="chkConfidential">
  <span class="on">Yes</span>
  <span class="off">No</span>
</label>
   <%-- <label for="chkCostInvolved">Any cost involved?  : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
<input type="checkbox" class="toggle" id="chkCostInvolved" />
<label for="chkCostInvolved">
  <span class="on">Yes</span>
  <span class="off">No</span>
</label>--%>
</div>
</div>
<%--<div class="col-md-3 text-right">
<div class="form-group">


</div></div>--%>




</div>

<div class="row">




</div>

<div class="row">
<div class="col-md-12">
<%--<div class="form-group">--%>

<%--<label for="txtSubject">Subject : <span class="text-danger">*</span></label>
<div class="input-group mb-3">
<div class="input-group-prepend">
<span class="input-group-text"><i class="mdi mdi-grease-pencil"></i></span>
</div>
<input type="text" class="form-control" id="txtSubject" title="Subject" />
</div>--%>
<%--<div class="gin-group">      
      <input class="gin-input" id="txtSubject1" type="text" required>
      <span class="gin-highlight"></span>
      <span class="gin-bar"></span>
      <label class="gin-label">Subject</label>
    </div>--%>

<label class="pure-material-textfield-outlined">
  <input type="text" placeholder=" "id="txtSubject" title="Subject" maxlength="199" oninput="this.value = this.value.replace(/[^ a-zA-Z0-9&.,_-“”‘’'%]/g, '');" required>
  <span>Subject...</span>
</label>
<%--</div>--%>
</div>

</div>

<div class="row">
<div class="col-md-12">
<%--<div class="form-group">--%>

<%--<label for="txtRemarks">Remarks : <span class="text-danger">*</span></label>
<div class="input-group mb-3">
<div class="input-group-prepend">
<span class="input-group-text"><i class="mdi mdi-grease-pencil"></i></span>
</div>
<input type="text" class="form-control" id="txtRemarks" title="Remarks" />
</div>--%>
<%--<div class="gin-group">      
      <input class="gin-input" id="txtRemarks" type="text" required>
      <span class="gin-highlight"></span>
      <span class="gin-bar"></span>
      <label class="gin-label">Remarks</label>
    </div>--%>

<label class="pure-material-textfield-outlined">
<%--  <textarea placeholder=" "id="txtRemarks" title="Remarks"/>--%>
    <textarea rows="1" cols="25" name="Remarks" id="txtRemarks" maxlength="3500" title="Remarks" oninput="this.value = this.value.replace(/[^-@.,/#&+\w\s]/g, '');">
</textarea>
  <span>Remarks</span>
</label>
<%--</div>--%>
</div>
</div>

<div class="row">
<div class="col-md-12">
    <%--<div class="loaderColor">
<div class="loaderColor--dot"></div>
<div class="loaderColor--dot"></div>
<div class="loaderColor--dot"></div>
<div class="loaderColor--dot"></div>
<div class="loaderColor--dot"></div>
<div class="loaderColor--dot"></div>
<div class="loaderColor--text"></div>
</div>--%>
<div class="form-group" style="width:790px; max-width:790px; ">
<%--<label for="summernote">Content : <span class="text-danger">*</span></label>--%>
    
<div class="summernote" >
<%--<h4></h4>--%>
</div>
    <span id="total-caracteres"></span>
</div>
</div>

</div>




<%--<div class="row">
     <div class="loaderColor">
<div class="loaderColor--dot"></div>
<div class="loaderColor--dot"></div>
<div class="loaderColor--dot"></div>
<div class="loaderColor--dot"></div>
<div class="loaderColor--dot"></div>
<div class="loaderColor--dot"></div>
<div class="loaderColor--text"></div>
</div>
</div>--%>
<div class="row">
<div class="col-md-7">
<div class="form-group">
    <div class="input-group">

   

    <table>
        <tr><td><label for="rbnApproverType">Approver Type  : <span class="text-danger">*</span></label></td>
            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td><label for="rbnApproverType">Cost in rupees : <span class="text-danger">*</span></label>  </td></tr>
      
        <tr><td>
            <div id="rbnApproverType" class="btn-group"  style="cursor: pointer;">
<a class="btn btn-dark btn-sm active" data-toggle="hdnApproverType" data-title="S" id="SeqA">Sequential</a>
<a class="btn btn-dark btn-sm notActive" data-toggle="hdnApproverType" data-title="P" >Parallel</a>
</div>
            </td>  <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td>  <input type="text" id="txt_cost"  onfocus="if(this.value=='') this.value='';" onkeypress="return onlyNos(event,this);" ondrop="return false" onblur="if(this.value=='') this.value='';" /></td></tr>
    </table>
        <input type="hidden" name="hdnApproverType" id="hdnApproverType">

</div>


     



</div>
<div class="col-md-12" id="parallelrow">
<%--<div class="row" id="p_rowid">      
</div>--%>

</div>
</div>

<div class="col-md-5">
<div class="form-group">
 <label for="rdbNature">Attach File  : </label>   
<%--<div class="file-upload">
<div class="file-select">
<div class="file-select-button" id="fileName">Choose File</div>
<div class="file-select-name" id="noFile">No file chosen...</div> 
<input type="file" name="chooseFile" id="fileUploaded">
</div>
</div>--%>
<%--<form method="post" class="file-uploader" enctype="multipart/form-data">--%>
  <div class="file-upload">
<div class="file-select">
<div class="file-select-button" id="fileName">Choose File</div>
<div class="file-select-name" id="noFile">No file chosen...</div> 
    <div class="file-chooser">
<input type="file" <%--name="chooseFile" id="fileUploaded"--%> class="file-chooser__input">
     </div>
</div>
</div>
    <%--<div class="file-chooser">
    <input class="file-chooser__input" type="file">
  </div>--%>
  <div class="file-uploader__message-area">
    <p>Select a file to upload</p>
  </div>
  
 <%-- <input class="file-uploader__submit-button" type="submit" value="Upload">--%>
<%--</form>--%>

</div>
</div>


</div>

<div class="row">


</div>
<div class="row">
<div class="col-md-12">
<div class="form-group"> 
<%--<label for="rbnApproverType">Add New Approver  : <span class="text-danger">*</span></label>
<div class="col-md-3">
    <button id="addPara" type="button" class="btn btn-primary" data-toggle="tooltip" data-original-title="Add New"><i class="fa fa-plus" aria-hidden="true"></i>&nbsp; Add&nbsp;</button>
</div>--%>

</div>
</div>
</div>
<div class="row">
<%--<div class="col-md-12">
<div class="form-group"> --%>    
<%--<div class="buttonbox"> 
<input id="btnconfirm" type="button" value="Confirm" class="btn-input" onclick="return ReqNoteCofirm();" data-toggle="modal" data-backdrop="false"/>
<input id="btnexit" type="button" value="Exit" class="btn-input" onclick="return frmExit();" data-toggle="modal" data-backdrop="false"/>
</div>--%>
<div class="col-md-2 col-sm-2 col-xs-4"> <a href="#" class="btn btn-sm animated-button thar-one btn-primary" style="width: 100%;
margin: 5px;"onclick="return ReqNoteCofirm();" id="btnSubmit"><i class="fa fa-check"></i> Confirm</a> </div>
    <div class="col-md-2 col-sm-2 col-xs-4"> <a href="#" class="btn btn-sm animated-button thar-one btn-red" style="width: 100%;
margin: 5px;" onclick="return frmExit();"><i class="fa fa-sign-out-alt"></i> Exit</a> </div>
<%--</div>
</div>--%>
    
</div>



</div>
</form> 
<%-- <div class="row" id="showSubmitBtn">
    <div class="col-md-2 col-sm-2 col-xs-4"> <a href="#" class="btn btn-sm animated-button thar-one btn-primary" style="width: 100%;
margin: 5px;"onclick="return ReqNoteCofirm();" id="btnSubmit"><i class="fa fa-thumbs-up"></i> Submit</a> </div>
    <div class="col-md-2 col-sm-2 col-xs-4"> <a href="#" class="btn btn-sm animated-button thar-one btn-red" style="width: 100%;
margin: 5px;" onclick="return frmExit();"><i class="fa fa-sign-out-alt"></i> Exit</a> </div>

</div>--%>   
</div>
</div>
</div>

   
<div class="alertSuccess myAlert-top alert alert-success" role="alert">
  <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
  <i class="fa fa-check"></i><strong> Success! </strong> <span id="msgSuccess"></span>
</div>
<div class="alertWarning myAlert-top alert alert-warning" role="alert">
  <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
  <i class="fa fa-exclamation-triangle"></i><strong> Warning! </strong> <span id="msgWarning"></span>
</div>
<div class="alertDanger myAlert-top alert alert-danger" role="alert">
  <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
  <i class="fa fa-exclamation-circle"></i><strong> Alert! </strong> <span id="msgDanger"></span>
</div>
 <div class="block-ui clear">
          <div class="loading-info">
            <div class="loading-text loading">
              <div class="text"> Please Wait...</div>
              <div class="loaderwait" role="progressbar">
                <div class="rect1"></div>
                <div class="rect2"></div>
                <div class="rect3"></div>
                <div class="rect4"></div>
                <div class="rect5"></div>
              </div>
            </div>
          </div>
        </div>   

<input id="hdUserId" type="hidden" runat="server"/>
        <input id="hdBranchId" type="hidden" runat="server"/>
        <input id="hdFirmId" type="hidden" runat="server"/>
     <input id="hdSesssion" type="hidden" runat="server"/>
     <input id="hdNoteID" type="hidden" runat="server"/>
</asp:Content>

<%--<div class="btn-group" data-toggle="buttons" role="group"style="width: 100%;">
<label class="btn btn-outline btn-dark">
<div class="custom-control custom-radio"  style="cursor: pointer;">
<input type="radio" id="rdbPara" name="rdbApprovType" value="parallel" class="custom-control-input" style="cursor: pointer;">
<label class="custom-control-label fa-xs" for="rdbPara" style="cursor: pointer;"> <i class="ti-check text-active" aria-hidden="true"></i>Parallel</label>
</div>
</label>
<label class="btn btn-outline btn-dark" >
<div class="custom-control custom-radio" style="cursor: pointer;">
<input type="radio" id="rdbSeq" name="rdbApprovType" value="sequential" class="custom-control-input fa-xs"  style="cursor: pointer;">
<label class="custom-control-label fa-xs" for="rdbSeq"  style="cursor: pointer;"> <i class="ti-check text-active" aria-hidden="true"></i> Sequential</label>
</div>
</label>
<label class="btn btn-outline btn-dark" >
<div class="custom-control custom-radio" style="cursor: pointer;">
<input type="radio" id="rdbFinalAppr" name="rdbApprovType" value="FinalApprover" class="custom-control-input"  style="cursor: pointer;">
<label class="custom-control-label fa-xs" for="rdbFinalAppr"  style="cursor: pointer;"> <i class="ti-check text-active" aria-hidden="true"></i> Final Approver</label>
</div>
</label>
</div>--%>

<%--<div class="btn-group" data-toggle="buttons" role="group"style="width: 100%;">
<label class="btn btn-outline btn-dark">
<div class="custom-control custom-radio"  style="cursor: pointer;">
<input type="radio" id="rdbHigh" name="rdbPriority" value="high" class="custom-control-input" style="cursor: pointer;border: 0px;">
<label class="custom-control-label fa-xs" for="rdbHigh" style="cursor: pointer;"> <i class="ti-check text-active" aria-hidden="true"></i>High</label>
</div>
</label>
<label class="btn btn-outline btn-dark" >
<div class="custom-control custom-radio" style="cursor: pointer;">
<input type="radio" id="rdbMedium" name="rdbPriority" value="medium" class="custom-control-input"  style="cursor: pointer;">
<label class="custom-control-label fa-xs" for="rdbMedium"  style="cursor: pointer;"> <i class="ti-check text-active" aria-hidden="true"></i> Medium</label>
</div>
</label>
<label class="btn btn-outline btn-dark" >
<div class="custom-control custom-radio" style="cursor: pointer;">
<input type="radio" id="rdbLow" name="rdbPriority" value="low" class="custom-control-input"  style="cursor: pointer;">
<label class="custom-control-label fa-xs" for="rdbLow"  style="cursor: pointer;"> <i class="ti-check text-active" aria-hidden="true"></i> Low</label>
</div>
</label>
</div>--%>

<%--<div class="form-group">
<label for="rdbConfid">Nature of Note  : <span class="text-danger">*</span></label>
<div class="btn-group" data-toggle="buttons" role="group"style="width: 100%;">
<label class="btn btn-outline btn-dark">
<div class="custom-control custom-radio"  style="cursor: pointer;">
<input type="radio" id="rdbConfid" name="rdbNature" value="Confidential" class="custom-control-input" style="cursor: pointer;">
<label class="custom-control-label fa-xs" for="rdbConfid" style="cursor: pointer;"> <i class="ti-check text-active" aria-hidden="true"></i>Confidential</label>
</div>
</label>
<label class="btn btn-outline btn-dark" >
<div class="custom-control custom-radio" style="cursor: pointer;">
<input type="radio" id="rdbNonConfid" name="rdbNature" value="Non-Confidential" class="custom-control-input"  style="cursor: pointer;">
<label class="custom-control-label fa-xs" for="rdbNonConfid"  style="cursor: pointer;"> <i class="ti-check text-active" aria-hidden="true"></i> Non-Confidential</label>
</div>
</label>
</div>

</div>--%>

<%--<div class="rowAccord">
<div class="col">
<div class="tabs">
<div class="tab" id="ShowContent" >
<input type="checkbox" id="chck1" class="inputAccord"/>
<label class="tab-label" for="chck1">Add Content :</label>
<div class="tab-content">

</div>
</div>
<div class="tab" id="ShowAttach" >
<input type="checkbox" id="chck2" class="inputAccord"/>
<label class="tab-label" for="chck2">Add Attachement :</label>
<div class="tab-content">

</div>
</div>
</div>
</div>
</div>--%>