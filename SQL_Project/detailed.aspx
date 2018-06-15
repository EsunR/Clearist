<%@ Page Language="C#" AutoEventWireup="true" CodeFile="detailed.aspx.cs" Inherits="detailed" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link rel="stylesheet" type="text/css" href="css/detailed.css"/>
	<script type="text/javascript" src="js/jquery-3.2.1.min.js" ></script>
	<script type="text/javascript" src="js/detailed.js"></script>
    <script src="js/cookieManager.js" type="text/javascript" charset="utf-8"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="mission_detailed_box" runat="server">
        <div id="detailed_top">

        </div>

        <div class="md_box">
            <asp:Label ID="md_name_title" CssClass="title" runat="server" Text="任务名称"></asp:Label>
            <asp:TextBox ID="md_name" CssClass="text_box" runat="server"></asp:TextBox>
        </div>

        <div class="md_box">
            <asp:Label ID="md_note_title" CssClass="title" runat="server" Text="备注"></asp:Label>
            <asp:TextBox ID="md_note" CssClass="text_box" runat="server"></asp:TextBox>
        </div>

        <div id="subtasks_box" class="md_box">
            <asp:Label ID="md_subtasks" CssClass="title" runat="server" Text="子任务"></asp:Label>
            <ul id="subtasks_list">
                <li>子任务1</li>
                <li>子任务1</li>
            </ul>
            <div id="add_subtasks">
                <input id="subtasks_tb" type="text" />
                <input id="subtasks_btn" type="button" value="添加" />
            </div>
        </div>

        <div id="detailed_bottom">
            <div id="time_cost">
                <span class="detailed_bottom_label">任务用时</span>
                <asp:Label ID="time_cost_num" CssClass="detailed_bottom_num" runat="server" Text=""></asp:Label>
            </div>
            <div id="start_time">
                <span class="detailed_bottom_label">开始时间</span>
                <asp:Label ID="start_time_num" CssClass="detailed_bottom_num" runat="server" Text=""></asp:Label>
            </div>
            <asp:Button ID="detailed_apply" runat="server" Text="应用更改" OnClick="detailed_apply_Click" />
        </div>
    </div>
    </form>
</body>
</html>
