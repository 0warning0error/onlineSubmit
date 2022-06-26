<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <base href="${pageContext.request.contextPath }/" />
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="./CSS/common.css">
    <link rel="stylesheet" href="./CSS/register.css">
    <script type="text/javascript" src="./easyui/jquery.min.js"></script>
    <script src="./JS/register.js"></script>
    <script>
        $(function(){
        //注册
        $("#registerBtn").click(function(){
            var data = $("#form").serialize();
            $.ajax({
                type: "post",
                url: "system/register",
                data: data,
                dataType: "json", //返回数据类型
                success: function(data){
                    if(data.type=="success"){
                        window.location.href="system/login";
                    }else{
                        alert(data.msg);
                    }
                }
            });
        });
    });
    </script>
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
            <li><a href="./login.html">SIGN IN</a></li>
            <li><a href="">EXPO</a></li>
            <li><a href="">JOBS</a></li>
        </ul>
    </div>
</div>

<!-- 注册模块 -->
<div class="register">
    <div class="reg-area">
        <form id="form" action="">
            <ul>
                <li>
                    <input type="text" name="username" placeholder="username" class="content">
                </li>
                <li>
                    <input type="password" name="password" placeholder="password" class="content">
                </li>
                <li>
                    <input type="password" name="contain_password" placeholder="confirm password" class="content">
                </li>
                <li>
                    <input type="text" placeholder="name" name="name" class="content">
                </li>
                <li>
                    <input type="tel" placeholder="tel" name="phone_number" class="content">
                </li>
                <li>
                    <input type="text" placeholder="address" name="address" class="content">
                </li>
                <li>
                    <label for="male">male</label><input type="radio" name="sex" id="male">
                    <label for="female">female</label><input type="radio" name="sex" id="female">
                </li>
                <li>
                    <input type="button" value="Create" class="reg-btn" id="registerBtn">
                    <input type="reset" value="Reset" class="reg-btn">
                </li>


            </ul>
        </form>
    </div>
</div>

<!-- 底部模块 -->
<div class="footer">
    <div class="footer_box">
        <a href="https://www.facebook.com/CVPR2022/" target="_blank"><img src="./images/facebook.svg" alt=""></a>
        <a href="https://twitter.com/CVPR" target="_blank"><img src="./images/twitter.svg" alt=""></a>
        <a href="https://www.instagram.com/cvfcvpr/" target="_blank"><img src="./images/instagram.svg" alt=""></a>
    </div>

</div>
</body>
</html>