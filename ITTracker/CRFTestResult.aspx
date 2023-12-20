<%@ Page Title="" Language="C#" MasterPageFile="~/PWA_Master.Master" AutoEventWireup="true" CodeBehind="CRFTestResult.aspx.cs" Inherits="ITTracker.CRFTestResult" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="js/TestResult.js" + "new Date().getTime()"></script>
    <link href="css/MultipleUpload.css" rel="stylesheet"/>
    <script src="js/MultipleUpload.js"></script>
    <script src="js/aes.js"></script>
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
        .radio-tile-group {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
        }

            .radio-tile-group .input-container {
                position: relative;
                height: 2.0rem;
                width: 8rem;
                margin: 0.3rem;
            }

                .radio-tile-group .input-container .radio-button {
                    opacity: 0;
                    position: absolute;
                    top: 0;
                    left: 0;
                    height: 100%;
                    width: 100%;
                    margin: 0;
                    cursor: pointer;
                }

                .radio-tile-group .input-container .radio-tile {
                    display: flex;
                    flex-direction: column;
                    align-items: center;
                    justify-content: center;
                    /*width: 100%;*/
                    height: 100%;
                    border: 2px solid #001d28;
                    border-radius: 5px;
                    /*padding: 1rem;*/
                    transition: transform 300ms ease;
                }

                .radio-tile-group .input-container .radio-tile-label {
                    text-align: center;
                    font-size: 0.75rem;
                    font-weight: 400;
                    /*text-transform: uppercase;*/
                    letter-spacing: 1px;
                    color: #001d28;
                    margin-bottom: 0;
                }

                .radio-tile-group .input-container .radio-tile-i {
                    color: #001d28;
                }

                .radio-tile-group .input-container .radio-button:checked + .radio-tile {
                    background-color: #001d28;
                    border: 2px solid #001d28;
                    color: white;
                    transform: scale(1.1, 1.1);
                }

                    .radio-tile-group .input-container .radio-button:checked + .radio-tile .icon svg {
                        fill: white;
                        background-color: #001d28;
                    }

                    .radio-tile-group .input-container .radio-button:checked + .radio-tile .radio-tile-label {
                        color: white;
                        background-color: #001d28;
                    }

                    .radio-tile-group .input-container .radio-button:checked + .radio-tile .radio-tile-i {
                        color: white;
                    }
    </style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="card card-5 rightmarg">
        <form class="form-inline" runat="server" method="post" enctype="multipart/form-data">
                 <div class="card-body">

                <div class="row">
            <label class="col-md-1 align-left ">CRF <span class="required">*</span> </label>
             <div class="col-md-10 align-left">
               <select id="ddlCrf" class="form-control" style="width:100%;" name="CRF_Sel" onchange="fillCRFData()">
                   <option value="-1">Choose CRF</option>
                      </select>
                 </div>
           
           </div>
               <div class="padding-bottom-10px p-t-40"></div>
                <div class="row" style="padding-top:10px">
   
                 <label class="col-md-1 align-right " id="myLargeModalLabel">Content </label>
                <div id="snote" class="form-group col-md-10 padding-bottom-10px" style="color: black; display:block; text-align:initial;" contenteditable="false">
                  
                    <div class="summernoteview" id="content" >
                    </div>
                </div>
                 </div>
              
                     <div id="CrfDetailsID" style="display: none">
                         <div class="form-group row col-md-12 padding-bottom-10px" style="color: black;">
                             <label class=" col-md-2 align-right">IT Team : </label>
                             <div class="col-md-2 align-left">
                                 <label class="align-left" id="lblTeam" style="width: 150px; color: maroon"></label>
                             </div>
                             <label class=" col-md-2 align-right">Request Type : </label>
                             <div class="col-md-2 align-left">
                                 <label class="align-left" id="lblType" style="width: 150px; color: maroon"></label>
                             </div>
                             <label class=" col-md-2 align-right">Developer : </label>
                             <div class="col-md-2 align-left">
                                 <label class="align-left" id="lblReqtr" style="width: 150px; color: maroon"></label>
                             </div>
                         </div>
                         <div class="form-group row col-md-12 padding-bottom-10px" style="color: black;">

                             <label class=" col-md-2 align-right">User Expected Date : </label>
                             <div class="col-md-2 align-left">
                                 <label class="align-left" id="lblUserExpectDate" style="width: 150px; color: maroon"></label>
                             </div>
                             <label class=" col-md-2 align-right">Priority : </label>
                             <div class="col-md-2 align-left">
                                 <label class="align-left" id="lblPrior" style="width: 150px; color: maroon"></label>
                             </div>
                             <label class=" col-md-2 align-right">Dvlpmt Complete Date : </label>
                             <div class="col-md-2 align-left">
                                 <label class="align-left" id="lblTarDt" style="width: 100%; color: maroon"></label>
                             </div>
                             <label class=" col-md-2 align-right">Error Report Impact : </label>
                             <div class="col-md-2 align-left">
                                 <label class="align-left" id="lblErrorImpact" style="width: 150px; color: maroon"></label>
                             </div>
                             <label class=" col-md-2 align-right" id="lblBugF" style="color: blueviolet"><b>Bug Found :</b></label>
                             <div class="col-md-2 align-left" id="divBugF">
                                 <div class="form-group">
                                     <input type="checkbox" class="toggle" id="applicableOption" onchange="ApplicableHide();" />
                                     <label for="applicableOption">
                                         <span class="on">Yes</span>
                                         <span class="off">No</span>
                                     </label>
                                 </div>
                             </div>
                         </div>
                     </div>
                     <hr/>
                        <div class="col-md-6">
                             <h4 class="panel-group col-md-12 align-center padding-bottom-10px" id="lblFiles">Attached Files</h4>
                             <div class="table-responsive">
                                 <table class="table1 table-hover" id="tblFilesU">
                                 </table>
                             </div>
                         </div>



                       <div class="col-md-12 row" >
                <div id="Doc1" class="panel-group col-md-6  padding-bottom-10px">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title align-left"><a data-toggle="collapse" href="#collapse12">Test Cases  <i class="fa fa-arrow-alt-circle-down"></i></a></h3>
                        </div>
                        <div id="collapse12" class="panel-collapse collapse">
                            <div class="panel-body">
                                <div class="table-responsive">
                                    <table class="table1 table-hover" id="tblTestCase"></table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                           
                    <%-- <div id="Doc2" class="panel-group col-md-4   padding-bottom-10px">
                         <div class="panel panel-default">
                             <div class="panel-heading">
                                 <h3 class="panel-title align-left"><a data-toggle="collapse" href="#collapse13">Test Request Form  <i class="fa fa-arrow-alt-circle-down"></i></a></h3>
                             </div>
                             <div id="collapse13" class="panel-collapse collapse">
                                 <div class="panel-body">
                                     <div class="table-responsive">
                                         <table class="table1 table-hover" id="tblTestrqstfrm"></table>
                                     </div>
                                 </div>
                             </div>
                         </div>
                     </div>--%>

                        <div id="Doc3" class="panel-group col-md-6   padding-bottom-10px">
                         <div class="panel panel-default">
                             <div class="panel-heading">
                                 <h3 class="panel-title align-left"><a data-toggle="collapse" href="#collapse14">Test Request Form  <i class="fa fa-arrow-alt-circle-down"></i></a></h3>
                             </div>
                             <div id="collapse14" class="panel-collapse collapse">
                                 <div class="panel-body">
                                     <div class="table-responsive">
                                         <table class="table1 table-hover" id="tblTestrqstfrm"></table>
                                     </div>
                                 </div>
                             </div>
                         </div>
                     </div>

                   </div>
                     <br/>

                        <div id="TestingTA" class="panel-group col-md-12 align-center padding-bottom-10px">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title align-left"><%--<a data-toggle="collapse" href="#collapse2">--%>Testing TA Details<%--</a>--%></h3>
                        </div>
                        <%--<div id="collapse2" class="panel-collapse collapse">--%>
                            <div class="panel-body">
                                <div class="table-responsive">
                                    <table class="table1 table-hover" id="tblTestingTADtls">
                                    </table>
                                </div>
                            </div>
                        <%--</div>--%>
                    </div>
                </div>

                  <div class="form-group" id="divtblPrincpleIntDtl"  data-toggle="tooltip" data-placement="top" title="select row">
                             <table class="table table-hover align-center " id="tblticket" onmousedown="gr()" >
                                 <tbody>
                                 </tbody>
                             </table>
                         </div>
                     <hr/>
                     <div id="DivBug" style="display:none">
                         <h5 style="align-items: center; align-content: center">Bug Details</h5>
                         <br />
                         <div class="form-group row col-md-11" style="padding-bottom: 10px;">
                             <label class="col-md-2 align-left  ">Subject : </label>
                             <div class="col-md-10">
                                 <input type="text" placeholder="Bug Subject.." class="form-control" style="width: 100%" id="txtSubject" title="Subject" />
                             </div>
                         </div>
                         <div class="form-group row col-md-11" style="padding-bottom: 10px;">
                             <label class="col-md-2 align-left  ">Description : </label>
                             <div class="col-md-10 ">
                                 <textarea rows="1" style="width: 100%;" class="form-control" name="Remarks" id="txtDescription" maxlength="3500" title="Remarks" oninput="this.value = this.value.replace(/[^-@.,/#&+\w\s]/g, '');">
                                </textarea>
                             </div>
                         </div>

                         <div class="form-group row col-md-11" style="padding-bottom: 10px;" id="BugDetails">
                             <label class="col-md-2 align-left  ">Date : </label>
                             <div class="col-md-4">
                                 <input type="text" placeholder="Date.." class="form-control" style="width: 100%" id="txtFromDate" title="Subject" />
                             </div>
                             <label class="col-md-2 align-left  ">Environment  : </label>
                             <div class="col-md-4 align-left">
                                 <select id="ddlEnvironment" class="form-control" style="width: 100%;" name="Environment">
                                     <option value="-1">Choose Environment</option>
                                 </select>
                             </div>

                         </div>
                         <div class="form-group row col-md-11" style="padding-bottom: 10px;">
                             <label class="col-md-2 align-left  ">Severity : </label>
                             <div class="col-md-4 align-left">
                                 <select id="ddlPriority" class="form-control" style="width: 100%;" name="Priority">
                                     <option value="-1">Choose Priority</option>
                                 </select>
                             </div>
                               <div class="col-md-6 row col-sm-2 col-xs-4">
                                <label class="pure-material-textfield-outlined">
                                 <textarea rows="1" cols="1" name="Remarks" id="txtBugRemarks" maxlength="100" title="Remarks" oninput="this.value = this.value.replace(/[^-@.,/#&+\w\s]/g, '');">
                                 </textarea>
                                 <span>Remark</span>
                             </label>
                             </div>   

                         </div>
                         <div class="form-group row col-md-11" style="padding-bottom: 10px;">

                             <label class="col-md-2 align-left  ">Bug Status : </label>

                             <div class="col-md-4 align-left">
                                 <select id="ddlBugstatus" class="form-control" style="width: 100%;" name="Priority">
                                     <%--<option value="-1">Choose Status</option>--%>
                                 </select>
                             </div>
                             <label class="col-md-2 align-left  "></label>

                             <div class="col-md-2 align-left buttonbox">
                                 <input id="btnAdd" type="button" style="height: 90%; width: 100%;" value="Add" class="btn-input fa-text-height" onclick="return CalTotal();" data-toggle="modal" data-backdrop="false" />
                                  <input id="btnSubmitD" type="button" style="height: 90%; display:none; width: 100%;" value="Submit" class="btn-input fa-text-height" onclick="return BugFix();" data-toggle="modal" data-backdrop="false" />
                             </div>
                         </div>
                         <div class="form-group">
                             <table class="table table-hover align-center " id="tabChange">
                                 <tbody>
                                 </tbody>
                             </table>
                         </div>
                     </div> 
                <hr/>
                
                      <div class="row" style="display:none">

                   
                     <div class="row col-md-2 "></div>
                     <div class="row col-md-10">
                         <div class="col-md-5 text-center">
                         
                             <button type="button" style="height: 100%; font-size:12px" class="btn btn-block btn-outline-primary font-10 card-5" onclick="ReportShow();"><i class="fa fa-file-alt"></i>  Bug Tracking Report</button>
                         </div>

                         <div class="col-md-5 text-center">
                             <button type="button" style="height: 100%;font-size:12px" class="btn btn-block btn-outline-danger font-10 card-5" data-toggle="modal" data-target=".bs-example-modal-lg2" onclick="ShowContentFlow();"><i class="fa fa-users"></i>  Bug Tracking Workflow</button>
                         </div>
                     </div>
                             </div>
           
               <div class="col-md-12 row" >
                <div id="Doc" class="panel-group col-md-6  padding-bottom-10px">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title align-left"><a data-toggle="collapse" href="#collapse1">Attached By Tester  <i class="fa fa-arrow-alt-circle-down"></i></a></h3>
                        </div>
                        <div id="collapse1" class="panel-collapse collapse">
                            <div class="panel-body">
                                <div class="table-responsive">
                                    <table class="table1 table-hover" id="tblFiles"></table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                     <div id="DocD" class="panel-group col-md-6   padding-bottom-10px">
                         <div class="panel panel-default">
                             <div class="panel-heading">
                                 <h3 class="panel-title align-left"><a data-toggle="collapse" href="#collapse1D">Attached By Developer  <i class="fa fa-arrow-alt-circle-down"></i></a></h3>
                             </div>
                             <div id="collapse1D" class="panel-collapse collapse">
                                 <div class="panel-body">
                                     <div class="table-responsive">
                                         <table class="table1 table-hover" id="tblFilesD"></table>
                                     </div>
                                 </div>
                             </div>
                         </div>
                     </div>
                </div>
                <div id="UAT" style="display:none" class="panel-group col-md-12 align-center padding-bottom-10px">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title align-left"><a data-toggle="collapse" href="#collapse2">UAT Details</a></h3>
                        </div>
                        <div id="collapse2" class="panel-collapse collapse">
                            <div class="panel-body">
                                <div class="table-responsive">
                                    <table class="table1 table-hover" id="tblUatDtls">
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
        
                
                     <div class="form-group row col-md-12 padding-bottom-10px " id="parallelrow">
                         <div class="form-group col-md-2 panel-title align-right">
                             <label for="rdbNature">Attach File  <i class="fa fa-arrow-alt-circle-right"></i></label>
                         </div>
                         <div class="file-upload col-md-4">
                             <div class="file-select">
                                 <div class="file-select-button" id="fileName">Choose File</div>
                                 <div class="file-select-name" id="noFile">No file chosen...</div>
                                 <div class="file-chooser">
                                     <input type="file" <%--name="chooseFile" id="fileUploaded"--%> class="file-chooser__input" />
                                 </div>
                             </div>
                         </div>
                         <div class="file-uploader__message-area">
                             <p>Select a file to upload</p>
                         </div>

                     </div>
    
                     <%-- WorkFlowTree --%>
                     <div class="card" id="contentModelFlow" style="background-color: #e5e5e5;">
                         <div class="card-body">
                             <!-- sample modal content -->
                             <div class="modal bs-example-modal-lg2" tabindex="-1" role="dialog" aria-labelledby="lblFlow" aria-hidden="true" data-keyboard="false" data-backdrop="static">
                                 <div class="modal-dialog modal-max1">
                                     <div class="modal-content">
                                         <div class="modal-header">
                                             <h4 class="modal-title" id="lblFlow">Work Flow</h4>
                                             <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="HideContentFlow();">×</button>
                                         </div>
                                         <div class="modal-body vh-75 scrollable">
                                             <div class="card animated bounceIn" style="background-color: #e5e5e5;" id="WorkFlowSection">

                                                 <section class="timeline1">
                                                 </section>

                                             </div>
                                         </div>
                                         <div class="modal-footer">
                                             <button type="button" class="btn btn-danger waves-effect text-left" data-dismiss="modal" onclick="HideContentFlow();">Close</button>
                                         </div>
                                     </div>
                                     <!-- /.modal-content -->
                                 </div>
                                 <!-- /.modal-dialog -->
                             </div>
                             <!-- /.modal -->
                         </div>
                     </div><hr/>
                     <div id="DivTestStatus" class="form-group row col-md-11" style="padding-bottom: 10px;">

                         <label class="col-md-2 align-left  ">Test Stage : </label>

                         <div class="align-left col-md-4 align-center">
                             <label class="radio-inline align-left" />
                             <input type="radio" name="opttest" class="form-control radio-button" id="Initial" value="Initial" checked="checked" />&nbsp;<b>Initial</b>&nbsp;&nbsp;&nbsp;
                             <input type="radio" name="opttest" class="form-control radio-button" id="Retesting" value="Retesting" />&nbsp;<b>Retesting</b>
                         </div>
                                      <label class="col-md-2 align-left  ">Test Status  : </label>
                         <div class="col-md-4 align-left">
                             <select id="ddlTestStatus" class="form-control" style="width: 100%;" name="TestStatus"   onchange="updationcheck()">
                                 <option value="-1">Choose Status</option>

                                
                             </select>
                         </div>
                     </div>
                 <div id="div8" class="col-md-12  padding-bottom-10px row">                       
            
               </div>
                      <div id="DivTestCase" class="form-group row col-md-12" style="padding-bottom: 10px;display:none">
                            <div  class="form-group row col-md-12" style="padding-bottom: 10px;">
                                 <label class="col-md-3 align-left  ">High Testcase Count : </label>
                                 <div class="align-left col-md-4 align-center">
                                     <input type="text" class="form-control" style="width: 100%" placeholder="Enter High Testcase Count" id="txt_high_cnt" title="High" onkeypress="return isNumberKey(event,this)" />
                                 </div>
                            </div>
                            <div class="form-group row col-md-12" style="padding-bottom: 10px;" >
                                 <label class="col-md-3 align-left  ">Medium Testcase Count  : </label>
                                 <div class="col-md-4 align-left">
                                     <input type="text" class="form-control" style="width: 100%" placeholder="Enter Medium Testcase Count" id="txt_mid_cnt" title="Medium" onkeypress="return isNumberKey(event,this)" />
                                 </div>
                            </div>
                            <div class="form-group row col-md-12" style="padding-bottom: 10px;">
                                 <label class="col-md-3 align-left  ">Low Testcase Count  : </label>
                                 <div class="col-md-4 align-left">
                                     <input type="text" class="form-control" style="width: 100%" placeholder="Enter Low Testcase Count" id="txt_low_cnt" title="Low" onkeypress="return isNumberKey(event,this)" />
                                 </div>
                            </div>
                     </div>
              
