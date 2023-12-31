﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ITTacker.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0" />
    <title>Manappuram AppSuite</title>
    <link rel="icon" type="image/png" sizes="16x16" href="App_Themes/Theme/assets/img/favicon-16x16.png"/>
    <link href="App_Themes/Theme/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="App_Themes/Theme/assets/css/main.css" rel="stylesheet" type="text/css" />
    <link href="App_Themes/Theme/assets/css/plugins.css" rel="stylesheet" type="text/css" />
    <link href="App_Themes/Theme/assets/css/responsive.css" rel="stylesheet" type="text/css" />
    <link href="App_Themes/Theme/assets/css/icons.css" rel="stylesheet" type="text/css" />
    <link href="App_Themes/Theme/assets/css/login.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="App_Themes/Theme/assets/css/fontawesome/font-awesome.min.css"/>
    <!--[if IE 7]><link rel="stylesheet" href="assets/css/fontawesome/font-awesome-ie7.min.css"><![endif]-->
    <!--[if IE 8]><link href="assets/css/ie8.css" rel="stylesheet" type="text/css"/><![endif]-->
    <!--<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,600,700' rel='stylesheet' type='text/css'>-->
    <script type="text/javascript" src="App_Themes/Theme/assets/js/libs/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="App_Themes/Theme/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="App_Themes/Theme/assets/js/libs/lodash.compat.min.js"></script>
    <!--[if lt IE 9]><script src="assets/js/libs/html5shiv.js"></script><![endif]-->
    <script type="text/javascript" src="App_Themes/Theme/plugins/uniform/jquery.uniform.min.js"></script>
    <script type="text/javascript" src="App_Themes/Theme/plugins/validation/jquery.validate.min.js"></script>
    <script type="text/javascript" src="App_Themes/Theme/plugins/nprogress/nprogress.js"></script>
    <script type="text/javascript" src="App_Themes/Theme/assets/js/login.js"></script>
    
    <script>$(document).ready(function () { Login.init() });</script>
</head>
    <body class="login">

       
    <div class="logo">
        <img src="App_Themes/Theme/assets/img/manappuram_50.png" alt="logo" />
    </div>
    <div class="box">
        <div class="content">
            <form class="form-vertical login-form" runat ="server" >
                <h3 class="form-title">Sign In to your Account</h3>
               <div class="alert fade in alert-danger" style="display: none;"><i class="icon-remove close" data-dismiss="alert"></i>Enter any username and password. </div>
                  <div class="alert fade in alert-info" style="display: none;"><i class="icon-remove close" data-dismiss="alert"></i>Sorry! Please Login From Portal!!!!!</div>
                <div class="form-group">
                    <div class="input-icon">
                        <i class="icon-user"></i>
                        <input type="text" name="username" id="username" class="form-control" placeholder="Username" autofocus="autofocus" data-rule-required="true" runat="server" data-msg-required="Please enter your username." />
                    </div>
                </div>
                <div class="form-group">
                    <div class="input-icon">
                        <i class="icon-lock"></i>
                        <input type="password" name="password" id="password" class="form-control" placeholder="Password" data-rule-required="true" data-msg-required="Please enter your password." />
                    </div>
                </div>
                <div class="form-actions">
                    <label class="checkbox pull-left">
                        <input type="checkbox" class="uniform" name="remember"/>
                        Remember me</label>
                  <%--  <asp:Button ID="Button1"  Cssclass="submit btn btn-primary pull-right"  runat="server" Text="Login" OnClick="Button1_Click" Font-Bold="True" />--%>
                    <button type="submit"  class="submit btn btn-primary pull-right">Sign In <i class="icon-angle-right"></i></button>
                </div>
            </form>
                      

            
        </div>
        <div class="inner-box">
            <div class="content">
                <i class="icon-remove close hide-default"></i><a href="#" class="forgot-password-link">Forgot Password?</a>
                <form class="form-vertical forgot-password-form hide-default" action="Login.aspx" method="post">
                    <div class="form-group">
                        <div class="input-icon">
                            <i class="icon-envelope"></i>
                            <input type="text" name="email" class="form-control" placeholder="Enter email address" data-rule-required="true" data-rule-email="true" data-msg-required="Please enter your email." />
                        </div>
                    </div>
                    <button type="submit" class="submit btn btn-default btn-block">Reset your Password </button>
                </form>
                <div class="forgot-password-done hide-default"><i class="icon-ok success-icon"></i><span>Great. We have sent you an email.</span> </div>
            </div>
        </div>
    </div>
</body>
</html>
