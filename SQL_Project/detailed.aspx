<%@ Page Language="C#" AutoEventWireup="true" CodeFile="detailed.aspx.cs" Inherits="detailed" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link rel="stylesheet" type="text/css" href="css/detailed.css"/>
	<script type="text/javascript" src="js/jquery-3.2.1.min.js" ></script>
	<script type="text/javascript" src="js/detailed.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="mission_detailed_box" runat="server">
        <div class="md_box">
            <asp:Label ID="md_name_title" CssClass="title" runat="server" Text="任务名称"></asp:Label>
            <asp:TextBox ID="md_name" CssClass="text_box" runat="server"></asp:TextBox>
        </div>
        <div class="md_box">
            <asp:Label ID="md_note_title" CssClass="title" runat="server" Text="备注"></asp:Label>
            <asp:TextBox ID="md_note" CssClass="text_box" runat="server"></asp:TextBox>
        </div>

    </div>
    </form>
</body>
</html>