<div class="radio-tile-group" id="showBtnsAppr" style="display:none">

<div class="input-container" id="showApprReturnBtn">
<input id="returntoDev" class="radio-button" type="radio" name="radio" />
<div class="radio-tile">
<label for="returntoDev" class="radio-tile-label"><i class="fa fa-reply"></i>  Bug Found</label>
</div>
</div>
    <div class="input-container" id="showApprBtn">
        <input id="testover" class="radio-button" type="radio" name="radio" />
        <div class="radio-tile">
            <label for="testover" class="radio-tile-label"><i class="fa fa-thumbs-up"></i>Test Over</label>
        </div>
    </div>
    <div class="input-container" id="showForBtn" style="display: none">
        <input id="retest" class="radio-button" type="radio" name="radio" />
        <div class="radio-tile">
            <label for="retest" class="radio-tile-label"><i class="fa fa-share"></i>Retest</label>
        </div>
    </div>
</div>

  <div id="DivSuggestion" class="row col-md-12 form-group" style="padding-bottom: 10px;">

                     <label class="col-md-3 align-right" id="lblBugFf" style="color: blueviolet"><b>If any suggestion ?</b></label>
                    <div class="col-md-2 align-left" id="aaSuggestion">
                        <div class="form-group">
                            <input type="checkbox" class="toggle" id="r_and_d" onchange="tester();" />
                            <label for="r_and_d">
                                <span class="on">Yes</span>
                                <span class="off">No</span>
                            </label>
                        </div>
                    </div>
                     <div class="col-md-6">
                            <label  id="rdlabel" style="display:none" class="pure-material-textfield-outlined">
                                <textarea rows="1" cols="14" name="reason" id="txtSuggestion" maxlength="3500" title="Suggestion" oninput="this.value = this.value.replace(/[^-@.,/#&+\w\s]/g, '');"></textarea>
                                <span> Tester Suggestion </span>
                            </label>
                        </div>

                         
                        </div>

   <%---------------------------------376292---------St--------------------------------------------------%>
      <div id="DivDelay" class="row col-md-12 form-group" style="padding-bottom: 10px;">
                       <label class="col-md-2 align-left  ">Test Delay Updation  : </label>
                         <div class="col-md-4 align-left">
                             <select class="form-control" name="Change" style="width:100%" id="testdelay">
                                 <option value="-1">Choose Delay Reason</option>
                              </select>
                         </div>
                         
                    <div class="col-md-6">
                            <label  id="rdlabel1" class="pure-material-textfield-outlined">
                                <textarea rows="1" cols="14" name="reason" id="txtSuggestion1" maxlength="3500" title="Suggestion" oninput="this.value = this.value.replace(/[^-@.,/#&+\w\s]/g, '');"></textarea>
                                <span> Tester Delay Suggestion </span>
                            </label>
                      </div>
                        </div>
   <%---------------------------------376292---------Ed--------------------------------------------------%>


                <br />
                     <div class="row">
                         <div class="col-md-11">
                             <label class="pure-material-textfield-outlined">
                                 <textarea rows="3" cols="15" name="Remarks" id="txtRemarks" maxlength="3500" title="Remarks" oninput="this.value = this.value.replace(/[^-@.,/#&+\w\s]/g, '');">
                                 </textarea>
                                 <span>Remarks</span>
                             </label>
                         </div>
                     </div>
                         <div class="row" id="showSubmitBtn">
                             <div class="col-md-2 col-sm-2 col-xs-4">
                                 <a href="#" class="btn btn-block btn-outline-success btn-flat" style="width: 100%; margin: 5px;"
                                     onclick="return TestResultconfirm();" id="btnSubmit">  <i class="fa fa-thumbs-up"></i>&nbsp;Confirm</a>
                             </div>
                        <%-- <div id="testerReturn" class="col-md-2 col-sm-2 col-xs-4" style="display:none;">
                            <a href="#" class="btn btn-block btn-outline-info btn-flat" id="btnHandOver" style="width: 100%; margin: 5px;" onclick="HandOver();">
                                <i class="fa fa-hand-point-right"></i>Return</a>
                        </div>--%>
                             <div class="col-md-2 col-sm-2 col-xs-4">
                                 <a href="#" class="btn btn-block btn-outline-danger btn-flat" style="width: 100%; margin: 5px;"
                                     onclick="return frmExit();"><i class="fa fa-sign-out-alt"></i>&nbsp;Exit</a>
                             </div>
                             <div class="col-md-8 row col-sm-2 col-xs-4" id="ExceptionDiv">
                                 <div class="col-md-3 col-sm-2 col-xs-4">
                                 <a href="#" class="btn btn-block btn-outline-info btn-flat" style="width: 100%; margin: 5px;"
                                     onclick="return Exceptionconfirm();" id="btnException"><i class=" fa fa-thermometer-half"></i>&nbsp;Exception</a>   
                                     </div>
                                               
                          </div>
                         </div>


                     </div> 
        </form>
    </div>
    <input id="hdUserId" type="hidden" runat="server" />
    <input id="hdBranchId" type="hidden" runat="server" />
    <input id="hdFirmId" type="hidden" runat="server" />

    <input id="hdSesssion" type="hidden" runat="server" />
    <input id="hddata" type="hidden" runat="server" />
    <input id="hdRqstID" type="hidden" runat="server" />
    <input id="hdEmpCheck" type="hidden" runat="server" />
    <input id="hdBugStatus" type="hidden" runat="server" />
    <input id="hdTestCheck" type="hidden" runat="server" />
    <input id="hdBugId" type="hidden" runat="server" />
    <input id="hdnbug" type="hidden" runat="server" />
    <input id="hdGetTechleader" type="hidden" runat="server" />

</asp:Content>
