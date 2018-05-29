﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" MaintainScrollPositionOnPostback="true" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>Clearist - 任务助手</title>
<link rel="stylesheet" type="text/css" href="css/login.css"/>
<script type="text/javascript" src="js/jquery-3.2.1.min.js" ></script>
<script>
	$(function(){
		$("#Button2").click(function(){
			$("#register_box").slideDown();
		})
		$("#Button4").click(function(){
			$("#register_box").slideUp();
		})
		$("#show_developer_setting").mouseover(function(){
			$("#show_developer_setting").animate({fontSize:'20px'},100);
		})
		$("#show_developer_setting").mouseleave(function(){
			$("#show_developer_setting").animate({fontSize:'10px'},100);
		})
		$("#show_developer_setting").click(function(){
			$("#developer_panel").css("display","block");
		})
	})
</script>
</head>
<body>
	<img id="login_logo" src="img/login_logo.png"/>
	<form id="form1" runat="server">
		<!--注册界面-->
		<div class="right_box" id="register_box" style="z-index: 3;display: none;">
			<div class="right_box_mainbox">
            	<div class="decoration" id="decoration_1">
            		<div class="title">REGISTER</div></div>
            	<div class="decoration" id="decoration_2"></div>
	            <div class="label">用户名</div>
	            <div class="box" id="id_box">
	                <asp:TextBox ID="TextBox3" CssClass="box textbox" runat="server"></asp:TextBox>
	            </div>
	            <div class="label">密 码</div>
	            <div class="box" id="psw_box">
	                <asp:TextBox ID="TextBox4" CssClass="box textbox" runat="server"></asp:TextBox>
	            </div>
	            <div class="label">重复密码</div>
	            <div class="box" id="repsw_box">
	                <asp:TextBox ID="TextBox5" CssClass="box textbox" runat="server"></asp:TextBox>
	            </div>
	            <div id="btn_box" style="margin-top: 50px;">
		            <div id="loginbtn_box" class="btn">
		                <asp:Button ID="Button3" CssClass="btn button"  runat="server" Text="注 册" OnClick="Button3_Click" />
		            </div>
		            <div style="float: left;width: 30px;height: 50px;"></div>
		            <div class="btn">
                      <input type="button" id="Button4" class="btn button" value="取 消" /> 
		            </div>
		         </div>
	         </div>
		</div>
		<!--登录界面-->
		<div class="right_box">
            <div class="right_box_mainbox">
            	<div class="decoration" id="decoration_1">
            		<div class="title">LOGIN</div>
            	</div>
            	<div class="decoration" id="decoration_2">
            		<!--<div id="show_developer_setting">
            			<a>开发人员选项</a>
            		</div>-->
            	</div>
	            <div class="label">用户名</div>
	            <div class="box" id="id_box">
	                <asp:TextBox ID="TextBox1" CssClass="box textbox" runat="server"></asp:TextBox>
	            </div>
	            <div class="label">密 码</div>
	            <div class="box" id="psw_box">
	                <asp:TextBox ID="TextBox2" CssClass="box textbox" runat="server"></asp:TextBox>
	            </div>
	            <div id="btn_box">
		            <div id="loginbtn_box" class="btn">
		                <asp:Button ID="Button1" CssClass="btn button"  runat="server" Text="登 录" OnClick="Button1_Click" />
		            </div>
		            <div style="float: left;width: 30px;height: 50px;"></div>
		            <div class="btn">
                      <input type="button" id="Button2" class="btn button" value="新用户" /> 
		            </div>
		         </div>
	         </div>
		</div>
	    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:clearist %>" SelectCommand="SELECT * FROM [account]"></asp:SqlDataSource>
	</form>
</body>
</html>
