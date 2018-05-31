$(function(){
	$("#user_avatar img").hover(
		function(){
			$("#user_message").fadeToggle();
		}
	);
//	密码验证
	function psw_verify(){
		alert("hello!");
		return false;
	}
})

