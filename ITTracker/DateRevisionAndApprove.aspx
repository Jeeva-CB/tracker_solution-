<%@ Page Title="" Language="C#" MasterPageFile="~/PWA_Master.Master" AutoEventWireup="true" CodeBehind="DateRevisionAndApprove.aspx.cs" Inherits="ITTracker.DateRevisionAndApprove" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="StyleAutoComplete.css" rel="stylesheet" />
    <link href="css/MultipleUpload.css" rel="stylesheet"/>
    <script src="js/DateRevisionAndApprove.js"></script>
    <script src="js/MultipleUpload.js"></script>
    <script src="js/aes.js"></script>
     <script type="text/javascript" src="http://github.com/malsup/blockui/raw/master/jquery.blockUI.js?v2.34"></script>
    <style>
        .card-body {
            background: #fff;
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

        .container {
            border: none !important;
        }

        .shadow {
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
            background-color: #a3e39a0a !important;
        }



        .card {
            border: none !important;
        }

        .card-body {
            border: none !important;
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
    </style>


    <style>
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
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">





    <form class="form-inline" runat="server" method="post" enctype="multipart/form-data">
        
        <div class="card-body">
            
           
            
            
            <div class="card-body shadow">
                <div class="row">
                        <label class="col-md-2 align-left ">Choose a CRF <span class="required">*</span> </label>
                        <div class="col-md-10 align-left">
                            <select id="ddlCrf" class="form-control select2" style="width: 100%;" name="txt" onchange="fillCRFData()">
                                <option value="-1">Choose CRF</option>
                            </select>
                        </div>

                    </div>
                <br />
                <h5 class="modal-title" id="myLargeModalLabel">CRF Content</h5>
                <hr />
                <div class="row">
                    <div class="col-md-12">

                        <div class="summernoteview">
                        </div>
                    </div>
                </div>
            </div>
            <br />
            <div id="requesterdtls" style="display:none">
            <div class="card-body shadow">
                <div class="row" id="taDetails">
                    <div id="devTA" class="panel-group col-md-12 align-center padding-bottom-10px">
                        <h3 class="panel-title align-left">Development TA Details</h3>
                        <hr />
                        <table class="table table-hover align-center " id="tabChange">
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="card-body shadow">
                <h3 class="panel-title align-left"> Important Dates</h3><hr />
                <div class="row">
                        <label class="col-md-2 align-left "> Sub CRF <span class="required">*</span> </label>
                        <div class="col-md-10 align-left">
                            <select id="ddlSubCrf" class="form-control" style="width: 100%;" name="CRF_Sel" onchange="fillDates()"> </select> 
                        </div>

                    </div>
                <br />
                <div class="row" id="datesel1" style="padding-bottom: 10px;">
                    <label class="col-md-2 align-right ">Development Start Date:  </label>
                    <div class="col-md-4 align-left">
                        <input type="text" class="form-control align-center" placeholder=" Dev Start Date" id="lblstaDt1" style="width: 100%; color: black">
                    </div>
                    <label class="col-md-2 align-right ">Development End Date:  </label>
                    <div class="col-md-4 align-left">
                        <input type="text" class="form-control align-center" placeholder="Dev End Date" id="lblTarDt1" style="width: 100%; color: black">
                    </div>
               </div>
                <div class="row" id="datesel2" style="padding-bottom: 10px;">
                    <label class="col-md-2 align-right ">Testing Start Date:  </label>
                    <div class="col-md-4 align-left">
                        <input type="text" class="form-control align-center" placeholder="Test Start Date" id="lblstaDt" style="width: 100%; color: black">
                    </div>
                    <label class="col-md-2 align-right ">Testing End Date:  </label>
                    <div class="col-md-4 align-left">
                        <input type="text" class="form-control align-center" placeholder="Test End Date" id="lblTarDt" style="width: 100%; color: black">
                    </div>
                </div>
                <div class="row" id="datesel3" style="padding-bottom: 10px;">
                    <label class="col-md-2 align-right ">Project Target Date:  </label>
                    <div class="col-md-4 align-left">
                        <input type="text" class="form-control align-center" placeholder="Project Target Date" id="lblprtdate" style="width: 100%; color: black">
                    </div>
                </div>
              
               <%-- <div class="form-group row col-md-12 padding-bottom-10px " id="parallelrow">
                         <div class="form-group col-md-2 panel-title align-right">
                             <label for="rdbNature">Attach File  <i class="fa fa-arrow-alt-circle-right"></i></label>
                         </div>
                         <div class="file-upload col-md-4">
                             <div class="file-select">
                                 <div class="file-select-button" id="fileName">Choose File</div>
                                 <div class="file-select-name" id="noFile">No file chosen...</div>
                                 <div class="file-chooser">
                                     <input type="file"  class="file-chooser__input" />
                                 </div>
                             </div>
                         </div>
                         <div class="file-uploader__message-area">
                             <p>Select a file to upload</p>
                         </div>

                     </div>--%>
                
                <div class="row" style="padding-bottom: 20px;">
                    <label class="col-md-2 align-left ">Remarks  </label>
                    <div class="col-md-10 align-left">
                        <textarea rows="1" cols="" class="form-control" style="width: 100%" name="Remarks" id="txtRemarks" title="Remarks" oninput="this.value = this.value.replace(/[^-@.,/#&+\w\s]/g, '');">
                            </textarea>
                    </div>
                </div>
                   <div class="row" id="showSubmitBtn">
                      
                    <div class="col-md-2 col-sm-2 col-xs-4">
                        <a href="#" class="btn btn-block btn-outline-success btn-flat" style="width: 100%; margin: 0px;"
                            onclick="return FileUploading();" id="btnSubmit"><i class="fa fa-thumbs-up"></i>&nbsp;&nbsp;Apply</a>
                    </div>
                    
                    <div class="col-md-2 col-sm-2 col-xs-4">
                        <a href="#" class="btn btn-block btn-outline-danger btn-flat" style="width: 100%; margin: 0px;"
                            onclick="return frmExit();"><i class="fa fa-sign-out-alt"></i>&nbsp;&nbsp;Exit</a>
                    </div>
                 
                </div>     
            </div>
            </div>
            <br />
            <div id="forapprover" style="display:none">
                 <div class="card-body shadow">
                <h3 class="panel-title align-left"> Attachments/Approvals</h3><hr />
                <div id="Doc" style="padding-bottom: 20px;" class="row padding-bottom-10px">
                    <div class="table-responsive col-md-6 align-left">
                        <table class="table1 table-hover" id="tblFiles">
                        </table>
                    </div>
                </div>
                <h3 class="panel-title align-left"> Old Date Details</h3><hr />
                 <div id="CrfDetailsID" >

                      <div class="form-group row col-md-12 padding-bottom-10px" style="color: black;">
                      <label class=" col-md-2 align-right">Requested Date: </label>
                    <div class="col-md-2 align-left">
                        <label class="align-left" id="lblRqstDt" style="width: 150px; color: maroon"></label>
                    </div>
               
                    <label class=" col-md-2 align-right">Development Start Date : </label>
                    <div class="col-md-2 align-left">
                        <label class="align-left" id="lbldevstdt" style="width: 150px; color: maroon"></label>
                    </div>
                    <label class=" col-md-2 align-right"> Development End Date : </label>
                    <div class="col-md-2 align-left">
                        <label class="align-left" id="lbldevenddt" style="width: 150px; color: maroon"></label>
                    </div>
                       
                </div>  
                <div class="form-group row col-md-12 padding-bottom-30px" style="color: black;">
                 
                       <label class=" col-md-2 align-right">Testing Start Date : </label>
                    <div class="col-md-2 align-left">
                        <label class="align-left" id="lbltstdt" style="width: 150px; color: maroon"></label>
                    </div>
                    <label class=" col-md-2 align-right">Testing End Date: </label>
                    <div class="col-md-2 align-left">
                        <label class="align-left" id="lbltstenddt" style="width: 150px; color: maroon"></label>
                    </div>
                    <label class=" col-md-2 align-right">Project Target Date : </label>
                    <div class="col-md-2 align-left">
                        <label class="align-left" id="iblprjtdate" style="width: 150px; color: maroon"></label>
                    </div>
                 
                </div>
                </div>    
               
            </div>
             <div class="card-body shadow">
                 <h3 class="panel-title align-left"> Updated Date Details</h3><hr />
                 <div class="row" id="datesel5" style="padding-bottom: 10px;">
                    <label class="col-md-2 align-right ">Development Start Date:  </label>
                    <div class="col-md-4 align-left">
                        <input type="text" class="form-control align-center" readonly="readonly" placeholder=" Dev Start Date" id="lblstaDt3" style="width: 100%; color: black">
                    </div>
                    <label class="col-md-2 align-right ">Development End Date:  </label>
                    <div class="col-md-4 align-left">
                        <input type="text" class="form-control align-center" readonly="readonly"  placeholder="Dev End Date" id="lblTarDt3" style="width: 100%; color: black">
                    </div>
               </div>
                <div class="row" id="datesel6" style="padding-bottom: 10px;">
                    <label class="col-md-2 align-right ">Testing Start Date:  </label>
                    <div class="col-md-4 align-left">
                        <input type="text" class="form-control align-center" readonly="readonly"  placeholder="Test Start Date" id="lblstaDt2" style="width: 100%; color: black">
                    </div>
                    <label class="col-md-2 align-right ">Testing End Date:  </label>
                    <div class="col-md-4 align-left">
                        <input type="text" class="form-control align-center" readonly="readonly"  placeholder="Test End Date" id="lblTarDt2" style="width: 100%; color: black">
                    </div>
                </div>
                <div class="row" id="datesel4" style="padding-bottom: 10px;">
                    <label class="col-md-2 align-right ">Project Target Date:  </label>
                    <div class="col-md-4 align-left">
                        <input type="text" class="form-control align-center" readonly="readonly"  placeholder="Project Target Date" id="lblprtdate1" style="width: 100%; color: black">
                    </div>
                </div>
                 <div class="row" style="padding-bottom: 20px;">
                    <label class="col-md-2 align-left ">Remarks  </label>
                    <div class="col-md-10 align-left">
                        <textarea rows="1" cols="" class="form-control" style="width: 100%" name="Remarks" id="txtRemarks1" title="Remarks" oninput="this.value = this.value.replace(/[^-@.,/#&+\w\s]/g, '');">
                            </textarea>
                    </div>
                </div>
             <div class="row" id="showSubmitBtn1">
                      
                    <div class="col-md-2 col-sm-2 col-xs-4">
                        <a href="#" class="btn btn-block btn-outline-success btn-flat" style="width: 100%; margin: 0px;"
                            onclick="return DateConfirmation();" id="btnSubmit1"><i class="fa fa-thumbs-up"></i>&nbsp;&nbsp;Approve</a>
                    </div>
                    
                    <div class="col-md-2 col-sm-2 col-xs-4">
                        <a href="#" class="btn btn-block btn-outline-danger btn-flat" style="width: 100%; margin: 0px;"
                            onclick="return returnToRequester();"><i class="fa fa-sign-out-alt"></i>&nbsp;&nbsp;Return</a>
                    </div>
                 
                </div> 
                 </div>

            </div>
           
            <br />

    </form>


    <input id="hdSesssion" type="hidden" runat="server" />
    <input id="hdUserId" type="hidden" runat="server" />
    <input id="hdBranchId" type="hidden" runat="server" />
    <input id="hdFirmId" type="hidden" runat="server" />
    <input id="hdnReturnStatus" type="hidden" runat="server" />
    <input id="hdnAllEmployees" type="hidden" runat="server" />
    <input id="hdnquerynoteid" type="hidden" runat="server" />
    <input id="hdnReqID" type="hidden" runat="server" />
</asp:Content>
