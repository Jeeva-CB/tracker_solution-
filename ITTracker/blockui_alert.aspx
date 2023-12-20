<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="blockui_alert.aspx.cs" Inherits="ITTacker.blockui_alert" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    
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
<link href="css/jquery-ui.css" rel="stylesheet" />
    <script src="js/jquery.min.js"></script> 
    <script src="js/jquery-ui.js"></script>  
    <script type="text/javascript" src="http://github.com/malsup/blockui/raw/master/jquery.blockUI.js?v2.34"></script>
    <script type="text/javascript">


var start = function(){
  $('.block-ui').removeClass('clear');
}

var finish = function(){
  $('.block-ui').addClass('clear');
}
        function ReqNoteCofirm() {
              $('.block-ui').removeClass('clear');
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    
          <button class="btn" type="button" onclick='start()'>start loading</button>
   <div class="col-md-2 col-sm-2 col-xs-4"> <a href="#" class="btn btn-sm animated-button thar-one btn-primary" style="width: 100%;
margin: 5px;"onclick="return ReqNoteCofirm();" id="btnSubmit"><i class="fa fa-check"></i> Confirm</a> </div>
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
    </form>
</body>
</html>
