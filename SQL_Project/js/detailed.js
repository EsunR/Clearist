$(function () {
    //点击文本框效果
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

    //生成子任务列表
    var subtasks_list_arr = GetSubtasksArr();//存放子任务名的数组
    var subtasks_id_arr = GetSubtasksIdArr();
    if (subtasks_list_arr != "") {
        for (var i = 0; i < subtasks_list_arr.length; i++) {
            $("#subtasks_list").append("<li>" + subtasks_list_arr[i] + "<img src='img/close.png' /></li>");
        }
        var i = 0;
        $("#subtasks_list li").each(function () {
            this.subtasks_id = subtasks_id_arr[i];
            i++;
        })
    }

    //删除子任务
    var subtasks_delete = new Array();
    $("#subtasks_list img").click(function () {
        subtasks_delete.push($(this).parent()[0].subtasks_id);
        setCookie("subtasks_delete", subtasks_delete, 7); //将删除的子任务id添加到cookie
        $(this).parent().fadeOut();
    })
    

    //添加按钮
    var subtasks = new Array();
    $("#subtasks_btn").click(function () {
        if ($("#subtasks_tb").val() != "") {
            $("#subtasks_list").append("<li>" + $("#subtasks_tb").val() + "</li>").scrollTop(10000);
            subtasks.push($("#subtasks_tb").val());
            setCookie_CN("new_subtasks", subtasks, 7); //将新添加的子任务写入cookie
            $("#subtasks_tb").val("");
        }
    });

    
    //"应用更改"按钮
    $("#detailed_apply").click(function () {
        if ($("#md_name").val() == "") {
            $("#md_name").addClass("text_box_click");
            $("#md_note").removeClass("text_box_click");
            $("#subtasks_tb").removeClass("text_box_click");
            $("#md_name").animate({ "right": "30px" }, 30)
                .animate({ "right": "0px" }, 30)
                .animate({ "right": "-30px" }, 30)
                .animate({ "right": "0px" }, 30)
                .animate({ "right": "30px" }, 30)
                .animate({ "right": "0px" }, 30)
                .animate({ "right": "-30px" }, 30)
                .animate({ "right": "0px" }, 30)
            return false;
        }
        else {
            setCookie_CN("mission_change", $("#md_name").val(), 7);
            setCookie_CN("note_change", $("#md_note").val(), 7);
            return true;
        }
    })
    
})