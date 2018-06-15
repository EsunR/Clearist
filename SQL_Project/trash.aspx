<%@ Page Language="C#" AutoEventWireup="true" CodeFile="trash.aspx.cs" Inherits="trash" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Clearist-垃圾箱</title>
    <link rel="stylesheet" type="text/css" href="css/trash_completed.css"/>
    <script type="text/javascript" src="js/jquery-3.2.1.min.js" ></script>
	<script type="text/javascript" src="js/trash.js" ></script>
	<script src="js/cookieManager.js" type="text/javascript" charset="utf-8"></script>
    <script>
        //获取删除列表中的mission名字构成的字符串，将其转化为数组
        var GetDeleteMissionArr = function () {
            var delete_mission_string = "<%= GetDeleteMissionList()%>";
            var delete_mission_arr = delete_mission_string.split(",");
            return delete_mission_arr;
        }

        var GetDeleteMissionIdArr = function () {
            var delete_mission_id = "<%= GetDeleteMissionId()%>";
            var delete_mission_id_arr = delete_mission_id.split(",");
            return delete_mission_id_arr;
        }
    </script>
</head>
<body>
<form id="form1" runat="server">
    <div id="top_bar">
        <img src="img/top_bar_logo.png"/>
        <div id="home_btn"><img src="img/home.png"/><span>主页</span></div>
	</div>
    <div id="btn_box">
        <div id="backup_btn" class="btn">还原任务数</div>
        <span id="backup_num" class="num">0</span>
        <div id="delete_btn" class="btn">彻底删除数</div>
        <span id="delete_num" class="num">0</span>
    </div>
    <div id="list_box">
        <div id="title">回收站</div>
        <ul id="list_ul">
            <!--
            <li class="list_li"><span>删除的消息</span><img class="delete_forever" src="img/delete-forever_dark.png"/><img class="backup" src="img/backup_dark.png"/></li>
            -->
        </ul>
    </div>
    <asp:Button ID="confirm_button" runat="server" Text="确认操作" OnClick="confirm_button_Click" />
</form>
</body>
</html>
