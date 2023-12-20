<%@ Page Title="" Language="C#" MasterPageFile="~/PWA_Master.Master" AutoEventWireup="true" CodeBehind="AdminPage.aspx.cs" Inherits="ITTacker.AdminPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="StyleAutoComplete.css" rel="stylesheet" />
    <script src="AutoCompleteJS.js"></script>
    <script src="js/AdminPage.js"></script>
    <script src="js/jquery.min.1.11.1.js" type="text/javascript"></script>
    <script src="js/jquery.table2excel.min.js" type="text/javascript"></script>
    <style>
        .brdstyle {
            color: #168D85;
        }

        .btn_chng {
            font: 12px !important;
            padding: 10px;
            background-color: darkblue;
            width: 25%;
            line-height: 1.4;
            font-weight: bold;
            color: #ffffff;
        }

            .btn_chng:hover {
                background-color: #168D85;
                color: #ffffff;
            }

        .rnd {
            border-radius: 60px;
            border-color: darkblue;
            width: 150px;
        }
        .lblfnt{
            font-size:12px!important;
        }
            .rnd:hover {
                background-color: #0505a7;
                color: #ffffff;
                border-color: #0505a7;
            }

        .marg {
            margin-top: 10px;
        }

        .txtchng {
            width: 150px;
        }
        .fntColr{
            color :darkblue;
        }
        .bord{
            border:0.5px dashed #808080;
            padding:10px;
        }

        .change:visited::after {
            content: "";
            position: absolute;
            height: 0%;
            left: 50%;
            top: 50%;
            width: 150%;
            z-index: -1;
            -webkit-transition: all 0.75s ease 0s;
            -moz-transition: all 0.75s ease 0s;
            -o-transition: all 0.75s ease 0s;
            transition: all 0.75s ease 0s;
        }

        .change.thar-two::before {
            display: block;
            position: absolute;
            left: 0px;
            top: 0px;
            height: 0px;
            width: 100%;
            z-index: -1;
            content: '';
            color: #000 !important;
            background: darkblue !important;
            border: 2px solid #F7CA18;
            transition: all 0.4s cubic-bezier(0.215, 0.61, 0.355, 1) 0s;
        }

        .card {
            margin-top: 20px !important;
        }
        .EmpBtn{
            background-color:#808080;
            border-color:#F7CA18;
        }
        .EmpBtn:hover{
            background-color:#F7CA18;
            border-color:#808080;
        }
        .srchstyle{
             border: 1px solid #ccc;
             border-radius:5px ;
             border-left:none;
             border-right:none;
             width:100%;
             margin-right:5px;
             margin-left:5px;
             padding:3px 10px;
        }
        .PendtblStyl{
            color:white;
            background-color:#bb8a8a;
        }
        a:active {
           color: gray;
        }
        .PendDtldTbl{
            color:#4e1010;
            background-color:#cbbc81;
        }
        .exclbtn{
            background-color:#bb8a8a ;
            color:white;
            border: 1px solid #763636;
             border-radius:10px ;
             width:125px;
             height:30px;
        }
        .exclbtnDt{
            background-color:#cbbc81 ;
            color:#4e1010;
             border: 1px solid #763636;
             border-radius:10px ;
             width:125px;
             height:30px;
        }
    </style>
    <script type="text/javascript">
            function exportexcel() {
                $("#tblPendRprt").table2excel({
                    name: "Table2Excel",
                    filename: "PaperlessPendingList",
                    fileext: ".xls"
                });
            }
        function exportexcel2() {
             $("#tblPendRprtDtl").table2excel({
                    name: "Table2Excel",
                    filename: "PaperlessPendingListDetails",
                    fileext: ".xls"
                });
        }
		</script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row col-12">
        <div class="col-12">
            <div class="card card-5 rightmarg">
                <form class="form-horizontal" runat="server" method="post" enctype="multipart/form-data">
                    <div class="card-body">

                        <%--      <div class="navbar-collapse collapse" id="navbarSupportedContent">
                      <ul class="navbar-nav float-left mr-auto">
                           <li class="nav-item "><a href="#AddDoc" aria-controls="AddDoc"  data-toggle="tooltip">Add Document Type</a></li>   

                              <li class="nav-item "><a href="#NeedDisc" aria-controls="NeedDisc" data-toggle="tooltip">Need Discussion</a></li>   
                            </ul>
                        </div>--%>


                    <div class="row">
                            <div class="col-md-6 align-right form-group">
                                <input id="btnAddDoc" type="button" value="Document Type" class="btn_chng  align-center" onclick="AddType()" data-toggle="modal"  data-backdrop="false" />
                                &nbsp; &nbsp; &nbsp; &nbsp; 
                                <input id="btnAutoSkip" type="button" value="Skip Reviewer" class="btn_chng  align-center" onclick="AutoSkip()" data-toggle="modal"  data-backdrop="false" />
                               &nbsp; &nbsp; &nbsp; &nbsp;  
                                <%--<input id="btncancel" type="button" value="Cancel Note" class="btn_chng  align-center" onclick="NoteCancl()" data-toggle="modal" data-backdrop="false" />--%>
                                <input id="btnReport" type="button" value="Pending Report" class="btn_chng  align-center" onclick="PendRpt()" data-toggle="modal" data-backdrop="false" />
                            </div>

                        </div>                    </div>
                    <%--  ---------------------------------------Doc Type---------------------------------------%>
                    <div id="DocTyp" style="display: none" >
                        <%--  <div class="col-12" id="divRadio">
                            <div class="card card-5">
                                <section class="panel vh-20">
                                    <div class="col-12 marg ">
                                      <%--  <button type="button" class="btn  rnd font-10" onclick="ShowDocDv()"><i class="fa fa-plus"></i>Add Document Type</button>--%>


                        <%--   </div>
                                </section>
                            </div>
                        </div>--%>
                        <div class="col-12" id="ShowAddd" <%--style="display: none"--%>>
                            <%--  <div class="col-md-4"></div>--%>
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="card card-5" >
                                        <div class="card-header">

                                            <label for="ddlDocType">ADD NEW DOCUMENT TYPE</label>
                                        </div>
                                        <%--<div class="col-md-4">--%>
                                        <div class="col-md-12">
                                            <section class="panel vh-40 ">
                                                <div class="col-12 panel-body" id="DIvDoc">
                                                    <div class="col-md-12">
                                                        <div class="col-md-4">

                                                            <label class="pure-material-textfield-outlined">
                                                                <label>Type Name :</label>
                                                                <input type="text" class="txtchng" placeholder=" " id="txtDocType" title="Document Type" maxlength="20" oninput="this.value = this.value.replace(/[^ a-zA-Z0-9&.,_-]/g, '');" required>
                                                            </label>
                                                            <label class="pure-material-textfield-outlined">
                                                                <label>Descrption :</label>
                                                                <input type="text" class="txtchng" placeholder=" " id="txtDesc" title="Description" maxlength="20" oninput="this.value = this.value.replace(/[^ a-zA-Z0-9&.,_-]/g, '');" required>
                                                            </label>
                                                            <%--  
                                          </div>
                                            <div class="col-md-4 col-sm-2 col-xs-4">--%>
                                                        </div>
                                                        <%-- <a href="#" class="btn btn-sm animated-button thar-one btn-primary" style="width: 50%; margin: 5px;"
                                                        onclick="return ConfirmDAta()" id="btnAdd"><i class="fa fa-check"></i>Add</a>--%>
                                                        <div class="col-md-12">

                                                            <button type="button" class="btn  rnd font-10" onclick="return ConfirmDAta()"><i class="fa fa-plus"></i>&nbsp;&nbsp;&nbsp;Add Document Type</button>
                                                        </div>
                                                        <br />
                                                      <%--  <div class="col-md-12">
                                                            <button type="button" class="btn  rnd font-10" onclick="ShowDocDivv()"><i class="fa fa-file-alt"></i>&nbsp;&nbsp;&nbsp;Show Document Type</button>

                                                        </div>--%>
                                                    </div>
                                                </div>
                                            </section>
                                        </div>
                                        <%--</div>--%>
                                    </div>
                                </div>
                                <div class="col-md-6" id="ShwTblDoc" style="display: none">
                                    <div class="card card-5" <%--style="background-color: #d1c5c5"--%>>
                                         <div class="card-header">
                                            <label for="ddlDocType">DOCUMENT TYPE LIST</label>
                                        </div>
                                        <div class="col-md-12">
                                            <section class="panel vh-40">
                                                <div class="panel-body" id="DIvTbl">

                                                    <div class="col-12">
                                                        <%--   <div class="col-md-4"></div>--%>
                                                        <div class="col-md-12">
                                                            <%--  <div class="card card-5">--%>
                                                            <%--<div class="card-header">

                                        <label for="ddlDocType">DOCUMENT TYPE</label>
                                    </div>--%>
                                                            <%--   <section class="panel vh-60 ">--%>
                                                            <%-- <div class="col-12 panel-body" id="DIvTbl">--%>
                                                            <div class="table-responsive vh-40">
                                                                <table class="table1 table-hover" id="tblDocs">
                                                                </table>
                                                            </div>
                                                            <%--  </div>--%>
                                                            <%--  </section>--%>
                                                            <%-- </div>--%>
                                                        </div>
                                                    </div>
                                                </div>
                                            </section>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                    <%-----------------------------------------Auto Skip -----------------------------%>
                    <div class="col-12" id="AutoSkip" data-spy="scroll">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="card card-5" style="background-color: #ffffff">
                                    <div class="card-header">
                                              <label for="ddlDocType">SKIP REVIEWER</label>
                                        <div class="row">
                                              <div class="col-md-4">
                                                  <input type="text" class="form-control" placeholder="Type Here to Search &amp; Press Enter" id="txtAutoSkipNote" >
                                                  
                                             <%--<div class="search-box">
                                                    <a href="javascript:void(0)" style="color: darkblue; font-weight: 700; font-size: 1.125rem">Search  <i class="fa fa-search font-18" style="color: darkblue;"></i></a>

                                                    <div class="app-search1 position-absolute">
                                                        
                                                        <a class="srh-btn1"><i class="ti-close"></i></a>
                                                    </div>

                                                </div>--%>
                                                </div>
                                            <div class="col-md-2 col-sm-2 col-xs-4"> <a href="#" class="btn btn-sm animated-button thar-one btn-primary" style="width: 100%;
