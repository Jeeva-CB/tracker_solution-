﻿<%@ Page Title="" Language="C#" MasterPageFile="~/PWA_Master.Master" AutoEventWireup="true" CodeBehind="RandDCTOorHeadApprove.aspx.cs" Inherits="ITTracker.RandDCTOorHeadApprove" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="css/MultipleUpload.css" rel="stylesheet"/>
    <script src="js/MultipleUpload.js"></script>

    <script type="text/javascript" src="http://github.com/malsup/blockui/raw/master/jquery.blockUI.js?v2.34"></script>
     <script src="js/aes.js"></script>
    <script src="js/RandCTOandHOD.js"></script>
   <%-- <script src="js/RandDWork.js"></script>--%>
    <script src="js/AutoCompleteJS.js"></script>


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
        font-size: 12px;
        line-height: 1.5;
        overflow: hidden;
        width: 100%;
    }

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

                .task-style {
    border: 1px solid #dfd7d7;
    padding: inherit;
    cursor:pointer;
}
                .pluselement {
    height: 32px;
    padding: 6px 0px !important;
}

                .buttonelement {
    width: 100%;
    height: 31px;
    padding: 5px 0px;
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
    .myAlert-top {
        position: fixed;
        top: 10%;
        left: 8%;
        width: 90%;
    }

    .myAlert-bottom {
        position: fixed;
        bottom: 10%;
        left: 5%;
        width: 90%;
    }

    .alert {
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
        0%, 40%, 100% {
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
    <div class="card-body">
        <div class="row ">
                <div class="ma-header col-5"></div>
                <div class="ma-header">
                    <h4 style="color: #45457b; align-items: center; align-content: center">R&D Work Approval</h4>
                </div>
            </div>
        <hr />
        

        <div class="row" id="to_cancell">
            <label class="col-md-2 align-left "> Choose Work <span class="required">* :</span> </label>
            <div class="col-md-10 align-left">
                <select id="ddlCrf" class="form-control" style="width: 100%;" name="CRF_Sel" onchange="return showTables();">
                    <option value="-1">Choose the R&D Work</option>
                </select>
            </div>
        </div>
        <br />
        <div class="card-body shadow" style="background: #fff;" id="closecanceldata">
            <h3 class="panel-title align-left">Work Details</h3>
            <hr />
            <div class="form-group row col-md-12 padding-bottom-10px" style="color: black;">
                <label class=" col-md-2 align-right">Team : </label>
                <div class="col-md-2 align-left">
                    <label class="align-left" id="lblTeam" style="width: 150px; color: maroon"></label>
                </div>
                <label class=" col-md-2 align-right">Start Date : </label>
                <div class="col-md-2 align-left">
                    <label class="align-left" id="lblStDt" style="width: 150px; color: maroon"></label>
                </div>
                <label class=" col-md-2 align-right">Target Date : </label>
                <div class="col-md-2 align-left">
                    <label class="align-left" id="lblTarDt" style="width: 150px; color: maroon"></label>
                </div>
            </div>
            <div class="form-group row col-md-12 padding-bottom-10px" style="color: black;">
                <label class=" col-md-2 align-right">Developer Remark : </label>
                <div class="col-md-4 align-left">
                    <label class="align-left" id="lblDvrmk" style="width: 150px; color: maroon"></label>
                </div>
                <label class=" col-md-2 align-right" id="lblstats"> Status : </label>
                <div class="col-md-4 align-left">
                    <label class="align-left" id="lblsts" style="width: 150px; color: maroon"></label>
                </div>
            </div>

            <div class="form-group row col-md-12 padding-bottom-10px" style="color: black;">
                <label class=" col-md-2 align-right">TL Remark : </label>
                <div class="col-md-4 align-left">
                    <label class="align-left" id="lblTLrmk" style="width: 150px; color: maroon"></label>
                </div>
                <label class=" col-md-2 align-right" id="lblHDrmrk">R&D Head Remark : </label>
                <div class="col-md-4 align-left">
                    <label class="align-left" id="lblHDrmk" style="width: 150px; color: maroon"></label>
                </div>
            </div>
            <hr />



            <div class="row" style="padding-bottom: 10px;" id="tardthides">
                <div class="col-md-12">
                    <div class="table-responsive">
                        <table class="table1 table-hover" id="tabChange2">
                        </table>
                    </div>
                </div>
            </div>

        </div>
        <br />
        <div class="row">
            <label class="col-md-2 align-left ">Remark :</label>
            <div class="form-group col-md-10">
                <textarea rows="1" cols="" class="form-control" style="width: 100%" name="Remarks" id="txtModRemar" title="Remarks" oninput="this.value = this.value.replace(/[^-@.,/#&+\w\s]/g, '');">
                </textarea>
            </div>
        </div>

              <div class="col-md-12 row padding-bottom-10px" >

    <div id="Doc" class="panel-group col-md-6">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title align-left"><%--<a data-toggle="collapse"  href="#collapse1" style="color:blue">--%>Attached Files<%--</a>--%></h3>
                        </div>
                        <%--<div id="collapse1" class="panel-collapse collapse">--%>
                            <div class="panel-body">
                                <div class="table-responsive">
                                    <table class="table1 table-hover" id="tblFiles">
                                    </table>
                                </div>
                            </div>
                        <%--</div>--%>
                    </div>
                </div>
                </div>
        
        <div class="row" id="showSubmitBtn">
            <div class="col-md-2 col-sm-2 col-xs-4">
                <a href="#" class="btn btn-block btn-outline-success btn-flat" style="width: 100%; margin: 5px;"
                    onclick="return WorkApproveConfirm();" id="btnSubmit"><i class="fa fa-thumbs-up"></i>&nbsp;Approve</a>
            </div>
            <div class="col-md-2 col-sm-2 col-xs-4">
                <a href="#" class="btn btn-block btn-outline-primary btn-flat" style="width: 100%; margin: 5px;"
                    onclick="return WorkReturnConfirm();" id="btnReturn"><i class="fa fa-thumbs-down"></i>&nbsp;Return</a>
            </div>
            <div class="col-md-2 col-sm-2 col-xs-4" id="ctoReject">
                <a href="#" class="btn btn-block btn-outline-danger btn-flat" style="width: 100%; margin: 5px;"
                    onclick="return Workrejectconfirm();"><i class="fa fa-sign-out-alt"></i>&nbsp;Reject</a>
            </div>

            <div class="col-md-2 col-sm-2 col-xs-4">
                <a href="#" class="btn btn-block btn-outline-danger btn-flat" style="width: 100%; margin: 5px;"
                    onclick="return frmExit();"><i class="fa fa-sign-out-alt"></i>&nbsp;Exit</a>
            </div>


        </div>


      
</div>

   

    

    <input id="hdUserId" type="hidden" runat="server"/>
        <input id="hdBranchId" type="hidden" runat="server"/>
        <input id="hdFirmId" type="hidden" runat="server"/>
     <input id="hdSesssion" type="hidden" runat="server"/>
     <input id="hdNoteID" type="hidden" runat="server"/>
</asp:Content>