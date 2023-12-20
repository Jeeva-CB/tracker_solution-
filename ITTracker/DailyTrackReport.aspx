<%@ Page Title="" Language="C#" MasterPageFile="~/PWA_Master.Master" AutoEventWireup="true" CodeBehind="DailyTrackReport.aspx.cs" Inherits="ITTracker.DailyTrackReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   
    <script src="js/DailyTrackerReport.js"></script>
    <%--<link href="StyleAutoComplete.css" rel="stylesheet" />
    <script src="AutoCompleteJS.js"></script>--%>
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

           .select2-container--default .select2-selection--multiple {
         
               height: auto  !important;
           }


           .select2-container--default .select2-selection--multiple .select2-selection__choice {
               background-color: #2962ff;
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
             <div class="row" style="text-align:center">
            <%--<div class="ma-header col-5"></div>
            <div class="ma-header">--%>

                <h3 style="color: #5d87b3">Daily Work Report</h3>

           <%-- </div>--%>
        </div>
       <div class="card card-5 rightmarg">
       
    <form id="Form1" class="form-inline row-border" action="#" runat="server">
   
      
    <div class="card-body">

             <div class="row" style="margin-bottom:1%;">
                 <label class="col-md-2">Choose Report Type:</label>
                <%-- <div class="form-control clearfix" id="idRpt">--%>
                     <div class="col-md-2 icheck-primary d-inline">
                         <input type="radio" name="Rpt" value="0" id="rbcpt" checked="checked" onchange="return showCommon();"/>
                         <label for="rbcpt">Common Report</label>&nbsp;&nbsp;
                     </div>
                 
                    <div class="col-md-2 icheck-success d-inline">
                         <input type="radio" name="Rpt" value="1" id="rbcwr" onchange="return showCRFWise();"/>
                         <label for="rbLow">CRF Wise Report</label>&nbsp;&nbsp;&nbsp;&nbsp;                      
                     </div>
                     <div class="col-md-2 icheck-primary d-inline">
                         <input type="radio" name="Rpt" value="2" id="rbtwr" onchange="return showTeamWise();"/>
                         <label for="rbtwr">Team Wise Report</label>&nbsp;&nbsp;
                     </div>
                     <div class="col-md-2 icheck-primary d-inline">
                         <input type="radio" name="Rpt" value="3" id="rbQArpt" onchange="return showCRFWiseQA();"/>
                         <label for="rbQArpt">CRF Wise Report for QA</label>&nbsp;&nbsp;
                     </div>
                   <div class="col-md-2 icheck-primary d-inline">
                         <input type="radio" name="Rpt" value="4" id="block" onchange="return showblock();"/>
                         <label for="block">Punching Block Today</label>&nbsp;&nbsp;
                     </div>
                 <%--</div>--%>
             </div>
        
        <div class="row" id="commonRpt" style="margin-bottom:1%;">
            <label class="col-md-2 align-left ">Developer List <span class="required">*</span> </label>
            <div class="col-md-4 align-left">
                <select class="form-control select2" id="ddlDevlp" style="width: 100%" name="Develpor" onchange="GetAssignedWork()">
                    <option value="-1">Choose Developer</option>
                </select>
            </div>
<%--            <div id="AssgnedWrks" style="display:none;">--%>
            <label class="col-md-2 align-left " id="AssgnedWrks1" style="display:none;">Assigned Works <span class="required">*</span> </label>
            <div class="col-md-4 align-left" id="AssgnedWrks" style="display:none;">
                <select class="form-control select2" id="ddlWorks" style="width: 100%" name="CRF_Sel" onchange="SelectAssignedProjects()">
                    <option value="-1">All</option>
                    <option value="0">Other Works</option>
                </select>
            </div>

        </div>
         
         <div class="row" id="CrfWiseRptQA"style="display:none; margin-bottom:1%;" >
            <label class="col-md-2 align-left">Enter CRFID<span class="required">*</span> </label>
            <div class="col-md-4 align-left">
                <input type="text" class="form-control" id="ddCRFQA" style="width: 100%" name="CRF" onkeypress="return isNumber(event, this.value, 0)">
            </div>
        </div>



         <div class="row" id="CrfWiseRpt"style="display:none; margin-bottom:1%;" >
            <label class="col-md-2 align-left ">Enter CRFID<span class="required">*</span> </label>
            <div class="col-md-4 align-left">
                <input type="text" class="form-control" id="ddCRF" style="width: 100%" name="CRF" onkeypress="return isNumber(event, this.value, 0)">
            </div>
        </div>
    
        <div class="row" id="TeamRpt"style="display:none;margin-bottom:1%;">
        <label class="col-md-2 align-left ">Choose Developers:<span class="required">*</span> </label>
            <div class="col-md-10 align-left">
                <select class="form-control select2" id="ddlDevlp1" multiple="multiple" style="width: 100%" name="Develpor">
                </select>
            </div>
        </div>
     
        <div class="row" id="dt">
            <label class="col-md-2 align-left">From Date <span class="required">*</span> </label>
            <div class="col-md-4 align-left">
             <input type="text" class="form-control " name="fromdate" style="width:100%;" id="fromdate" readonly="readonly" />

            </div>
   
            <label class="col-md-2 align-left">To Date <span class="required">*</span> </label>
            <div class="col-md-4 align-left" >
                <input type="text" class="form-control" name="todate" id="todate"style="width:100%;" readonly="readonly"  />

            </div>

        </div>            
      <br />
      
                    
                
                
                <div class="padding-bottom-10px p-t-40"></div>
           
               
               
                
               <div class="row">
                <div class="col-md-12">
                    <div class="form-group">
                        <div class="buttonbox">
                            <input id="btnConfirm" type="button" value="Generate" class=" btn-facebook btn-lg" onclick="viewReport()" data-toggle="modal" data-backdrop="false" />

                            <input id="btnExit" type="button" value="Exit" class=" btn-lg btn-facebook" onclick="frmExit()" data-toggle="modal" data-backdrop="false" />
                        </div>
                    </div>
                </div>
            </div>
         <table class="table-bordered align-centre col-md-12" id="tableData" style="display:none"><tbody></tbody></table>
            </div>

             
    </form>
        </div>
    <input id="hdFirmId" type="hidden" runat="server" />
    <input id="hdBranchId" type="hidden" runat="server" />
    <input id="hdUserId" type="hidden" runat="server" />
   
</asp:Content>