$(function () {

    //隐藏所有子标题
    $(".nav-menu").each(function () {
        $(this).children(".nav-content").hide();
    });

    //给菜单项中的所有主标题绑定事件
    $(".nav-title").each(function () {
        //获取点击当前标签下所有子标签
        var navConEle = $(this).parents(".nav-menu").children(".nav-content");

        //绑定点击事件,判断navConEle的display这个属性是否为none,时none的话时隐藏状态
        $(this).click(function () {
            if (navConEle.css("display") != "none") {
                //隐藏,传参数自带动画,单位为毫秒
                navConEle.hide(300);
            } else {
                //显示,传参数自带动画,单位为毫秒
                $(".nav-menu").each(function () {
                    $(this).children(".nav-content").hide(300);
                });
                navConEle.show(300);
            }
        });
    });


    // 想要通过点击侧边导航栏显示相应的内容，在下面函数中修改要显示的用户列表，用户列表样式css已经写好了，只需要设置成一样的
    // 类名即可



    // 点击cvpr按钮，显示图片
    $(".content-left .left-title a").click(function () {
        $(this).parents(".left-title").parents(".content-left").parents(".content").children(".content-right")
            .children("img").show();
    })
});