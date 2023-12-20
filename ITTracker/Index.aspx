<%@ Page Title="" Language="C#" MasterPageFile="~/PWA_Master.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="ITTacker.Index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   <%--<script src="js/chart.js"></script>--%>
    <script src="js/indexDashBoard.js?v=2"></script>
<%--      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">--%>
    <style>

/* Style the tab */
.tab1 {
  overflow: hidden;
  border: 1px solid #ccc;
  background-color: #f1f1f1;
}

/* Style the buttons inside the tab */
.tab1 button {
  background-color: inherit;
  float: left;
  border: none;
  outline: none;
  /*cursor: pointer;*/
  padding: 14px 16px;
  transition: 0.3s;
  font-size: 17px;
}

/* Change background color of buttons on hover */
.tab1 button:hover {
  background-color: #ddd;
}

td:hover { 
   background: yellow; 
}
/*td a { 
   display: block; 
   border: 0.2px solid black;
   padding: 5px; 
}*/



/* Create an active/current tablink class */
.tab button.active {
  background-color: #ccc;
}

/* Style the tab content */
.tabcontent1 {
  display: none;
  padding: 6px 12px;
  border: 1px solid #ccc;
  border-top: none;
}

        .btns:hover{
            color:black !important;
        }

        .hovereffect:hover {
    background: #f4f6f9;
}

        .table-bordered td, .table-bordered th {

    padding: 8px;
}

.over {
    overflow: auto;
 height:auto;
}

        .progress {
    height: .5rem !important;
}

        

        .background-card {
    padding: 18px;
    background: white;
    border-radius: 8px;
    box-shadow:0px 0px 5px #00000030;
    
}
</style>
    <style>
/* Center the loader */
#loader {
  position: absolute;
  left: 50%;
  top: 50%;
  z-index: 1;
  width: 120px;
  height: 120px;
  margin: -76px 0 0 -76px;
  border: 16px solid #f3f3f3;
  border-radius: 50%;
  border-top: 16px solid #3498db;
  -webkit-animation: spin 2s linear infinite;
  animation: spin 2s linear infinite;
}

@-webkit-keyframes spin {
  0% { -webkit-transform: rotate(0deg); }
  100% { -webkit-transform: rotate(360deg); }
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

/* Add animation to "page content" */
.animate-bottom {
  position: relative;
  -webkit-animation-name: animatebottom;
  -webkit-animation-duration: 1s;
  animation-name: animatebottom;
  animation-duration: 1s
}

@-webkit-keyframes animatebottom {
  from { bottom:-100px; opacity:0 } 
  to { bottom:0px; opacity:1 }
}

@keyframes animatebottom { 
  from{ bottom:-100px; opacity:0 } 
  to{ bottom:0; opacity:1 }
}

#myDiv {
  display: none;
  text-align: center;
}
</style>
    <script>
        document.getElementById("London").click();
function openCity(evt, cityName) {
  var i, tabcontent, tablinks;
  tabcontent = document.getElementsByClassName("tabcontent1");
  for (i = 0; i < tabcontent.length; i++) {
    tabcontent[i].style.display = "none";
  }
  tablinks = document.getElementsByClassName("tablinks1");
  for (i = 0; i < tablinks.length; i++) {
    tablinks[i].className = tablinks[i].className.replace(" active", "");
  }
  document.getElementById(cityName).style.display = "block";
  evt.currentTarget.className += " active";
        }
    function loadPopup()
    {
          $.ajax({
                type: "GET",
                url: "CreateNote.aspx"
          }).done(function(data) {
                $('body').append($(data).popup());
                $('#popup1').popup('open');
          });
    }
</script>
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


<div class="row">
    <div id="pro_det2" class="col-md-4">
            <div class="card card-5 animated bounceIn">
                <div class="loaderColor">
                    <div class="loaderColor--dot"></div>
                    <div class="loaderColor--dot"></div>
                    <div class="loaderColor--dot"></div>
                    <div class="loaderColor--dot"></div>
                    <div class="loaderColor--dot"></div>
                    <div class="loaderColor--dot"></div>
                    <div class="loaderColor--text"></div>
                </div>

                <div class="card-header">
                    NOTIFICATION
                </div>
                <section class="panel vh-60  scrollable">

                    <div class="panel-body" id="notifyDiv">
                    </div>
                    <div class="panel-body" style="display: none;" id="notifyEmptyDiv">
                        <div style="font-size: 18px; text-align: center; padding-top: 40%;">
                            <h5>You don't have any notifications right now...!</h5>
                        </div>
                        <div style="font-size: 12px; text-align: center;">Notifications about your Notes will show up here...</div>
                    </div>
                </section>
            </div>
    </div>



  
