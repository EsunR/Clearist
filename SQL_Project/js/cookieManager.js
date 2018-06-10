//写入cookie
function setCookie(key, value, t){
	var oDate = new Date();
	oDate.setDate( oDate.getDate() + t );
	document.cookie = key + '=' +value + ';expires=' +oDate.toGMTString();  
}
//读取cookie
function getCookie(key) {
	var arr1 = document.cookie.split('; '); //以分号空格『; 』为判断标准分隔开每条数据
	for(var i = 0; i < arr1.length; i++) {
		var arr2 = arr1[i].split('='); //以等号『=』为判断标准分隔开每一条数据的名字和值
		if(arr2[0] == key) {
			return decodeURI(arr2[1]); //如果遍历的当前条的数据的名字与传入的key值相同，则范围其对应的值
		}
	}
}
//刪除cookie
function removeCookie(key){
	setCookie(key, '', -1);
}