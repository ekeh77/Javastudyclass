const toDoForm = document.querySelector(".js-toDoForm"),
    toDoInput = toDoForm.querySelector("input"),
    toDoList = document.querySelector(".js-toDoList");

const TODOS_LS = 'toDos';

let toDos = [];

function filterFn(toDo){

}

function deleteToDo(event){
    const btn = event.target;
    const li = btn.parentNode;
    toDoList.removeChild(li)
    /* 각각의 함수를 실행시키고 배열로 반환하는것 */
    const cleanToDos = toDos.filter(function(toDo){
        return toDo.id !== parseInt(li.id);
    })
    toDos = cleanToDos;
    saveToDos();
}

function saveToDos(){
    /* 형태를 텍스트로 변환 */
    localStorage.setItem(TODOS_LS, JSON.stringify(toDos));
}

function paintToDo (text) {
    /* 엘리멘트를 생성하는 명령어 */
    const li = document.createElement("li");
    const delBtn = document.createElement("button");
    const span = document.createElement("span");
    const newId = toDos.length + 1;
    delBtn.innerHTML = "X";
    delBtn.addEventListener("click", deleteToDo)
    span.innerText = text;
    /* 부모요소에 아들요소를 넣고싶을 때 사용하는 명령어 */
    li.appendChild(delBtn);
    li.appendChild(span);
    li.id = newId;
    toDoList.appendChild(li);
    const toDoObj = {
        text : text,
        id : newId
    };
    toDos.push(toDoObj);
    saveToDos();
}

function handleSubmit(event){
    event.preventDefault();
    const currentValue = toDoInput.value;
    paintToDo(currentValue);
    toDoInput.value = "";
}

function loadToDos() {
    const loadedToDos = localStorage.getItem(TODOS_LS);
    if(loadedToDos !== null){
        /* 형태를 다시 OBJ로 변환 */
        const parsedToDos = JSON.parse(loadedToDos);
        /* 각각의 함수를 실행시키는것 */
        parsedToDos.forEach(function(toDo){
            paintToDo(toDo.text)
        });
    }
    
}

function init() {
    loadToDos();
    toDoForm.addEventListener("submit", handleSubmit);
}

init();