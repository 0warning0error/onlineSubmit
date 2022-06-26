<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <base href="${pageContext.request.contextPath }/" />
    <meta charset="UFT-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="./CSS/common.css">
    <link rel="stylesheet" href="./CSS/login.css">
    <script type="text/javascript" src="./easyui/jquery.min.js"></script>
    <script src="./JS/common.js"></script>
    <script>
        $(function(){
            //登录
            $("#btn-login").click(function(){
                var data = $("#form").serialize();
                $.ajax({
                    type: "post",
                    url: "system/login",
                    data: data,
                    dataType: "json", //返回数据类型
                    success: function(data){
                        if(data.type=="success"){
                            var val = $('input[name="type"]:checked').val();
                            if(val==2){
                                window.location.href="./author/index";
                            }
                            if(val==3){
                                window.location.href="./expert/index";
                            }
                            if(val==1){
                                window.location.href="./editor/index";
                            }
                            /** 2021-03-18 修改 */
                            if(val==4){
                                window.location.href="./administrator/index";
                            }
                        }else{
                            alert(data.msg);
                        }
                    }
                });
            });
            //注册
        })

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


<div class="login">
    <div class="login-main">
        <form id="form" >
            <ul>
                <li>
                    <input type="text" name="username"  placeholder="username" class="content">
                </li>
                <li>
                    <input type="password" name="password"  placeholder="password" class="content">
                </li>
                <li>
                    <label for="author">author</label><input type="radio" name="type" value="2" id="author">
                    <label for="expert">expert</label><input type="radio" name="type" value="3" id="expert">
                    <label for="editor">editor</label><input type="radio" name="type" value="1" id="editor">
                    <label for="administrator">administrator</label><input type="radio" name="type" value="4" id="administrator">
                </li>
                <li>
                    <input type="button" value="Login" id="btn-login" class="login-btn"/>
                </li>
            </ul>
        </form>
        <a href="./system/register" target="_self">
            <button id="btn-register" class="login-btn">
                Register
            </button>
        </a>
    </div>

</div>
<div class="clear_float"></div>


<!-- 底部模块 -->
<div class="footer">
    <div class="footer_box">
        <a href="https://www.facebook.com/CVPR2022/" target="_blank"><img src="./images/facebook.svg" alt=""></a>
        <a href="https://twitter.com/CVPR" target="_blank"><img src="./images/twitter.svg" alt=""></a>
        <a href="https://www.instagram.com/cvfcvpr/" target="_blank"><img src="./images/instagram.svg" alt=""></a>
    </div>

</div>
</body>
<script>

</script>
</html>