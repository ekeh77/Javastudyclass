const clockContainer = document.querySelector(".js-clock"),
    clockTitle = clockContainer.querySelector("h1")

function getTime(){
    
    /* 시간을 가져오는법 */
    const date = new Date();
    const minutes = date.getMinutes();
    const hours = date.getHours();
    const seconds = date.getSeconds();

    /* 작은 if사용하는법 */
    clockTitle.innerText = `${hours < 10 ? `0${hours}` : hours}:${
                            minutes < 10 ? `0${minutes}` : minutes}:${
                            seconds < 10 ? `0${seconds}` : seconds}`;
}

function init() {
    getTime();

    /* 함수를 시간의 간격으로 실행하는법  */
    setInterval(getTime, 1000);
}

init();