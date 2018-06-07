$(function(){
	$("#user_avatar img").hover(
		function(){
			$("#user_message").fadeToggle();
		}
	);
	
	$("#user_avatar img").click(function(){
		$("#psw_box").fadeIn();
	})
	
	$("#psw_cancel").click(function(){
		$("#psw_box").fadeOut();
	})
})

