var showTitle1 = function(obj){
	var whatTitle = document.getElementById("showTitle")
	var colorName = document.getElementsByName("btnColor")
	var goDownId = document.getElementById("goDown")
	whatTitle.innerHTML = "저녁 식사 메뉴 아이디어를 찾아보세요"
	whatTitle.style ="color:orange; animation:moveUp 1s ease-in-out;"
	obj.style = "background-color: orange;"
	goDownId.style = "background-color: orange;"
	for (var i=0; i<colorName.length; i++)
	{
		if (colorName[0] != colorName[i])
		{
			colorName[i].style = "background-color: #eeeeee;"
		}
	}
	
}
var showTitle2 = function(obj){
	var whatTitle = document.getElementById("showTitle")
	var colorName = document.getElementsByName("btnColor")
	var imgName = document.getElementsByName("cakeImg")
	var goDownId = document.getElementById("goDown")
	whatTitle.innerHTML = "집안 꾸미기 아이디어를 찾아보세요"
	whatTitle.style ="color:#669988; animation:moveUp 1s ease-in-out;"
	obj.style = "background-color: #669988;"
	goDownId.style = "background-color: #669988;"
	for (var i=0; i<colorName.length; i++)
	{
		if (colorName[1] != colorName[i])
		{
			colorName[i].style = "background-color: #eeeeee;"
		}
	}
}
var showTitle3 = function(obj){
	var whatTitle = document.getElementById("showTitle")
	var colorName = document.getElementsByName("btnColor")
	var goDownId = document.getElementById("goDown")
	whatTitle.innerHTML = "새로운 패션을 찾아보세요"
	whatTitle.style ="color:#0088ff; animation:moveUp 1s ease-in-out;"
	obj.style = "background-color: #0088ff;"
	goDownId.style = "background-color: #0088ff;"
	for (var i=0; i<colorName.length; i++)
	{
		if (colorName[2] != colorName[i])
		{
			colorName[i].style = "background-color: #eeeeee;"
		}
	}
}
var showTitle4 = function(obj){
	var whatTitle = document.getElementById("showTitle")
	var colorName = document.getElementsByName("btnColor")
	var goDownId = document.getElementById("goDown")
	whatTitle.innerHTML = "정원 가꾸기 아이디어를 찾아보세요"
	whatTitle.style ="color:#669988; animation:moveUp 1s ease-in-out;"
	obj.style = "background-color: #669988;"
	goDownId.style = "background-color: #669988;"
	for (var i=0; i<colorName.length; i++)
	{
		if (colorName[3] != colorName[i])
		{
			colorName[i].style = "background-color: #eeeeee;"
		}
	}
}