margin: 5px;"onclick="return NoteSearch();" id="btnSearch"><i class="fa fa-search"></i> Search</a> </div>
                                            
                                  </div>
                                    </div>
                                    <div class="card-body " >

<%--<section class="panel vh-40 "><br />  --%>                                      
<div class="col-md-12">
<div class="table-responsive" style="display:none" id ="shwNoteDtlsDiv">
<table class="table table-hover table-success" id="tblNoteDtls"  > 
<thead class=" text-white" >
<tr >                                 
</tr> 
</thead> 
<tbody class="border border-dark"></tbody>
</table> 
</div>
</div>
    <br /> 
<div class="col-md-12">
<div id="Notelabels" style="display:none">
<div class="bord">
<div class="row">
<div class="col-md-6" >
<label class="lblfnt">Note ID :</label> <span id="lblSkNoteId" class ="head6 fntColr"></span><input type="hidden" name="NoteId" id="hdnSkNoteId"/>
</div>

</div>
                                        
<div class="col-md-8" >
<div class=" col-md-12"><label class="lblfnt">Subject : </label>
<span id="lblSubject"  class ="head6 fntColr"></span>
</div>
</div>


<div class="row">
     <div class="col-md-3 font-10" >
<div class="form-group"><label class="lblfnt">Document Type :</label>  <span id="lblDoctyp" class="font-12 text-maroon"></span></div>
</div>
    <div class="col-md-3 font-10" >
