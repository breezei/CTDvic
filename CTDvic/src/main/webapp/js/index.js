/*
setInterval(function(){
    var img = $("<img src='IMAGE/snow.png'>");
    $("#snowstart").append(img);
    var size = parseInt( Math.pow(Math.random()*5+3, 2));
    img.css("width",size+"px");
    var w = $(window).width();
    var left =parseInt(Math.random()*(w-size));
    img.css("left",left+"px");
    //var top = $(window).height()-size;
    var startsnow = document.getElementById('snowstart');
    var foot = document.getElementsByClassName('foot')[0];

    var rect1 = startsnow.getBoundingClientRect();
    var rect2 = foot.getBoundingClientRect();
    var distanceY = rect2.bottom - rect1.bottom-size;

//var top = $(window).height()-size;
    img.animate({"top":distanceY+"px"},size*500)
        .fadeOut(1000,function(){
            //当动画完成时执行此代码，清除缓存
            img.remove();
            //console.log($("img").length);
        });
},800)
*/

//鼠标悬停执行动画
$(document).ready(function() {
    $('#wenhao').hover(
        function () {
            $(this).addClass('animate__animated animate__pulse'); // 添加动画类
        },
        function() {
            $(this).removeClass('animate__animated animate__pulse');
        }
    );

})

//加载时滚动到顶部
window.onload=function(){
    if(document.body.scrollTop>0){
        console.log(1);
        setTimeout(() => window.scrollTo(0,0), 150)
        document.body.scrollTop=0;
    }
    setTimeout(() => window.scrollTo(0,0), 150)
    document.body.scrollTop=0;
}

