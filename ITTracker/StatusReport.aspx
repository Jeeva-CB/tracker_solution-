<%@ Page Title="" Language="C#" MasterPageFile="~/PWA_Master.Master" AutoEventWireup="true" CodeBehind="StatusReport.aspx.cs" Inherits="ITTacker.StatusReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="js/Report.js?v=2"></script>
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="row col-12">
   <div class="col-12">
    <div class="card card-5 rightmarg"> 
      <form class="form-horizontal" runat="server" method="post" enctype="multipart/form-data">    
        <div class="card-body">
          <div class="row">
            <div class="col-md-2 form-group">
               <label for="ddlFirm">Firm :</label>
                <div class="div-select-dark">
                   <select class="select-dark" name="Firm" id="ddlFirm"> </select>
                </div>
            </div>
            <div class="col-md-2 form-group">
              <label for="ddlDocType">Document Type :</label> 
              <div class="div-select-dark">
                <select class="select-dark" name="DocType" id="ddlDocType"> </select>
              </div>
           </div>
           <div class="col-md-2 form-group">
              <label for="ddlDocType">Department :</label> 
              <div class="div-select-dark">
                <select class="select-dark" name="Dept" id="ddlDept"> </select>
              </div>
           </div>
           <div class="col-md-2 form-group">
              <label for="ddlDocType">Status :</label> 
              <div class="div-select-dark">
                <select class="select-dark" name="Dept" id="ddlStatus"> </select>
              </div>
           </div>
           <div class="col-md-2 form-group"> 
             <label for="rbnPriority">Priority : <span class="text-danger">*</span></label>
              <div id="rbnPriority" class="btn-group"  style="cursor: pointer;">
                  <a class="btn btn-dark  btn-sm active" data-toggle="hdnPriority" data-title="-1">All</a>
                <a class="btn priority-red btn-sm notActive" data-toggle="hdnPriority" data-title="1">High</a>
                <a class="btn priority-orange btn-sm notActive" data-toggle="hdnPriority" data-title="2">Medium</a>
                <a class="btn priority-yellow btn-sm notActive" data-toggle="hdnPriority" data-title="3">Low</a>
             </div>
             <input type="hidden" name="hdnPriority" id="hdnPriority">
           </div>
           <div class="col-md-2 form-group">
                 <label for="chkCircular">Circular/Office Note?  :</label>
                    <input type="checkbox" class="toggle" id="chkCircular" />
                     <label for="chkCircular"> <span class="on">Yes</span>  <span class="off">No</span> </label>
           </div>
           <div class="col-md-2">
              <label for="chkCircular"></label>
              <label class="pure-material-textfield-outlined">
                <input type="text" placeholder=""id="txtSubject" title="Subject">
                <span>Subject...</span>
                </label>
          </div>
         </div>
         <div class="row">
           <div class="col-md-12 form-group">
              <div class="buttonbox"> 
                <input id="btnconfirm" type="button" value="Generate" class="btn-input" onclick="return GenerateRpt();" data-toggle="modal" data-backdrop="false"/>
                <input id="btnexit" type="button" value="Exit" class="btn-input" onclick="return frmExit();" data-toggle="modal" data-backdrop="false"/>
               </div>
           </div>
          </div>


<div class="row">
<div class="col-md-12">
<div class="form-group"  style="display: none;" id="rptReportDiv">
<div class="row">
<div class="col-md-4">
Priority Status: <i class='fa fa-circle' style='color:#FF0000; font-size: 10px; padding-right: 2px;'></i> - High  <i class='fa fa-circle' style='color:#fb8c00; font-size: 10px; padding-right: 2px;'></i> - Medium <i class='fa fa-circle' style='color:#fdee30; font-size: 10px; padding-right: 2px;'></i> - Low
<br/>

</div>
<div class="col-md-8 text-right">
</div>
</div>
<div class="table-responsive">
<table class="table table-hover table-success" id="tblSearchReport" style="table-layout:fixed;"> 
<thead class="bg-success text-white">
<tr >                                 
</tr> 
</thead> 
<tbody class="border border-dark"></tbody>
</table> 
</div>
</div>
</div>
</div>

<div class="row">
<div class="col-md-12">
<div class="form-group" style="display: none;" id="rptEmptyDiv">
<div style="font-size: 18px; text-align: center;"><i class="fa fa-filter fa-5x" aria-hidden="true" style="opacity: 0.5;"></i></div>
<div style="font-size: 18px; text-align: center;">    <h5>We didn't find anything...</h5></div>
    <div style="font-size: 12px; text-align: center;">    Try a different keyword...</div>
</div>



</div>
</div>
        </div>
      </form>      
    </div>
   </div>
</div>



        <input id="hdUserId" type="hidden" runat="server"/>
        <input id="hdBranchId" type="hidden" runat="server"/>
        <input id="hdFirmId" type="hidden" runat="server"/>
</asp:Content>
