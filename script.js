console.log("Welcome to HimVista Projects");
window.onload=function(){

setTimeout(function(){

document.getElementById("loader").style.display="none";

},1500);

}
window.addEventListener("scroll",function(){

const nav=document.querySelector(".navbar");

if(window.scrollY>50){

nav.style.background="#0B3D91";

}else{

nav.style.background="rgba(11,61,145,.25)";

}

});
const modal=document.getElementById("quoteModal");

const btn=document.querySelector(".btn");

const close=document.querySelector(".close");

btn.onclick=function(){

modal.style.display="block";

}

close.onclick=function(){

modal.style.display="none";

}

window.onclick=function(e){

if(e.target==modal){

modal.style.display="none";

}

}