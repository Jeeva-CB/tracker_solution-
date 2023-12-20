<%@ Page Title="" Language="C#" MasterPageFile="~/PWA_Master.Master" AutoEventWireup="true" CodeBehind="CrfDelayTracking.aspx.cs" Inherits="ITTracker.CrfDelayTracking" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%--<script src="CrfDelayTrack.js"></script>--%>
    <script src="js/CrfDelayTrack.js"></script>
    
<%--    <script src="js/CrfDelayTrack.js?<%=DateTime.Now.Ticks.ToString()%>"></script>--%>
    <link href="css/MultipleUpload.css" rel="stylesheet"/>
    <script src="js/MultipleUpload.js"></script> 
    <script src="js/aes.js"></script>
    <link rel="stylesheet" href="css/simple-modal.css" />
    <script src="js/simple-modal.js"></script>
    <script>
       $(window).on('load', function () {            
      
                setInterval("getPendingCount();", 1000);
 
        });

        function getPendingCount() {


    var Data = '';
    Data = '' + 'µ' + '' + 'µ' + $("[id*=hdUserId]").val()
    $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "CrfDelayTracking.aspx/getBugCount",
        data: "{pageVal:'GetEnquiryCount', pageval1:'" + Data + "',pageval2:''}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;            
            document.getElementById("pendCnt").innerHTML = Result;
      
           

        }
    });
}

    </script>
    <style>
        
        /*.card-body{
            background:#e5e5e5;
        }*/
            @media screen and (min-width: 1000px) {
            .modal-dialog {
                max-width: 800px; /* New width for default modal */
            }
        }

        .timeline1 {
            position: relative;
            padding: 50px 0;
        }
        /*header.note-toolbar {
    padding: 0 0 5px 5px;
    margin: 0;
    background: #197969;
}*/

  
         /*.bg-success {
               background-color: #197969 !important;
         }*/
            .timeline1::before {
                content: '';
                background: #C5CAE9;
                width: 5px;
                height: 95%;
                position: absolute;
                left: 50%;
                transform: translateX(-50%);
            }

        .timeline-item {
            width: 100%;
            margin-bottom: 5px;
        }

            .timeline-item:nth-child(even) .timeline-content {
                float: right;
                padding: 40px 30px 10px 30px;
            }

                .timeline-item:nth-child(even) .timeline-content .wf-date {
                    right: auto;
                    left: 0;
                }

                .timeline-item:nth-child(even) .timeline-content::after {
                    content: '';
                    position: absolute;
                    border-style: solid;
                    width: 0;
                    height: 0;
                    top: 30px;
                    left: -15px;
                    border-width: 10px 15px 10px 0;
                    border-color: transparent #f5f5f5 transparent transparent;
                }

            .timeline-item::after {
                content: '';
                display: block;
                clear: both;
            }
            .shadow{
                box-shadow: 5px 15px 5px 3px #0017304d;
            }

        .timeline-content {
            position: relative;
            width: 45%;
            padding: 10px 15px;
            border-radius: 4px;
            background: #fff;
            box-shadow: 5px 15px 5px 3px #0017304d;
        }

            .timeline-content::after {
                content: '';
                position: absolute;
                border-style: solid;
                width: 0;
                height: 0;
                top: 30px;
                right: -15px;
                border-width: 10px 0 10px 15px;
                border-color: transparent transparent transparent #f5f5f5;
            }

        .timeline-img {
            width: 30px;
            height: 30px;
            background: #197969;
            border-radius: 70%;
            position: absolute;
            left: 50%;
            margin-top: 25px;
            margin-left: -15px;
            color: #fff;
            text-align: center;
            padding-top: 7px;
        }

        .bnt-more {
            cursor: pointer;
            background: #3F51B5;
            color: #FFFFFF;
            padding: 3px 10px;
            text-transform: uppercase;
            font-size: 12px;
            display: inline-block;
            border-radius: 2px;
            box-shadow: 0 1px 3px -1px rgba(0, 0, 0, 0.6);
        }

            .bnt-more:hover, .bnt-more:active, .bnt-more:focus {
                background: #32408f;
                color: #FFFFFF;
                text-decoration: none;
            }

            .note-editor.note-frame .note-editing-area .note-editable[contenteditable="false"] {
               background-color: #a3e39a0a    !important;
        }

        .card {
            border:none !important;
        }
        .card-body{
            border:none !important;
        }

        .container{
            border:none !important;
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

        .timeline-item .timeline-img-header {
            background: linear-gradient(rgba(0, 0, 0, 0), rgba(0, 0, 0, 0.4)), url("https://picsum.photos/1000/800/?random") center center no-repeat;
            background-size: cover;
        }

        .timeline-img-header {
            height: 200px;
            position: relative;
            margin-bottom: 20px;
        }

            .timeline-img-header h2 {
                color: #FFFFFF;
                position: absolute;
                bottom: 5px;
                left: 20px;
            }

        .wf-date {
            background: #197969;
            display: inline-block;
            color: #FFFFFF;
            padding: 5px;
            position: absolute;
            top: 0;
            right: 0;
            font-size: .75rem;
        }

        @media screen and (max-width: 768px) {
            .timeline::before {
                left: 50px;
            }

            .timeline1 .timeline-img {
                left: 50px;
            }

            .timeline1 .timeline-content {
                max-width: 100%;
                width: auto;
                margin-left: 70px;
            }

            .timeline1 .timeline-item:nth-child(even) .timeline-content {
                float: none;
            }

            .timeline1 .timeline-item:nth-child(odd) .timeline-content::after {
                content: '';
                position: absolute;
                border-style: solid;
                width: 0;
                height: 0;
                top: 30px;
                left: -15px;
                border-width: 10px 15px 10px 0;
                border-color: transparent #f5f5f5 transparent transparent;
            }
        }

        .read-more-state {
            display: none;
        }

        .read-more-target {
            opacity: 0;
            max-height: 0;
            font-size: 0;
            transition: .25s ease;
        }

        .read-more-state:checked ~ .read-more-wrap .read-more-target {
            opacity: 1;
            font-size: inherit;
            max-height: 999em;
        }

        .read-more-state ~ .read-more-trigger:before {
            content: 'Show more';
        }

        .read-more-state:checked ~ .read-more-trigger:before {
            content: 'Show less';
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
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <div class="rightmarg">
        <form class="form-inline" runat="server" method="post" enctype="multipart/form-data">
            <div class="card-body">
                <div class="card-body shadow" style="padding-bottom: 10px;">
                    <div class="row">
                        <label class="col-md-1 align-left ">CRF </label>
                        <div class="col-md-9 align-left">
                            <select id="ddlCrf" class="form-control select2" style="width: 101%;" name="CRF_Sel" onchange="fillCRFData()">
                                <option value="-1">Choose CRF</option>
                            </select>
                        </div>
                        <div class="col-md-1 align-left">
                              <a href="#" class="btn btn-block btn-danger btn-xs" data-toggle="modal" onclick="return ModalFill();" data-target="#ModeModal" style="width: 100%; margin: 0px;">
                                  <span class=" flashit badge badge-light animation-fadeIn" id="pendCnt">0</span></a>
                        </div>

                    </div>

                    <div class="padding-bottom-10px p-t-40"></div>
                    <div class="row" style="padding-top: 10px">
                        <label class="col-md-1 align-right " id="myLargeModalLabel">Content </label>
                        <div id="snote" class="form-group  col-md-10 padding-bottom-10px" style="color: black; display: block; text-align: initial;" contenteditable="false">
                            <div class="summernoteview" id="content">
                            </div>
                        </div>
                    </div>
                </div>
                  <br/>
                <div id="CrfDetailsID" class="card-body shadow" style="display: none; padding-bottom: 20px; padding-top: 20px;">
                    <div class="form-group row col-md-12 padding-bottom-10px" style="color: black;">
                        <label class=" col-md-2 align-right">IT Team : </label>
                        <div class="col-md-2 align-left">
                            <label class="align-right" id="lblTeam" style="text-align: right; width: 150px; color: maroon"></label>
                        </div>
                        <label class=" col-md-2 align-right">Request Type : </label>
                        <div class="col-md-2 align-left">
                            <label class="align-left" id="lblType" style="text-align: right; width: 150px; color: maroon"></label>
                        </div>
                        <label class=" col-md-2 align-right">Developer : </label>
                        <div class="col-md-2 align-left">
                            <label class="align-left" id="lblReqtr" style="width: 200px; color: maroon"></label>
                        </div>
                    </div>
                    <div class="form-group row col-md-12 padding-bottom-10px" style="color: black;">

                        <label class=" col-md-2 align-right">User Expected Date : </label>
                        <div class="col-md-2 align-left">
                            <label class="align-left" id="lblUserExpectDate" style="text-align: right; width: 150px; color: maroon"></label>
                        </div>
                        <label class=" col-md-2 align-right">Priority : </label>
                        <div class="col-md-2 align-left">
                            <label class="align-left" id="lblPrior" style="width: 150px; text-align: right; color: maroon"></label>
                        </div>
                        <label class=" col-md-2 align-right">Dvlpmt Complete Date : </label>
                        <div class="col-md-2 align-left">
                            <label class="align-left" id="lblTarDt" style="width: 150%; color: maroon"></label>
                        </div>
                        <label class=" col-md-2 align-right" style="color: red">Error Report Impact : </label>
                        <div class="col-md-2 align-left">
                            <label class="align-left" id="lblErrorImpact" style="width: 150px; text-align: right; color: maroon"></label>
                        </div>
                        <label class=" col-md-2 align-right">Creator : </label>
                        <div class="col-md-2 align-left">
                            <label class="align-left" id="lblCreator" style="width: 150px; text-align: right; color: maroon"></label>
                        </div>
                        <label class=" col-md-2 align-right" style="color: red">Tech Lead : </label>
                        <div class="col-md-2 align-left">
                            <label class="align-left" id="lblTechLead" style="width: 150px; color: maroon"></label>
                        </div>
                    </div>

                    <div class="form-group row col-md-12 padding-bottom-10px" style="color: black;">

                        <label class=" col-md-2 align-right">Dvlpmt Start Date : </label>
                        <div class="col-md-2 align-left">
                            <label class="align-left" id="lblDvlpmtStartDate" style="text-align: right; width: 150px; color: maroon"></label>
                        </div>
                        <label class=" col-md-2 align-right">Department : </label>
                        <div class="col-md-2 align-left">
                            <label class="align-left" id="lblDeptName" style="text-align: right; width: 150px; color: maroon"></label>
                        </div>
                        <label class=" col-md-2 align-right">Proj Target Date : </label>
                        <div class="col-md-2 align-left">
                            <label class="align-left" id="lblTargetDt" style="width: 150px; color: maroon"></label>
                        </div>

                    </div>

                </div>            
           <br/>

         <%-- </div>--%>
                <div class="card-body shadow" style="padding-bottom: 10px;">

                    <div class=" row" style="padding-bottom: 20px; padding-top: 20px;">
                        <label class="col-md-1 align-left ">Action  </label>
                        <div class="col-md-10 align-left">
                            <textarea rows="1" cols="" class="form-control" style="width: 100%" name="Remarks" id="txtRemarks" title="Remarks" oninput="this.value = this.value.replace(/[^-@.,/#&+\w\s]/g, '');">
                            </textarea>
                        </div>
                    </div>
                    <div class="row" id="showSubmitBtn">
                        <div class="col-md-1 col-sm-1 col-xs-2">
                            <%--    <a href="#" class="btn btn-block btn-outline-success btn-flat" style="width: 100%; margin: 5px;"
                            onclick="return NoteRecommendConfirm();" id="btnSubmit"><i class="fa fa-thumbs-up"></i>Confirm</a>--%>
                        </div>
                        <div class="col-md-2 col-sm-2 col-xs-4">
                            <a href="#" class="btn btn-block btn-outline-success btn-flat" style="width: 100%; margin: 0px;"
                                onclick="return ActionTaken(1);" id="btnSubmit"><i class="fa fa-thumbs-up"></i>&nbsp;&nbsp;Confirm</a>
                        </div>
                   <%--     <div class="col-md-2 col-sm-2 col-xs-4">
                            <a href="#" class="btn btn-block btn-outline-secondary btn-flat" style="width: 100%; margin: 0px;"
                                onclick="return NoteRecommendReject();" id="btnReject"><i class="fa fa-thumbs-down"></i>&nbsp;&nbsp;Reject</a>
                        </div>--%>
                        <div class="col-md-2 col-sm-2 col-xs-4">
                            <a href="#" onclick="return ActionTaken(2);" class="btn  btn-block btn-outline-info btn-flat" style="width: 100%; margin: 0px;" ><i class=" fa fa-forward"></i>&nbsp;&nbsp;Escalate</a>
                        </div>
                        <div class="col-md-2 col-sm-2 col-xs-4">
                            <a href="#" class="btn btn-block btn-outline-danger btn-flat" style="width: 100%; margin: 0px;"
                                onclick="return frmExit();"><i class="fa fa-sign-out-alt"></i>&nbsp;&nbsp;Exit</a>
                        </div>


                    </div>
                </div>
                <br/>
                <div class="card-body shadow" id="IdTree" style=" display:none;padding-bottom: 10px;">
                    <div class="row">
                        <div class="col-md-12">
                            <div class=" animated bounceIn" style="background-color: #fff;" id="WorkFlowSection">
                                <section class="timeline1 card">
                                </section>
                            </div>
                        </div>
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
                                <h4 <%--style="font-size:30%; width:100%;"--%> class="col-md-11 align-left ">Respond Here.!</h4>
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

                                            <div class="row col-md-12" style="padding-bottom: 10px;">
                                                <label class="col-md-2 align-left ">CRF</label>
                                                <div class="form-group col-md-10" style="padding-left: 0;">
                                                    <select class="form-control tlead select2" style="width: 100%;" onchange=" EnquiryDetailsFill();" id="ddlCrfReq">
                                                    </select>
                                                </div>
                            
                                            </div>
                                            <div class="row col-md-12" style="padding-bottom: 10px;">
                                                <label class="col-md-2 align-left ">Message</label>
                                                <div class="form-group col-md-10" style="padding-left: 0;">
                                                    <textarea rows="1" cols="" class="form-control" style="width: 100%" name="Remarks" id="txtMessage" title="Remarks" oninput="this.value = this.value.replace(/[^-@.,/#&+\w\s]/g, '');">
                                                </textarea>
                                                </div>
                                            </div>

                                            <div class="row col-md-12" style="padding-bottom: 10px;">
                                                <label class="col-md-2 align-left "></label>
                                                <div class="form-group col-md-2" id="btnReply" style="padding-left: 0;">
                                                    <button type="button" class="btn btn-block btn-outline-orange btn-flat" onclick="return Reply();"><i class="fa fa-reply">&nbsp;&nbsp;</i>Reply</button>
                                                </div>
                                                <div class="form-group col-md-2" id="btnSent" style="padding-left: 0; display:none;">
                                                    <button type="button"  class="btn btn-block btn-outline-info btn-flat" onclick="return EnquiryConfirm();"><i class="fa  fa-envelope">&nbsp;&nbsp;</i>Sent</button>
                                                </div>
                                                <div class="form-group col-md-2" style="padding-left: 0;">
                                                    <button type="button" class="btn btn-block btn-outline-danger btn-flat" data-dismiss="modal" onclick="return ClearPopUp();"><i class="fa fa-sign-out-alt">&nbsp;&nbsp;</i>Exit</button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>                               
                             
                            </section>
                        </div>
                         <div class="modal-footer">
                             <div class="card-body shadow" id="IdModTree" style="display:none; padding-bottom: 10px;">
                                 <div class="row">
                                     <div class="col-md-12">
                                         <div class=" animated bounceIn" style="background-color: #fff;" id="WorkFlowSectionPop">
                                             <section class="timeline1 card">
                                             </section>
                                         </div>
                                     </div>
                                 </div>
                             </div>
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
