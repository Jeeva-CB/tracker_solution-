<%@ Page Title="" Language="C#" MasterPageFile="~/PWA_Master.Master" AutoEventWireup="true" CodeBehind="team_module_dev.aspx.cs" Inherits="ITTracker.team_module_dev" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="js/team.js"></script>
    <script src="AutoCompleteJS.js"></script>
    <link href="StyleAutoComplete.css" rel="stylesheet" />
    <script type="text/javascript">
        $(document).on('click', '.cancel-emp', function () {
            $(this).parent().remove();
            $("#txtmodule").prop("readonly", false);
        });
    </script>
    <script type="text/javascript">
        $(document).on('click', '.cancel-emp', function () {
            $(this).parent().remove();
            $("#txttech").prop("readonly", false);
        });
    </script>
    <script type="text/javascript">
        $(document).on('click', '.cancel-emp', function () {
            $(this).parent().remove();
            $("#hdntdev").prop("readonly", false);
        });
    </script>
<script type="text/javascript">
        $(document).on('click', '.cancel-emp', function () {
            $(this).parent().remove();
            $("#txtEmpCode").prop("readonly", false);
        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="card card-5 rightmarg">
        <form class="form-inline" runat="server" method="post" enctype="multipart/form-data">
            <div class="card-body">
     <div id="div1" class="form-group col-md-12  padding-bottom-10px" style="color: black;">
         <div class="row col-md-12" id="mod" style="margin-bottom:1%;">
             <label class="col-md-6 align-right "> Adding Modules/ Deleting Modules :<span class="required"></span></label>
             <div class="col-md-2">
                 <input type="radio" name="rbRe" id="rbmod" onclick="showmodule()" />&nbsp;<span style="color: black">Module</span>
             </div>            
         </div>
         <div class="row col-md-12" id="dev" style="margin-bottom:1%;">
             <label class="col-md-6 align-right "> Adding/Deleting Developers or Tester to Team :<span class="required"></span></label>
             <div class="col-md-2">
                 <input type="radio" name="rbRe" id="rbdev" onclick="showdeveloper()" />&nbsp;<span style="color: black">Developer/Tester</span> &nbsp;&nbsp;
             </div>            
         </div>
         <div class="row col-md-12" id="tecl" style="margin-bottom:1%;">
             <label class="col-md-6 align-right "> Adding/Deleting TechLeads :<span class="required"></span></label>
             <div class="col-md-2">
                 <input type="radio" name="rbRe" id="rbtechld" onclick="showtechlead()" />&nbsp;<span style="color: black">Techlead</span>
             </div>            
         </div>

         <div class="row col-md-12" id="test" style="margin-bottom:1%;">
             <label class="col-md-6 align-right "> For Changing TestEngineers :<span class="required"></span></label>
             <div class="col-md-2">
                 <input type="radio" name="rbRe" id="rbtest" onclick="fortesters();" />&nbsp;<span style="color: black">For Testers</span>
             </div>            
         </div>



    </div>
                <div id="modDatas">
                    <div class="row" id="moduledata" style="display: none; margin-bottom: 1%;">
                        <div id="di" class="form-group col-md-12  padding-bottom-10px" style="color: black;">
                            <label class="col-md-3 align-right "><span class="required"></span></label>
                            <div class="col-md-6 align-left">
                                <input type="radio" name="rbReturn" id="rbReturn" onclick="ShowPurpose()" /><span style="color: black;"> &nbsp;INSERT </span>
                                <input type="radio" name="rbReturn" id="rbNonReturn" onclick="ShowPurpose1()" /><span style="color: black">&nbsp; DELETE</span>
                            </div>
                        </div>
                    </div>

                    <div id="insert" style="display: none; margin-bottom: 1%;">

                        <div class="row col-md-12">
                            <label class="row col-md-2">Select Team :</label>
                            <select class="form-control input-group-text col-md-4" id="techlead" style="width: 300px; color: black;" name="techlead" onchange="techleadfill()">
                                <option value="-1"></option>
                            </select>
                            <label class="row col-md-2">Module :</label>
                            <input class="col-md-3" type="text" id="txtmod" name="txtmod" style="width: 300px; color: black;" />
                            <input class="col-md-1" type="button" id="butadd" value="ADD" onclick="adddata()" />
                        </div>
                        <br />
                        <div class="col-md-12" style="margin-bottom: 2%;">
                            <table class="table table-hover" id="tableData"></table>
                        </div>
                        <div class="row" id="showSubmitBtn">
                            <div class="col-md-2 col-sm-2 col-xs-4">
                                <a href="#" class="btn btn-sm animated-button thar-one btn-primary" style="width: 100%; margin: 5px;"
                                    onclick="return ConfirmNote();" id="btnSubmit"><i class="fa fa-thumbs-up"></i>Insert</a>
                            </div>
                            <div class="col-md-2 col-sm-2 col-xs-4">
                                <a href="#" class="btn btn-sm animated-button thar-one btn-red" style="width: 100%; margin: 5px;"
                                    onclick="return frmExit();"><i class="fa fa-sign-out-alt"></i>Exit</a>
                            </div>

                        </div>

                    </div>
                    <div id="delete" style="display: none; margin-bottom: 1%;">
                        <div class="row col-md-12">
                            <label class="col-md-2">Select Team :</label>
                            <select class="form-control input-group-text col-md-4" id="techlead1" style="width: 300px; color: black;" name="techlead" onchange="moduleselect()">
                            </select>

                            <label class="col-md-2">Select Module :</label>
                            <select class="form-control input-group-text col-md-3" id="module1" style="width: 300px; color: black;" name="Module" onchange="techleadfill()">
                            </select>

                            <input class="col-md-1" type="button" id="butadd1" value="ADD" onclick="adddata1()" />
                        </div>

                        <div class="col-md-12" style="margin-bottom: 2%;">
                            <table class="table table-hover" id="tableData1"></table>
                        </div>
                        <div class="row" id="showSubmitBtn1">

                            <div class="col-md-2 col-sm-2 col-xs-4">
                                <a href="#" class="btn btn-sm animated-button thar-one btn-primary" style="width: 100%; margin: 5px;"
                                    onclick="return ConfirmNote1();" id="btnSubmit1"><i class="fa fa-thumbs-up"></i>Delete</a>
                            </div>
                            <div class="col-md-2 col-sm-2 col-xs-4">
                                <a href="#" class="btn btn-sm animated-button thar-one btn-red" style="width: 100%; margin: 5px;"
                                    onclick="return frmExit();"><i class="fa fa-sign-out-alt"></i>Exit</a>
                            </div>

                        </div>
                    </div>
                </div>

                <div id="devdata" style="display: none">

                    <div id="techleaddata" style="display: none">
                        <div class="card-body">
                            <div id="div2" class="form-group col-md-12  padding-bottom-10px" style="color: black;">
                                <label class="col-md-3 align-right "><span class="required"></span></label>
                                <div class="col-md-6 align-left">
                                    <input type="radio" name="rbReturn" id="rbInsert" onclick="InsertPurpose();" /><span style="color: black;"> &nbsp;INSERT </span>
                                    <input type="radio" name="rbReturn" id="rbDelete" onclick="DeletePurpose()" /><span style="color: black">&nbsp; DELETE</span>
                                </div>
                            </div>


                            <div id="insertdev" style="display: none">


                                <%--<div class="row">--%>
                                    <div id="div12" class="form-group col-md-12  p-1 padding-bottom-10px" style="color: black;">
                                        <label class="col-md-2 align-right ">Team <span class="required">*</span>: </label>
                                        <div class="col-md-4 align-left">
                                            <select class="form-control input-group-text" id="ddlteam" style="width: 100%; color: black;" name="ddlteam">
                                                <option value="-1"></option>
                                            </select>
                                        </div>

                                        <label class="col-md-2 align-right ">Member <span class="required">*</span>: </label>
                                        <div class="col-md-4 align-left">
                                              <select id="txtEmpCode" class="form-control select2"  style="width: 100%;" name="Emp"></select>
                                        </div>
                                    </div>
                               <div id="div13" class="form-group col-md-12  p-1 padding-bottom-10px" style="color: black;">
                                        <label class="col-md-2 align-right ">Developer Category <span class="required">*</span>: </label>
                                        <div class="col-md-4 align-left">
                                            <select class="form-control input-group-text" id="Category" style="width: 100%; color: black;" name="Category">
                                            </select>
                                        </div>
                                      <input class="col-md-1 align-left" type="button" id="butadddevp" value="ADD" onclick="adddevelpordata()" />
                                </div>
        
                                <div class="row">
                                    <div class="form-group col-md-12  padding-bottom-10px" style="color: black;">
                                        <table class="table table-hover" id="tabledeveloperData">
                                        </table>
                                    </div>
                                </div>
                           
                          
                            <div class="row" id="showSubmitBtn3">

                                <div class="col-md-2 col-sm-2 col-xs-4">
                                    <a href="#" class="btn btn-sm animated-button thar-one btn-primary" style="width: 100%; margin: 5px;"
                                        onclick="return ConfirmNotedev();" id="btnSubmit3"><i class="fa fa-thumbs-up"></i>Confirm</a>
                                </div>
                                <div class="col-md-2 col-sm-2 col-xs-4">
                                    <a href="#" class="btn btn-sm animated-button thar-one btn-red" style="width: 100%; margin: 5px;"
                                        onclick="return frmExit();"><i class="fa fa-sign-out-alt"></i>Exit</a>
                                </div>

                            </div>
                            </div>

                         <div id="deletedev" style="display: none">


                                <%--<div class="row">--%>
                                    <div id="div123" class="form-group col-md-12  p-1 padding-bottom-10px" style="color: black;">
                                        <label class="col-md-2 align-right ">Team <span class="required">*</span>: </label>
                                        <div class="col-md-4 align-left">
                                            <select class="form-control input-group-text" id="ddlteam1" style="width: 100%; color: black;" name="ddlteam" onchange="getEmployeeDetailsDlt();">
                                                <option value="-1"></option>
                                            </select>
                                        </div>

                                        <label class="col-md-1 align-right ">Member <span class="required">*</span>: </label>
                                        <div class="col-md-4 align-left">
                                              <select id="txtEmpCode1" class="form-control select2"  style="width: 100%;" name="Emp"></select>
                                        </div>
                                             <input class="col-md-1 align-left" type="button" id="butadddevp1" value="ADD" onclick="deldevelpordata()" />
                                    </div>
                               
                           
        
                                <div class="row">
                                    <div class="form-group col-md-12  padding-bottom-10px" style="color: black;">
                                        <table class="table table-hover" id="tabledeveloperDel">
                                        </table>
                                    </div>
                                </div>
                           
                          
                            <div class="row" id="showSubmitBtnDel">

                                <div class="col-md-2 col-sm-2 col-xs-4">
                                    <a href="#" class="btn btn-sm animated-button thar-one btn-primary" style="width: 100%; margin: 5px;"
                                        onclick="return ConfirmDeldev();" id="btnSubmitDel"><i class="fa fa-thumbs-up"></i>Delete</a>
                                </div>
                                <div class="col-md-2 col-sm-2 col-xs-4">
                                    <a href="#" class="btn btn-sm animated-button thar-one btn-red" style="width: 100%; margin: 5px;"
                                        onclick="return frmExit();"><i class="fa fa-sign-out-alt"></i>Exit</a>
                                </div>

                            </div>
                            </div>


                         </div>
                       </div>
                    </div>
                        <div id="divtechnew" style="display:none">
                           <div class="card-body">
                            <div id="techdata">
                                <div class="row col-md-12">
                                    <label class="col-md-2 align-right ">Choose CRF:<span class="required"></span></label>
                                    <div class="col-md-10 align-left">
                                        <select id="txtmodule" class="form-control select2" style="width: 100%;" name="txt" onchange="subcrfonchange()"></select>
                                    </div>
                                </div>
                                <br />
                                <div class="form-group col-md-12  padding-bottom-10px" style="color: black;">
                                    <label class="col-md-3 align-right "><span class="required"></span></label>
                                    <div class="col-md-6 align-left">
                                        <input type="radio" name="rbRess" value="rbtech" id="rbtech" onclick="showtech()" /><span style="color: black;"> &nbsp;TECHLEAD </span>

                                        &nbsp;&nbsp;
                                    <input type="radio" name="rbRess" value="rbdeve" id="rbdeve" onclick="showdev()" /><span style="color: black">&nbsp; DEVELOPER</span>

                                    </div>
                                </div>
                                <div class="form-group col-md-12  padding-bottom-10px" style="color: black;">
                                    <label class="col-md-3 align-right "><span class="required"></span></label>
                                    <div class="col-md-6 align-left">
                                        <input type="radio" name="rbTlDl" value="rbnewtldl" id="rbnewtldl" onclick="shownewtldp()" /><span style="color: black;"> &nbsp;Insert</span>
                                        &nbsp;&nbsp;
                                    <input type="radio" name="rbTlDl" value="rbremov" id="rbremov" onclick="showdeltldp()" /><span style="color: black">&nbsp; Delete</span>
                                        &nbsp;&nbsp; 
                                    <input type="radio" name="rbTlDl" value="rbchange" id="rbchange" onclick="showcangetldp()" /><span style="color: black">&nbsp; Change</span>
                                    </div>
                                </div>

                                <div class="table-responsive" style="margin-bottom: 1%;">
                                    <table class="table1 table-hover" id="tabChange">
                                    </table>
                                </div>
                                <div class="row" id="subcrfdis" style="display: none;margin-bottom: 1%;">
                                    
                                        <label class="col-md-2 align-right">CRF Sub <span class="required">*:</span></label>
                                        <div class="col-md-10 align-left">
                                            <select class="form-control input-group-text" id="dd_subcrf" style="width: 100%; color: black;" name="subcrf" onchange="getdevelplist()"></select>
                                        </div>
                       
                                </div>
                                <div id="techleaddetails" style="display: none;margin-bottom: 1%;">
                                    <div class="row">
                                         <label class="col-md-2 align-right ">Tech Lead <span class="required">*</span>: </label>
                                        <div class="col-md-4">
                                           <select id="tecLeads" class="form-control select2"  style="width: 100%;" name="TL"></select>
                                        </div>
<%--                                        <div id="remar" class="col-md-6 align-right">--%>
                                            <label class="col-md-2 align-right ">Remarks <span class="required">*</span>: </label>
                                                <textarea  class="col-md-4 align-left" rows="1" name="Remarks"  style="width: 100%;" id="txtRemarks" maxlength="3500" title="Remarks" oninput="this.value = this.value.replace(/[^-@.,/#&+\w\s]/g, '');" required></textarea>
<%--                                        </div>--%>
                                    </div>


                                    <div class="row" id="showSubmitBtn2" style="margin-bottom: 1%;">

                                        <div class="col-md-2 col-sm-2 col-xs-4">
                                            <a href="#" class="btn btn-sm animated-button thar-one btn-primary" style="width: 100%; margin: 5px;"
                                                onclick="return ConfirmNotetech();" id="btnSubmit2"><i class="fa fa-thumbs-up"></i>Confirm</a>
                                        </div>
                                        <div class="col-md-2 col-sm-2 col-xs-4">
                                            <a href="#" class="btn btn-sm animated-button thar-one btn-red" style="width: 100%; margin: 5px;"
                                                onclick="return frmExit();"><i class="fa fa-sign-out-alt"></i>Exit</a>
                                        </div>

                                    </div>
                                </div>
                                <div id="devlopertab" style="display: none;">
                                    <div id="devta">
                                    <div class="row" style="margin-bottom: 1%;">
                                        <label class="col-md-2 align-right ">Developer <span class="required">*</span>: </label>
                                        <div class="col-md-4">
                                            <select id="txtdev" class="form-control select2" style="width: 100%;" name="DL"></select>
                                        </div>
                                    </div>
                                    </div>

                                    <div class="row" id="datesel" style="display: none; margin-bottom: 1%;">
                                            <label class="col-md-2 align-right ">Start Date: <span class="required">*</span>: </label>
                                            <div class="col-md-4 align-left">
                                                <input type="text" class="form-control align-center" placeholder="Start Date" id="lblstaDt" style="width: 100%; color: black">
                                            </div>
                                            <label class="col-md-2 align-right ">End Date: <span class="required">*</span>: </label>
                                            <div class="col-md-4 align-left">
                                                <input type="text" class="form-control align-center" placeholder="Target Date" id="lblTarDt" style="width: 100%; color: black">
                                            </div>
                                        
                                    </div>
                                    <div class="row" id="devlopsel" style="display: none; margin-bottom: 1%;">

                                        <label class="col-md-2 align-right ">Developer <span class="required">*</span>: </label>
                                        <select class="form-control col-md-4 align-left input-group-text" id="dd_develp" style="width: 100%; color: black;" name="devsel"></select>

                                    </div>



                                    <div id="dman1" class="row col-md-12 p-1" style="display: none">
                                        <label class="col-md-2" for="ddlChange">Changes : <span class="text-danger">*</span></label>

                                        <div class="col-md-4 align-left">
                                            <select id="ddlChange" class="form-control" style="width: 100%;" name="ddlChange" onchange="GetWorkList()"></select>

                                        </div>
                                        <label class="col-md-2" for="ddlWork">Related Work : <span class="text-danger">*</span></label>
                                        <div class="col-md-4 align-left">
                                            <select id="ddlWork" class="form-control" style="width: 100%;" name="Work"></select>
                                        </div>
                                    </div>
                                    <div id="dman2" class="row col-md-12 p-1" style="display: none">
                                        <label class="col-md-2" for="ddlChange">Number of Changes : <span class="text-danger">*</span></label>
                                        <div class="col-md-2 align-left">
                                            <input type="text" class="form-control" style="width: 100%" maxlength="3" id="TNoc" title="TNoc" onkeypress="return isNumber(event, this.value, 0)" />
                                        </div>
                                        <div class="col-md-5 align-left buttonbox">
                                            <input id="btnAdd1" type="button" style="width: 36%; height: 90%" value="Add" class="btn-input fa-text-height" onclick="return CalTotal();" data-toggle="modal" data-backdrop="false" />
                                        </div>
                                    </div>
                                    <div class="form-group col-md-12 padding-bottom-10px" style="color: black;">
                                        <div class="form-group">
                                            <table class="table table-hover align-center " id="tabChanged">
                                                <tbody>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <div id="dman3" class="row col-md-12 p-1" style="display: none;">
                                        <label class="col-md-2" for="ddlChange">Man Hours for : <span class="text-danger">*</span></label>
                                        <div class="col-md-2 align-left">
                                            <span>Development</span>
                                            <input type="text" class="form-control" style="width: 100%" placeholder="Development.." maxlength="3" id="DevWork" title="DevWork" readonly="readonly" />
                                        </div>

                                        <div class="col-md-2 align-left">
                                            <span>Prev TA TotalHours    </span>
                                            <input type="text" class="form-control" style="width: 100%" placeholder="Prev TA Total.." maxlength="3" id="CodWork" title="CodWork" readonly="readonly" />
                                        </div>

                                        <div class="col-md-2 align-left">
                                            <span>Total Work Hours</span>
                                            <input type="text" class="form-control" style="width: 100%" placeholder="Work Hours.." maxlength="3" id="TWork" title="TWork" readonly="readonly" />
                                        </div>
                                    </div>








                                    <div id="remar1" class="row" style="display: none;margin-bottom: 1%;">
                                        
                                            <label class="col-md-2 align-right ">Remarks<span class="required">*</span>: </label>
                                            <textarea  class="col-md-10 align-left" rows="1" name="Remarks"  style="width: 100%;" id="txtRemarks2" maxlength="3500" title="Remarks" oninput="this.value = this.value.replace(/[^-@.,/#&+\w\s]/g, '');" required></textarea>
                               
                                    </div>

                                    <div class="row"style="margin-bottom: 1%;"  id="showSubmitBtn4">

                                        <div class="col-md-2 col-sm-2 col-xs-4">
                                            <a href="#" class="btn btn-sm animated-button thar-one btn-primary" style="width: 100%; margin: 5px;"
                                                onclick="return ConfirmCRFdevloper();" id="btnSubmit4"><i class="fa fa-thumbs-up"></i>Confirm</a>
                                        </div>
                                        <div class="col-md-2 col-sm-2 col-xs-4">
                                            <a href="#" class="btn btn-sm animated-button thar-one btn-red" style="width: 100%; margin: 5px;"
                                                onclick="return frmExit();"><i class="fa fa-sign-out-alt"></i>Exit</a>
                                        </div>

                                    </div>
</div>


                               
                            </div>
                            </div>
                        </div>

                 <div id="divtechnew1" style="display:none">
                           <div class="card-body">
                            <div id="techdata1">
                                <div class="row col-md-12">
                                    <label class="col-md-2 align-right ">Choose CRF:<span class="required"></span></label>
                                    <div class="col-md-10 align-left">
                                        <select id="txtmodule1" class="form-control select2" style="width: 100%;" name="txt" onchange="showtech();subcrfonchange1();"></select>
                                    </div>
                                </div>
                                <br />
                       

                                <div class="row" style="padding-bottom: 10px;">
                                    <div class="table-responsive" >
                                        <table class="table1 table-hover" id="tabChange1">
                                        </table>
                                    </div>
                                </div>

                                <div class="row" style="padding-bottom: 10px;">
                                    <div class="table-responsive">
                                        <table class="table1 table-hover" id="tabChange2">
                                        </table>
                                    </div>
                                </div>
                                
                                 <div class="row" id="subcrfdis2"  style="padding-bottom: 10px;">

                                        <label class="col-md-2 align-right">CRF Sub <span class="required">*:</span></label>
                                        <div class="col-md-10 align-left">
                                            <select class="form-control input-group-text" id="dd_subcrf2" style="width: 100%; color: black;" name="subcrf" onchange="getalreadyAssignedTester()"></select>
                                        </div>

                                    </div>
                                
                                <div id="devlopertab1" >

                                   
                                    <div id="devta1">
                                        <div class="row" style="padding-bottom: 10px;">
                                            <label class="col-md-2 align-right ">Test Engineer <span class="required">*</span>: </label>
                                            <div class="col-md-4">
                                                <select id="txtdev1" class="form-control select2" style="width: 100%;" name="DL"></select>
                                            </div>
                                            <label class="col-md-2 align-right ">Already Assigned Tester<span class="required">*</span>: </label>
                                            <div class="col-md-4">
                                                <select class="form-control" id="dd_tester" style="width: 100%; color: black;" name="devsel"></select>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row" id="datesel1"  style="padding-bottom: 10px;">
                                        <label class="col-md-2 align-right ">Start Date: <span class="required">*</span>: </label>
                                        <div class="col-md-4 align-left">
                                            <input type="text" class="form-control align-center" placeholder="Start Date" id="lblstaDt1" style="width: 100%; color: black">
                                        </div>
                                        <label class="col-md-2 align-right ">End Date: <span class="required">*</span>: </label>
                                        <div class="col-md-4 align-left">
                                            <input type="text" class="form-control align-center" placeholder="Target Date" id="lblTarDt1" style="width: 100%; color: black">
                                        </div>

                                    </div>
                                   
                                    



                                    <div id="remar2" class="row"  style="padding-bottom: 10px;">

                                        <label class="col-md-2 align-right ">Remarks<span class="required">*</span>: </label>
                                        <textarea class="col-md-10 align-left" rows="1" name="Remarks" style="width: 100%;" id="txtRemarks3"  title="Remarks" oninput="this.value = this.value.replace(/[^-@.,/#&+\w\s]/g, '');" required></textarea>

                                    </div>

                                    <div class="row" style="padding-bottom: 10px;" id="showSubmitBtn5">

                                        <div class="col-md-2 col-sm-2 col-xs-4">
                                            <a href="#" class="btn btn-sm animated-button thar-one btn-primary" style="width: 100%; margin: 5px;"
                                                onclick="return ConfirmTesterChange();" id="btnSubmit5"><i class="fa fa-thumbs-up"></i>Confirm</a>
                                        </div>
                                        <div class="col-md-2 col-sm-2 col-xs-4">
                                            <a href="#" class="btn btn-sm animated-button thar-one btn-red" style="width: 100%; margin: 5px;"
                                                onclick="return frmExit();"><i class="fa fa-sign-out-alt"></i>Exit</a>
                                        </div>

                                    </div>
                                </div>
 
                            </div>
                            </div>
                        </div>
   
              <div class="col-md-2 align-left buttonbox">
                  <input id="btnAdd" type="button" style="width: 60%; height: 60%" value="Back" class="btn btn-block btn-outline-info btn-flat" onclick="return Refresh();" data-toggle="modal" data-backdrop="false" />
             </div>
           </div>     
        </form>
    </div>
    <input id="hdUserId" type="hidden" runat="server" />
    <input id="hddata" type="hidden" runat="server" />
    <input id="hdBranchId" type="hidden" runat="server" />
    <input id="hdFirmId" type="hidden" runat="server" />
    <input id="hdnSystemIP" type="hidden" runat="server" />
    <input id="hdDeveloperID" type="hidden" runat="server" />
    <input id="hdman" type="hidden" runat="server" />
    <input id="hdcst" type="hidden" runat="server" />
     <input id="hdCrv" type="hidden" runat="server" />
    <input id="hdtest" type="hidden" runat="server" />
    <input id="hddev" type="hidden" runat="server" />
    <input id="hdRqstID" type="hidden" runat="server" />
    <input id="hdDevlpr" type="hidden" runat="server" />
    <input id="hddraftid" type="hidden" runat="server" />
</asp:Content>
