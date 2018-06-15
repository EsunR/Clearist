$(function () {
    //初始化列表
    var delete_mission_arr = GetDeleteMissionArr();
    var delete_mission_id_arr = GetDeleteMissionIdArr();
    var delete_mission_count = delete_mission_arr.length;
    if (delete_mission_arr[0] != "") {
        for (var i = 0; i < delete_mission_arr.length; i++) {
            $("#list_ul").append("<li class='list_li'><span>" + delete_mission_arr[i] + "</span><img class='delete_forever' src='img/delete-forever_dark.png'/><img class='backup' src='img/backup_dark.png'/></li>")
        }
    }
    
    //为每个节点设置属性
    var j = 0;
    $("#list_ul .list_li").each(function () {
        this.mission_id = delete_mission_id_arr[j];
        j++;
    });
    

    //顶部主页按钮
    $("#home_btn").click(function () {
        window.location.replace("home.aspx");
    });

    //删除按钮
    var delete_num = 0; //记录彻底删除任务的数目
    var mission_delete_forever_arr = new Array();
    $(".delete_forever").each(function () {
        this.delete_forever = 0;    //保证每个删除按钮的点击状态是独立的
    });
    $(".delete_forever").click(function () {
        if (this.delete_forever == 0) {
            $(this).attr("src", "img/delete-forever.png");
            $(this).parent().css("background", "#F45147")
            $(this).siblings(".backup").css("display", "none");
            $(this).siblings("span").css("color", "white");
            this.delete_forever = 1;
            delete_num++;
            $("#delete_num").text(delete_num);
            //写入cookie数组
            alert($(this).parent()[0].mission_id);
        }
        else {
            $(this).attr("src", "img/delete-forever_dark.png");
            $(this).parent().css("background", "white")
            $(this).siblings(".backup").css("display", "block");
            $(this).siblings("span").css("color", "rgba(0, 0, 0, 0.7)");
            this.delete_forever = 0;
            delete_num--;
            $("#delete_num").text(delete_num);
        }
    });

    //还原按钮
    var backup_num = 0; //记录还原任务的数目
    $(".backup").each(function () {
        this.backup = 0;    //保证每个删除按钮的点击状态是独立的
    })
    $(".backup").click(function () {
        if (this.backup == 0) {
            $(this).attr("src", "img/backup.png");
            $(this).parent().css("background", "#22a8f0")
            $(this).siblings(".delete_forever").css("display", "none");
            $(this).siblings("span").css("color", "white");
            this.backup = 1;
            backup_num++;
            $("#backup_num").text(backup_num);
        }
        else {
            $(this).attr("src", "img/backup_dark.png");
            $(this).parent().css("background", "white")
            $(this).siblings(".delete_forever").css("display", "block");
            $(this).siblings("span").css("color", "rgba(0, 0, 0, 0.7)");
            this.backup = 0;
            backup_num--;
            $("#backup_num").text(backup_num);
        }
    });

})