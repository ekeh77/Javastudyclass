const COORDS = 'coords';

function getWeather(lat, log){
    /* API 데이터를 얻어오는 방법 
       그리고 그 데이터를 다 로드하면 가져오게 하는 then을 사용
    */
    /*fetch().then(function(response){
        return response.json()
    }).then(function(json){
        console.log(json);
    });*/
}

function saveCoords(coordsObj){
    localStorage.setItem(COORDS, JSON.stringify(coordsObj))
}

function handleGeoSucces(position){

    /* 위도를 가져오기 */
    const latitude = (position.coords.latitude);

    /* 경도를 가져오기 */
    const longitude = (position.coords.longitude);

    const coordsObj = {
        latitude,
        longitude
    };

    saveCoords(coordsObj);
    getWeather(latitude, longitude);
}

function handleGeoError(){
    console.log('Cant access geo location');
}

function askForCoods(){

    /* navigator안에 여러함수가 있는데 여기서 현재 위치를 가져오는 함수 */
    navigator.geolocation.getCurrentPosition(handleGeoSucces, handleGeoError);

}

function loadCoords(){
    const loadedCoords = localStorage.getItem(COORDS);
    if(loadedCoords === null){
        askForCoods();
    }
    else{
        const parseCoords = JSON.parse(loadedCoords);
        getWeather(parseCoords.latitude, parseCoords.longitude)
    }
}

function init(){
    loadCoords();
}

init();