<%@ Page Title="" Language="C#" MasterPageFile="~/PWA_Master.Master" AutoEventWireup="true" CodeBehind="team_module.aspx.cs" Inherits="ITTracker.team_module" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
       <script src="js/team.js" ></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

  <div class="card card-5 rightmarg">
        <form class="form-inline" runat="server" method="post" enctype="multipart/form-data">
            <div class="card-body">

                <div class="row">
                    
                </div>
                
              
             
             <div class="row">
<div class="col-md-12">


        <center>
                    <table>
                        <tr>

                             <td>
                     
                        
                               <input type="radio" name="rbReturn" id="rbReturn" onclick="ShowPurpose()" /><span style="color: black; width:3px"> &nbsp;INSERT </span>
                            
                              &nbsp;&nbsp; <input type="radio" name="rbReturn" id="rbNonReturn" onclick="ShowPurpose1()" /><span style="color: black">&nbsp; DELETE</span>
                    
                            </td>
                            </tr>
                        </table>
                        <div id="insert" style="display:none" >
                            <table>
                            <tr>
                            <td>
                           <h6> <label> Select Team</label></h6></td><td>
            
                            <select class="form-control input-group-text" id="techlead" style="width: 300px; color: black;" name="techlead" onchange="techleadfill()">
                                    <option value="-1"></option>
                            </select>
                            </td>
                            </tr>
                          <tr>  <td>
                           <h6> <label> Module</label></h6></td><td>
                    <input type="text" id="txtmod" name="txtmod" style="width: 300px; color: black;" />
                            </td>
                               <td>
              <input type="button" id="butadd" value="ADD"onclick="adddata()"/>
                                    </td>
                       </tr>  <tr>
                                   
                           <td>
                                
                               

    <table class="table table-hover" id="tableData">
                          
                    
                           </table><%--table--%>

                            </td>
                        
                                </tr>
                                </table>

                             <div class="row" id="showSubmitBtn">
                   
    <div class="col-md-2 col-sm-2 col-xs-4"> <a href="#" class="btn btn-sm animated-button thar-one btn-primary" style="width: 100%;
margin: 5px;"onclick="return ConfirmNote();" id="btnSubmit"><i class="fa fa-thumbs-up"></i> Insert</a> </div>
    <div class="col-md-2 col-sm-2 col-xs-4"> <a href="#" class="btn btn-sm animated-button thar-one btn-red" style="width: 100%;
margin: 5px;" onclick="return frmExit();"><i class="fa fa-sign-out-alt"></i> Exit</a> </div>

</div>
                        </div> 
                        <div id="delete" style="display:none" >
                            <table>
                            <tr>
                            <td>
                           <h6> <label> Select Team</label></h6></td><td>
            
                            <select class="form-control input-group-text" id="techlead1" style="width: 300px; color: black;" name="techlead" onchange="moduleselect()">
                          
                            </select>
                            </td>
                            </tr>
                          <tr>  <td>
                           <h6> Select Module</h6></td><td>
                            <select class="form-control input-group-text" id="module1" style="width: 300px; color: black;" name="Module" onchange="techleadfill()">
                             
                                </select>
                            </td>
                               <td>
                                          <input type="button" id="butadd1" value="ADD"  onclick="adddata1()"/>
                                    </td>
                       </tr>
                                <tr>
                                   
                                      <td>
                                
                               
        <table class="table table-hover" id="tableData1">
                          
                    
                           </table><%--table--%>
  

                            </td>
                                </tr>
                    </table>
                             <div class="row" id="showSubmitBtn1">
                   
    <div class="col-md-2 col-sm-2 col-xs-4"> <a href="#" class="btn btn-sm animated-button thar-one btn-primary" style="width: 100%;
margin: 5px;"onclick="return ConfirmNote1();" id="btnSubmit1"><i class="fa fa-thumbs-up"></i> Delete</a> </div>
    <div class="col-md-2 col-sm-2 col-xs-4"> <a href="#" class="btn btn-sm animated-button thar-one btn-red" style="width: 100%;
margin: 5px;" onclick="return frmExit();"><i class="fa fa-sign-out-alt"></i> Exit</a> </div>

</div>
                        </div> 
            
               
 </div>

            </div>
                  </center>
        </form>
    </div>
<input id="hdUserId" type="hidden" runat="server"/>
        <input id="hdBranchId" type="hidden" runat="server"/>
        <input id="hdFirmId" type="hidden" runat="server"/>
      <input id="hdnReturnStatus" type="hidden" runat="server"/>
    <input id="hdnAllEmployees" type="hidden" runat="server"/>
    <input id="hdnquerynoteid" type="hidden" runat="server"/>
    <input id="hdnContentNoteId" type="hidden" runat="server"/>
     <input id="hdnReqEmp" type="hidden" runat="server"/>
    <input id="hdnSystemIP" type="hidden" runat="server"/>
     <input id="hdSesssion" type="hidden" runat="server"/>
    <input id="hdEditOption" type="hidden" runat="server"/>
    <input id="hdnDiscussResStatus" type="hidden" runat="server"/>
      <input id="hdEditedContent" type="hidden" runat="server"/>
    <input id="DocTypenew" type="hidden" runat="server"/>

</asp:Content>
