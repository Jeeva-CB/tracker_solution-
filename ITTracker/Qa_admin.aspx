<%@ Page Title="" Language="C#" MasterPageFile="~/PWA_Master.Master" AutoEventWireup="true" CodeBehind="Qa_admin.aspx.cs" Inherits="ITTracker.Qa_admin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="StyleAutoComplete.css" rel="stylesheet" />
    <script src="AutoCompleteJS.js"></script>
    <script src="js/qa_admin.js"></script>
    <script src="js/jquery.min.1.11.1.js" type="text/javascript"></script>
    <script src="js/jquery.table2excel.min.js" type="text/javascript"></script>
 <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">

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
     <style>
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
     <style>


       a:hover {
    color: #0056b3;
    text-decoration: none!important;
}

        .btns:hover {
            color: black !important;
        }

        .hovereffect:hover {
            background: #f4f6f9;
        }

        .info-box .info-box-icon {
            width: 50px !important;
            height: 50px !important;
        }

        .btn {
            width: 130px;
        }

       
        .over {
            overflow: auto;
            max-height: 248px;
            height: 248px;
        }

      

        .col-md-6 {
            max-width: 20% !important;
        }

      
        @media screen and (min-width: 676px) {
            .modal-dialog {
                max-width: 670px; /* New width for default modal */
            }
        }
        img.iconss {
                  width: 96px!important;
        }
          img.iconss1 {
                  width: 96px!important;
        }
    </style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row col-12">
        <div class="col-12">
            <div class="card card-5 rightmarg">
                <form class="form-horizontal" runat="server" method="post" enctype="multipart/form-data">
                    <div class="card-body">
                           <div class="row">
                               <div class="col-md-3">
<%--                                 <label for="ddlDocType" style="font-size:large;color:palevioletred">Add New QA TechLead</label>--%>
                             <div class="info-box" id="div_1">
                                   <span class="info-box-icon">
                                <img class="iconss" src="img/index.png"/></span>
                                  <div class="info-box-content" id="div_info1">
                              
                                <a href="#" class="btns" style="font-style:italic;color:gray;font-size:large" onclick="addnew_qatech();">Add New QA TechLead</a>
                              
                            </div>
                                 </div>
                                   </div>
                               <div class="col-md-6"></div>
                               <div class="col-md-3">
<%--                                 <label for="ddlDocType" style="font-size:large;color:palevioletred">Add New QA TechLead</label>--%>
                             <div class="info-box" id="div_2">
                                   <span class="info-box-icon">
                                <img class="iconss1" src="img/imagesp.png" /></span>
                                  <div class="info-box-content"  id="div_info2">
                              
                                <a href="#" class="btns" style="font-style:italic;color:gray;font-size:large" onclick="edit_techlead_modules();">Add More Modules</a>
                              
                            </div>
                                 </div>
                                   </div>
                                  </div>
                        <div style="display: none" id ="div_create">
                        <div style="height:30px"></div>
                        <div class="row">
                            <label class="col-md-3 align-left " style="font-size:medium">Select Employee<span class="required">*</span> </label>
                            <div class="col-md-7 align-left">
                                <select id="ddl_qateam" class="form-control" style="width: 100%;" name="CRF_Sel">
                                    <option value="-1">SELECT</option>
                                </select>
                            </div>

                        </div>
                          <div style="height:30px"></div>
                         <div class="row">
                            <label class="col-md-3 align-left " style="font-size:medium">Select Dept:<span class="required">*</span> </label>
                            <div class="col-md-7 align-left">
                                <select id="ddl_module" class="form-control module select2" style="width: 100%;" name="CRF_Sel" multiple="multiple">
                                    <option value="-1">Select Department</option>
                                </select>
                            </div>

                        </div>
                            <div style="height:30px"></div>
                          <div class="row" id="showSubmitBtn">
                        <div class="col-md-2 col-sm-2 col-xs-4">
                            <a href="#" class="btn btn-sm animated-button thar-one btn-primary" style="width: 100%;
                            margin: 5px;"onclick="return confirm();" id="btnSubmit"><i class="fa fa-thumbs-up"></i> Confirm</a>
                        </div>
                 <div class="col-md-2 col-sm-2 col-xs-4">
                        <a href="#" class="btn btn-sm animated-button thar-one btn-red" style="width: 100%;
                        margin: 5px;" onclick="return frmExit();"><i class="fa fa-sign-out-alt"></i> Exit</a>
                       </div>
                    </div>
</div>
                          <div style="display: none" id ="div_edit">
                              <div style="height:30px"></div>
                        <div class="row">
                            <label class="col-md-3 align-left " style="font-size:medium">Select Employee<span class="required">*</span> </label>
                            <div class="col-md-7 align-left">
                                <select id="ddl_qateam_edt" class="form-control" style="width: 100%;" name="CRF_Sel" onchange="fill_qamodules()">
                                    <option value="-1">SELECT</option>
                                </select>
                            </div>

                        </div>
                          <div style="height:30px"></div>
                              <div class="row">
                                  <%--<div class="col-md-6">--%>
                                        <div class="col-md-12 align-content-center">
                                            <table class="table table-hover table-bordered" id="tab_techdtls">
                                                <tbody>
                                                </tbody>
                                            </table>
                                        </div>

                                   <%-- </div>--%>
                         </div>
                                   <div class="col-md-2 col-sm-2 col-xs-4">
                        <a href="#" class="btn btn-sm animated-button thar-one btn-primary" style="width: 100%; margin: 5px;"
                            onclick="return Addmore_module();" id="btnSubmit1"><i class="fa fa-arrow-circle-up"></i>Add More</a>
                    </div>
                              <div style="height:50px"></div>
                         <div class="row" id="ed_mod_div" style="display: none">
                            <label class="col-md-3 align-left " style="font-size:medium">Select Dept:<span class="required">*</span> </label>
                            <div class="col-md-7 align-left">
                                <select id="ddl_module_edt" class="form-control module1 select2" style="width: 100%;" name="CRF_Sel" multiple="multiple" onchange="viewbtn()">
                                    <option value="-1">Select Department</option>
                                </select>
                            </div>
                              <div class="col-md-2 align-right">
                                  <a href="#" class="btn btn-sm animated-button thar-one btn-primary" style="width: 100%;
                            margin: 5px;"onclick="return confirm_add();" id="btnadd"><i class="fa fa-thumbs-up"></i>ADD</a>
                      
                                    </div>
                        </div>
                            <div style="height:30px"></div>
                          <div class="row" id="showSubmitBtn_edt" style="display: none">
                      <div class="col-md-4"></div>  <div class="col-md-2 col-sm-2 col-xs-4">
                            <a href="#" class="btn btn-sm animated-button thar-one btn-primary" style="width: 100%;
                            margin: 5px;"onclick="return confirm_edit();" id="btnSubmitedit"><i class="fa fa-thumbs-up"></i> Confirm</a>
                        </div>
                 <div class="col-md-2 col-sm-2 col-xs-4">
                        <a href="#" class="btn btn-sm animated-button thar-one btn-red" style="width: 100%;
                        margin: 5px;" onclick="return frmExit();"><i class="fa fa-sign-out-alt"></i> Exit</a>
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
