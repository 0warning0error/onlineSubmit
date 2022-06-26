<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="en">

<head>
    <base href="${pageContext.request.contextPath }/" />
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="./CSS/MainPage.css">
    <link rel="stylesheet" href="./CSS/common.css">
    <script src="./JS/common.js"></script>
    <link rel="shortcut icon" href="favicon.ico" />
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

<!-- 主要内容模块 -->
<div class="main">
    <!-- 左边的文本内容模块 -->
    <div class="main_left">
        <div class="about">
            <h3>ABOUT</h3>
            <p>
                CVPR is the premier annual computer vision event comprising the main conference and
                several co-located workshops and short courses. With its high quality and low cost,
                it provides an exceptional value for students, academics and industry researchers.
            </p>
            <br>
            <p>
                Due to the continuing impact and future unpredictability of the COVID-19 pandemic,
                CVPR 2021 is moving to a virtual event. This was a difficult decision, but the
                safety and well-being of our participants is our utmost priority. While we
                understand that a virtual event cannot replicate the experience of a physical meeting
                , we will work hard to provide a high quality alternative that allows the exchange
                of our community's latest research and ideas.
            </p>
        </div>
        <div class="ieee">
            <a href="https://www.thecvf.com/" target="_blank" id="cvf"><img src="./images/cvf.jpeg" alt=""></a>
            <a href="https://www.computer.org/" target="_blank" id="ieee"><img src="./images/ieee_cs.png"
                                                                               alt=""></a>
        </div>
        <div class="social">
            <a href="https://www.facebook.com/CVPR2022/" target="_blank"><img id="facebook"
                                                                              src="./images/facebook.svg" alt=""></a>
            <a href="https://twitter.com/CVPR" target="_blank"><img src="./images/twitter.svg" alt=""></a>
            <a href="https://www.instagram.com/cvfcvpr/" target="_blank"><img src="./images/instagram.svg"
                                                                              alt=""></a>
        </div>
    </div>

    <!-- 右边的主要图片模块 -->
    <div class="main_right">
        <img src="./images/main_contnt.jpeg" alt="">
    </div>
</div>

<!-- 通知事项模块 -->
<div class="must_know">

    <!-- 左侧的地点以及联系方式模块 -->
    <div class="must_know_left">
        <div class="location">
            <h1>CVPR 2022 LOCATION</h1>
            <p>CVPR 2022 will take place virtually from June 19th to June 25th.
                Check back for updates.
            </p>
        </div>
        <div class="contact">
            <h5>Contacts:</h5>
            <p>OneT Ymy -<a href="ymy.onet@gmail.com"> ymy.onet@gmail.com</a></p>
        </div>
    </div>

    <!-- 右侧的新闻模块 -->
    <div class="must_know_right">
        <div class="news_and_updates">
            <h3 style="font-size: 22px;">NEWS AND UPDATES</h3>
            <br>
            <ul>
                <li>06/21 – AWARDS Announced <a href="https://cvpr2021.thecvf.com/node/329">here</a> & <a
                        href="https://cvpr2021.thecvf.com/node/330">here</a></li><br>
                <li>06/18 – CVPR Virtual is now LIVE. You can access it <a
                        href="https://www.eventscribe.net/2021/2021CVPR/login.asp">here</a></li><br>
                <li>06/17 – Login information for the virtual site will be sent tomorrow,
                    Friday 06/18. A link will also be posted here. You will need the email
                    address you registered with and your confirmation id that was provided.
                </li><br>
                <li>06/15 - CVPR'21: We will have curated student social events with invited
                    mentors to speak on various topics about research and work.
                    See more <a href="https://cvpr2021.thecvf.com/node/275">here</a></li><br>
                <li>06/11 – Best Paper Candidates can be found <a
                        href="https://cvpr2021.thecvf.com/node/290">here</a></li><br>
                <li>06/11 – CVPR Main Conference Papers and Workshop Papers are online now! <a
                        href="https://openaccess.thecvf.com/CVPR2021">
                    main</a> ,<a href="https://openaccess.thecvf.com/CVPR2021_workshops/menu">workshops</a></li>
                <br>
                <li>05/26 - Paper Presentation Requirements for CVPR 2021 available <a
                        href="https://cvpr2021.thecvf.com/node/209">here</a></li><br>
                <li>05/26 - CVPR'21 is accepting applicants for DEI registration waivers <a
                        href="https://cvpr2021.thecvf.com/node/38">here</a></li>
                <br>
                <li>05/14 - The 24 hour Main Conference, Workshop and Tutorial schedules have been
                    posted <a href="">here</a>
                </li><br>
                <li>03/25 - Media information is available <a href="https://cvpr2021.thecvf.com/node/63">here</a>
                </li><br>
                <li>03/06 - The camera ready deadline has been extended until March 29th</li><br>
                <li>03/04 - Registration is LIVE <a href="https://cvpr2021.thecvf.com/node/48">here</a></li><br>
            </ul>
        </div>
    </div>
</div>

<!-- 倒计时模块 -->
<div class="begin">
    <div class="begin_one">
        <h2>CVPR 2022 begins</h2>
    </div>
    <div class="begin_two">
        <ul class="one">
            <li>00</li>
            <li>00</li>
            <li>00</li>
            <li>00</li>
        </ul>
        <ul class="two">
            <li>Days</li>
            <li>Hours</li>
            <li>Minutes</li>
            <li>Seconds</li>
        </ul>
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