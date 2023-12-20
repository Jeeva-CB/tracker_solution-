<%@ Page Title="" Language="C#" MasterPageFile="~/PWA_Master.Master" AutoEventWireup="true" CodeBehind="alerttest.aspx.cs" Inherits="ITTacker.alerttest" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        $(window).on('load', function () {
//            $("#msgSuccess").text("You have been signed in successfully!");
//            $(".alert").show();
//            setTimeout(function(){
//                $(".myAlert-top").fadeTo(500, 0).slideUp(500, function(){
//        $(this).remove(); 
//    });
//}, 2000);
            //$(".alertSuccess").hide();
            setInterval("push_api();", 3000);
            //5 secons
            //180000 -- 3 minutes
        });

function push_api() {
  if (!Notification) {
    return;
  }

  if (Notification.permission !== "granted")
    Notification.requestPermission();

  var notification = new Notification('', {
    icon: 'https://i.imgur.com/Eesst9S.png',
    body: "Sad affleck!",
  });

  notification.onclick = function () {
    window.open("https://twitter.com/mehedih_");      
    };
    notification.onshow = function () {
        var self = helllo;
        setTimeout(function () {
            self.close();
        }, 1000);
    };
        } 

function fnShow() {
  var date = new Date()
  ,  time = date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();
 
  Notification.requestPermission(function (perm) {
    if (perm == "granted") {
      var notification = new Notification("The Time now is:", {
        dir: "auto",
        lang: "hi",
        tag: "testTag"+date.getTime(),
        icon: "https://upload.wikimedia.org/wikipedia/commons/thumb/2/26/Clock_simple.svg/120px-Clock_simple.svg.png",
        body: time
        });
        notification.onclick = function () {
    window.open("https://twitter.com/mehedih_");      
  };
      notification.onshow = function(){
        var self = helllo;
        setTimeout(function(){
          self.close();
        }, 1000);
      }
    }
  })
}
function myAlertTop() {
    warningAlert("Note Created Successfully...!",10000);
}

function successAlert(msg,tim) {
 $("#msgSuccess").text(msg);
  $(".alertSuccess").show();
   setTimeout(function(){
    //            $(".alertSuccess").fadeTo(500, 0).slideUp(500, function(){
    //    $(this).remove(); 
    //});
       $(".alertSuccess").hide();
}, tim);
}

function dangerAlert(msg,tim) {
 $("#msgDanger").text(msg);
  $(".alertDanger").show();
   setTimeout(function(){
    //            $(".alertSuccess").fadeTo(500, 0).slideUp(500, function(){
    //    $(this).remove(); 
    //});
       $(".alertDanger").hide();
}, tim);
        }

function warningAlert(msg,tim) {
 $("#msgWarning").text(msg);
  $(".alertWarning").show();
   setTimeout(function(){
    //            $(".alertSuccess").fadeTo(500, 0).slideUp(500, function(){
    //    $(this).remove(); 
    //});
       $(".alertWarning").hide();
}, tim);
}

function myAlertBottom() {
    // alert("alert-bottom");
  $(".myAlert-bottom").show();
  setTimeout(function(){
    $(".myAlert-bottom").hide(); 
  }, 2000);
}


//window.setTimeout(function() {
//    $(".alert").fadeTo(500, 0).slideUp(500, function(){
//        $(this).remove(); 
//    });
//}, 4000);
</script>
<style>
.myAlert-top{
    position: fixed;
    top: 12%; 
    left:8%;
    width: 90%;
    z-index: 9999
}