<div class="form-group"><label class="lblfnt">Created By  :</label>  <span id="lblCreateBy" class="font-12 text-maroon"></span></div>
</div>
    <div class="col-md-3 font-10" >
<div class="form-group"><label class="lblfnt">Department : </label><span id="lbldept" class="font-12 text-maroon"></span></div>
</div>
    <div class="col-md-3 font-10" >
<div class="form-group"><label class="lblfnt">Created Date :</label> <span id="lblcreatedDate" class="font-12 text-maroon"></span></div>
</div>


</div></div></div>
</div>
  <br />
<div class="col-md-12">
<div class="col-md-12">
 <%--    <button type="button" class="btn  rnd font-10" onclick="ShowApprvrDiv()"><i class="fa fa-file-alt"></i>&nbsp;&nbsp;&nbsp;Approvers List </button>--%>
</div>
<div class="table-responsive">
<table class="table1 table-hover" id="tblApprovers">
</table>
</div>
</div>
<br />
<div id="AddApprvsDiv" style="background-color:#d3cccc">
<div class="row"><div class="col-md-9"></div>
<div class="col-md-3 align-right">
<a href="#1" class="btn btn-sm animated-button  EmpBtn" style="width: 200px;
margin: 5px;"onclick="return addApprovers();" id="btnAdd"><i class="fa fa-user-plus"></i> Add Approvers</a>
</div>
</div>
<div class="row" id="showEmpName" style="display:none">
<div class="col-md-12">
<div class="col-md-12" id="parallelrow">
<div class="row" id="p_rowid">
 <div class="col-md-2"><div class="form-group">
 <b>Add Employee</b></div></div>
 <div class="col-md-8 employee-id-row"><div class="form-group">
 <div class="all-emp" id="r_emp"></div>
       <a href="#2" class="btn btn-sm animated-button  EmpBtn" style="width:20% " onclick="AdApprovesFn()" id="Addbtn"><i class="fa fa-check"></i> </a> 
 <div class="autocomplete" style="width:50%;" align="left"><input id="txtEmpCodes" autocomplete="off" class="text-uppercase srchstyle" name="searchEmployee" placeholder="Search Employee.." onkeyup="SearchDataAutoCompleteEmpSingle(this.id, this.value,'2','hdnEmpCode','PWAAPP','GetEmployeeNote' ,'r_emp')" type="text">
  </div>
     <div class="col-md-2"><input id="hdnEmpCode" type="hidden"><%--</div>--%>
   <%--  <div class="col-md-2">--%>
 </div>
 </div></div></div>
