﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="home.aspx.cs" Inherits="home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<title>home</title>
	<link rel="stylesheet" type="text/css" href="css/home.css"/>
	<script type="text/javascript" src="js/jquery-3.2.1.min.js" ></script>
	<script type="text/javascript" src="js/home.js" ></script>
	<script src="js/cookieManager.js" type="text/javascript" charset="utf-8"></script>
	<script>
        //密码验证
        function psw_verify() {
            var old_psw = document.getElementById("<%=old_psw.ClientID%>");
            var new_psw = document.getElementById("<%=new_psw.ClientID%>");
            var re_new_psw = document.getElementById("<%=re_new_psw.ClientID%>");
            var psw_wrong = document.getElementById("<%= psw_wrong.ClientID %>");

            if (old_psw.value == "" || new_psw.value == "" || re_new_psw.value == "") {
                psw_wrong.innerText = "请将信息填写完整！";
                return false;
            }

            if (new_psw.value != re_new_psw.value) {
                psw_wrong.innerText = "两次输入的新密码不一致！";
                return false;
            }

            if (old_psw.value == new_psw.value) {
                psw_wrong.innerText = "新密码不能与原密码相同！";
                return false;
            }
        }

        //获取任务or提醒数量，参数为“mission”获取的是任务数量，参数为“remind”获取的是提醒数量
        var get_count = function (mission_remind) {
            if (mission_remind == "mission")
                return getCookie("mission_count");
            else if (mission_remind == "remind")
                return getCookie("mission_count");
        }

        //获取mission表中的mission字段并存放在一个数组中
        var get_mission_list = function () {
            var mission_list_string = "<%= GetMissionList() %>";
            var mission_list_arr = mission_list_string.split(",");
            return mission_list_arr;
        }

        //获取mission表中未完成的mission id并存放在一个数组中
        var ger_mission_id_queue = function () {
            var mission_id_queue_string = "<%= GetMissionIdQueue() %>";
            var mission_id_queue_arr = mission_id_queue_string.split(",");
            return mission_id_queue_arr;
        }

        $(document).ready(function () {
            
        })

	</script>
</head>
<body>
<div id="message_box" class="MD_card">默认消息</div>
<form id="form1" runat="server">
	<!--顶部栏-->
    <!--
    <asp:Button ID="Button1" runat="server" Text="ServerTest" OnClick="Button1_Click" />
    <input type="button" id="Button2" value="JsTest" />
    -->
	<div id="top_bar">
		<img src="img/top_bar_logo.png"/>
		<div id="user_avatar">
			<img src="img/default_avatar.png"/>
			<div id="user_message">
				<div id="user_message_title">用户信息</div>
				<div class="user_message">
					ID
					<div><asp:Label ID="Label1" runat="server" Text="Label"></asp:Label></div>
				</div>
				<div class="user_message">
					UID
					<div><asp:Label ID="Label2" runat="server" Text="Label"></asp:Label></div>
				</div>
			</div>
		</div>
		<a id="logout" href="login.aspx">登出</a>
	</div>
	<!--修改密码-->
	<div id="psw_box">
		<div id="psw_box_title">修改密码</div>
		<div class="psw_title">原密码</div>
        <asp:TextBox ID="old_psw" runat="server" AutoCompleteType="Disabled"></asp:TextBox>
		<div class="psw_title">新密码</div>
        <asp:TextBox ID="new_psw" runat="server" AutoCompleteType="Disabled"></asp:TextBox>
		<div class="psw_title">重复密码</div>
        <asp:TextBox ID="re_new_psw" runat="server" AutoCompleteType="Disabled"></asp:TextBox>
      <div id="psw_btn_box">
      	<div class="psw_btn" style="border-right: solid 1px rgba(255,255,255,0.8);">
              <asp:Button ID="psw_suer" CssClass="psw_real_btn" runat="server" Text="确定" OnClick="psw_suer_Click" OnClientClick="return psw_verify();" />
      	</div>
      	<div class="psw_btn" style="border-left: solid 1px rgba(255,255,255,0.8);">
            <input type="button" id="psw_cancel" class="psw_real_btn" value="取消" />
      	</div>
      </div>
	    <asp:Label ID="psw_wrong" CssClass="psw_wrong" runat="server" Text=""></asp:Label>
	</div>
	<!--计数信息-->
	<div id="count_box">
		<div class="count_left_right">
			<div class="count_title">任 务</div>
			<img class="count_icon" src="img/clipboard-text.png"/>
            <asp:Label ID="count_mission_num"  runat="server" Text="0"></asp:Label>
			<div id="clock_box">
				<div id="clock">
					<div id="minutes">00</div>
					<div id="time_spacing">&nbsp;:&nbsp;</div>
					<div id="seconds">00</div>
				</div>
				<div id="clock_button">
					<img id="play_pause" src="img/pause-circle.png"/>
					<img id="stop_hide" src="img/stop-circle-outline.png"/>
					<img id="replay" src="img/replay.png"/>
				</div>
			</div>
		</div>
		<div class="count_left_right" style="margin-right: 0px;">
			<div class="count_title">日 期</div>
			<img class="count_icon" src="img/calendar-clock.png"/>
			<div id="date_box">
                <div id="date_day" class="date"></div>
                <div id="date_week" class="date"></div>
			</div>
		</div>
	</div>
	
	<!--列表盒子-->
	<div id="list_box">
        <img class="btn_plus" id="btn_add_mission" src="img/plus-circle.png"/>
		<div id="mission" class="mission_remind MD_card" style="overflow:auto;overflow-x: hidden;">
            <!--添加任务-->
            <div id="add_mission_box" class="add_mission_remind_box">
                <div class="add_list_tag">任务名称</div>
                <input class="add_list_text" id="add_mission_name" type="text" value="" runat="server" autocomplete="off"/>
                <div class="add_list_tag">备注</div>
                <input class="add_list_text" id="add_mission_note" type="text" value="" runat="server" autocomplete="off"/>
                <div class="add_list_btn_box">
                    <asp:Button class="add_list_btn_true add_list_btn" ID="add_mission_true" runat="server" Text="确定" OnClick="add_mission_true_Click" />
                    <div class="add_list_btn_false add_list_btn" id="add_mission_false">取消</div>
                </div>
            </div>

			<ul class="list">
				<!--<li>
					<span class="mission long_text">Demo</span>
					<img class="checkbox list_button" src="img/check.png" />
					<img class="clock list_button" src="img/clock-outline.png" />
					<img class="delete list_button" src="img/delete.png" />
				</li>-->
			</ul>
		</div>
		<div id="remind" class="mission_remind MD_card">
			<div id="detailed_default" class="detailed">
                <img id="detailed_default_img" src="img/detailed.png" />
			    <div id="detailed_default_tag">点击左侧列表以显示<br/>详细信息</div>
            </div>
            <div id="detailed_mission" class="detailed">
                详细页面
			</div>
		</div>
	</div>

    <!--功能按钮-->
    <div id="function_box_position">
    <div id="function_btn_box">
        <div id="trash" class="function_btn"><img src="img/delete-empty.png"/><span>垃圾箱</span></div>
        <div id="completed" class="function_btn"><img src="img/book-open.png"/><span>已完成任务</span></div>
        <div id="refresh" class="function_btn"><img src="img/refresh.png"/><span>刷新</span></div>
    </div>
    </div>
</form>
</body>
</html>
