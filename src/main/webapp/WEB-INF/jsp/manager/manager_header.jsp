<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.lixc.bureau.entity.User" %>
<%@ page import="com.lixc.bureau.constants.BureauConstants" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<style type="text/css">
    .navbar-inverse .navbar-nav > .open > a,
    .navbar-inverse .navbar-nav > .open > a:hover,
    .navbar-nav > li {margin-left: 2px;}
</style>
<%
    String path = request.getContextPath();
    String idxUrl = path + "/index";
    User user = (User)request.getSession().getAttribute(BureauConstants.USER_TOKEN);
    if(user == null){
        user = new User();
        user.setUserName("test");
    }
    %>
<div class="container">
    <div class="navbar-header">
        <button class="navbar-toggle" type="button" data-toggle="collapse" data-target=".bs-navba r-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
    </div>
    <nav class="collapse navbar-collapse bs-navbar-collapse" role="navigation">
        <ul class="nav navbar-nav navbar-right">
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="glyphicon glyphicon-user"></i>
                    <%=user.getUserName() %>
                    <b class="caret"></b></a>
                <ul class="dropdown-menu">
                    <li><a href="<%=idxUrl %>"><i class="glyphicon glyphicon-home"></i> 回首页</a></li>
                    <li><a href="<%=path %>/user/logout"><i class="glyphicon glyphicon-off"></i> 退出</a></li>
                </ul>
            </li>
        </ul>
    </nav>
</div>
<script type="text/javascript">
    window.onload = function (){
        $('li.dropdown').mouseover(function(){
            $(this).addClass('open');}).mouseout(function(){$(this).removeClass('open');});
    };
</script>