</div>
</div>
</div>
</div>
                                        <%--</section>--%>

                                       </div>
                    
                                </div>
                            </div>
                        </div>
                    </div>
                   <%-- //--------------------------------------------------------------------//--%>
                    <div id="ShwEmptyDiv" style="display:none">
                                        <div class="row">
<div class="col-md-12">
<div class="form-group" >
<div style="font-size: 18px; text-align: center;"><i class="fa fa-filter fa-5x" aria-hidden="true" style="opacity: 0.5;"></i></div>
<div style="font-size: 18px; text-align: center;">    <h5>We didn't find anything...</h5></div>
    <div style="font-size: 12px; text-align: center;">    Try a different keyword...</div>
</div>



</div>
</div>
                    </div>
                    <%------------------------------------Cancel Note -------------------------------------------------------%>
              <%--      <div id="CanclNt" style="display: none">
                        <div class="col-12">
                            <div class="col-4"></div>
                            <div class="col-md-6">
                                <div class="card card-5">
                                    <div class="card-header">
                                        <label for="ddlDocType">CANCEL NOTE</label>
                                    </div>

                                    <section class="panel vh-60 ">
                                        <div class="col-12 panel-body" id="DinVote">
                                            <div class="col-md-4">


                                                <div class="nav-item search-box">
                                                    <a href="javascript:void(0)" style="color: #7460ee; font-weight: 700; font-size: 1.125rem">Search  <i class="fa fa-search font-18" style="color: #7460ee;"></i></a>

                                                    <div class="app-search position-absolute">
                                                        <input type="text" class="form-control" placeholder="Search &amp; enter" id="txtSearchNote">
                                                        <a class="srh-btn"><i class="ti-close"></i></a>
                                                    </div>

                                                </div>
                                                <%-- <div class="col-12">
                                                       <div class="col-md-4">
                                                          <input type="text" placeholder=" " id="txtNoteID" title="Note ID" maxlength="20" readonly="readonly">
                                                   </div>
                                                       </div>--%>
                                         <%--   </div>
                                        </div>
                                    </section>
                                </div>
                            </div>
                        </div>
                    </div>--%>
                 <%--   ---------------------------------------Pending Report----------------------------------------------%>
                     <div id="RprtDtlDiv" style="display: none ">
                             <div class="row">
                                 <div class="col-md-12">
                                  <div class="card card-5" >
                                       <div class="card-header">
                                            <label for="ddlPendRpte" > <a href="#3" class="btn btn-sm" style="width: 100%;