<div class="col-md-4">
<div class="card card-5 animated bounceIn">  
<div class="loaderColor">
<div class="loaderColor--dot"></div>
<div class="loaderColor--dot"></div>
<div class="loaderColor--dot"></div>
<div class="loaderColor--dot"></div>
<div class="loaderColor--dot"></div>
<div class="loaderColor--dot"></div>
<div class="loaderColor--text"></div>
</div>
<div class="card-header">
ACTION LIST
</div>
    <!--alerts Start-->
<section class="panel vh-60  scrollable">
<div class="panel-body" id="alertDiv">


</div>
<div class="panel-body" style="display: none;" id="alertEmptyDiv">
<div style="font-size: 18px; text-align: center;"><i class="fa fa-exclamation-triangle fa-5x" aria-hidden="true" style="opacity: 0.5;"></i></div>
<div style="font-size: 18px; text-align: center;padding-top: 40%;">    <h5>You don't have any alerts right now...!</h5></div>
    <div style="font-size: 12px; text-align: center;">Your pending Approvals will appear here...</div>
</div>
 </section>
    <!--alerts end-->
</div>  
</div>
    <div id="pro_det" class="col-md-8" style="display: none;">
        <div class="col-md-12">
            <div class="card card-5 animated bounceIn">
                <div class="loaderColor">
                    <div class="loaderColor--dot"></div>
                    <div class="loaderColor--dot"></div>
                    <div class="loaderColor--dot"></div>
                    <div class="loaderColor--dot"></div>
                    <div class="loaderColor--dot"></div>
                    <div class="loaderColor--dot"></div>
                    <div class="loaderColor--text"></div>
                </div>
                <div class="card-header">
                    PROJECT DETAILS
                </div>
                <!--alerts Start-->
                <section class="panel vh-60  scrollable">
                    <div class="panel-body">
                        <div class="row-col-md-12 over">
                            <div class="card-body table-responsive p-0">
                                <div id="loader"></div>
                                <table class="table-bordered align-centre col-md-12" id="tbl_Task_List" onclick="grT()">
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                </section>
                <!--alerts end-->
            </div>
        </div>
    </div>




<%--<div id="pro_det2" class="col-md-6" >
        <div class="col-md-12">
            <div class="card card-5 animated bounceIn">
                <div class="loaderColor">
                    <div class="loaderColor--dot"></div>
                    <div class="loaderColor--dot"></div>
                    <div class="loaderColor--dot"></div>
                    <div class="loaderColor--dot"></div>
                    <div class="loaderColor--dot"></div>
                    <div class="loaderColor--dot"></div>
                    <div class="loaderColor--text"></div>
                </div>
                <div class="card-header">
                    PROJECT DETAILS
                </div>
                <section class="panel vh-60  scrollable">
                    <div class="panel-body">
                        <div class="row-col-md-12 over">
                                <div id="loader1"></div>
                                
                                <div class="card card-widget widget-user-2">
                                
                                <div class="card-footer p-0">
                                    <ul class="nav flex-column">
                                        <li class="nav-item">
                                            <a href="#" class="nav-link">CRF Created by Me :<span class="float-right badge bg-warning"><label id="lb1"></label></span>
                                            </a>
                                        </li>
                                        
                                        <li class="nav-item">
                                            <a href="#" class="nav-link">CRF Approved/Assigned :<span class="float-right badge bg-warning"><label id="lb2"></label></span>
                                            </a>
                                        </li> 
                                        <li class="nav-item">
                                            <a href="#" class="nav-link">TA Completed/Assigned :<span class="float-right badge bg-warning"><label id="lb3"></label></span>
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="#" class="nav-link">Testing TA Completed/Assigned :<span class="float-right badge bg-warning"><label id="lb4"></label></span>
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="#" class="nav-link">Development Completed/Assigned  :<span class="float-right badge bg-warning"><label id="lb5"></label></span>
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="#" class="nav-link">Testing Completed/Assigned :<span class="float-right badge bg-warning"><label id="lb6"></label></span>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>

                        </div>
                    </div>

                </section>
</div>
</div>
 </div>  --%> 


</div>
  

<div id="theModal" class="modal fade text-center">
    <div class="modal-dialog">
      <div class="modal-content">
      </div>
    </div>
  </div>
    <input id="hdUserId" type="hidden" runat="server" />
    <input id="hdBranchId" type="hidden" runat="server"/>
    <input id="hdFirmId" type="hidden" runat="server"/>
    <input id="hdnNotifyCount" type="hidden" runat="server"/>
    <input id="hdnAlertCount" type="hidden" runat="server"/>
</asp:Content>
