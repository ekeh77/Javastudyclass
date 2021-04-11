var makeFoods = function(foodName, giveStar, imgUrl){
    this.foodName = foodName;
    this.giveStar = giveStar;
    this.imgUrl = imgUrl;
};

var foodList = [];
foodList[0] = new makeFoods("산딸기케이크", "★★★★☆", "./img/1.jpg");
foodList[1] = new makeFoods("스테이크","★★★★★","./img/2.jpg");
foodList[2] = new makeFoods("채소덩어리","☆☆☆☆☆","./img/3.jpg");
foodList[3] = new makeFoods("팬케이크","★★★☆☆","./img/4.jpg");
foodList[4] = new makeFoods("연어를위에올린거","★★★★☆","./img/5.jpg");
foodList[5] = new makeFoods("건강한계란","★★☆☆☆","./img/6.jpg");
foodList[6] = new makeFoods("단호박죽","★★★★☆","./img/7.jpg");

var makeDay = [];
makeDay[0] = "월";
makeDay[1] = "화";
makeDay[2] = "수";
makeDay[3] = "목";
makeDay[4] = "금";
makeDay[5] = "토";
makeDay[6] = "일";
makeDay[7] = "전체";

var init = function(){
    var menuId = getId("giveMeFood")
    var inputMenu = makeMenu();
    menuId.innerHTML = inputMenu;
}

var whatfood = function(obj){
    var giveId = []; 
    giveId[0] = getId("day0");
    giveId[1] = getId("day1");
    giveId[2] = getId("day2");
    giveId[3] = getId("day3");
    giveId[4] = getId("day4");
    giveId[5] = getId("day5");
    giveId[6] = getId("day6");
    giveId[7] = getId("day7");
    var showFood = getId("showFood");
    
    if(giveId[0].id == obj.id){
        var getFood = makeFoodMenu(foodList[0].foodName, foodList[0].giveStar, foodList[0].imgUrl);
        showFood.innerHTML = getFood
    }
    else if(giveId[1].id == obj.id){
        var getFood = makeFoodMenu(foodList[1].foodName, foodList[1].giveStar, foodList[1].imgUrl);
        showFood.innerHTML = getFood
    }
    else if(giveId[2].id == obj.id){
        var getFood = makeFoodMenu(foodList[2].foodName, foodList[2].giveStar, foodList[2].imgUrl);
        showFood.innerHTML = getFood
    }
    else if(giveId[3].id == obj.id){
        var getFood = makeFoodMenu(foodList[3].foodName, foodList[3].giveStar, foodList[3].imgUrl);
        showFood.innerHTML = getFood
    }
    else if(giveId[4].id == obj.id){
        var getFood = makeFoodMenu(foodList[4].foodName, foodList[4].giveStar, foodList[4].imgUrl);
        showFood.innerHTML = getFood
    }
    else if(giveId[5].id == obj.id){
        var getFood = makeFoodMenu(foodList[5].foodName, foodList[5].giveStar, foodList[5].imgUrl);
        showFood.innerHTML = getFood
    }
    else if(giveId[6].id == obj.id){
        var getFood = makeFoodMenu(foodList[6].foodName, foodList[6].giveStar, foodList[6].imgUrl);
        showFood.innerHTML = getFood
    }
    else if(giveId[7].id == obj.id){
        var getFood = "";
        for(var i=0; i<foodList.length; i++){
            getFood += "<div id='wowAllFoodDiv'>"
            getFood += "<div id='wowAllFood'>"
            getFood += "<span> 음식이름 : "
            getFood += foodList[i].foodName
            getFood += "</span>"
            getFood += "<span> 별점 : "
            getFood += foodList[i].giveStar
            getFood += "</span>"
            getFood += "<img src='" + foodList[i].imgUrl + "'/>"
            getFood += "</div>" 
            getFood += "</div>"
        }
        showFood.innerHTML = getFood
    }
    
}

var makeMenu = function(){
    var menuHTML = "";
    for(var i=0; i<makeDay.length; i++){
        menuHTML += "<div id='day" + i + "' class='day' onclick='whatfood(this);'>";
        menuHTML += "<span name='foodlist'>";
        menuHTML += makeDay[i];
        menuHTML += "</span>";
        menuHTML += "</div>";
    }
    return menuHTML;
}

var getId = function(ID){
    var whatId = document.getElementById(ID);
    return whatId;
}

var makeFoodMenu = function(foodName, giveStar, imgUrl){
    var foodMenu = "";
    foodMenu += "<div id='wowFood'>"
    foodMenu += "<span> 음식이름 : "
    foodMenu += foodName
    foodMenu += "</span>"
    foodMenu += "<span> 별점 : "
    foodMenu += giveStar
    foodMenu += "</span>"
    foodMenu += "<img src='" + imgUrl + "'/>"
    foodMenu += "</div>" 
    return foodMenu
}