<%@ Page Title="" Language="C#" MasterPageFile="~/PWA_Master.Master" AutoEventWireup="true" CodeBehind="TechnicalAnalysis.aspx.cs" Inherits="ITTracker.TechnicalAnalysis" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="js/TechAnalysis.js?<%=DateTime.Now.Ticks.ToString()%>"></script>


   
    <style>
            @media screen and (min-width: 1000px) {
            .modal-dialog {
                max-width: 1000px; /* New width for default modal */
            }
        }
        .select2-container--default .select2-selection--multiple .select2-selection__choice {
    background-color: #2962ff !important;
    padding: 0px 12px !important;
    color:#ffffff !important;
}

        .select2-container .select2-selection--multiple {
    box-sizing: border-box;
    cursor: pointer;
    display: table !important;
    min-height: auto;
    user-select: none;
    -webkit-user-select: none;
    min-width: 100% !important;
}


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

        .label-head {
            display: block;
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

    <div class="card card-5 rightmarg">
        <form class="form-inline" runat="server" method="post" enctype="multipart/form-data">
            <div class="card-body">
                <div class="row">
                    <label class="col-md-1 align-left ">CRF <span class="required">*</span> </label>
                    <div class="col-md-10 align-left">
                        <select id="ddlCrf" class="form-control select2" style="width: 100%;" name="CRF_Sel" onchange="fillCRFData()">
                            <option value="-1">Choose CRF</option>
                        </select>
                    </div>
                </div>
                <div class="row">
                    <div id="div2" class="form-group col-md-12  padding-bottom-10px" style="color: black;">
                        <label class="col-md-3 align-right ">CRF: </label>
                        <div class="col-md-9 align-left">
                            <h4>
                                <label class="align-left" id="lblCRFID" style="color: black"></label>
                            </h4>
                        </div>
                    </div>
                </div>
                <div class="padding-bottom-10px p-t-40"></div>
                <div class="row" style="padding-top: 10px">
                    <label class="col-md-1 align-right " id="myLargeModalLabel">Content </label>
                    <div id="snote" class="form-group col-md-10 padding-bottom-10px" style="color: black; display: block; text-align: initial;" contenteditable="false">
                        <div class="summernoteview" id="content">
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
                        <label class=" col-md-2 align-right">Requested By: </label>
                        <div class="col-md-2 align-left">
                            <label class="align-left" id="lblReqtr" style="width: 150px; color: maroon"></label>
                        </div>
                    </div>
                    <div class="form-group row col-md-12 padding-bottom-10px" style="color: black;">
                        <label class=" col-md-2 align-right">Requested Date : </label>
                        <div class="col-md-2 align-left">
                            <label class="align-left" id="lblRqstDt" style="width: 150px; color: maroon"></label>
                        </div>
                        <label class=" col-md-2 align-right">Target Date : </label>
                        <div class="col-md-2 align-left">
                            <label class="align-left" id="lblTarDt" style="width: 150px; color: maroon"></label>
                        </div>
                        <label class=" col-md-2 align-right">Priority : </label>
                        <div class="col-md-2 align-left">
                            <label class="align-left" id="lblPrior" style="width: 150px; color: maroon"></label>
                        </div>
                        <label class=" col-md-2 align-right" style="color: red">Error Report Impact : </label>
                        <div class="col-md-2 align-left">
                            <label class="align-left" id="lblErrorImpact" style="width: 150px; color: maroon"></label>
                        </div>
                    </div>
                </div>
                <hr />
                <div id="ModHeadFdbk" class="panel-group col-md-12 p-1 align-center padding-bottom-10px" style="display: none">
                    <div class="panel-heading">
                            <h3 class="panel-title align-left">Feedback from HOD</h3>
                        </div>        
                    <div class="panel-body">
                        <div class="table-responsive">
                            <table class="table1 table-hover" id="tblHdFdbk"></table>
                        </div>
                    </div>
                </div>

                <div id="Doc" class="panel-group col-md-12 align-center padding-bottom-10px">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title align-left"><%--<a data-toggle="collapse" href="#collapse1">--%>Attached Files<%--</a>--%></h3>
                        </div>
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table1 table-hover" id="tblFiles">
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row col-md-12 form-group">

                     <label class="col-md-3 align-right" id="lblBugFf" style="color: blueviolet"><b>Related to R&D Work?</b></label>
                    <div class="col-md-2 align-left" id="aansdwork">
                        <div class="form-group">
                            <input type="checkbox" class="toggle" id="r_and_d" onchange="rand_D();" />
                            <label for="r_and_d">
                                <span class="on">Yes</span>
                                <span class="off">No</span>
                            </label>
                        </div>
                    </div>
                    <label  class="col-md-3" id="rdlabel" style="display:none;">Choose R&D Work :<span class="required text-danger">*</span> </label>
                    <div class="col-md-4 align-left" id="randd" style="display:none;">
                        <select id="ddlRD" class="form-control select2" style="width: 100%;" name="CRF_Sel">
                            <option value="-1">Choose R&D Work</option>
                        </select>
                    </div>

                         
                        </div>
                <br />
                


                <div class="card-body">
                    <div class="col-md-12 p-1 form-group">
                        
                        
                            
                            <div class="col-md-3">
                                <label for="rbnInfrastructureChange" class="label-head">InfrastructureChange : <span class="text-danger">*</span></label>
                                <div class="form-group clearfix">
                                    <div class=" icheck-success d-inline">
                                        <input type="radio" name="rbInfra"value="0"id="rbmod2" oninput="this.value = this.value.replace(/[^ a-zA-Z0-9&.,_-“”‘’'%]/g, '');" onchange="infra()"/>
                                        <label for="rbmod2">Yes</label>
                                        &nbsp;&nbsp;                       
                                    </div>
                                    <div class="icheck-danger d-inline">
                                        <input type="radio" name="rbInfra"value="1" id="rbdev2" oninput="this.value = this.value.replace(/[^ a-zA-Z0-9&.,_-“”‘’'%]/g, '');" onchange="infras()"/>
                                        <label for="rbdev2">No</label>&nbsp;&nbsp;
                                    </div>
                                </div>
                            </div>
                             
                         
                            <div class="col-md-3 form-group">
                                <label for="rbnPriority" class="label-head">Risk Classification :<span class="text-danger">*</span></label>
                                <div class="form-group clearfix">
                                    <div class=" icheck-success d-inline">
                                        <input type="radio" name="rbPrio"value="0" id="rbmod5" />
                                        <label for="rbmod5">Low</label>&nbsp;&nbsp;                       
                                    </div>
                                    <div class=" icheck-primary d-inline">
                                        <input type="radio" name="rbPrio"value="1" id="rbdev5" />
                                        <label for="rbdev5">Medium</label>&nbsp;&nbsp;
                                    </div>
                                    <div class="icheck-danger d-inline">
                                        <input type="radio" name="rbPrio"value="2" id="rbtechld5" />
                                        <label for="rbtechld5">High</label>
                                    </div>
                                </div>
                            </div>
                        
                       </div>

                    <div id="dmans3" class="row col-md-12"style="display: none">
                            <label for="txtPhase" class="col-md-2">No of New/Modification in Tables :<span class="required text-danger">*</span> </label>
                            <div class="col-md-4 align-left">
                                <input type="text" class="form-control" style="width: 100%" placeholder=" " id="txtmodule" title="Phase" onkeypress="return isNumber(event, this.value, 0);" maxlength="3" />
                 </div>
                            <label for="txtPhase" class="col-md-2">Additional Space Required for this release for 1 year :<span class="required text-danger">*</span> </label>
                            <div class="col-md-4 align-left">
                                <input type="text" class="form-control" style="width: 100%" placeholder=" " id="txtspace" title="Phase" oninput="this.value = this.value.replace(/[^ a-zA-Z0-9&.,_-“”‘’'%]/g, '');" />
                            </div>
                        </div>
                    <div id="dmans1"class="row col-md-12 p-1"style="display: none">
                            <label for="txtPhase" class="col-md-2">Estimated Data Growth for 1 year :<span class="required text-danger">*</span> </label>
                            <div class="col-md-4 align-left">
                                <input type="text" class="form-control" style="width: 100%" placeholder=" " id="txtestimate" title="Phase" oninput="this.value = this.value.replace(/[^ a-zA-Z0-9&.,_-“”‘’'%]/g, '');" />
                            </div>
                            <label for="txtPhase" class="col-md-2">Impact in server resource [CPU/Memory/Sessions] :<span class="required text-danger">*</span> </label>
                            <div class="col-md-4 align-left">
                                <div class="form-group clearfix">
                                    <div class=" icheck-success d-inline">
                                        <input type="radio" name="rbRe"value="0" id="rbmod" />
                                        <label for="rbmod">Low</label>&nbsp;&nbsp;                       
                           
                                    </div>
                                    <div class=" icheck-primary d-inline">
                                        <input type="radio" name="rbRe"value="1" id="rbdev" />
                                        <label for="rbdev">Medium</label>&nbsp;&nbsp;
                           
                                    </div>
                                    <div class="icheck-danger d-inline">
                                        <input type="radio" name="rbRe"value="2" id="rbtechld" />
                                        <label for="rbtechld">High</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    <div id="dmans"class="row col-md-12 p-1"style="display: none">
                                <label for="txtPhase" class="col-md-2">If High/Medium Please Brief the Technical Reasons:<span class="required text-danger">*</span> </label>
                                <div class="col-md-4 align-left">
                                    <input type="text" class="form-control" style="width: 100%" placeholder=" " id="txtreason" title="Phase" oninput="this.value = this.value.replace(/[^ a-zA-Z0-9&.,_-“”‘’'%]/g, '');" />
                                </div>
                            </div>
                      
                  </div>
                    <%--</div>--%>

                <div class="card-body">
                        <div id="Emp" class="panel-group col-md-10 align-center padding-bottom-10px">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h3 class="panel-title align-left"><a data-toggle="collapse" href="#collapse2">Developers</a></h3>
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

                                        <%--            dils        ---------------%>
                       <div id="Emp" class="panel-group col-md-10 align-center padding-bottom-10px">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h3 class="panel-title align-left"><a data-toggle="collapse" href="#collapse3">Alternative Developers</a></h3>
                                </div>
                                <div id="collapse3" style="" class="panel-collapse collapse">
                                    <div class="panel-body">
                                        <div class="table-responsive">
                                            <table class="table1 table-hover" id="tblEmps1"></table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
             <%---  dils------------%>
                        <div class="row col-md-12 p-1">
                            <label for="txtPhase" class="col-md-2">Phase :</label>
                            <div class="col-md-4 align-left">
                                <input type="text" class="form-control" style="width: 100%" placeholder=" " id="txtPhase" title="Phase" oninput="this.value = this.value.replace(/[^ a-zA-Z0-9&.,_-“”‘’'%]/g, '');" onblur="manpower()" />
                            </div>
                            <label class="col-md-2" for="ddlDevlp">Developer : <span class="text-danger  p-2">*</span></label>
                            <div class="col-md-4 align-left">
                                <select id="ddlDevlp" class="form-control select2" style="width: 100%;" name="ddlDevlp" onchange="empdatesel()">
                                </select>
                            </div>
                        </div>
                        <div id="dman" class="row col-md-12 p-1" style="display: none">
                            <label class="col-md-2" for="txtStartDt">Start Date : <span class="text-danger p-2">*</span></label>
                            <div class="col-md-4 align-left">
                                <input type="text" class="form-control" style="width: 100%" placeholder="Start Date..." id="txtStartDt" title="txtStartDt" />
                            </div>
                            <label class="col-md-2" for="ddlDevlp">End Date : <span class="text-danger p-2">*</span></label>
                            <div class="col-md-4 align-left">
                                <input type="text" class="form-control" style="width: 100%" placeholder="End Date..." id="txtEndDt" title="txtEndDt" />
                            </div>
                        </div>
                        <div id="dman1" class="row col-md-12 p-1" style="display: none">
                            <label class="col-md-2" for="ddlChange">Changes : <span class="text-danger">*</span></label>

                            <div class="col-md-4 align-left">
                                <select id="ddlChange" class="form-control select2" style="width: 100%;" name="ddlChange" onchange="GetWorkList()"></select>

                            </div>
                            <label class="col-md-2" for="ddlWork">Related Work : <span class="text-danger">*</span></label>
                            <div class="col-md-4 align-left">
                                <select id="ddlWork" class="form-control select2" style="width: 100%;" name="Work" onchange="GetTechnology()"></select>
<%--                                   <select id="ddlWork" class="form-control select2" style="width: 100%;" name="Work"> </select>--%>



                            </div>
                        </div>
                                <div class="col-md-2 col-sm-1 col-xs-2" style="display:none" id="butShow">
                        <a href="#" class="btn btn-block btn-outline-info btn-flat" style="width: 100%; margin: 5px;"
                            data-toggle="modal" onclick="return loadModal();" data-target="#ModeModal"><i class=" fa fa-reply"></i>&nbsp;&nbsp; WBS</a>
                    </div>   
            

                 <%--       <div class="form-group col-md-12 padding-bottom-10px" style="color: black;">
                            <div class="form-group">
                                <table class="table table-hover align-center " id="tabChange">
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                        </div>--%>

                                  <!-- Modal -->
          
                    
                    <div id="ModeModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <div class="row col-md-12">
                            <h4 <%--style="font-size:30%; width:100%;"--%> class="col-md-11 align-left ">Please Describe Here.!</h4>
                            <div class="col-md-1 col-sm-2 col-xs-4">
                                <button type="button" class="btn btn-block btn-outline-danger btn-sm" onclick="ClearPopUp();" style="text-align: center;" data-dismiss="modal">x</button>
                            </div>
                        </div>
                    </div>
                    <div class="modal-body">
                  
                             <!-- Main content -->
                        <section class="content">
                            <div class="card">

                                <form role="form">
                                    <div class="card-body shadow" style="background: #fff;">
                                      <%--  <div class="row col-md-12" style="padding-bottom: 10px;">
                                            <label class="col-md-2 align-left "></label>
                                            <div class="form-group col-md-10" style="padding-left: 0;">
                                                <select id="ddlCrfList" class="form-control" style="width: 100%;" name="CRF_Sel" onchange="UserListLoad()">
                                                    <option value="-1">Choose CRF</option>
                                                </select>
                                            </div>
                                        </div>--%>
                                        <div class="row col-md-12" style="padding-bottom: 10px;">
                                            <%--<label class="col-md-2 align-left ">Asssign To</label>
                                            <div class="form-group col-md-4" style="padding-left: 0;">
                                                <select id="ddlDevlp1" class="form-control select2" style="width: 100%;" name="ddlDevlp">
                                                </select>
                                            </div>--%>
                                            <label class="col-md-2 align-left ">ID </label>
                                            <div class="form-group col-md-2" style="padding-left: 0;">
                                                <input type="text" class="form-control" style="width: 100%" placeholder="ID" id="txtId" title="txtId1" />

                                            </div>
                                            <label class="col-md-1 align-left ">Start date </label>
                                            <div class="form-group col-md-3" style="padding-left: 0;">
                                                <input type="text" class="form-control" style="width: 100%" placeholder="Start Date..." id="txtStartDt1" title="txtTarDt1" />

                                            </div>
                                            <label class="col-md-1 align-left ">Target date </label>
                                            <div class="form-group col-md-3" style="padding-left: 0;">
                                                <input type="text" class="form-control" style="width: 100%" placeholder="Target Date..." id="txtEndDt1" title="txtTarDt1" />

                                            </div>
                                      
                                        </div>
                                        <div class="row col-md-12" style="padding-bottom: 10px;">
                                            <label class="col-md-2 align-left ">Describe the Changes</label>
                                            <div class="form-group col-md-10" style="padding-left: 0;">
                                                                                              <textarea rows="1" cols="" class="form-control" style="width: 100%" name="Remarks" id="txtModRemarks2" title="Remarks" oninput="this.value = this.value.replace(/[^-@.,/#&+\w\s]/g, '');">
                                                </textarea>
                                            </div>
                                        </div>
                                    </div>
                                 <div class="col-md-4 p-1  align-left buttonbox">
                                <input id="btnAdd2" type="button" style="width: 36%; height: 90%" value="Add" class="btn-input fa-text-height" onclick="return CalAdd();" data-toggle="modal" data-backdrop="false" />
                            </div>
                                    <br />  <br />
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="table-responsive">
                                                <table class="table1 table-hover" id="tabChange1">
                                                </table>
                                            </div>
                                        </div>
                                    </div>

                                    <br />
                                    <div class="card-body shadow" style="background: #fff;">
                                     
                                    </div>
                                    <hr />
                                    <div class="col-md-12">
                                        <div class="row">
                                            <label class="col-md-1 align-left "></label>
                                            <div class="form-group col-md-2" style="padding-left: 0;">
                                                <button type="button" class="btn btn-block btn-outline-success btn-flat" onclick="WbsConfirm();">Submit</button>
                                            </div>
                                            <div class="form-group col-md-2" style="padding-left: 0;">
                                                <button type="button" class="btn btn-block btn-outline-danger btn-flat" data-dismiss="modal" onclick="return ClearPopUp();">Exit</button>

                                            </div>

                                        </div>
                                    </div> 
                                       
                                      
                                </form>
                            </div>
                        </section>
                           </div>
                </div>

            </div>
        </div>
                   

                        <div id="dman2" class="row col-md-12 p-1" style="display:none">
                            <label class="col-md-2" for="ddlChange">Number of Changes : <span class="text-danger">*</span></label>
                            <div class="col-md-4 align-left">
                                <input type="text" class="form-control" style="width: 100%" maxlength="3" id="TNoc" title="TNoc" onkeypress="return isNumber(event, this.value, 0)" />
                            </div>
                             <label class="col-md-2" for="ddlChange">Manpower  : <span class="text-danger">*</span></label>
                            <div class="col-md-4 align-left">
                                <input type="text" class="form-control" style="width: 100%" maxlength="3" id="TNoc1" title="TNoc1" onkeypress="return isNumber(event, this.value, 0)" onchange="costestimation()"/>
                            </div> 
                            </div>
                        <div id="dman5" class="row col-md-12 p-1" style="display: none">
                            <label class="col-md-2" for="ddlCost"> Cost Estimation: <span class="text-danger">*</span></label>
                            <div class="col-md-4 align-left">
<%--                                <input type="text" class="form-control" style="width: 100%" maxlength="7" id="TNoc2" title="TNoc2" onkeypress="return isNumber(event, this.value, 0)" />--%>
                                    <input type="text" class="form-control" style="width: 100%" placeholder="Cost Estimation.." maxlength="7" id="TNoc2" title="TNoc2" readonly="readonly" />

                            </div>
                            

                             <label class="col-md-2" for="ddlTechno">Choose Technology: <span class="text-danger">*</span></label>
                            <div class="col-md-4 align-left">
                                <select id="ddlTechno" class="form-control select2"style="width: 100%;" name="Tech"></select>
                            
                             </div>
                               <label class="col-md-2" for="ddlmodulename" style="margin-top:12px">Module Name : <span class="text-danger">*</span></label>
                             <div class="col-md-4 align-left" style="margin-top:12px">
                            <select class="form-control select2" style="width: 100%;"  name="ReqType" id="ddlmodulname"></select>
                           </div>
                                <label for="rbnPriority" class="label-head" style="margin-top:12px;margin-left:10px">Module Complexity :<span class="text-danger">*</span></label>
                                <div class="form-group clearfix" style="margin-left:76px;">
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
                                 <label for="rbnPriority" class="label-head" style="margin-left: 16px;margin-top: 12px;">Change in Critical Complexity  :<span class="text-danger">*</span></label>
                                <div class="form-group clearfix" style="margin-left:20px;margin-top:13px;">
                                    <div class=" icheck-success d-inline">
                                        <input type="radio" name="rbCritcl"value="2" id="rbcchigh" />
                                        <label for="rbcchigh">High</label>&nbsp;&nbsp;                       
                                    </div>
                                    <div class=" icheck-primary d-inline">
                                        <input type="radio" name="rbCritcl"value="1" id="rbccmedium" />
                                        <label for="rbccmedium">Medium</label>&nbsp;&nbsp;
                                    </div>
                                    <div class="icheck-danger d-inline">
                                        <input type="radio" name="rbCritcl"value="0" id="rbcclow" />
                                        <label for="rbcclow">Low</label>
                                    </div>
                                </div>
                            
                    <%--<div id= "dman4" class="row col-md-12 p-1" style="display: none">--%>
                            <div class="col-md-4 p-1  align-left buttonbox" style="margin-bottom: 10px;margin-left: revert-layer: 10px;margin-left: 370px;">
                                <input id="btnAdd" type="button" style="width: 36%; height: 90%" value="Add" class="btn-input fa-text-height" onclick="return AddWbsData();" data-toggle="modal" data-backdrop="false" />
                            </div>
                        </div>







                    <div class="row">
                        <div class="col-md-12">
                            <div class="table-responsive">
                                <table class="table1 table-hover" id="tabChange" onmousedown="grTab()">
                                </table>
                            </div>
                        </div>
                    </div>
                        <div id="dman3" class="row col-md-12 p-1" style="display: none;">
                            <label class="col-md-2" for="ddlChange">Man Hours for : <span class="text-danger">*</span></label>
                            <div class="col-md-2 align-left">
                                <span>Development</span>
                                <input type="text" class="form-control" style="width: 100%" placeholder="Development.." maxlength="3" id="DevWork" title="DevWork" readonly="readonly" />
                            </div>

                            <div class="col-md-2 align-left">
                                <span>Code Review</span>
                                <input type="text" class="form-control" style="width: 100%" placeholder="Code Review.." maxlength="3" id="CodWork" title="CodWork" readonly="readonly" />
                            </div>

                            <div class="col-md-2 align-left">
                                <span>Total Work Hours</span>
                                <input type="text" class="form-control" style="width: 100%" placeholder="Work Hours.." maxlength="3" id="TWork" title="TWork" readonly="readonly" />
                            </div>
                             <div class="col-md-2 align-left">
                                <span>Total Cost</span>
                                <input type="text" class="form-control" style="width: 100%" placeholder="Total cost.." maxlength="3" id="TCost" title="TCost" readonly="readonly" />
                            </div>
                        </div>
                    </div>

                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

                <%--                jeeva--%>

                  <div class="card-body" style="border-style:solid;border-color:lightgrey;">
                        <label for="ChngReq" class="col-md-2" style="padding-bottom:10px;font-size:larger;color: blueviolet">Change Request Type:<span class="required text-danger"></span> </label>
                    <div class="col-md-12 p-1 form-group">
                        
                        
                           
                         <div class="col-md-3">
                   <div class="form-group">
                       <label for="ddlReqType"style="font-size:smaller">Request Type :</label>
                           <select class="form-control select2" style="width: 100%;"  name="ReqType" id="ddlReqType" onchange="selectmodule()">
                           </select>
                       </div>
               </div>
                        <div class="form-group" id="newmode" style="display: none">
                       <label for="ddlReqType">Select Module:</label>
                           <select class="form-control select2" style="width: 100%;" name="ReqType" id="exmodule">
                           </select>
                       </div>
         
                       </div>
                           </div>

                <%--jeeva--%>
     
                  
               
                   &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                <div class="row col-md-12 p-1">
                    <label class="col-md-3 align-right" id="lblBugF" style="color: blueviolet"><b>Handover to Techlead :</b></label>
                    <div class="col-md-2 align-left" id="tech_handOver1">
                        <div class="form-group">
                            <input type="checkbox" class="toggle" id="tech_handOver" onchange="ApplicableHide();" />
                            <label for="tech_handOver">
                                <span class="on">Yes</span>
                                <span class="off">No</span>
                            </label>
                        </div>
                    </div>
                    <label class="col-md-4 align-right" id="iblDependency" style="color: blueviolet"><b> Any Dependency with another Techlead:</b></label>
                    <div class="col-md-2 align-left" id="Dependency">
                        <div class="form-group">
                            <input type="checkbox" class="toggle" id="dependency_sel" onchange="Dependency_Check();" />
                            <label for="dependency_sel">
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
                        <div class="col-md-2 col-sm-2 col-xs-4">
                            <a href="#" class="btn btn-block btn-outline-success btn-flat" style="width: 100%; margin: 5px;"
                                onclick="return TAConfirm();" id="btnSubmit"><i class="fa fa-thumbs-up"></i>Confirm</a>
                        </div>
                        <div class="col-md-2 col-sm-2 col-xs-4">
                            <a href="#" class="btn btn-block btn-outline-warning btn-flat" style="width: 100%; margin: 5px;"
                                onclick="return ReturnNote();" id="btnReturn"><i class="fa fa-thumbtack"></i>Return</a>
                        </div>
                         <div class="col-md-2 col-sm-2 col-xs-4">
                            <a href="#" class="btn btn-block btn-outline-primary btn-flat" id="btnHandOver" style="width: 100%; margin: 5px;" onclick="HandOver();">
                                <i class="fa fa-hand-point-right"></i>Hand Over</a>
                        </div>
                        <div class="col-md-2 col-sm-2 col-xs-4">
                            <a href="#" class="btn btn-block btn-outline-danger btn-flat" style="width: 100%; margin: 5px;"
                                onclick="return frmExit();"><i class="fa fa-sign-out-alt"></i>Exit</a>
                        </div>
                         <div class="col-md-2 col-sm-2 col-xs-4">
                            <a href="#" class="btn btn-block btn-outline-danger btn-flat" style="width: 100%; margin: 5px;"
                                onclick="return RejctCRF();"><i class="fa fa-thumbs-down"></i>Reject</a>
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
    <input id="hdcost" type="hidden" runat="server" />
    <input id="hddev" type="hidden" runat="server" />
    <input id="hddata" type="hidden" runat="server" />
    <input id="hddatas" type="hidden" runat="server" />
    <input id="hdRqstID" type="hidden" runat="server" />
    <input id="hdDevlpr" type="hidden" runat="server" />
    <input id="hddraftid" type="hidden" runat="server" />
     <input id="change" type="hidden" runat="server" />
      <input id="work" type="hidden" runat="server" />


</asp:Content>
