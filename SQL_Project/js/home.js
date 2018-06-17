$(function(){
	var check_flag = 0;	//任务标记
    var clock_status = 0;	//计时器关闭时为0，开启时为1
    var mission_selected = new Array();   //任务已完成队列
    var mission_id_queue = ger_mission_id_queue();  //获取当前的任务id队列，用于删除按钮调用记录删除的任务
    var mission_count = get_count("mission");   //获取任务数
    



//  显示日期
    var d = new Date();
    $("#date_day").text(d.getFullYear() + "年" + d.getMonth() + "月" + d.getDate() + "日");
    var weekday = new Array(7)
    weekday[0] = "星期日"
    weekday[1] = "星期一"
    weekday[2] = "星期二"
    weekday[3] = "星期三"
    weekday[4] = "星期四"
    weekday[5] = "星期五"
    weekday[6] = "星期六"
    $("#date_week").text(weekday[d.getDay()]);


//  初始化列表
    var format_list = function (mission_remind) {
        if (mission_remind == "mission") {
            var mission_list_attr = get_mission_list();
            for (var i = 0; i < mission_count; i++) {
                $("#mission ul").append("<li><span class='mission'>" + mission_list_attr[i] + "</span><img class='checkbox list_button' src='img/check.png' /><img class='clock list_button' src='img/clock-outline.png' /><img class='delete list_button' src='img/delete.png' /></li >");
            }
            var i = 0;
            $(".mission").each(function () {
                this.queue = i; //任务的队列
                this.mark = 1;  //未完成标记为1，已完成标记为0，删除标记为2
                this.mission_id = mission_id_queue[i];
                console.log(this.queue + "=" + this.mission_id);
                i++;
            })
        }
    }
    format_list("mission");


//	消息框函数
	var messageBox = function(message){
		$("#message_box").text(message);
		$("#message_box").animate({"opacity":"1"},800).delay(1500).animate({"opacity":"0"},800);
	}

//	展示个人信息动画
	$("#user_avatar img").hover(
		function(){
			$("#user_message").fadeToggle();
		}
	);

//	显示修改密码框动画
	$("#user_avatar img").click(function(){
		$("#psw_box").fadeIn();
	})
	
	$("#psw_cancel").click(function(){
		$("#psw_box").fadeOut();
	})

//	选择框按钮
	var aCheckbox = document.getElementsByClassName("checkbox");
	for(var i = 0; i<aCheckbox.length; i++){
		aCheckbox[i].check_flag = 0;
	}
    $("#list_box .checkbox").click(function () {
        var oMission = $(this).prev(".mission")[0];
		if(this.check_flag == 0){
			this.src = "img/checked.png"
			this.check_flag = 1;
			$(this).prev("span").css({textDecoration:"line-through", color:"rgba(0,0,0,0.5)"});
			$(this).nextAll("img").animate({top: "-35px"}, 400)
            $(this).parent().css("border-left", "solid 10px rgba(0,0,0,0.2)")
            $(this).prev(".mission")[0].mark = 0;   //将.mission标签mark标记为已完成（0）
		}
		else{
			this.src = "img/check.png";
			this.check_flag = 0;
			$(this).prev("span").css({textDecoration:"none", color:"black"});
			$(this).nextAll("img").animate({top: "0px"}, 400)
            $(this).parent().css("border-left", "solid 10px #F45147")
            $(this).prev(".mission")[0].mark = 1;   //将.mission标签mark标记为未完成（1）
        }
        //将选择的任务添加或删除到mission_select数组中
        if (oMission.mark == 0) {
            mission_selected.push(oMission.mission_id);
        }
        else if (oMission.mark == 1) {
            for (var i = 0; i < mission_selected.length; i++) {
                if (mission_selected[i] == oMission.mission_id)
                    mission_selected.splice(i, 1);
            }
        }
        var mission_selected_string = mission_selected.join();
        setCookie("mission_selected", mission_selected_string, 7);
	})

//	时钟按钮
	$("#list_box .clock").click(function(){
		$(this).addClass("time_creater");
		if(clock_status == 0){
			clock_status = 1;
			this.src = "img/clock_black.png";
			$(this).nextAll("img").animate({top: "-35px"}, 400);
			$(this).prevAll("img").animate({top: "-35px"}, 400);
			$("#clock_box").animate({"top":"-154px"},400);
			time_start();
		}
		else{
			$(this).animate({"left":"3px"},100);
			$(this).animate({"left":"-3px"},100);
			$(this).animate({"left":"3px"},100);
			$(this).animate({"left":"0px"},100)
		}
	})
	//暂停、开始按钮
	var play_pause = 0;
	$("#play_pause").click(function(){
		if(play_pause == 0){
			this.src = "img/play-circle.png";
			time_pause();
			play_pause = 1;
			$("#stop_hide").attr("src","img/stop-circle-outline.png");
			stop_hide = 0;
		}
		else{
			this.src = "img/pause-circle.png";
			time_start();
			play_pause = 0;
			$("#stop_hide").attr("src","img/stop-circle-outline.png");
			stop_hide = 0;
		}
	})
	//重置按钮
	$("#replay").click(function(){
		time_pause();
		$("#minutes").text("00");
		$("#seconds").text("00");
		$("#play_pause").attr("src","img/play-circle.png");
		play_pause = 1;
		$("#stop_hide").attr("src","img/stop-circle-outline.png");
		stop_hide = 0;
	})
	//停止、收起面板按钮
	var stop_hide = 0;
	$("#stop_hide").click(function(){
		if(stop_hide == 0){
			stop_hide = 1;
			time_pause();
			$(this).attr("src","img/chevron-down.png");
			$("#play_pause").attr("src","img/play-circle.png");
			play_pause = 1;
		}
		else{
			messageBox("工作记录已提交！")
			clock_status = 0;
			//重置列表按钮
			this.src = "img/stop-circle-outline.png";
			$("#list_box .time_creater").nextAll("img").animate({top: "0px"}, 400);
			$("#list_box .time_creater").prevAll("img").animate({top: "0px"}, 400);
			$("#list_box .time_creater").removeClass("time_creater");
			$("#clock_box").animate({"top":"0px"},400);
			$("#list_box .clock").attr("src","img/clock-outline.png");
			//重置停止、收起面板、暂停按钮
			$("#stop_hide").attr("src","img/stop-circle-outline.png");
			stop_hide = 0;
			$("#play_pause").attr("src","img/pause-circle.png");
			play_pause = 0;
			//重置时间
			$("#minutes").text("00");
			$("#seconds").text("00");
		}
	})
	//开始计时
	var start;
	var time_start = function(){
		clearInterval(start);
		start = setInterval(function(){
			var add_seconds = parseInt($("#seconds").text()) + 1;
			if(add_seconds == 60){
				add_seconds = 0;
				var add_minutes = parseInt($("#minutes").text()) + 1;
				$("#minutes").text(checkTime(add_minutes));
			}
			$("#seconds").text(checkTime(add_seconds));
		},1000)
	}
	function checkTime(i){
		if (i<10) 
			i="0" + i;
		return i
	}
	//停止计时
	var time_pause = function(){
		clearInterval(start);
	}

//  删除按钮
    $("#list_box .delete").click(function () {
        var mission_delete = $(this).siblings(".mission")[0].mission_id;
        setCookie("mission_delete", mission_delete, 7);
        mission_count--;
        window.location.replace("home.aspx");
    })

//  点击任务列表显示详细信息
    var mission_detailed_mode = "default"
    $("#mission .mission").click(function () {
        setCookie("detailed", $(this)[0].mission_id, 7);   //写入cookie记录当前选择的任务id
        if (mission_detailed_mode == "default") {
            mission_detailed_mode = "active"
            //局部刷新页面更新数据
            $("#detailed_mission").load("/detailed.aspx", function () { })
            $("#detailed_mission").animate({ "right": "0px", "display": "block" }, 400);
        }
        else {
            $("#detailed_mission").animate({ "right": "-450px", "display": "none" }, 400)
                .animate({ "right": "0px", "display": "block" }, 400);
            //局部刷新页面更新数据（为配合动画做一定的延时）
            setTimeout(function () {
                $("#detailed_mission").load("/detailed.aspx", function () { })
            }, 400)
        }
    })

//  添加按钮
    //鼠标移动到“添加”按钮的动画
    var add_list_open = 0;
    $("#btn_add_mission").hover(function () {
        if (add_list_open == 0)
            $("#add_mission_box").css("z-index","-1").animate({ "left": "-20px" }, 200);
    }, function () {
        if (add_list_open == 0) {
            $("#add_mission_box").animate({ "left": "15px" }, 200);
        }
    })
    //鼠标点击“添加”按钮的动画
    $("#btn_add_mission").click(function () {
        if (add_list_open == 0) {
            $("#add_mission_box").animate({ "left": "-470px" }, 500);
            setTimeout(function () {
                $("#add_mission_box").css("z-index", "2").animate({ "left": "15px" }, 500);
            }, 500)
            add_list_open = 1;
        }
        else {
            $("#add_mission_box").animate({ "left": "-470px" }, 500);
            setTimeout(function () {
                $("#add_mission_box").css("z-index", "-1").animate({ "left": "15px" }, 500);
            }, 500);
            add_list_open = 0;
        }
        $(".add_list_text").each(function () {
            $(this).val("");
        });
    })
    //点击“取消”按钮
    $("#add_mission_false").click(function () {
        $("#add_mission_box").animate({ "left": "-470px" }, 500);
        setTimeout(function () {
            $("#add_mission_box").css("z-index", "-1").animate({ "left": "15px" }, 500);
        }, 500);
        add_list_open = 0;
    })
    //点击“确定”按钮
    $("#add_mission_true").click(function () {
        $("#add_mission_box").animate({ "left": "-470px" }, 500);
        setTimeout(function () {
            $("#add_mission_box").css("z-index", "-1").animate({ "left": "15px" }, 500);
        }, 500);
        add_list_open = 0;
        if ($("#add_mission_name").val() == "") {
            return false;
        }
        else
            return true;
    })

    //功能按钮动画
    $("#refresh").mouseover(function () {
        $("#function_btn_box span").css("display", "block");
        $("#completed").animate({ "opacity": "1", "top": "0"}, 250);
        $("#trash").animate({ "opacity": "1", "top": "0"}, 500);
    })
    $("#function_btn_box").mouseleave(function () {
        $("#trash").animate({ "opacity": "0", "top": "120" }, 500);
        $("#completed").animate({ "opacity": "0", "top": "60" }, 250);
        $("#function_btn_box span").css("display", "none");
    })
    $("#refresh").click(function () {
        window.location.replace("home.aspx");
    })
    $("#trash").click(function () {
        window.location.replace("trash.aspx");
    })
    $("#completed").click(function () {
        window.location.replace("completed.aspx");
    })

})

