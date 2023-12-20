<%@ Page Title="" Language="C#" MasterPageFile="~/PWA_Master.Master" AutoEventWireup="true" CodeBehind="DailyTrackingTester.aspx.cs" Inherits="ITTracker.DailyTrackingTester" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%--   <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.js"></script>
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.3/jquery.timepicker.min.css">
    <script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.3/jquery.timepicker.min.js"></script>--%>


      <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"/>
  <link rel="stylesheet" href="/resources/demos/style.css"/>
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    <script src="js/TrackerTester.js?<%=DateTime.Now.Ticks.ToString()%>"></script>

  
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="card card-5 rightmarg">
        <form class="form-inline" runat="server" method="post" enctype="multipart/form-data">
            
            <div class="card-body">
           <div class="row col-md-12 p-1">               
            <label class="col-md-3 align-left ">CRF ID <span class="required text-danger">*</span> </label>
             <div class="col-md-8 align-left" style="display:none">
                <select class="form-control dd-list" id="ddlWorks" style="width: 100%;" name="CRF_Sel" onchange="SelectAssignedProjects()">
                                <option value="-1">Choose Assigned Works</option>
                                 <option value="0">Other Works</option>
                </select>
              </div> 
               <div class="col-md-2 align-left">

               <input type="text" id="txtWorks" style="width:100%" class="form-control" onkeypress="return onlyNos(event,this);"  maxlength="6" />
               </div> 
                              <label class="col-md-1 align-left ">Desc<span class="required text-danger">*</span> </label>

                 <div class="col-md-5 align-left">
               <input type="text" id="txtDescription" style="width:100%" class="form-control" />
               </div> 
           </div>
           <div class="row col-md-12 p-1">
             <label class="col-md-3 align-left ">Description of work performed <span class="required text-danger">*</span> </label>
             <div class="col-md-8 align-left">
                 <select class="form-control dd-list" id="ddlDesc" style="width: 100%;" name="CRF_Sel" onchange="ShowDesc()">
                     <option value="-1">Choose Description of work performed</option>
                 </select>
             </div>
           </div>
             <div class="row col-md-12 p-1">
                       <label class="col-md-3 align-left ">Percentage of completion: <span class="required text-danger">*</span> </label>
             <div class="col-md-4 align-left ">
               <input type="text" id="txtpercentage" style="width:100%" class="form-control" onkeypress="return onlyNos(event,this);" maxlength="3" />
                 </div>
           <label class="col-md-1 align-left ">Date: <span class="required text-danger">*</span> </label>
             <div class="col-md-3 align-left ">
               <input type="text" id="datepicker" class="form-control" style="width:100%" readonly="readonly" />
                 </div>
                  </div>      
             <div class="row col-md-12 p-1" id="txtsection" style="display:none">
             <label class="col-md-3 align-left ">Detail Description <span class="required text-danger">*</span> </label>
             <div class="col-md-4 align-left">
              <textarea rows="2" cols="10" class="form-control" style="width:100%"  name="Remarks" id="txtReason" maxlength="3500" title="Description" oninput="this.value = this.value.replace(/[^-@.,/#&+\w\s]/g, '');"></textarea>
                 </div>
             <label class="col-md-1 align-left ">Remarks <span class="required text-danger">*</span> </label>
             <div class="col-md-3 align-left">
              <textarea rows="2" cols="10" style="width:100%" class="form-control" name="Remarks" id="txtRemarks" maxlength="3500" title="Remarks" oninput="this.value = this.value.replace(/[^-@.,/#&+\w\s]/g, '');"></textarea>
             </div>
           </div>
            <div class="row col-md-12 p-1" id="timesectn" style="display:none">
             <label class="col-md-3 align-left ">Choose time taken for your discussion <span class="required text-danger">*</span> </label>
             <div class="col-md-8 align-left">
             <asp:DropDownList ID="ddlHours" runat="server" class="form-control col-md-3"/>:<asp:DropDownList ID="ddlMinutes" runat="server" class="form-control col-md-3" />

             </div>
            </div>

         
     
                <div class="padding-bottom-10px p-t-40"></div>
               <%--<div class="row" id="txt" style="display:none">--%>
     

               
                   
                <div id="demo"></div>
               
                <div class="row" id="AddBtn">
                    <div class="col-md-10"></div>
                    <div class="col-md-2 col-sm-2 col-xs-4">
                        <a href="#" class="btn btn-sm animated-button thar-one btn-primary" style="width: 100%; margin: 5px;"
                            onclick="return AddNote();" id="btnSubmit1"><i class="fa fa-arrow-circle-up"></i>Add</a>
                    </div>
                </div>                  
                 <table class="table-bordered align-centre col-md-12" id="tableData" style="display:none"><tbody></tbody></table>
                <div class="row" id="showSubmitBtn" style="display:none">
                    <div class="col-md-2 col-sm-2 col-xs-4">
                        <a href="#" class="btn btn-sm animated-button thar-one btn-primary" style="width: 100%; margin: 5px;"
                            onclick="return ConfirmNote();" id="btnSubmit"><i class="fa fa-thumbs-up"></i>Confirm</a>
                    </div>
                  
                    <div class="col-md-2 col-sm-2 col-xs-4">
                        <a href="#" class="btn btn-sm animated-button thar-one btn-default" style="width: 100%; margin: 5px;"
                            onclick="return frmExit();"><i class="fa fa-sign-out-alt"></i>Exit</a>
                    </div>

                </div>
            </div>
    
        </form></div>
    <input id="hdUserId" type="hidden" runat="server" />
    <input id="hdBranchId" type="hidden" runat="server" />
    <input id="hdFirmId" type="hidden" runat="server" />
    
    <input id="hdnSystemIP" type="hidden" runat="server" />
    <input id="hdSesssion" type="hidden" runat="server" />
    <input id="hdTLead" type="hidden" runat="server" />
    
    <input id="hddraftid" type="hidden" runat="server" />
</asp:Content>
