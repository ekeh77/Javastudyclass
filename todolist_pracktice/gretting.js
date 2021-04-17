const form = document.querySelector(".js-form"),
    input = form.querySelector("input"),
    greeting = document.querySelector(".js-greetings");

const USER_LS = "currentUser",
    SHOWING_CN = "showing";

function saveName(text){
    /* localStorage에 앞에값 이름으로 뒤에값을 저장하는것 */
    localStorage.setItem(USER_LS, text)
}

function handleSubmit(event){
    /* 이벤트의 발생을 막는 명령어 */
    event.preventDefault();

    const currentValue = input.value;
    paintGreeting(currentValue);
    saveName(currentValue);
}

function askForName(){
    form.classList.add(SHOWING_CN);
    /* 앞쪽 이벤트가 발생한 경우 뒤에 함수를 호출하는것 */
    form.addEventListener("submit", handleSubmit);
}

function paintGreeting(text){
    form.classList.remove(SHOWING_CN);
    greeting.classList.add(SHOWING_CN);
    greeting.innerText = `Hello ${text}`;
}

function loadName(){
    /* localStorage에 값을 불러오는것 */
    const currentUser = localStorage.getItem(USER_LS);
    if(currentUser === null){
        askForName();
    }
    else{
        paintGreeting(currentUser);
    }
}

function init(){
    loadName();
}

init();