.myAlert-bottom{
    /*position: fixed;*/
    bottom: 10%;
    left:5%;
    width: 90%;
}
.div.fullscreen {
  position: absolute;
  width:100%; 
  height:960px; 
  top: 0; 
  left: 0; 
  background-color: lightblue;
}
.alert{
    display: none;
}
</style>
<style>
.block-ui {
  position: fixed;
  width: 100%;
  height: 100%;
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;
  background-color: black;
  opacity: 0.75;
  display: flex;
  text-align: center;
}
.block-ui .loading:after {
  content: " ";
  background: black;
  opacity: 0.4;
  pointer-events: none;
  border-radius: 4px;
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
}
.block-ui .loading .loaderwait {
  display: none;
  margin: auto;
  width: 50px;
  height: 30px;
  text-align: center;
  font-size: 10px;
  position: absolute;
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;
  z-index: 1;
  display: block;
}
.block-ui .loading .loaderwait div {
  background-color: white;
  height: 100%;
  width: 6px;
  display: inline-block;
  animation: stretchdelay 1.2s infinite ease-in-out;
}
.block-ui .loading .loaderwait .rect2 {
  animation-delay: -1.1s;
}
.block-ui .loading .loaderwait .rect3 {
  animation-delay: -1s;
}
.block-ui .loading .loaderwait .rect4 {
  animation-delay: -0.9s;
}
.block-ui .loading .loaderwait .rect5 {
  animation-delay: -0.8s;
}
.block-ui .loading .loaderwait.load2 .loader2 {
  display: block;
}
.block-ui .loading .loaderwait.load3 .loader3 {
  display: block;
}
.block-ui .loading .loaderwait.load4 .loader4 {
  display: block;
}
.block-ui.clear {
  animation: dissappear 1s 1;
  -webkit-animation-fill-mode: forwards;
  animation-fill-mode: forwards;
}
.block-ui .loading-info {
  margin: auto;
  align-content: center;
  align-items: center;
  align-self: center;
}
.block-ui .loading-info .loading-text {
  display: block;
}
.block-ui .loading-info .loading-text .text {
  margin: 0 0 2em 0;
  position: relative;
  z-index: 9;
  color: white;
}
.block-ui .loading-info .loading-text button {
  margin-top: 15px;
  position: relative;
  z-index: 9;
}
@keyframes stretchdelay {
  0%,
  40%,
  100% {
    transform: scaleY(0.4);
  }
  20% {
    transform: scaleY(1);
  }
}
@keyframes dissappear {
  0% {
    opacity: 1;
  }
  99% {
    opacity: 0;
    display: none;
    width: 100%;
    height: 100%;
    margin-top: 0;
    margin-left: 0;
  }
  100% {
    width: 0;
    height: 0px;
    margin-top: -100000px;
    margin-left: -100000000px;
  }
}

</style>
 <link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.5/themes/base/jquery-ui.css"
        type="text/css" media="all" />
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.5/jquery-ui.min.js"></script>
    <script type="text/javascript" src="http://github.com/malsup/blockui/raw/master/jquery.blockUI.js?v2.34"></script>
    <script type="text/javascript">


var start = function(){
  $('.block-ui').removeClass('clear');
}

var finish = function(){
  $('.block-ui').addClass('clear');
}

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<%--<div class="fullscreen">
<button class="form-control" onclick="myAlertTop()">show alert top</button>
<div class="alertSuccess myAlert-top alert alert-success" role="alert">
  <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
  <i class="fa fa-check"></i><strong> Success!</strong> <span id="msgSuccess"></span>
</div>
<div class="alertWarning myAlert-top alert alert-warning" role="alert">
  <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
  <i class="fa fa-exclamation-triangle"></i><strong> Warning!</strong> <span id="msgWarning"></span>
</div>
<div class="alertDanger myAlert-top alert alert-danger" role="alert">
  <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
  <i class="fa fa-exclamation-circle"></i><strong> Danger!</strong> <span id="msgDanger"></span>
</div>
</div>--%>

<div class="flex-form">
          <button class="btn" type="button" onclick='start()'>start loading</button>
        </div>
 <div class="block-ui clear">
          <div class="loading-info">
            <div class="loading-text loading">
              <div class="text"> Please Wait...</div>
              <div class="loaderwait" role="progressbar">
                <div class="rect1"></div>
                <div class="rect2"></div>
                <div class="rect3"></div>
                <div class="rect4"></div>
                <div class="rect5"></div>
              </div>
                 <button onclick="finish()">Finish loading</button>
            </div>
          </div>
        </div>
</asp:Content>
