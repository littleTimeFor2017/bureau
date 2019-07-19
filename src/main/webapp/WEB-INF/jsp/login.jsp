<%@page contentType="text/html;charset=UTF-8"
        pageEncoding="UTF-8"
%>
<html lang="en">
<head>
    <%@include file="common.jsp" %>
    <title>管理后台-登录</title>
    <link href="<%=path%>/css/font-awesome.css" rel="stylesheet"><!-- Font-awesome-CSS -->
    <link href="<%=path%>/css/style.css" rel='stylesheet' type='text/css'/><!-- style.css -->
    <script type="text/javascript" src="<%=path %>/common/layer/3.0.3/layer.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="keywords"
          content="Basic Login Form Responsive Widget,Login form widgets, Sign up Web forms , Login signup Responsive web form,Flat Pricing table,Flat Drop downs,Registration Forms,News letter Forms,Elements"/>
    <%--<script type="application/x-javascript"> addEventListener("load", function () {--%>
        <%--setTimeout(hideURLbar, 0);--%>
    <%--}, false);--%>

    <%--function hideURLbar() {--%>
        <%--window.scrollTo(0, 1);--%>
    <%--} </script>--%>
    <script>$(document).ready(function (c) {
        $('.alert-close').on('click', function (c) {
            $('.main-agile').fadeOut('slow', function (c) {
                $('.main-agile').remove();
            });
        });
    });
    </script>
</head>
<body>
<h1>后台管理系统</h1>
<div class="main-agile">
    <%--<div class="alert-close"></div>--%>
    <div class="content-wthree">
        <div class="circle-w3layouts"></div>
        <h2>Login</h2>
        <form action="/bureau/user/login" method="post">
            <div class="inputs-w3ls">
                <input type="text" name="userName" id="userName" placeholder="用户名" required=""/>
            </div>
            <div class="inputs-w3ls">
                <input type="password" name="password"  id="password" placeholder="密码" required=""/>
            </div>
           <input type="button"  value="登录" onclick="login()">
            <div class="wthree-text">
                <ul>
                    <li><a href="#">忘记密码?</a></li>
                </ul>
            </div>
        </form>
    </div>
</div>
</body>
<script>
    function login(){
        $.ajax({
            url: 'user/login?userName='+$("#userName").val()+"&password="+$("#password").val(),
            // data:
            //     {
            //         'userName':$("#userName").val(),
            //         'password':$("#password").val()
            //     },
            dataType:'json',
            method: 'POST',
            success:function (data) {
                if(data&& data.success){
                        //manager/index
                    // 登录成功以后跳转到管理后台首页
                    window.location.href="/bureau/manager/index";
                }else{
                    layer.msg(data.msg, {icon: 2});
                }
            },
            error:function (data) {
                console.log(data)

            }
        })
    }
</script>
</html>