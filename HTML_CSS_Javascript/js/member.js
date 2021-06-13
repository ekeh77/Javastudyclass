function init(){
	var obj = document.getElementById("userMonth")
	var strMonth ="<option value=''>월</option>";
	for (var i = 1; i<=12; i++)
	{
		strMonth += "<option value='"+ i +"'>"+ i +"</option>";
	}
	obj.innerHTML = strMonth;
}

function delLine(obj){
	
}

function chkValue(id1, id2){
	var obj = document.getElementById(id1);
	if(obj.value == ""){
		var obj2 = document.getElementById(id2);
		obj2.innerHTML = "필수값입니다."
	}
	else{
		var obj2 = document.getElementById(id2);
		obj2.innerHTML = ""
	}
}

function chkPass(){
	var obj1 = document.getElementById("userPass");
	var obj2 = document.getElementById("userPass_Re");

	if(obj1.value !== "" || obj2.value !== ""){

		if(obj1.value != obj2.value){
			var obj3 = document.getElementById("passMsg_Re");
			obj3.innerHTML = "두개의 패스워드값이 일치하지 않습니다.";
		}
		else{
			var obj3 = document.getElementById("passMsg_Re");
			obj3.innerHTML = "패스워드 일치";
		}
	}
}

function chk_Year(obj){
	var obj2 = document.getElementById("birthMsg");
		console.log(obj2.value)
	if(obj.value.length < 4){
		obj2.innerHTML = "년도는 4자리를 정확하게 입력하세요";
	}
	else{
		obj2.innerHTML = "";
		chk_Month();
	}
}
function chk_Month(){
	var obj = document.getElementById("userMonth")

		if(obj.value.length == 0){
			var obj2 = document.getElementById("birthMsg");
			obj2.innerHTML = "태어난 월을 입력해주세요"
		}
		else{
			var obj2 = document.getElementById("birthMsg");
			obj2.innerHTML = "";
			chk_day();
		}
}
function chk_day(){
	var obj = document.getElementById("userDay")
		if(obj.value <= 0 || obj.value > 31){
			var obj2 = document.getElementById("birthMsg");
			obj2.innerHTML = "태어난 일을 입력해주세요"
		}
		else{
			var obj2 = document.getElementById("birthMsg");
			obj2.innerHTML = "";
		
		}
}