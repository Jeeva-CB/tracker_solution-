<%@ Page Title="" Language="C#" MasterPageFile="~/PWA_Master.Master" AutoEventWireup="true" CodeBehind="DailyWorkVerifying.aspx.cs" Inherits="ITTracker.DailyWorkVerifying" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%--   <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.js"></script>
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.3/jquery.timepicker.min.css">
    <script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.3/jquery.timepicker.min.js"></script>--%>


      <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"/>
  <link rel="stylesheet" href="/resources/demos/style.css"/>
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    <script src="js/DailyWorkVerify.js?<%=DateTime.Now.Ticks.ToString()%>"></script>
     <style>
       .card-body{
            background:#fff;
        }

        .timeline1 {
            position: relative;
            padding: 50px 0;
        }
        header.note-toolbar {
    padding: 0 0 5px 5px;
    margin: 0;
    background: #197969;
}
           .container{
            border:none !important;
        }
              .shadow{
                box-shadow: 5px 15px 5px 3px #0017304d;
            }

        .bg-success {
               background-color: #197969 !important;
         }

         .bg-success {
               background-color: #197969 !important;
         }
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

        .timeline-content {
            position: relative;
            width: 45%;
            padding: 10px 15px;
            border-radius: 4px;
            background: #fff;
            box-shadow: 0 20px 25px -15px rgba(0, 0, 0, 0.3);
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
               .note-editor.note-frame .note-editing-area .note-editable[contenteditable="false"] {
               background-color: #a3e39a0a    !important;
        }

 

        .card {
            border:none !important;
        }
        .card-body{
            border:none !important;
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
         .radio-tile-group {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
        }

            .radio-tile-group .input-container {
                position: relative;
                height: 2.5rem;
                width: 9rem;
                margin: 0.5rem;
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
                    border: 2px solid #079ad9;
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
                    color: #079ad9;
                    margin-bottom: 0;
                }

                .radio-tile-group .input-container .radio-tile-i {
                    color: #079ad9;
                }

                .radio-tile-group .input-container .radio-button:checked + .radio-tile {
                    background-color: #079ad9;
                    border: 2px solid #079ad9;
                    color: white;
                    transform: scale(1.1, 1.1);
                }

                    .radio-tile-group .input-container .radio-button:checked + .radio-tile .icon svg {
                        fill: white;
                        background-color: #079ad9;
                    }

                    .radio-tile-group .input-container .radio-button:checked + .radio-tile .radio-tile-label {
                        color: white;
                        background-color: #079ad9;
                    }

                    .radio-tile-group .input-container .radio-button:checked + .radio-tile .radio-tile-i {
                        color: white;
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
    </style>
  
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form class="form-inline" runat="server" method="post" enctype="multipart/form-data">
         <div class="card-body">
            <div class="card-body shadow" style="background: #fff;">
                <div class="row col-md-12 p-1">
                    <label class="col-md-2 align-left ">Choose Developers:</label>
                    <div class="col-md-10 align-left">
                        <select class="form-control select2" id="ddlDevlp1" multiple="multiple" style="width: 100%" name="Develpor">
                        </select>
                    </div>
                </div>
                <br />
                <div class="row">
                    <label class="col-md-2 align-left ">Choose a Date:</label>
                    <div class="col-md-3 align-left ">
                        <input type="text" id="datepicker" class="form-control" style="width: 100%" readonly="readonly" />
                    </div>
                    <%--<label class="col-md-2 align-left ">To Date:</label>
                    <div class="col-md-3 align-left ">
                        <input type="text" id="datepicker1" class="form-control" style="width: 100%" readonly="readonly" />
                    </div>--%>
                    <div class="col-md-2">
                        <a href="#" class="btn btn-sm animated-button thar-one btn-primary" style="width: 80%; margin: 5px;"
                            onclick="return ShowData();" id="btnShow"><i class="fa fa-arrow-circle-up"></i>Show</a>
                    </div>
                </div>
            </div>
            <br />
            <div class="card-body shadow" style="background: #fff;">
                <div class="row">
                    <table class="table-bordered align-centre col-md-12" id="tableData">
                        <tbody></tbody>
                    </table>
                </div>
           </div>
             <br />
             <div class="card-body shadow" style="background: #fff;">
                <div class="row" id="showSubmitBtn1">
                    <div class="col-md-2 col-sm-2 col-xs-4">
                        <a href="#" class="btn btn-block btn-outline-success btn-flat" style="width: 100%; margin: 5px;"
                            onclick="return ConfirmNote();" id="btnSubmit2"><i class="fa fa-thumbs-up"></i>Confirm</a>
                    </div>
                    <div class="col-md-2 col-sm-2 col-xs-4">
                        <a href="#" class="btn btn-block btn-outline-danger btn-flat" style="width: 100%; margin: 5px;"
                            onclick="return frmExit();"><i class="fa fa-sign-out-alt"></i>Exit</a>
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
                            <h4 <%--style="font-size:30%; width:100%;"--%> class="col-md-11 align-left ">Delete The Work And Add Your Comments Here.!</h4>
                            <div class="col-md-1 col-sm-2 col-xs-4">
                                <button type="button" class="btn btn-block btn-outline-danger btn-sm" onclick="ClearPopUp();" style="text-align: center;" data-dismiss="modal">x</button>
                            </div>
                        </div>
                    </div>
                    <div class="modal-body">
                        <section class="content">
                            <div class="card">
                                <div class="card-body">
                                    <form role="form">
                                        <div class="row col-md-12" style="padding-bottom: 10px;">
                                            <div class="col-md-6">
                                                <label>Work Updated By</label>
                                                <input type="text" id="txtWorkBy" class="form-control" style="width: 100%" readonly="readonly" />
                                            </div>
                                            <div class="col-md-6">
                                                <label>Assigned Work</label>
                                                <input type="text" id="txtAssWork" class="form-control" style="width: 100%" readonly="readonly" />
                                            </div>
                                        </div>
                                        <div class="row col-md-12" style="padding-bottom: 10px;">
                                            <div class="col-md-6">
                                                <label>Description</label>
                                                <input type="text" id="txtWorDes" class="form-control" style="width: 100%" readonly="readonly" />
                                            </div>
                                            <div class="col-md-2">
                                                <label>Date</label>
                                                <input type="text" id="txtDate" class="form-control" style="width: 100%" readonly="readonly" />
                                            </div>
                                            <div class="col-md-2">
                                                <label>Percentage</label>
                                                <input type="text" id="txtPercent" class="form-control" style="width: 100%" readonly="readonly" />
                                            </div>
                                            <div class="col-md-2">
                                                <label>Time</label>
                                                <input type="text" id="txtTime" class="form-control" style="width: 100%" readonly="readonly" />
                                            </div>
                                        </div>
                                        <div class="row col-md-12" style="padding-bottom: 10px;">
                                            <label class="col-md-2 align-left ">Comments:</label>
                                            <div class="form-group col-md-10" style="padding-left: 0;">
                                                <textarea rows="1" cols="" class="form-control" style="width: 100%" name="Remarks" id="txtComments" title="Remarks" oninput="this.value = this.value.replace(/[^-@.,/#&+\w\s]/g, '');">
                                                </textarea>
                                            </div>
                                        </div>

                                        <div class="row col-md-12" style="padding-bottom: 10px;">
                                            <label class="col-md-2 align-left "></label>
                                            <div class="form-group col-md-2" style="padding-left: 0;">
                                                <button type="button" class="btn btn-block btn-outline-success btn-flat" onclick="return ConfirmDelete();">Return & Delete</button>
                                            </div>
                                            <div class="form-group col-md-2" style="padding-left: 0;">
                                                <button type="button" class="btn btn-block btn-outline-danger btn-flat" data-dismiss="modal" onclick="return ClearPopUp();">Exit</button>

                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>

                        </section>
                    </div>
                </div>

            </div>
        </div>
    </form>
    <input id="hdUserId" type="hidden" runat="server" />
    <input id="hdBranchId" type="hidden" runat="server" />
    <input id="hdFirmId" type="hidden" runat="server" />    
    <input id="hdnSystemIP" type="hidden" runat="server" />
    <input id="hdSesssion" type="hidden" runat="server" />
    <input id="hdTLead" type="hidden" runat="server" />    
    <input id="hddraftid" type="hidden" runat="server" />
</asp:Content>
