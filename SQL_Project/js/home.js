$(function(){
	var check_flag = 1;
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
//	选择框
	$("#list_box .checkbox").click(function(){
		if(check_flag == 1){
			this.src = "img/checked.png"
			check_flag = 0;
			$(this).prev("span").css({textDecoration:"line-through", color:"rgba(0,0,0,0.5)"});
			$(this).nextAll("img").animate({top: "-35px"}, 400)
			$(this).parent().css("border-left","solid 10px rgba(0,0,0,0.2)")
		}
		else{
			this.src = "img/check.png";
			check_flag = 1;
			$(this).prev("span").css({textDecoration:"none", color:"black"});
			$(this).nextAll("img").animate({top: "0px"}, 400)
			$(this).parent().css("border-left","solid 10px #F45147")
		}
	})
})

