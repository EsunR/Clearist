$(function () {
    $("#md_name").click(function () {
        $(this).addClass("text_box_click");
        $("#md_note").removeClass("text_box_click");
        $("#subtasks_tb").removeClass("text_box_click");
    });
    $("#md_note").click(function () {
        $(this).addClass("text_box_click");
        $("#md_name").removeClass("text_box_click");
        $("#subtasks_tb").removeClass("text_box_click");
    });
    $("#subtasks_tb").click(function () {
        $(this).addClass("text_box_click");
        $("#md_name").removeClass("text_box_click");
        $("#md_note").removeClass("text_box_click");
    });

    //添加按钮
    var subtasks = new Array();
    $("#subtasks_btn").click(function () {
        if ($("#subtasks_tb").val() != "") {
            $("#subtasks_list").append("<li>" + $("#subtasks_tb").val() + "</li>").scrollTop(10000);
            subtasks.push($("#subtasks_tb").val());
            setCookie("new_subtasks", subtasks, 7); //将新添加的任务写入cookie
            $("#subtasks_tb").val("");
        }
        
    });
})