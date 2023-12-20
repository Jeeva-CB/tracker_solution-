<%@ Page Title="" Language="C#" MasterPageFile="~/PWA_Master.Master" AutoEventWireup="true" CodeBehind="TechnicalAnalysisTesting.aspx.cs" Inherits="ITTracker.TechnicalAnalysisTesting" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="js/TechAnalysisTesting.js?<%=DateTime.Now.Ticks.ToString()%>"></script>
    <link href="css/MultipleUpload.css" rel="stylesheet"/>
    <script src="js/MultipleUpload.js"></script> 
    <script src="js/aes.js"></script>
    <link rel="stylesheet" href="css/simple-modal.css" />
    <script src="js/simple-modal.js"></script>

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
        .blink_me {
            animation: blinker 1s linear infinite;
          }
          @keyframes blinker {  
                  50% { opacity: 0; }
           }
           .card-body {
            background: #fff;
        }
            .timeline-card {
            padding: 0 !important;
        }

            .timeline-card p {
                padding: 0 20px;
            }

            .timeline-card a {
                margin-left: 20px;
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
                <div class="row">
                    <div id="div2" class="form-group col-md-12  padding-bottom-10px" style="color: black;">
                        <label class="col-md-3 align-right ">CRF: </label>
                        <div class="col-md-9 align-left">
                           <h4> <label class="align-left" id="lblCRFID" style="color: black"></label></h4>
                        </div>
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

                     <div id="CrfDetailsID" style="display:none">
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
                     <label class=" col-md-2 align-right" style="color:red">Error Report Impact : </label>
                    <div class="col-md-2 align-left">
                        <label class="align-left" id="lblErrorImpact" style="width: 150px; color: maroon"></label>
                    </div>
                    <label class=" col-md-2 align-right">Creator : </label>
                    <div class="col-md-2 align-left">
                        <label class="align-left" id="lblCreator" style="width: 150px; color: maroon"></label>
                    </div> 
                        <label class=" col-md-2 align-right" style="color:red">Tech Lead : </label>
                    <div class="col-md-2 align-left">
                        <label class="align-left" id="lblTechLead" style="width: 150px; color: maroon"></label>
                    </div>
                </div>
                
                 <div class="form-group row col-md-12 padding-bottom-10px" style="color: black;">
                       
                    <label class=" col-md-2 align-right">Dvlpmt Start Date : </label>
                    <div class="col-md-2 align-left">
                        <label class="align-left" id="lblDvlpmtStartDate" style="width: 150px; color: maroon"></label>
                    </div>
                    <label class=" col-md-2 align-right">Department : </label>
                    <div class="col-md-2 align-left">
                        <label class="align-left" id="lblDeptName" style="width: 150px; color: maroon"></label>
                    </div> 
                     <label class=" col-md-2 align-right" style="color:blueviolet"><b>Not Applicable :</b></label>
                    <div class="col-md-2 align-left">
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

                <div id="Doc" class="panel-group col-md-12 align-center padding-bottom-10px">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title align-left">Attached Files</h3>
                        </div>
                            <div class="panel-body">
                                    <table class="table1 table-hover" id="tblFiles">
                                    </table>
                            </div>
                    </div>
                </div>
                   
                    <div id="Emp" class="panel-group col-md-10 align-center padding-bottom-10px">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="align-left" style="color:blue;"><a data-toggle="collapse" href="#collapse2">Test Engineer Details</a></h4>
                                </div>
                                <div id="collapse2" style="" class="panel-collapse collapse">
                                    <div class="panel-body">
                                        <div class="table-responsive">
                                            <table class="table1 table-hover" id="tblEmps"></table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                <div class="card-body"  id="boxdata">
                    <div class="p-1">
                        <div class="row p-1">
                             <div class="col-md-4 align-center"> 
                            <label  for="txtStartDt">Start Date:</label>
                                <input type="text" class="form-control" style="width: 100%" placeholder="Start Date..." id="txtStartDt" title="txtStartDt" />
                            </div>
                            <div class="col-md-4 align-center">
                              <label  for="txtEndDt">End Date:</label>
                                <input type="text" class="form-control" style="width: 100%" placeholder="End Date..." id="txtEndDt" title="txtEndDt" onblur="Clear2();" />
                            </div>
                            <div class="col-md-2 align-center">
                                <input id="btnBHR" type="button" value="Check" style="margin-top: 15px;" class="btn btn-block btn-outline-info btn-flat" onclick="return businessHRFill();" data-toggle="modal" data-backdrop="false" />
                            </div>
                              <div class="col-md-1 align-center">
                                <input type="text" id="txtBusHours" style=" display: none;" readonly class="form-control" />
                                <label id="lblBusHours" style="width: 100%; font-size: large; font-weight: 200; color: maroon;margin-top: 20px;margin-left: 60%;" class="blink_me"></label>
                            </div>
                              <span class="col-md-1" style="color: red;margin-top: 24px;"><b>Hours left! </b></span>

                        </div>
                    </div>
                        <div  class="p-1">
                          <div class="row p-1">
                               <div class="col-md-4 align-center">
                               <label for="ddlTester">Test Engineer:</label>        
                                    <select id="ddlTester" class="form-control select2" style="width: 100%;" name="Tester"<%-- onchange="StartDateFill()"--%>></select>
                                </div>
                              <div class="col-md-4 align-center">
                                    <label  for="ddlProjType">Project Type:</label>
                                    <select id="ddlProjType" class="form-control select2" style="width: 100%;" name="ProjType" onchange="showPhase();"></select>
                                </div>
                               <div class="col-md-4 align-center">
                                    <label for="ddlPhase">Phase:</label>
                                    <select id="ddlPhase" class="form-control select2" style="width: 100%;" name="Phase" onchange="showRelatedWork();"></select>
                                </div>                             
                       </div>                             
                      </div>
                          
                      
                        <div id="datahide" style="display:none">
                            <div class="row p-1">                               
                                <div class="col-md-4 align-center">
                                    <label for="ddlRelWork">Related Work:</label>
                                     <select id="ddlRelWork" class="form-control select2" style="width: 100%;" name="RelWork"></select>
                                </div>
                                <div class="col-md-4 align-center">
                                    <label for="ddlRelWork">No.Of TestCases:</label>
                                    <input type="text" class="form-control" style="width: 100%;" maxlength="3" id="TNoc"  title="TNoc" onkeypress="return isNumber(event, this.value, 0)"  />
                                </div>

                              <%--  original module complexity--%>
                                        <%--  <div class="card-body"  id="boxdataa">
                 <div class="col-md-3 form-group" style="margin-left:310px;margin-top:-32px;margin-left: 100px;padding-top: 30px;">
                               <label for="rbnPriority" class="label-head">Module Complexity :<span class="text-danger">*</span></label>--%>
                                <%--387276--%>
                       <div class="col-md-4 align-center">
                                    <label for="ddlRelWork"style="margin-top:5px;">Module Complexity :</label>
                                 <%--   <input type="text" class="form-control" style="width: 100%;" maxlength="3" id="TNocd"  title="TNoc" onkeypress="return isNumber(event, this.value, 0)"  />
                      --%>         <div class="form-group clearfix"style="margin-top:-5px;">
                                    <div class=" icheck-success d-inline">
                                        <input type="radio" name="rbmodl"value="2"style="margin-top:9px;" id="rbmchigh" />
                                        <label for="rbmchigh">High</label>&nbsp;&nbsp;                       
                                    </div>
                                    <div class=" icheck-primary d-inline">
                                        <input type="radio" name="rbmodl"value="1"style="margin-top:9px;" id="rbmcmedium" />
                                        <label for="rbmcmedium">Medium</label>&nbsp;&nbsp;
                                    </div>
                                    <div class="icheck-danger d-inline">
                                        <input type="radio" name="rbmodl"value="0" style="margin-top:9px;" id="rbmclow" />
                                        <label for="rbmclow">Low</label>
                                    </div>
                                </div>
                                   </div>
                       </div>



                       </div>






                                <%--<div class="form-group clearfix">
                                    <div class=" icheck-success d-inline">
                                        <input type="radio" name="rbmodl"value="2" id="rbmchigh" />
                                        <label for="rbmchigh">High</label>&nbsp;&nbsp;                       
                                    </div>
                                    <div class=" icheck-primary d-inline">
                                        <input type="radio" name="rbmodl"value="1" id="rbmcmedium" />
                                        <label for="rbmcmedium">Medium</label>&nbsp;&nbsp;
                                    </div>
                                    <div class="icheck-danger d-inline">
                                        <input type="radio" name="rbmodl"value="0" id="rbmclow" />
                                        <label for="rbmclow">Low</label>
                                    </div>
                                </div>
                                   </div>
                       </div>--%>

                                <div class="col-md-2 align-center">
                                    <input id="btnAdd" type="button" value="Add" style="margin-top: 15px;" class="btn btn-block btn-outline-info btn-flat" onclick="return CalTotal();" data-toggle="modal" data-backdrop="false" />
                                </div>
                            </div>

                          

                           
                        </div>
                        <hr />
                        <div id="dman1" class="form-group col-md-12 padding-bottom-10px" style="color: black;">
                            <div class="form-group" style="width: 100%">
                                <table class="table table-hover align-center " id="tabChange">
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <hr />
                        <div id="dman3" class="row col-md-12 p-1" style="display: none;">
                            <label class="col-md-2" for="ddlChange">Man Hours for : <span class="text-danger">*</span></label>
                            <div class="col-md-2 align-left">
                                <span>Development</span>
                                <input type="text" class="form-control" style="width: 100%" title="Development" placeholder="Development.." maxlength="3" id="DevWork" <%--title="DevWork"--%> readonly="readonly" />
                            </div>
                            <div class="col-md-2 align-left">
                                <span>Code Review</span>
                                <input type="text" class="form-control" style="width: 100%" title="CodeReview" placeholder="CodeReview.." maxlength="3" id="CodRvw" <%--title="DevWork"--%> readonly="readonly" />
                            </div>
                            <div class="col-md-2 align-left">
                                <span>Testing</span>
                                <input type="text" class="form-control" style="width: 100%" title="Testing" placeholder="Testing.." maxlength="3" id="TstWrk" <%--title="TstWrk"--%> readonly="readonly" />
                            </div>
                           
                        </div>

                        <div id="dman4" class="row col-md-12 p-1" style="display: none">
                            <label class="col-md-2" for="ddlChange">Total : <span class="text-danger">*</span></label>
                            <div class="col-md-2 align-left">
                                <span>Work Hours</span>
                                <input type="text" class="form-control" style="width: 100%" title="Work Hours" placeholder="Work Hours.." maxlength="3" id="TWork" title="TWork" readonly="readonly" />
                            </div>
                            <div class="col-md-2 align-left">
                                <span>Cost</span>
                                <input type="text" class="form-control" style="width: 100%" title="Cost" placeholder="Cost.." maxlength="3" id="TCost" title="TCost" readonly="readonly" />
                            </div>


                        </div>
                        <div class="form-group row col-md-12 padding-bottom-10px " id="parallelrow">
                            <div class="form-group col-md-2  align-right">
                                <label for="rdbNature">Attach File (Test-Cases)  <i class="fa fa-arrow-alt-circle-right"></i></label>
                            </div>
                            <div class="file-upload col-md-4">
                                <div class="file-select">
                                    <div class="file-select-button" id="fileName">Choose File</div>
                                    <div class="file-select-name" id="noFile">No file chosen...</div>
                                    <div class="file-chooser">
                                        <input type="file" class="file-chooser__input" />
                                    </div>
                                </div>
                            </div>
                            <div class="file-uploader__message-area">
                                <p>Select a file to upload</p>
                            </div>



                        </div>
                    
         </div> 
         <%--          <div class="card-body"  id="boxdataa">
                 <div class="col-md-3 form-group" style="margin-left:310px;margin-top:-32px;margin-left: 100px;padding-top: 30px;">
                               <label for="rbnPriority" class="label-head">Module Complexity :<span class="text-danger">*</span></label>
                                <div class="form-group clearfix">
                                    <div class=" icheck-success d-inline">
                                        <input type="radio" name="rbmodl"value="2" id="rbmchigh" />
                                        <label for="rbmchigh">High</label>&nbsp;&nbsp;                       
                                    </div>
                                    <div class=" icheck-primary d-inline">
                                        <input type="radio" name="rbmodl"value="1" id="rbmcmedium" />
                                        <label for="rbmcmedium">Medium</label>&nbsp;&nbsp;
                                    </div>
                                    <div class="icheck-danger d-inline">
                                        <input type="radio" name="rbmodl"value="0" id="rbmclow" />
                                        <label for="rbmclow">Low</label>
                                    </div>
                                </div>
                                   </div>
                       </div>--%>
                    <div class="row col-md-12 p-1">
                    <label class="col-md-3 align-right" id="lblBugF" style="color: blueviolet"><b>Handover to Techlead :</b></label>
                    <div class="col-md-2 align-left" id="tech_handOver1">
                        <div class="form-group">
                            <input type="checkbox" class="toggle" id="tech_handOver" onchange="ApplicableHideT();" />
                            <label for="tech_handOver">
                                <span class="on">Yes</span>
                                <span class="off">No</span>
                            </label>
                        </div>
                    </div>
                </div>
                   <div id="DivBug" style="display:none">
                   <div class="form-group row col-md-12" style="width: 100%">
                      <label class="col-md-2 align-left  ">Choose techlead : </label>
                             <div class="col-md-4 align-left">
                                 <select id="techlead" class="form-control select2" style="width: 100%;" name="techlead">
                                     <option value="-1">Choose Techlead</option>
                                 </select>
                             </div>
                        </div>
                        </div>
                <div class="row">
                        <div class="col-md-12">


                            <label class="pure-material-textfield-outlined">

                                <textarea rows="1" cols="15" name="Remarks" id="txtRemarks" maxlength="3500" title="Remarks" oninput="this.value = this.value.replace(/[^-@.,/#&+\w\s]/g, '');"></textarea>
                                <span>Remarks</span>
                            </label>

                        </div>
                    </div>
                    <div class="row" id="showSubmitBtn">
                        <div class="col-md-2 col-sm-2 col-xs-4" id="butShow" >
                            <a href="#" class="btn btn-block btn-outline-success btn-flat" style="width: 100%; margin: 5px;"
                                onclick="return NotApplicable();" id="btnSubmit"><i class="fa fa-thumbs-up"></i> Confirm</a>
                        </div>                      
                        <div class="col-md-2 col-sm-2 col-xs-4">
                            <a href="#" class="btn btn-block btn-outline-info btn-flat" id="btnHandOver" style="width: 100%; margin: 5px;" onclick="HandOverTest();">
                                <i class="fa fa-hand-point-right"></i>Hand Over</a>
                        </div>
                          <div class="col-md-2 col-sm-2 col-xs-4">
                            <a href="#" class="btn btn-block btn-outline-danger btn-flat" style="width: 100%; margin: 5px;"
                                onclick="return frmExit();"><i class="fa fa-sign-out-alt"></i> Exit</a>
                        </div>

 

                    </div>

                </div>
               
        </form>

    </div>
    <input id="hdUserId" type="hidden" runat="server" />
    <input id="hdBranchId" type="hidden" runat="server" />
    <input id="hdFirmId" type="hidden" runat="server" />

    <input id="hdSesssion" type="hidden" runat="server" />
    <input id="hdman" type="hidden" runat="server" />
    <input id="hdcst" type="hidden" runat="server" />
    <input id="hdtest" type="hidden" runat="server" />
    <input id="hddev" type="hidden" runat="server" />
    <input id="hddata" type="hidden" runat="server" />
    <input id="hdRqstID" type="hidden" runat="server" />
    <input id="hdDevlpr" type="hidden" runat="server" />
     <input id="hddraftid" type="hidden" runat="server" />
    <input id="hddevwork" type="hidden" runat="server" />
     <input id="hdcdrw" type="hidden" runat="server" />
    <input id="hdDetails" type="hidden" runat="server" />

</asp:Content>
