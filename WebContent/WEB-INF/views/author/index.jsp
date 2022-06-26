<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <base href="${pageContext.request.contextPath }/" />
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="./CSS/common.css">
    <link rel="stylesheet" href="./CSS/administrator.css">
    <script src = "./JS/jquery-3.6.0.min.js"></script>
    <script src="./JS/administrator.js"></script>

</head>
<body>
<!-- 导航模块 -->
<div class="top">
    <div class="logo">
        <a href="."><img src="./images/logo.jpeg" alt=""></a>
    </div>
    <div class="nav">
        <ul>
            <li><a href=".">HOME</a></li>
            <li><a href="">ORGANIZERS</a></li>
            <li><a href="">SPONSORS</a></li>
            <li><a href="">SUBMISSION</a></li>
            <li><a href="">ATTEND</a></li>
            <li><a href="">PROGRAM</a></li>
            <li><a href="system/login">SIGN IN</a></li>
            <li><a href="">EXPO</a></li>
            <li><a href="">JOBS</a></li>
        </ul>
    </div>
</div>

<!-- 边框模块 -->


<!-- 主业务模块 -->
<div class="admin-main">
    <div class = "content">
        <!--左侧导航栏-->
        <div class = "content-left">
            <div class = "left-title">
                <a href = "javascript:void(0);">${user.username}</a>
            </div>
            <!--水平线-->
            <div class = "seg"></div>
            <!--菜单栏导航-->
            <div class = "navigator">
                <!--每一个菜单栏项-->

            </div>

            <!--水平线-->
            <div class = "seg"></div>
        </div>

        <!--右侧内容区-->
        <div class = "content-right">
            <!-- <img src="./images/563119.jpeg" alt=""> -->
            <iframe id="main-view" src="" style="height: 100%;width: 100%">

            </iframe>
        </div>
    </div>
</div>

<!-- 清除浮动模块 -->
<div class="clear-float"></div>

<!-- 底部模块 -->
<div class="footer">
    <div class="footer_box">
        <a href="https://www.facebook.com/CVPR2022/" target="_blank"><img src="./images/facebook.svg" alt=""></a>
        <a href="https://twitter.com/CVPR" target="_blank"><img src="./images/twitter.svg" alt=""></a>
        <a href="https://www.instagram.com/cvfcvpr/" target="_blank"><img src="./images/instagram.svg" alt=""></a>
    </div>
</div>
</body>
<script type="text/javascript">
    var _menus = {"menus":[
            {"menuid":"1","icon":"","menuname":"稿件信息管理",
                "menus":[
                    {"menuid":"11","menuname":"添加稿件","icon":"icon-add","url":"./author/add"},
                    {"menuid":"12","menuname":"查询稿件","icon":"icon-search","url":"./author/queryManuscript"}
                ]
            },
            {"menuid":"2","icon":"","menuname":"个人信息管理",
                "menus":[
                    {"menuid":"21","menuname":"个人信息","icon":"icon-user-student","url":"./author/queryOwnInfo"}
                ]
            }
        ]};
    let navigator = document.querySelector(".navigator");
    $.each(_menus.menus,function (i,n){
        let menu = document.createElement('div');
        menu.className = "nav-menu";
        let menu_name = document.createElement('div');
        menu_name.className = 'nav-title';
        menu_name.innerText = n.menuname;
        menu.appendChild(menu_name);

        let content = document.createElement('div');
        content.className = "nav-content";

        $.each(n.menus,function (index,n){
            let link = document.createElement('a');
            link.setAttribute("ref",n.url);
            link.href = "javascript:void(0);";
            link.innerText = n.menuname;

            content.appendChild(link);
        })
        menu.appendChild(content);
        navigator.appendChild(menu);
    })

    $(".nav-content a").click(function (){
        let main_view = document.querySelector("iframe");
        main_view.src = $(this).attr("ref");
    })


</script>
</html>