margin: 5px;"onclick="this.style.color='#0c6598';return ReportView();" id="lblPendRpt">  PENDING REPORT</a></label>
                                            <label for="ddlPndTrtDtl"><a href="#4" class="btn btn-sm " style="width: 100%;
margin: 5px;"onclick="this.style.color='#0c6598';return ReportViewDetail();" id="lblPendRptdTL">  PENDING REPORT DETAIL</a> 
                                                </label>
                                        </div>
                                          <div class="col-md-12">
                                                <section class="panel vh-40 ">
                                                       <div class="col-12 panel-body" id="DIvRptPend" style="display:none">
                                                             <div class="col-12 panel-body">
                                                                 <div class="row">
                                                               <div class="col-md-5 align-left">
                                                              <input type="button" id="btnPend" onclick="exportexcel()" class="exclbtn" value="Export to Excel"/>
                                                           </div> 
                                                          <div class="col-md-6 align-left">
                                                                   <h4 style="color:#763636">PENDING REPORT</h4>
                                                               </div>
                                                                 </div></div>
                                                               <div class="col-md-12">
                                                                    <div class="table-responsive vh-40">
                                                                <table class="table1 table-hover PendtblStyl" id="tblPendRprt">
                                                                </table>
                                                            </div>
                                                                   </div>
                                                           </div>
                                                     <div class="col-12 panel-body" id="DIvRptPendDetail" style="display:none">
                                                           <div class="col-12 panel-body">
                                                                <div class="row">
                                                               <div class="col-md-5 align-left">
                                                              <input type="button" id="btnDtl" onclick="exportexcel2()" class="exclbtnDt" value="Export to Excel"/>
                                                           </div>
                                                               <div class="col-md-6 align-left">
                                                                   <h4 style="color:#4e1010">PENDING REPORT DETAIL</h4>
                                                               </div>
                                                               </div>
                                                           </div>
                                                               <div class="col-md-12">
                                                                    <div class="table-responsive vh-40">
                                                                <table class="table1 table-hover PendDtldTbl" id="tblPendRprtDtl">
                                                                </table>
                                                            </div>
                                                                   </div>
                                                           </div>
                             </section>
                                              </div>
                                      </div>
                                 </div>
                             </div>
                         </div>
                    <%-----------------------------------------------------------ENd------------------------------------------------%>
                    <input type="hidden" runat="server" id="hdNoteID" />
                    <input id="hdUserId" type="hidden" runat="server"/>
                </form>
            </div>
        </div>
    </div>


</asp:Content>
