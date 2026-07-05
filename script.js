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

const triggerBtns=document.querySelectorAll(".quote-trigger");

const close=document.querySelector(".close");

triggerBtns.forEach(function(btn){
btn.addEventListener("click",function(e){
e.preventDefault();
modal.style.display="block";
});
});

close.onclick=function(){

modal.style.display="none";

}

window.onclick=function(e){

if(e.target==modal){

modal.style.display="none";

}

}

// ===== Mobile menu toggle =====
const menuToggle=document.getElementById("menuToggle");
const navMenu=document.getElementById("navMenu");
const navBackdrop=document.getElementById("navBackdrop");

function closeMenu(){
  navMenu.classList.remove("active");
  menuToggle.classList.remove("active");
  navBackdrop.classList.remove("active");
}

if(menuToggle){
  menuToggle.addEventListener("click",function(){
    navMenu.classList.toggle("active");
    menuToggle.classList.toggle("active");
    navBackdrop.classList.toggle("active");
  });
}

if(navBackdrop){
  navBackdrop.addEventListener("click",closeMenu);
}

// Close menu when a nav link is tapped
if(navMenu){
  navMenu.querySelectorAll("a").forEach(function(link){
    link.addEventListener("click",closeMenu);
  });
}

// Close menu on resize back to desktop
window.addEventListener("resize",function(){
  if(window.innerWidth>768){
    closeMenu();
  }
});