<%@ Page Title="" Language="C#" MasterPageFile="~/PWA_Master.Master" AutoEventWireup="true" CodeBehind="CRFHODApprove.aspx.cs" Inherits="ITTracker.CRFHODApprove" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="js/CRFApprove.js" + "new Date().getTime()"></script>
        <style>
        @media screen and (min-width: 1000px) {
            .modal-dialog {
                max-width: 1000px; /* New width for default modal */
            }
        }
    </style>
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

    <div class="card card card-5 rightmarg">
        <form class="form-inline" runat="server" method="post" enctype="multipart/form-data">
            <div class="card-body">       
          <div class="row">
            <label class="col-md-1 align-left ">CRF </label>
             <div class="col-md-10 align-left">
               <select id="ddlCrf" class="select2 form-control" style="width:100%;" name="CRF_Sel" onchange="fillCRFData()">
                   <%--<option value="-1">Choose CRF</option>--%>
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
                <div class="row" style="padding-top:15px">
    
                 <label class="col-md-1 align-right " id="myLargeModalLabel">Content </label>
                <div id="snote" class="form-group  col-md-10 padding-bottom-10px" style="color: black; display:block; text-align:initial;" contenteditable="false">
                   
                    <div class="summernoteview" id="content" >
                    </div>
                </div>
                 </div>
                <div id="CrfDetailsID" style="display:none">
                <div class="form-group row col-md-12 padding-bottom-10px" style="color: black;">
                     <label class=" col-md-1 align-right"> </label>                   
                    <label class=" col-md-2 align-right">IT Team : </label>
                    <div class="col-md-2 align-left">
                        <label class="align-left" id="lblTeam" style="width: 150px; color: maroon"></label>
                    </div>
                    <label class=" col-md-1 align-right"> Type : </label>
                    <div class="col-md-2 align-left">
                        <label class="align-left" id="lblType" style="width: 150px; color: maroon"></label>
                    </div>
                        <label class=" col-md-2 align-right">Creator: </label>
                    <div class="col-md-2 align-left">
                        <label class="align-left" id="lblReqtr" style="width: 150px; color: maroon"></label>
                    </div>
                </div>  
                <div class="form-group row col-md-12 padding-bottom-30px" style="color: black;">
                         <label class=" col-md-1 align-right"></label>
                 
                       <label class=" col-md-2 align-right">Requested Date : </label>
                    <div class="col-md-2 align-left">
                        <label class="align-left" id="lblRqstDt" style="width: 150px; color: maroon"></label>
                    </div>
                    <label class=" col-md-1 align-right">Target Dt: </label>
                    <div class="col-md-2 align-left">
                        <label class="align-left" id="lblTarDt" style="width: 150px; color: maroon"></label>
                    </div>
                    <label class=" col-md-2 align-right">Priority : </label>
                    <div class="col-md-2 align-left">
                        <label class="align-left" id="lblPrior" style="width: 150px; color: maroon"></label>
                    </div>
                 
                </div>
                    <div class="form-group row col-md-12 padding-bottom-30px" style="color: black; padding-bottom: 30px;">
                        <label class=" col-md-1 align-right"></label>

                        <label class=" col-md-2 align-right" style="color: red">Error Report Impact : </label>
                        <div class="col-md-2 align-left">
                            <label class="align-left" id="lblErrorImpact" style="width: 150px; color: maroon"></label>
                        </div>
                    </div>
                </div>
            
                <div id="Doc" style="padding-bottom: 20px;" class="row padding-bottom-10px">
                    <label class="col-md-1 align-left ">Attached</label>
                    <div class="table-responsive col-md-10 align-left">
                        <table class="table1 table-hover" id="tblFiles">
                        </table>
                    </div>
                </div>
           
                
      <%--          <div class="row">
                    <div class="col-md-12">
                        <label class="">
                            <textarea rows="1" cols="15" name="Remarks" id="txtRemarks" maxlength="3500" title="Remarks" oninput="this.value = this.value.replace(/[^-@.,/#&+\w\s]/g, '');">
                            </textarea>
                            <span>Remarks</span>
                        </label>
                    </div>
                </div>--%>
                <div class="row" style="padding-bottom:20px;">                  
                    <label class="col-md-1 align-left ">Remarks  </label>
                    <div class="col-md-10 align-left">
                         <textarea rows="1" cols="" class="form-control" style="width:100%" name="Remarks" id="txtRemarks" title="Remarks" oninput="this.value = this.value.replace(/[^-@.,/#&+\w\s]/g, '');">
                            </textarea>
                    </div>
                </div>
                <div class="row" id="showSubmitBtn">
                       <div class="col-md-1 col-sm-1 col-xs-2">
                    <%--    <a href="#" class="btn btn-block btn-outline-success btn-flat" style="width: 100%; margin: 5px;"
                            onclick="return NoteRecommendConfirm();" id="btnSubmit"><i class="fa fa-thumbs-up"></i>Confirm</a>--%>
                    </div>
                    <div class="col-md-2 col-sm-2 col-xs-4"   id="butShow">
                        <a href="#" class="btn btn-block btn-outline-success btn-flat" style="width: 100%; margin: 0px;"
                            onclick="return NoteRecommendConfirm();" id="btnSubmit"><i class="fa fa-thumbs-up"></i>&nbsp;&nbsp;Confirm</a>
                    </div>
                    <div class="col-md-2 col-sm-2 col-xs-4">
                        <a href="#" class="btn btn-block btn-outline-secondary btn-flat" style="width: 100%; margin: 0px;"
                            onclick="return NoteRecommendReject();" id="btnReject"><i class="fa fa-thumbs-down"></i>&nbsp;&nbsp;Reject</a>
                    </div>
                    <div class="col-md-2 col-sm-2 col-xs-4">
                        <a href="#" class="btn btn-block btn-outline-info btn-flat" style="width: 100%; margin: 0px;"
                            data-toggle="modal" onclick="return CRFModalLoad();" data-target="#ModeModal"><i class=" fa fa-user"></i>&nbsp;&nbsp;Change User</a>
                    </div>
                    <div class="col-md-2 col-sm-2 col-xs-4">
                        <a href="#" class="btn btn-block btn-outline-danger btn-flat" style="width: 100%; margin: 0px;"
                            onclick="return frmExit();"><i class="fa fa-sign-out-alt"></i>&nbsp;&nbsp;Exit</a>
                    </div>
                 
                </div>


            </div>
             <!-- Modal -->
        <div id="ModeModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <div class="row col-md-12">
                            <h4 <%--style="font-size:30%; width:100%;"--%> class="col-md-11 align-left ">Change User Here.!</h4>
                            <div class="col-md-1 col-sm-2 col-xs-4">
                                <button type="button" class="btn btn-block btn-outline-danger btn-sm" onclick="ClearPopUp();" style="text-align: center;" data-dismiss="modal">x</button>
                            </div>
                        </div>
                    </div>
                    <div class="modal-body">
                  
                             <!-- Main content -->
            <section class="content">
                <%--<div class="container-fluid">--%>
                    <%--<div class="row">
                        <div class="col-md-12">--%>
                            <!-- Default box -->
                            <div class="card">
                                <div class="card-body">
                                    <form role="form">                                 
                                        <div class="row col-md-12" style="padding-bottom:10px;">
                                            <label class="col-md-2 align-left ">Select CRF</label>
                                            <div class="form-group col-md-10" style="padding-left: 0;">
                                                <select class="form-control tlead select2" style="width: 100%;" onchange="return UserListLoad();" id="ddlCrfList">
                                                    <%--<option value="-1">Choose CRF</option>--%>
                                                </select>
                                            </div>
                                        </div> 
                                        <div class="row col-md-12" style="padding-bottom:10px;">
                                            <label class="col-md-2 align-left ">Current User</label>
                                            <div class="form-group col-md-4" style="padding-left: 0;">
                                                <input type="text" id="txtCurrUser" readonly="readonly" style="width:100%;" class="form-control"/>
                                                <input type="text" id="txtUserId" readonly="readonly" style="width:100%;display:none;" class="form-control"/>
                                            </div>
                                          <label class="col-md-2 align-left ">Change To</label>
                                            <div class="form-group col-md-4" style="padding-left: 0;">
                                                <select class="form-control tlead select2" style="width: 100%;" onchange="" id="ddlToUser">
                                                </select>
                                            </div>
                                        </div> 
                                        <div class="row col-md-12" style="padding-bottom:10px;">
                                            <label class="col-md-2 align-left ">Remarks</label>
                                            <div class="form-group col-md-10" style="padding-left: 0;">
                                                <textarea rows="1" cols="" class="form-control" style="width: 100%" name="Remarks" id="txtModRemarks" title="Remarks" oninput="this.value = this.value.replace(/[^-@.,/#&+\w\s]/g, '');">
                                                </textarea>
                                            </div>
                                        </div> 
                              
                                        <div class="row col-md-12" style="padding-bottom: 10px;">
                                            <label class="col-md-2 align-left "></label>
                                            <div class="form-group col-md-2" style="padding-left: 0;">
                                                <button type="button" class="btn btn-block btn-outline-success btn-flat" onclick="return ChangeUserConfirm();">Submit</button>
                                            </div>
                                            <div class="form-group col-md-2" style="padding-left: 0;">
                                                <button  type="button" class="btn btn-block btn-outline-danger btn-flat" data-dismiss="modal" onclick="return ClearPopUp();">Exit</button>

                                            </div>
                                        </div> 
                               </form>
                           </div>
                           </div>

                     <div class="background-card" style="display:none;" id="ReportDiv">
                            <%--<div class="container-fluid">--%>
                                <div class="row mb-2">
                                    <div class="col-sm-6">
                                        <h4>Search Result</h4>
                                    </div>
                                    <div class="col-sm-6">
                                    </div>
                                </div>
                            <%--</div>--%>
                         <div class="row">
                             <div class="col-md-4">
                                 Priority Status: <i class='fa fa-circle' style='color: #FF0000; font-size: 10px; padding-right: 2px;'></i>- High  <i class='fa fa-circle' style='color: #fb8c00; font-size: 10px; padding-right: 2px;'></i>- Medium <i class='fa fa-circle' style='color: #fdee30; font-size: 10px; padding-right: 2px;'></i>- Low
                                 <br />
                             </div>                    
                         </div>
                         <div class="datatable-section" >
                         <div class="table-responsive">
                             <table class="table table-hover table-success sortable" id="tblSearchRpt">
                                 <thead class="bg-success text-white">
                                     <tr>
                                     </tr>
                                 </thead>
                                 <tbody class="border border-dark"></tbody>
                             </table>
                         </div>
                             </div>
                        </div>
                <div class="form-group" style="display: none;" id="EmptyDiv">
          
                    <div style="font-size: 18px; text-align: center;"><i class="fa fa-filter fa-5x" aria-hidden="true" style="opacity: 0.5;"></i></div>
                    <div style="font-size: 18px; text-align: center;">
                        <h5>We didn't find anything...</h5>
                    </div>
                    <div style="font-size: 12px; text-align: center;">Try a different keyword...</div>
                </div>
                            <!-- /.card-body -->

                        <%--</div>--%>
                        <!-- /.card -->

                   <%-- </div>--%>
                <%--</div>--%>

                </section>
                    </div>
            <%--        <div class="modal-footer">
                        <button type="button" class="btn btn-primary" onclick="ClickReportHere(1);" >Task Status Report</button>
                        <button type="button" class="btn btn-primary" onclick="ClickReportHere(3);" >Meeting Status Report</button>
                        <button type="button" class="btn btn-success" onclick="ClickReportHere(2);">Daily Work Report</button>
                        <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="ClearData();">Cancel</button>
                    </div>--%>
                </div>

            </div>
        </div>

        </form>
    </div>
    <input id="hdUserId" type="hidden" runat="server" />
    <input id="hdBranchId" type="hidden" runat="server" />
    <input id="hdFirmId" type="hidden" runat="server" />

    <input id="hdnReqEmp" type="hidden" runat="server" />
    <input id="hdnSystemIP" type="hidden" runat="server" />
    <input id="hdSesssion" type="hidden" runat="server" />
    <input id="hddraftid" type="hidden" runat="server" />
</asp:Content>
