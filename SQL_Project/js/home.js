$(function(){
	var check_flag = 0;	//任务标记
	var clock_status = 0;	//计时器关闭时为0，开启时为1

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
	$("#list_box .checkbox").click(function(){
		if(this.check_flag == 0){
			this.src = "img/checked.png"
			this.check_flag = 1;
			$(this).prev("span").css({textDecoration:"line-through", color:"rgba(0,0,0,0.5)"});
			$(this).nextAll("img").animate({top: "-35px"}, 400)
			$(this).parent().css("border-left","solid 10px rgba(0,0,0,0.2)")
		}
		else{
			this.src = "img/check.png";
			this.check_flag = 0;
			$(this).prev("span").css({textDecoration:"none", color:"black"});
			$(this).nextAll("img").animate({top: "0px"}, 400)
			$(this).parent().css("border-left","solid 10px #F45147")
		}
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
	

	
})

