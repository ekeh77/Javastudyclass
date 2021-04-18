const body = document.querySelector("body");

const IMG_NUMBER = 5;

function handleImgLoad() {
    console.log("finished loading");
}

function paintImage(imgNumber){
    
    /* Image 오브젝트는 자동으로 이미지 태그를 만들어준다 */
    const image = new Image();
    image.src = `./images/${imgNumber + 1}.jpg`;
    image.addEventListener("loadend",handleImgLoad);
    image.classList.add("bgImage")
    body.prepend(image);
}

function genRandom(){
    const number = Math.floor(Math.random() * IMG_NUMBER);
    return number;
}

function init(){
    const randomNumber = genRandom();
    paintImage(randomNumber);
}

init();