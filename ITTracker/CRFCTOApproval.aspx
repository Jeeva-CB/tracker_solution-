<%@ Page Title="" Language="C#" MasterPageFile="~/PWA_Master.Master" AutoEventWireup="true" CodeBehind="CRFCTOApproval.aspx.cs" Inherits="ITTracker.CRFCTOApproval" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="js/CTOApprove.js"></script>
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

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <center>
        <label id="error" style="color:red;display:none">Please select a CRF..!</label>
                <div class="row">
                    <div id="div1" class="form-group col-md-12  padding-bottom-10px" style="color: black;">
                        <label class="col-md-3 align-right "><span class="required"></span></label>
                        <div class="col-md-6 align-left"><table><tr><td>
                            </td><td><select class="form-control dd-list" id="ddlCrf" style="width:650px; color:maroon;" name="CRF_Sel" onchange="fillCRFData()">
                                <option value="-1">Choose CRF</option>
                            </select></td></tr></table>
                        </div>
                    </div>
                </div>
               <div class="padding-bottom-10px p-t-40"></div>
                <div id="snote" class="form-group col-md-12 padding-bottom-10px" style="color: black; display:none"contenteditable="false">
                    <label class="col-md-3 align-right " id="myLargeModalLabel">Note Content: </label>
                    <div class="summernoteview" id="content" >
                    </div>
                </div>
        <div id="textgroup1" style="display:none">
        <table><tr><td class=" col-md-3 align-right">
                
                    <label >Request Type : </label></td><td>
                    

                        <input type="text" readonly  class="form-control align-center"  id="lblType" style="width: 150px; color:maroon">
                   </td>
                
           <td class=" col-md-3 align-right">
                
                    <label>Requested By: </label></td><td>
                    

                        <input type="text" class="form-control align-center" readonly id="lblReqtr" style="width: 150px; color:maroon">
                   
                        </td></tr><tr><td class=" col-md-3 align-right">
                    <label >It Team : </label></td><td>
                    

                        <input type="text" readonly class="form-control align-center" id="lblTeam" style="width: 200px; color:maroon">
                    </td><td class=" col-md-3 align-right">
                
                
                    
                    <label >Target Date : </label></td><td>
                    

                        <input type="text" class="form-control align-center"  id="lblTarDt" style="width: 150px; color:maroon" readonly >
                    </td></tr>
            <tr><td class=" col-md-3 align-right">
                    <label >Priority : </label></td><td>
                    

                        <input type="text" readonly class="form-control align-center" id="lblpri" style="width: 150px; color:maroon">
                    </td><td class=" col-md-3 align-right">
                
                
                    
                    <label >Requested Date : </label></td><td>
                    

                        <input type="text" class="form-control align-center"  id="lblreqdt" style="width: 150px; color:maroon" readonly >
                    </td></tr>
            </table></div>
        <br />
        <div id="atta" style="display:none">
        
                    <label class=" col-md-3 align-right" id="lblFiles">Attached Files : </label>
                    <div class="table-responsive">
                        <table class="table1 table-hover" id="tblFiles">
                        </table>
                    </div>
                
        </div>
                <br />
        <br />
        <div class="form-group col-md-12  padding-bottom-10px" id="DivShwTbl" style="display: none">
                            <table class="table table-hover" id="tabChange">
                                  
                            </table>
                        </div>
        <br />
                
        <br />
        <div id="remar" style="display:none">
        <label class="pure-material-textfield-outlined">

    <textarea rows="1" cols="10" name="Remarks" id="txtRemarks" maxlength="3500" title="Remarks" oninput="this.value = this.value.replace(/[^-@.,/#&+\w\s]/g, '');" required>
</textarea>
  <span>Remarks</span>
</label>
            </div>
        
        <br />
        <br />
        <br />
      
        <div id="buttongro">
        <table><tr>
        <td  id="showSubmitBtn"class="col-md-2 col-sm-2 col-xs-4">
     <a href="#" class="btn btn-sm animated-button thar-one btn-primary" style="width: 100%;
margin: 5px;"onclick="return approve();" id="btnSubmit"><i class="fa fa-thumbs-up"></i> Confirm</a> </td><td  id="showRejectBtn"class="col-md-2 col-sm-2 col-xs-4">
     <a href="#" class="btn btn-sm animated-button thar-one btn-primary" style="width: 100%;
margin: 5px;"onclick="return reject();" id="btnReject"><i class="fa fa-thumbs-down"></i> Reject</a> </td>
    <td class="col-md-2 col-sm-2 col-xs-4"> <a href="#" class="btn btn-sm animated-button thar-one btn-red" style="width: 100%;
margin: 5px;" onclick="return frmExit();"><i class="fa fa-sign-out-alt"></i> Exit</a> </td>

</tr>
      </table>  
            </div>
       
        

</center>
    <input id="hdUserId" type="hidden" runat="server"/>
        <input id="hdBranchId" type="hidden" runat="server"/>
        <input id="hdFirmId" type="hidden" runat="server"/>
      <input id="hdnReturnStatus" type="hidden" runat="server"/>
    <input id="hdnAllEmployees" type="hidden" runat="server"/>
    <input id="hdnquerynoteid" type="hidden" runat="server"/>
    <input id="hdnContentNoteId" type="hidden" runat="server"/>
     <input id="hdnReqEmp" type="hidden" runat="server"/>
    <input id="hdnSystemIP" type="hidden" runat="server"/>
     <input id="hdSesssion" type="hidden" runat="server"/>
    <input id="hdEditOption" type="hidden" runat="server"/>
    <input id="hdnDiscussResStatus" type="hidden" runat="server"/>
      <input id="hdEditedContent" type="hidden" runat="server"/>
    <input id="DocTypenew" type="hidden" runat="server"/>
  
</asp:Content>
